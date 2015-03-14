/*
 * server/database
 *
 * Serverio duomenø bazë
 */

#include <a_mysql>
#include <YSI\YSI_Coding\y_hooks>

#define format_query(%0,%1) \
	mysql_format(database, %0, sizeof %0, %1)

#define _host "localhost"
#define _database "gamemode"
#define _username "root"
#define _password ""

new database;
new query[2000];

hook OnGameModeInit() {
	// #define filename "sql_create_database.txt"

	// if(file_exists(filename)) {
	// 	new File:file = fopen(filename, io_read);

	// 	if(file) {
	// 		fread(file, query);
			
				mysql_log();
	   
				database = mysql_connect(_host, _username, _database, _password);

	// 		mysql_query(database, query, .use_cache = false);
	// 	}
	// }
	// #undef filename
}

hook OnGameModeExit() {
	mysql_close(database);
}