/*
 * player/data
 *
 * Þaidëjo informacija
 */

#include <YSI\YSI_Coding\y_hooks>

new 
	player_Name[MAX_PLAYERS][MAX_PLAYER_NAME],

	ORM:player_ORM[MAX_PLAYERS],
	player_ID[MAX_PLAYERS],

	Float:player_Health[MAX_PLAYERS],
	Float:player_MaxHealth[MAX_PLAYERS],

	player_DefaultSkin[MAX_PLAYERS],
	player_AvailableSkins[MAX_PLAYERS][300 char],
	player_CurrentSkin[MAX_PLAYERS],

	player_Cash[MAX_PLAYERS],
	player_Bank[MAX_PLAYERS],
	player_BankPin[MAX_PLAYERS],

	player_Level[MAX_PLAYERS],

	// game/jobs
	player_Job[MAX_PLAYERS],
	player_JobRank[MAX_PLAYERS],

	Float:player_PosX[MAX_PLAYERS],
	Float:player_PosY[MAX_PLAYERS],
	Float:player_PosZ[MAX_PLAYERS],
	Float:player_PosA[MAX_PLAYERS]
;

playerData_LoadChar(playerid) {
	GetPlayerName(playerid, player_Name[playerid], MAX_PLAYER_NAME);
	new ORM:ormid = player_ORM[playerid] = orm_create("chars");

	orm_addvar_int(ormid, player_ID[playerid], "uid");
	orm_addvar_string(ormid, player_Name[playerid], MAX_PLAYER_NAME + 1, "name");

	orm_addvar_float(ormid, player_Health[playerid], "health");
	orm_addvar_float(ormid, player_MaxHealth[playerid], "max_health");

	orm_addvar_int(ormid, player_DefaultSkin[playerid], "default_skin");
	orm_addvar_int(ormid, player_CurrentSkin[playerid], "current_skin");
	orm_addvar_string(ormid, player_AvailableSkins[playerid], 301, "available_skins");

	orm_addvar_int(ormid, player_Cash[playerid], "cash");
	orm_addvar_int(ormid, player_Bank[playerid], "bank");
	orm_addvar_int(ormid, player_BankPin[playerid], "bank_pin");

	orm_addvar_int(ormid, player_Level[playerid], "level");

	orm_addvar_int(ormid, player_Job[playerid], "job");
	orm_addvar_int(ormid, player_JobRank[playerid], "job_rank");

	orm_addvar_float(ormid, player_PosX[playerid], "posX");
	orm_addvar_float(ormid, player_PosY[playerid], "posY");
	orm_addvar_float(ormid, player_PosZ[playerid], "posZ");
	orm_addvar_float(ormid, player_PosZ[playerid], "angle");
	
	orm_setkey(ormid, "name");
	orm_select(ormid, "OnPlayerDataLoad", "d", playerid);
}

forward OnPlayerDataLoad(playerid); 
public OnPlayerDataLoad(playerid)
{
	switch(orm_errno(player_ORM[playerid])) 
	{
		case ERROR_OK: {
			gameStart_Spawn(playerid);
		}
		case ERROR_NO_DATA: {
			classSelection_Show(playerid);
		}
	}
	orm_setkey(player_ORM[playerid], "uid");
	return 1;
}

playerData_SaveChar(playerid) {
	if(player_ID[playerid] != 0) {
		orm_update(player_ORM[playerid]);	
	}
}

hook OnPlayerDisconnect(playerid, reason) {
	playerData_SaveChar(playerid);

	orm_destroy(player_ORM[playerid]);

	resetPlayerVars(playerid);
}

resetPlayerVars(playerid) {
	player_Name           [playerid][0] = EOS;
	player_ORM            [playerid] = ORM:0;
	player_ID             [playerid] = 0;
	player_Health         [playerid] = 50.0;
	player_MaxHealth      [playerid] = 50.0;
	player_DefaultSkin    [playerid] = 0;
	player_AvailableSkins [playerid]{0} = EOS;
	player_CurrentSkin    [playerid] = 0;
	player_Cash           [playerid] = 0;
	player_Bank           [playerid] = 0;
	player_BankPin        [playerid] = 0;
	player_Level          [playerid] = 0;
	player_Job            [playerid] = JOB_NONE;
	player_JobRank        [playerid] = 0;
	player_PosX           [playerid] = 0.0;
	player_PosY           [playerid] = 0.0;
	player_PosZ           [playerid] = 0.0;
	player_PosA           [playerid] = 0.0;
}