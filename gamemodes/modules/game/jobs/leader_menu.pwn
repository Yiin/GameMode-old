YCMD:dmeniu(playerid, params[], help) {
	if(help) {
		M:P:I(playerid, "Direktoriaus darbo valdymo meniu.");
	}
	if(player_JobRank[playerid] != JOB_RANK_LEADER) {
		M:P:E(playerid, "Ði komanda skirta tik direktoriams!");
	}
	new job = player_Job[playerid];

	dialogSetHeader(job_Name[job]);
	dialogAddOption("Darbuotojai %i/%i", jobOnline(job), jobTotal(job));
	dialogAddOption("Transportas %i/%i", jobActiveVehicles(job), jobTotalVehicles(job));
}

jobOnline(job) {
	new count;
	foreach(new i : Player) {
		if(player_Job[i] == job && job != JOB_NONE) {
			count++;
		}
	}
	return count;
}

jobTotal(job) {
	format_query(query, "SELECT * FROM chars WHERE job = %i", job);
	mysql_query(database, query);

	return cache_get_row_count(0);
}

jobActiveVehicles(job) {
	new count;
	foreach(new i : Vehicle) {
		if(vehicle_Job[i] == job && vehicle_Status[i] == VEHICLE_STATUS_ACTIVE) {
			count++;
		}
	}
	return count;
}

jobTotalVehicles(job) {
	format_query(query, "SELECT * FROM vehicles WHERE job = %i", job);
	mysql_query(database, query);

	return cache_get_row_count(0);
}