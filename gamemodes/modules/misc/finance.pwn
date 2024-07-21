/*

*  _____  ______ _      _____          _   _ _______   _____  _____   ____       _ ______ _____ _______ 
* |  __ \|  ____| |    |_   _|   /\   | \ | |__   __| |  __ \|  __ \ / __ \     | |  ____/ ____|__   __|
* | |__) | |__  | |      | |    /  \  |  \| |  | |    | |__) | |__) | |  | |    | | |__ | |       | |   
* |  _  /|  __| | |      | |   / /\ \ | . ` |  | |    |  ___/|  _  /| |  | |_   | |  __|| |       | |   
* | | \ \| |____| |____ _| |_ / ____ \| |\  |  | |    | |    | | \ \| |__| | |__| | |___| |____   | |   
* |_|  \_\______|______|_____/_/    \_\_| \_|  |_|    |_|    |_|  \_\\____/ \____/|______\_____|  |_|   
*

*   @Author : Noddy
*   @Date : 7.12.2024

*/

#include <ylessinc\YSI_Coding\y_hooks>

#define INVALID_BANK_ACCOUNT   (-1);

enum {

    BANK_ACCOUNT_TYPE_INVALID = -1,

    BANK_ACCOUNT_TYPE_NORMAL = 1,
    BANK_ACCOUNT_TYPE_PREMIUM,
    BANK_ACCOUNT_TYPE_DIAMOND,
    BANK_ACCOUNT_TYPE_VIP,
}

enum e_PLAYER_FINANCE {

    playerID,
    bankAccount,
    bankAccountType,
    bankAccountPin,
    bankLoan,
    bankMoney
}

new FinanceInfo[MAX_PLAYERS][e_PLAYER_FINANCE];

forward mysql_LoadPlayerFinance(playerid);
public mysql_LoadPlayerFinance(playerid) {

    new rows = cache_num_rows();

    if(!rows) {

        new q[246];
        mysql_format(SQL, q, sizeof q, "INSERT INTO `player_finance` (`ID`, `BankAccount`, `AccountType`, `AccountPin`, `Loan`, `BankMoney`) \
                                        VALUES ('%d', '%d', '%d', '0', '0', '0')", 
                                        UserInfo[playerid][ID], INVALID_BANK_ACCOUNT, BANK_ACCOUNT_TYPE_INVALID);
        mysql_tquery(MySQL:SQL, q);
    }

    else {

        for(new j = 0; j < rows; j++) {

            cache_get_value_name_int(i, "ID", FinanceInfo[playerid][playerID]);
            cache_get_value_name_int(i, "BankAccount", FinanceInfo[playerid][bankAccount]);
            cache_get_value_name_int(i, "AccountType", FinanceInfo[playerid][bankAccountType]);
            cache_get_value_name_int(i, "AccountPin", FinanceInfo[playerid][bankAccountPin]);
            cache_get_value_name_int(i, "Loan", FinanceInfo[playerid][bankLoan]);
            cache_get_value_name_int(i, "BankMoney", FinanceInfo[playerid][bankMoney]);

        }
    }

    return (true);
}

hook OnPlayerLoaded(playerid) {

    new q[246];
    mysql_format(SQL, q, sizeof q, "SELECT * FROM `player_finance` WHERE `ID` = '%d'", UserInfo[playerid][ID]);
    mysql_tquery(SQL, q, "mysql_LoadPlayerFinance", "d", playerid);

    return Y_HOOKS_CONTINUE_RETURN_1;
}