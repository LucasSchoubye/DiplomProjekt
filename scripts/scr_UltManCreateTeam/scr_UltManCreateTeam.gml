// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_UltManCreateTeam(){

enum TeamFormations
{
	FourFourTwo,
	FourThreeThree,
}


	switch(TeamFormations.FourFourTwo)
	{
		case TeamFormations.FourFourTwo:
			// Goalie
			var player = instance_create_depth(room_width*0.1,room_height*0.5,0,obj_UltManPlayer)
			player.position = FootballPositions.GK
			
			// Defehders
			var player = instance_create_depth(room_width*0.3,room_height*0.4,0,obj_UltManPlayer)
			player.position = FootballPositions.CB
			var player = instance_create_depth(room_width*0.3,room_height*0.6,0,obj_UltManPlayer)
			player.position = FootballPositions.CB
			var player = instance_create_depth(room_width*0.3,room_height*0.2,0,obj_UltManPlayer)
			player.position = FootballPositions.LB
			var player = instance_create_depth(room_width*0.3,room_height*0.8,0,obj_UltManPlayer)
			player.position = FootballPositions.RB
			
			// Midfielders
			var player = instance_create_depth(room_width*0.5,room_height*0.4,0,obj_UltManPlayer)
			player.position = FootballPositions.CM
			var player = instance_create_depth(room_width*0.5,room_height*0.6,0,obj_UltManPlayer)
			player.position = FootballPositions.CM
			var player = instance_create_depth(room_width*0.5,room_height*0.2,0,obj_UltManPlayer)
			player.position = FootballPositions.LM
			var player = instance_create_depth(room_width*0.5,room_height*0.8,0,obj_UltManPlayer)
			player.position = FootballPositions.RM
			
			// Strikers
			var player = instance_create_depth(room_width*0.6,room_height*0.4,0,obj_UltManPlayer)
			player.position = FootballPositions.ST
			var player = instance_create_depth(room_width*0.6,room_height*0.6,0,obj_UltManPlayer)
			player.position = FootballPositions.ST
		break;
	}

}