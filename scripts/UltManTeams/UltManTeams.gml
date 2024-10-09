function UltManTeams() {
   
	teamList = ds_list_create()
	
	for (var i = 0; i < 20; ++i) {
		
		var newTeam = new UltManTeam()
	
		ds_list_add(teamList,newTeam)
		
	}

    return teamList
}
