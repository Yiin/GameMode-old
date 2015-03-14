#include <YSI\YSI_Coding\y_hooks>



hook OnPlayerConnect(playerid) {
	static username[MAX_PLAYER_NAME];
	GetPlayerName(playerid, username, MAX_PLAYER_NAME);

	format_query("SELECT * FROM users WHERE username = %s", username);
	new Cache:cache = mysql_query(database, query);

	if(cache_get_row_count()) {
		login(playerid, cache_save());
	}
	else {
		cache_delete(cache);
		register(playerid);
	}
}

static login(playerid, Cache:cache, fails = 0) {
	if(fails) {
		M:P:E(playerid, "Slaptaþodis neteisingas! (%i/3)", fails);
		if(fails == 3) {
			Kick(playerid);
		}
	}
	inline login_response(response, li) {
		#pragma unused li
		if(response) {
			static input_password[129];
			WP_Hash(input_password, dialog_Input);

			static real_password[129];
			cache_get_field_content(0, "password", real_password);

			if( ! strcmp(input_password, real_password)) {
				classSelection_Show(playerid);
			}
			else {
				login(playerid, cache, fails + 1);
			}
		}
	}
	dialogHeader("Prisijungimas");
	dialogAddOption("Norëdamas prisijungti ávesk savo slaptaþodá.");
	dialogShow(playerid, using inline login_response, " ", g_DialogText, "Prisijungti", "");
}

static register(playerid) {
	inline register_reponse(response, li) {
		#pragma unused li
		if(response) {
			static password[129];
			WP_Hash(password, dialog_Input);

			sql_
		}
	}
}