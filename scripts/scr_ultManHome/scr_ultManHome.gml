// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_ultManHome(){
	
	var matchBoxTop = room_height * 0.1;
	var matchBoxBottom = room_height * 1;
	var matchBoxLeft = room_width * 0.2;
	var matchBoxRight = room_width * 0.7;
	
	var logoHomeBoxTop = room_height * 0.17;
	var logoHomeBoxBottom = room_height * 0.332;
	var logoHomeBoxLeft = room_width * 0.275;
	var logoHomeBoxRight = room_width * 0.312;
	
	var logoAwayBoxTop = room_height * 0.17;
	var logoAwayBoxBottom = room_height * 0.332;
	var logoAwayBoxLeft = room_width * 0.625;
	var logoAwayBoxRight = room_width * 0.312;
	
	var matchDetailsBoxTop = room_height * 0.17;
	var matchDetailsBoxBottom = room_height * 0.37;
	var matchDetailsBoxLeft = room_width * 0.35;
	var matchDetailsBoxRight = room_width * 0.55;
	
	var teamStatsBoxTop = room_height * 0.37;
	var teamStatsBoxBottom = room_height * 0.57;
	var teamStatsBoxLeft = room_width * 0.2;
	var teamStatsBoxRight = room_width * 0.45;
	
	var playerStatsBoxTop = room_height * 0.37;
	var playerStatsBoxBottom = room_height * 0.57;
	var playerStatsBoxLeft = room_width * 0.45;
	var playerStatsBoxRight = room_width * 0.7;
	
	// Team logo 1
	draw_rectangle(matchBoxLeft, matchBoxTop, matchBoxRight, matchBoxBottom, true)
	draw_sprite(spr_manBluePlaceholder, 0, logoHomeBoxLeft, logoHomeBoxTop)
	draw_rectangle(matchDetailsBoxLeft, matchDetailsBoxTop, matchDetailsBoxRight, matchDetailsBoxBottom, true)
	draw_sprite(spr_arsenalPlaceholder, 0, logoAwayBoxLeft, logoAwayBoxTop)
	draw_rectangle(teamStatsBoxLeft, teamStatsBoxTop, teamStatsBoxRight, teamStatsBoxBottom, true)
	draw_rectangle(playerStatsBoxLeft, playerStatsBoxTop, playerStatsBoxRight, playerStatsBoxBottom, true)
	
	
	// Match Details
	
	// Team logo 1
}