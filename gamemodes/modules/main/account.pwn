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

forward OnPlayerLoaded(playerid);

#define MAX_PASSWORD_LEN        (64)
#define MIN_PASSWORD_LEN        (8)
#define MAX_LOGIN_ATTEMPTS      (3)

#define SPAWN_TYPE_REGISTER     (1)
#define SPAWN_TYPE_LOGIN        (2)

enum e_PLAYER_DATA {

    ID,
    Password[MAX_PASSWORD_LEN],
    Username[MAX_PLAYER_NAME],
    Age,
    Gender,
    eMail[128],
    Score,
    Skin,
    Staff
}

new UserInfo[MAX_PLAYERS][e_PLAYER_DATA];

new loginAttempts[MAX_PLAYERS];

timer timer_SpawnPlayer[400](playerid, spawnType) 
{
    if(spawnType == SPAWN_TYPE_REGISTER) {

        SetSpawnInfo(playerid, NO_TEAM, UserInfo[playerid][Skin], 167.1225,-160.3572,6.7786,91.0767, WEAPON_UNKNOWN, 0, WEAPON_UNKNOWN, 0, WEAPON_UNKNOWN, 0);
        SetPlayerVirtualWorld(playerid, 0);
        SetPlayerInterior(playerid, 0);

        SpawnPlayer(playerid);
    }

    else if(spawnType == SPAWN_TYPE_LOGIN) {

        SetSpawnInfo(playerid, NO_TEAM, UserInfo[playerid][Skin], 167.1225,-160.3572,6.7786,91.0767, WEAPON_UNKNOWN, 0, WEAPON_UNKNOWN, 0, WEAPON_UNKNOWN, 0);
        SetPlayerVirtualWorld(playerid, 0);
        SetPlayerInterior(playerid, 0);

        SpawnPlayer(playerid);
    }

    return (true);
}

forward mysql_CheckAccount(playerid);
public mysql_CheckAccount(playerid) {

    new rows = cache_num_rows();

    if(!rows) {

        Dialog_Show(playerid, "account_Register", DIALOG_STYLE_INPUT, ""c_server"[ R ] >> "c_white"Registracija", 
                    ""c_white"Vas racun nije pronadjen u "c_server"databazi.\n \
                    "c_white"Molimo vas da unesete zeljenu sifru.", 
        "Unesi", "Odustani");
        return (true);
    }

    else { 

        new playerIP[50];
        GetPlayerIp(playerid, playerIP, sizeof playerIP);

        loginAttempts[playerid] = 0;

        cache_get_value_name(0, "Password", UserInfo[playerid][Password], MAX_PASSWORD_LEN);

        Dialog_Show(playerid, "account_Login", DIALOG_STYLE_INPUT, ""c_server"[ R ] >> "c_white"Login", ""c_white"Vas racun je pronadjen u "c_server"databazi.\n \
                   "c_white"Username : "c_server"%s\n \
                   "c_white"IP : %s \n \
                   "c_white"Molimo vas ta unesete tacnu sifru.", 
        "Unesi", "Odustani", ReturnPlayerName(playerid), playerIP);

    }

    return (true);
}

forward mysql_RegisterAccount(playerid);
public mysql_RegisterAccount(playerid) {

    SendClientMessage(playerid, x_server, "R E L I A N T | "c_white"%s, dobrodosli na server.", ReturnPlayerName(playerid));
    SendClientMessage(playerid, x_server, "R E L I A N T | "c_white"Vas account je uspjesno kreiran i sacuvan u "c_server"databazi.");
    SendClientMessage(playerid, x_server, "R E L I A N T | "c_white"Ukoliko vam zatreba pomoc, "c_server"/new.");

    defer timer_SpawnPlayer(playerid, SPAWN_TYPE_REGISTER);

    CallLocalFunction("OnPlayerLoaded", "d", playerid);

    return (true);
}

forward mysql_LoadAccount(playerid);
public mysql_LoadAccount(playerid) {

    new rows = cache_num_rows();

    if(!rows) {

        SendClientMessage(playerid, x_server, "R E L I A N T | "c_white"Desila se je greska sa databazom...");
        Kick(playerid);
    }

    else {


        cache_get_value_name_int(0, "ID", UserInfo[playerid][ID]);
        cache_get_value_name(0, "Username", UserInfo[playerid][Username], MAX_PLAYER_NAME);
        cache_get_value_name_int(0, "Age", UserInfo[playerid][Age]);
        cache_get_value_name_int(0, "Gender", UserInfo[playerid][Gender]);
        cache_get_value_name(0, "eMail", UserInfo[playerid][eMail], 128);
        cache_get_value_name_int(0, "Score", UserInfo[playerid][Score]);
        cache_get_value_name_int(0, "Skin", UserInfo[playerid][Skin]);
        cache_get_value_name_int(0, "Staff", UserInfo[playerid][Staff]);


        SendClientMessage(playerid, x_server, "R E L I A N T | "c_white"%s, lijepo vas je vidjeti opet.", ReturnPlayerName(playerid));
        SendClientMessage(playerid, x_server, "R E L I A N T | "c_white"Ukoliko vam je potrebna pomoc"c_server" /askq.");
        SendClientMessage(playerid, x_server, "R E L I A N T | "c_white"Svi upiti za staff su besplatni do levela "c_server"3.");

        defer timer_SpawnPlayer(playerid, SPAWN_TYPE_LOGIN);
        CallLocalFunction("OnPlayerLoaded", "d", playerid);
    }

    return (true);
}

hook OnPlayerConnect(playerid) {

    new q[124];
    mysql_format(MySQL:SQL, q, sizeof q, "SELECt * FROM `users` WHERE `username` = '%e' LIMIT 1", ReturnPlayerName(playerid));
    mysql_tquery(MySQL:SQL, q, "mysql_CheckAccount", "d", playerid);


    return Y_HOOKS_CONTINUE_RETURN_1;
}

Dialog:account_Register(const playerid, response, listitem, string: inputtext[]) {

    if(!response) return Kick(playerid);

    new tmp_password[MAX_PASSWORD_LEN];

    if(sscanf(inputtext, "s[64]", tmp_password)) return Dialog_Show(playerid, "account_Register", DIALOG_STYLE_INPUT, ""c_server"[ R ] >> "c_white"Registracija", 
                                                                ""c_white"Vas racun "c_orange"nije "c_white"pronadjen u databazi.\n \
                                                                Molimo vas ta unesete zeljenu sifru.", 
                                                    "Unesi", "Odustani");  

    
    if( strlen(tmp_password) < MIN_PASSWORD_LEN || strlen(tmp_password) > MAX_PASSWORD_LEN ) return Dialog_Show(playerid, "account_Register", DIALOG_STYLE_INPUT, ""c_server"[ R ] >> "c_white"Registracija", 
                                                                                                            ""c_white"Vas racun "c_orange"nije "c_white"pronadjen u databazi.\n \
                                                                                                            Molimo vas ta unesete zeljenu sifru.\n \
                                                                                                            Sifra ne moze biti manja od "c_orange"8 "c_white"a veca od "c_orange"64 "c_white"karaktera!", 
                                                                            "Unesi", "Odustani");

    UserInfo[playerid][Password] = tmp_password;

    Dialog_Show(playerid, "account_Age", DIALOG_STYLE_INPUT,  ""c_server"[ R ] >> "c_white"Registracija", ""c_white"Unesite vase godine.\nGodine ne mogu biti manje od 13 a vece od 65", "Unesi", "Odustani");


    return (true);
}

Dialog:account_Age(const playerid, response, listitem, string: inputtext[]) {

    if(!response) return Kick(playerid);

    new tmp_age;
    
    if(sscanf(inputtext, "d", tmp_age)) return Dialog_Show(playerid, "account_Age", DIALOG_STYLE_INPUT,  ""c_server"[ R ] >> "c_white"Registracija", ""c_white"Unesite vase godine.\nGodine ne mogu biti manje od 13 a vece od 65", "Unesi", "Odustani");
    if(tmp_age < 13 || tmp_age > 65) return Dialog_Show(playerid, "account_Age", DIALOG_STYLE_INPUT,  ""c_server"[ R ] >> "c_white"Registracija", ""c_white"Unesite vase godine.\nGodine ne mogu biti manje od 13 a vece od 65", "Unesi", "Odustani");

    UserInfo[playerid][Age] = tmp_age;

    Dialog_Show(playerid, "account_Gender", DIALOG_STYLE_LIST, ""c_server"[ R ] >> "c_white"Registracija", "Musko\nZensko", "Odaberi", "Odustani");

    return (true);
}

Dialog:account_Gender(const playerid, response, listitem, string: inputtext[]) {

    if(!response) return Kick(playerid);

    new tmp_gender = listitem+1;

    UserInfo[playerid][Gender] = tmp_gender;

    Dialog_Show(playerid, "account_Email", DIALOG_STYLE_INPUT, ""c_server"[ R ] >> "c_white"Registracija", "Unesite vas korsinicki mail.\nMail vam moze pomoci kako bi vratili svoj account ukoliko ste izgubili sifru", "Unesi", "Odustani");

    return (true);
}

Dialog:account_Email(const playerid, response, listitem, string: inputtext[]) {

    if(!response) return Kick(playerid);

    if(strlen(inputtext) == 0)
        return  Dialog_Show(playerid, "account_Email", DIALOG_STYLE_INPUT, ""c_server"[ R ] >> "c_white"Registracija", "Unesite vas korsinicki mail.\nMail vam moze pomoci kako bi vratili svoj account ukoliko ste izgubili sifru", "Unesi", "Odustani");

    if(strfind(inputtext, "@", true) == -1)
        return  Dialog_Show(playerid, "account_Email", DIALOG_STYLE_INPUT, ""c_server"[ R ] >> "c_white"Registracija", "Unesite vas korsinicki mail.\nUnjeti eMail nije u validnom formatu...", "Unesi", "Odustani");

    new tmp_mail[128];
    format(tmp_mail, sizeof tmp_mail, "%s", inputtext);

    UserInfo[playerid][eMail] = tmp_mail;
    UserInfo[playerid][Username] = ReturnPlayerName(playerid);

    if(UserInfo[playerid][Gender] == 1) { UserInfo[playerid][Skin] = 303; }
    else { UserInfo[playerid][Skin] = 91; }

    new q[888];

    mysql_format(MySQL:SQL, q, sizeof q, "INSERT INTO `users` (`Password`, `Username`, `Age`, `Gender`, `eMail`, `Score`, `Skin`, `Staff`) \
                                          VALUES ('%e', '%e', '%d', '%d', '%e', '1', '%d', '0')",
                                          UserInfo[playerid][Password], ReturnPlayerName(playerid),
                                          UserInfo[playerid][Age], UserInfo[playerid][Gender],
                                          UserInfo[playerid][eMail], UserInfo[playerid][Skin]);
    mysql_tquery(MySQL:SQL, q, "mysql_RegisterAccount", "d", playerid);

    return (true);
}

Dialog:account_Login(const playerid, response, listitem, string: inputtext[]) {

    if(!response) return Kick(playerid);

    if(strcmp(inputtext, UserInfo[playerid][Password]) == 0 && strlen(inputtext) == strlen(UserInfo[playerid][Password]))
    {
    
        new q[128];
        mysql_format(MySQL:SQL, q, sizeof q, "SELECT * FROM `users` WHERE `Username` = '%e' LIMIT 1", ReturnPlayerName(playerid));
        mysql_tquery(MySQL:SQL, q, "mysql_LoadAccount", "d", playerid);
        return 1;
    }

    else {

        if(loginAttempts[playerid] >= MAX_LOGIN_ATTEMPTS)
            return Kick(playerid);

        loginAttempts[playerid]++;

        new playerIP[50];
        GetPlayerIp(playerid, playerIP, sizeof playerIP);

        Dialog_Show(playerid, "account_Login", DIALOG_STYLE_INPUT, ""c_server"[ R ] >> "c_white"Login", ""c_white"Vas racun je pronadjen u "c_server"databazi.\n \
                   "c_white"Username : "c_server"%s\n \
                   "c_white"IP : %s \n \
                   "c_white"Molimo vas ta unesete tacnu sifru.", 
        "Unesi", "Odustani", ReturnPlayerName(playerid), playerIP);

        SendClientMessage(playerid, x_server, "R E L I A N T | "c_white"Pokusaj logina : %d/%d", loginAttempts[playerid], MAX_LOGIN_ATTEMPTS);

    }

    return (true);
}

stock GetPlayerSQLID(playerid)
    return UserInfo[playerid][ID];