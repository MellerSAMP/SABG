#include <YSI\y_hooks>

new MySQL:databaseHandle;

hook OnGameModeInit() {
	print(" [MySQL] Connecting with credentials from.. \"scriptfiles\\mysql.ini\""),
	databaseHandle = mysql_connect_file("mysql.ini");
	if(mysql_errno(databaseHandle)) {
		printf(" [MySQL] Failed to connect to the database, returning error: (%i)\n Shutting down the server..", mysql_errno(databaseHandle));
		SendRconCommand("exit");
		return;
	}
	printf(" [MySQL] Estabilished a stable connection on handle (%i)", _:databaseHandle);
}