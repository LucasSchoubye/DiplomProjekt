// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_ultManHome(){
	
	var matchBoxTop = room_height * 0.1;
	var matchBoxBottom = room_height * 1;
	var matchBoxLeft = room_width * 0.2;
	var matchBoxRight = room_width * 0.7;
	
	var logoHomeBoxTop = room_height * 0.175;
	var logoHomeBoxLeft = room_width * 0.275;
	
	var logoAwayBoxTop = room_height * 0.175;
	var logoAwayBoxLeft = room_width * 0.625;
	
	var matchDetailsBoxTop = room_height * 0.15;
	var matchDetailsBoxBottom = room_height * 0.35;
	var matchDetailsBoxLeft = room_width * 0.35;
	var matchDetailsBoxRight = room_width * 0.55;
	
	var teamStatsBoxTop = room_height * 0.4;
	var teamStatsBoxBottom = room_height * 0.8;
	var teamStatsBoxLeft = room_width * 0.2;
	var teamStatsBoxRight = room_width * 0.45;
	
	var playerStatsBoxTop = room_height * 0.4;
	var playerStatsBoxBottom = room_height * 0.8;
	var playerStatsBoxLeft = room_width * 0.45;
	var playerStatsBoxRight = room_width * 0.7;
	
	// draw boxes
	draw_rectangle(matchBoxLeft, matchBoxTop, matchBoxRight, matchBoxBottom, true)
	draw_sprite(spr_manBluePlaceholder, 0, logoHomeBoxLeft, logoHomeBoxTop)
	draw_rectangle(matchDetailsBoxLeft, matchDetailsBoxTop, matchDetailsBoxRight, matchDetailsBoxBottom, true)
	draw_sprite(spr_arsenalPlaceholder, 0, logoAwayBoxLeft, logoAwayBoxTop)
	draw_rectangle(teamStatsBoxLeft, teamStatsBoxTop, teamStatsBoxRight, teamStatsBoxBottom, true)
	draw_rectangle(playerStatsBoxLeft, playerStatsBoxTop, playerStatsBoxRight, playerStatsBoxBottom, true)
}