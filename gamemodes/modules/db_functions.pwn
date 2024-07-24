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

stock mysql_save_integer(const table[], const row[], value, const conditionRow[], conditionValue) {

    new q[224];

    mysql_format(MySQL:SQL, q, sizeof q, "UPDATE `%s` SET `%s` = '%d' WHERE `%s` = '%d'", table, row, value, conditionRow, conditionValue);
    mysql_tquery(MySQL:SQL, q);

    return (true);
}

stock ReturnDate()
{
    static
        date[36];

    getdate(date[2], date[1], date[0]);
    gettime(date[3], date[4], date[5]);

    format(date, sizeof(date), "%02d/%02d/%d - %02d:%02d", date[0], date[1], date[2], date[3], date[4]);
    return date;
}

