/*

*  _____  ______ _      _____          _   _ _______   _____  _____   ____       _ ______ _____ _______ 
* |  __ \|  ____| |    |_   _|   /\   | \ | |__   __| |  __ \|  __ \ / __ \     | |  ____/ ____|__   __|
* | |__) | |__  | |      | |    /  \  |  \| |  | |    | |__) | |__) | |  | |    | | |__ | |       | |   
* |  _  /|  __| | |      | |   / /\ \ | . ` |  | |    |  ___/|  _  /| |  | |_   | |  __|| |       | |   
* | | \ \| |____| |____ _| |_ / ____ \| |\  |  | |    | |    | | \ \| |__| | |__| | |___| |____   | |   
* |_|  \_\______|______|_____/_/    \_\_| \_|  |_|    |_|    |_|  \_\\____/ \____/|______\_____|  |_|   
*

*   @Author : Noddy
*   @Date : 7.5.2024

*/

#include <ylessinc\YSI_Coding\y_hooks>

new staffVehicle[MAX_PLAYERS] = {INVALID_VEHICLE_ID};
new Text3D:staffLabel[MAX_PLAYERS];
new answeringQuestion[MAX_PLAYERS];

#define MAX_QUESTIONS       (1000)

#define MAX_QUESTION_LEN    (36)

enum e_STAFF_QUESTION_DATA {

    ID,
    PlayerID,
    Question[MAX_QUESTION_LEN],
    Date[36]
}

new QuestionInfo[MAX_QUESTIONS][e_STAFF_QUESTION_DATA];
new Iterator:iter_Question<MAX_QUESTIONS>;

forward mysql_SendQeustion(id);
public mysql_SendQeustion(id) {

    Iter_Add(iter_Question, id);

    foreach(new i : Player) {

        if(UserInfo[i][Staff] >= 1) {

            SendClientMessage(i, x_server, "(askq): "c_white"%s je postavio upit : "c_lblue"%s", ReturnPlayerName(QuestionInfo[id][PlayerID]), QuestionInfo[id][Question]);
            break;
        }
    }

    return (true);
}

forward mysql_LoadQuestions(playerid);
public mysql_LoadQuestions(playerid) {

    new rows = cache_num_rows();
    if(!rows) return SendClientMessage(playerid, -1, "Nema pitanja...");
    else {
        new dialogStr[460];
        for(new i = 0; i < rows; i++) { 
            new pID = 0, questionSTR[MAX_QUESTION_LEN], qDate[36];
            cache_get_value_name_int(i, "PlayerID", pID);
            cache_get_value_name(i, "Question", questionSTR, MAX_QUESTION_LEN);
            cache_get_value_name(i, "Date", qDate, 36);
        
            format(dialogStr, sizeof dialogStr, "{737be1}%s%s {ffffff}| %s | {daa520}%s\n", dialogStr, ReturnPlayerName(pID), questionSTR, qDate);
            Dialog_Show(playerid, "dialog_Questions", DIALOG_STYLE_LIST, "Questions", dialogStr, "Odaberi", "Odustani");
        }
    }
    return(true);
}

hook OnGameModeInit() {

    mysql_tquery(MySQL:SQL, "TRUNCATE TABLE `staff_questions`"); //* Brisanje svih pitanja pri pokretanju servera

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerConnect(playerid) {

    //*         >> [ SAFETY CHECKS ] << 

    answeringQuestion[playerid] = -1;

    if(IsValidVehicle(staffVehicle[playerid]))
        DestroyVehicle(staffVehicle[playerid]);
    if(IsValid3DTextLabel(staffLabel[playerid]))
        Delete3DTextLabel(staffLabel[playerid]);

    return Y_HOOKS_CONTINUE_RETURN_1;
}

YCMD:veh(playerid, params[], help) 
{
    if(UserInfo[playerid][Staff] < 1) return SendClientMessage(playerid, x_red, "(error): "c_white"Niste dovoljan staff level!");
    
    new vModel, vColor[2];

    if(sscanf(params, "ddd", vModel, vColor[0], vColor[1])) return SendClientMessage(playerid, x_server, "(staff): "c_white"/veh [Model] [Boja 1] [Boja 2].");

    if(vModel < 400 || vModel > 609) return SendClientMessage(playerid, x_server, "(staff): "c_white"Model vozila ne moze biti manji od 400 a veci od 609!");

    if(IsValidVehicle(staffVehicle[playerid])) {

        new Float:pPos[4];
        GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);
        GetPlayerFacingAngle(playerid, pPos[3]);

        if(IsValid3DTextLabel(staffLabel[playerid]))
            Delete3DTextLabel(staffLabel[playerid]);

        DestroyVehicle(staffVehicle[playerid]);
        staffVehicle[playerid] = CreateVehicle(vModel, pPos[0], pPos[1], pPos[2], pPos[3], vColor[0], vColor[1], 1500);
        PutPlayerInVehicle(playerid, staffVehicle[playerid], 0);

        SendClientMessage(playerid, x_server, "(staff): "c_white"Uspjesno ste stvorili staff vozilo.");

    }

    if(!IsValidVehicle(staffVehicle[playerid])) {

        new Float:pPos[4];
        GetPlayerPos(playerid, pPos[0], pPos[1], pPos[2]);
        GetPlayerFacingAngle(playerid, pPos[3]);

        staffVehicle[playerid] = CreateVehicle(vModel, pPos[0], pPos[1], pPos[2], pPos[3], vColor[0], vColor[1], 1500);
        PutPlayerInVehicle(playerid, staffVehicle[playerid], 0);

        if(IsValid3DTextLabel(staffLabel[playerid]))
            Delete3DTextLabel(staffLabel[playerid]);

        SendClientMessage(playerid, x_server, "(staff): "c_white"Uspjesno ste stvorili staff vozilo.");
    }

    if(!IsValid3DTextLabel(staffLabel[playerid])) {

        new fmt_label[64];
        format(fmt_label, sizeof fmt_label, ""c_lblue"(( Staff | "c_white"%s "c_lblue"))", ReturnPlayerName(playerid));
        staffLabel[playerid] = Create3DTextLabel(fmt_label, -1, 0.00, 0.00, 0.00, 3.50, 0);
        Attach3DTextLabelToVehicle(staffLabel[playerid], staffVehicle[playerid], 0.00, 0.00, 0.00);
    }

    return 1;
}

YCMD:setstaff(playerid, params[], help) 
{
    
    if(!IsPlayerAdmin(playerid)) return (true);

    new target, staff_level;

    if(sscanf(params, "ud", target, staff_level)) return SendClientMessage(playerid, x_server, "(staff): "c_white"/setstaff [Playerid] [0-4]");

    if(target == INVALID_PLAYER_ID) return (true);
    if(!IsPlayerConnected(target)) return SendClientMessage(playerid, x_server, "(staff): "c_white"Igrac nije konektovan na server!");
    if(staff_level < 0 || staff_level > 4) return SendClientMessage(playerid, x_server, "(staff): "c_white"Staff level ne moze biti manji od 0 a veci do 4!");

    if(staff_level == 0) {

        UserInfo[target][Staff] = 0;
        SendClientMessage(target, x_server, "(staff): "c_white"%s vam je skinuo staff.", ReturnPlayerName(playerid));
        SendClientMessage(playerid, x_server, "(staff): "c_white"Skinuli ste staff igracu %s", ReturnPlayerName(target));
        mysql_save_integer("users", "Staff", staff_level, "ID", UserInfo[target][ID]);
    }

    UserInfo[target][Staff] = staff_level;
    SendClientMessage(target, x_server, "(staff): "c_white"%s vam je postavio staff level %d.", ReturnPlayerName(playerid), staff_level);
    SendClientMessage(playerid, x_server, "(staff): "c_white"Postavili ste staff level %d igracu %s", staff_level, ReturnPlayerName(target));

    mysql_save_integer("users", "Staff", staff_level, "ID", UserInfo[target][ID]);

    return 1;
}

YCMD:askq(playerid, params[], help) {

    new text[MAX_QUESTION_LEN];
    if(sscanf(params, "s[246]", text)) return SendClientMessage(playerid, x_server, "(reliant): "c_white"/askq [Pitanje]");

    new question[MAX_QUESTION_LEN];
    strmid(question, text, 0, sizeof text, MAX_QUESTION_LEN);

    new qID = Iter_Free(iter_Question);

    QuestionInfo[qID][ID] = qID;
    QuestionInfo[qID][PlayerID] = playerid;
    QuestionInfo[qID][Question] = question;
    QuestionInfo[qID][Date] = ReturnDate();

    new q[400];
    mysql_format(MySQL:SQL, q, sizeof q, "INSERT INTO `staff_questions` (`ID`, `PlayerID`, `Question`, `Date`) \
                                          VALUES ('%d', '%d', '%e', '%e')",
                                          QuestionInfo[qID][ID], QuestionInfo[qID][PlayerID],
                                          QuestionInfo[qID][Question], QuestionInfo[qID][Date]);
    mysql_tquery(MySQL:SQL, q, "mysql_SendQeustion", "d", qID);
    return (true);
}

YCMD:questions(playerid, params[], help) 
{
    
    if(UserInfo[playerid][Staff] < 1) return SendClientMessage(playerid, x_red, "(error): "c_white"Niste dovoljan staff level!");

    new q[128];
    mysql_format(SQL, q, sizeof q, "SELECT * FROM `staff_questions`");
    mysql_tquery(SQL, q, "mysql_LoadQuestions", "d", playerid);

    return 1;
}

Dialog:dialog_Questions(const playerid, response, listitem, string: inputtext[]) {

    if(!response) return (true);

    new qID = listitem;
    answeringQuestion[playerid] = qID;
    Dialog_Show(playerid, "question_Answer", DIALOG_STYLE_INPUT, "Answer", "[ %s ] -> %s", "Odgovori", "Nazad", ReturnPlayerName(QuestionInfo[qID][PlayerID]), QuestionInfo[qID][Question]);
    
    return true;
}

Dialog:question_Answer(const playerid, response, listitem, string: inputtext[]) {

    if(!response) {

        new q[128];
        mysql_format(SQL, q, sizeof q, "SELECT * FROM `staff_questions`");
        mysql_tquery(SQL, q, "mysql_LoadQuestions", "d", playerid);
        return (true);
    }

    new answer[246];
    if(sscanf(inputtext, "s[246]", answer)) return Dialog_Show(playerid, "question_Answer", DIALOG_STYLE_INPUT, "Answer", "[ %s ] -> %s", "Odgovori", "Nazad", ReturnPlayerName(QuestionInfo[answeringQuestion[playerid]][PlayerID]), QuestionInfo[answeringQuestion[playerid]][Question]);
    
    return true;

}

