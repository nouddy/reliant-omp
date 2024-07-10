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

hook OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {

        if(newkeys & KEY_ACTION)
        {
            new veh = GetPlayerVehicleID(playerid),
                bool:engine,
                bool:lights,
                bool:alarm,
                bool:doors,
                bool:bonnet,
                bool:boot,
                bool:objective;

            if(IsVehicleBicycle(GetVehicleModel(veh)))
                return true;
                   
            GetVehicleParamsEx(veh, engine, lights, alarm, doors, bonnet, boot, objective);

            if(engine == VEHICLE_PARAMS_OFF)
                SetVehicleParamsEx(veh, VEHICLE_PARAMS_ON, lights, alarm, doors, bonnet, boot, objective);
            else
                SetVehicleParamsEx(veh, VEHICLE_PARAMS_OFF, lights, alarm, doors, bonnet, boot, objective);

            new str[60];
            format(str, sizeof(str),"%s si motor.", (engine == VEHICLE_PARAMS_OFF) ? "Upalio" : "Ugasio");
            SendClientMessage(playerid, x_server, "(reliant): "c_white"%s", str);

            return Y_HOOKS_BREAK_RETURN_1;
        }
        if(newkeys & KEY_YES)
        {
            new veh = GetPlayerVehicleID(playerid),
                bool:engine,
                bool:lights,
                bool:alarm,
                bool:doors,
                bool:bonnet,
                bool:boot,
                bool:objective;
            
            if(IsVehicleBicycle(GetVehicleModel(veh)))
            {
                return Y_HOOKS_BREAK_RETURN_1;
            }
            
            GetVehicleParamsEx(veh, engine, lights, alarm, doors, bonnet, boot, objective);

            if(lights == VEHICLE_PARAMS_OFF)
            {
                SetVehicleParamsEx(veh, engine, VEHICLE_PARAMS_ON, alarm, doors, bonnet, boot, objective);

            }
            else
            {
                SetVehicleParamsEx(veh, engine, VEHICLE_PARAMS_OFF, alarm, doors, bonnet, boot, objective);
            }
            new str[60];
            format(str, sizeof(str),"%s si svetla.", (lights == VEHICLE_PARAMS_OFF) ? "Upalio" : "Ugasio");
            SendClientMessage(playerid, x_server, "(reliant): "c_white"%s", str);

            return Y_HOOKS_BREAK_RETURN_1;
        }
    }
	return Y_HOOKS_CONTINUE_RETURN_1;
}
