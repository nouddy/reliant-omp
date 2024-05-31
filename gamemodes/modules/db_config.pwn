/*
 *
 *  _____  ______ _      _____          _   _ _______   _____  _____   ____       _ ______ _____ _______ 
 * |  __ \|  ____| |    |_   _|   /\   | \ | |__   __| |  __ \|  __ \ / __ \     | |  ____/ ____|__   __|
 * | |__) | |__  | |      | |    /  \  |  \| |  | |    | |__) | |__) | |  | |    | | |__ | |       | |   
 * |  _  /|  __| | |      | |   / /\ \ | . ` |  | |    |  ___/|  _  /| |  | |_   | |  __|| |       | |   
 * | | \ \| |____| |____ _| |_ / ____ \| |\  |  | |    | |    | | \ \| |__| | |__| | |___| |____   | |   
 * |_|  \_\______|______|_____/_/    \_\_| \_|  |_|    |_|    |_|  \_\\____/ \____/|______\_____|  |_|   
 *
 *  @Author         Vostic & Nodi
 *  @Date           31th May 2024
 *  @Project        reliant-project
 *
 *  @File           db_config.pwn
 *  @Module         database
 */

#include <ylessinc\YSI_Coding\y_hooks>

 new MySQL: SQL;

hook OnGameModeInit()
{
    mysql_log(ALL);

	SQL = mysql_connect_file("mysql.ini");

    if(mysql_errno(SQL) != 0)
    {
        printf("[MYSQL] Database connection failed, check mysql.ini!");
    }
    else
    {
        printf("[MYSQL] Connected to database succesfully");
    }
    return (true);
}

hook OnGameModeExit()
{
    if(SQL)
    {
        mysql_close(SQL);
    }
    return (true);
}
