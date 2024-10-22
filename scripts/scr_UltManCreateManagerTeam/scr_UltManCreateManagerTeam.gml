// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_UltManCreateManagerTeam(){

	// For each column
	for (var line = 0; line < array_length(obj_UltManManagerController.formationColumns); ++line) {
	    
		var list = obj_UltManManagerController.formationColumns[line]
		
		
		for (var i = 0; i < ds_list_size(list); ++i) 
		{
		    var player = instance_create_depth(line * room_width*-0.08 + room_width*0.4, room_height/(ds_list_size(list)+1)*(i+1) ,0,obj_UltManPlayer)
			var manPlayer = ds_list_find_value(list, i)
			
			player.position = manPlayer.position
			player.name = manPlayer.name
			player.playerStruct = manPlayer
			
			// Stats
			player.defence = manPlayer.defence
			player.dribbling = manPlayer.dribbling
			player.topSpd = manPlayer.topSpd
			player.strength = manPlayer.strength
			player.topPassSpd = manPlayer.topPassSpd
			player.topShootSpd = manPlayer.topShootSpd
			player.shooting = manPlayer.shooting
			player.passing = manPlayer.passing
		}
	}

}