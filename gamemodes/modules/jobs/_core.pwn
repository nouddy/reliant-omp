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

//*==============================================================================
//*--->>> @vars & misc
//*==============================================================================

#define MAX_JOBS                (2)
#define MAX_JOB_NAME_LEN        (64)

enum e_JOB_ID {
    INVALID_JOB_ID = -1;
    JOB_PIZZA_DELIVERY = 1,
    JOB_BUS_DRIVER
}

enum E_JOB_DATA {

    e_JOB_ID:jobID,
    jobName[MAX_JOB_NAME_LEN],

    Float:jobPos[3],
    Float:jobUniformPos[3],

    jobUniform[2] // * 1 | Male   2 | Female

}

new JobInfo[MAX_JOBS][E_JOB_DATA] = {

    { JOB_PIZZA_DELIVERY, "Dostavljac Pice", { 0.00, 0.00, 0.00 }, { 0.00, 0.00, 0.00 }, 155, 193 }, // * Pizza Delivery
    { JOB_BUS_DRIVER, "Bus Vozac", { 0.00, 0.00, 0.00 }, { 0.00, 0.00, 0.00 }, 304, 308 } // * Bus Driver
}

new jobPickup[MAX_JOBS][2],
    Text3D:jobLabel[MAX_JOBS][2];

//* Player Vars

new bool:jobUniform[MAX_PLAYERS];

//*==============================================================================
//*--->>> @functions
//*==============================================================================

stock SetPlayerJob(playerid, jobid, type) {

    if(type < 1 || type > 3)
        #error "Unesen je krivi tip pri funkciji SetPlayerJob | args > playerid, jobid, type!"

    if( jobid == 0 )
        return SendClientMessage(playerid, x_server, "(reliant): "c_white"Desila se greska pri postavljanju posla! Prijaviti skripteru!");

    static str[248];

    switch(type) {

        case 1: 
            format(str, sizeof str, "(reliant): "c_white"Skinut vam je posao!");
        case 2: 
            format(str, sizeof str, "(reliant): "c_white"Dali ste otkaz!");
        case 3:
            format(str, sizeof str, "(reliant): "c_white"Uspjesno ste se zaposlili kao %s!", JobInfo[jobid - 1][jobName]);
    }

    else if( jobid == INVALID_JOB_ID ) {

        UserInfo[playerid][Job] = jobid;
        SetPlayerSkin(playerid, UserInfo[playerid][Skin]);
        SendClientMessage(playerid, x_server, str);

        return Y_HOOKS_BREAK_RETURN_1;
    }

    else {

        UserInfo[playerid][Job] = jobid;
        SendClientMessage(playerid, x_server, str);

        return Y_HOOKS_BREAK_RETURN_1;
    }

    return (true);
}

stock ReturnJobName(jobid) {

    static __str[MAX_JOB_NAME_LEN];

    switch(JobInfo[jobid][jobID]) {

        case JOB_PIZZA_DELIVERY : { __str = "Dostavljac Pice"; }
        case JOB_BUS_DRIVER : { __str = "Bus Vozac"; }
        default: { __str = "[Undefined]:"; }
    }

    return __str;
}

stock IsPlayerNearJob(playerid) {

    for(new i = 0; i < MAX_JOBS; i++) {

        if(IsPlayerInRangeOfPoint(playerid, 2.0, JobInfo[i][jobPos][0], JobInfo[i][jobPos][1], JobInfo[i][jobPos][2]))
            return i;
    }

    return INVALID_JOB_ID;
}

stock GetPlayerJob(playerid)
    return UserInfo[playerid][Job];

//*==============================================================================
//*--->>> @hooks
//*==============================================================================

hook OnGameModeInit() {

    for(new i = 0; i < MAX_JOBS; i++) {
        
        static __str[288];
        format(__str, sizeof __str, ""c_orange"\187; %s "c_white"\n [ N ]", JobInfo[i][jobName]);

        jobPickup[i][0] = CreatePickup(1210, 1, JobInfo[i][jobPos][0], JobInfo[i][jobPos][1], JobInfo[i][jobPos][2]);
        jobPickup[i][1] = CreatePickup(1275, 1, JobInfo[i][jobUniformPos][0], JobInfo[i][jobUniformPos][1], JobInfo[i][jobUniformPos][2]);

        jobLabel[i][0] = Create3DTextLabel(__str, -1, JobInfo[i][jobPos][0], JobInfo[i][jobPos][1], JobInfo[i][jobPos][2], 3.50, 0);
        jobLabel[i][1] = Create3DTextLabel(""c_server"\187; Uniforma\n"c_white" [ N ] ", -1, JobInfo[i][jobUniformPos][0], JobInfo[i][jobUniformPos][1], JobInfo[i][jobUniformPos][2], 3.50, 0);

    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerConnect(playerid) {

    jobUniform[playerid] = false;

    return Y_HOOKS_CONTINUE_RETURN_1;
}

hook OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys) {

    if(PRESSED(KEY_NO)) {

        new job = IsPlayerNearJob(playerid);

        if(job != INVALID_JOB_ID) {

            if(UserInfo[playerid] != INVALID_JOB_ID)
                return SendClientMessage(playerid, x_server, "(reliant): "c_white"Vec ste zaposleni!");

            SetPlayerJob(playerid, JobInfo[job][jobID], 3);
            return Y_HOOKS_BREAK_RETURN_1;
        }

        if(IsPlayerInRangeOfPoint(playerid, 2.0, JobInfo[job][jobUniformPos][0], JobInfo[job][jobUniformPos][1], JobInfo[job][jobUniformPos][2])) {

            for(new i = 0; i < MAX_JOBS; i++) {

                if(JobInfo[i][jobID] == UserInfo[playerid][Job]) {
                    
                    

                    break;
                }
            }
        }
    }

    return Y_HOOKS_CONTINUE_RETURN_1;
}