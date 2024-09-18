// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_ultManHome(){
	
	// get current colours
	var currentColour = draw_get_color()
	var currentVAlign = draw_get_valign()
	var currentHAlign = draw_get_halign()
	var currentFont = draw_get_font()
	var currentAlpha = draw_get_alpha()
	
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
	var matchDetailsBoxLeft = room_width * 0.325;
	var matchDetailsBoxRight = room_width * 0.575;
	var matchDetailsBoxCenter = (matchDetailsBoxLeft + matchDetailsBoxRight) / 2
	var matchDetailsDividerLeft = room_width * 0.3375;
	var matchDetailsDividerRight = room_width * 0.5625;
	
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
	//draw_rectangle(matchDetailsBoxLeft, matchDetailsBoxTop, matchDetailsBoxRight, matchDetailsBoxBottom, true)
	draw_sprite(spr_arsenalPlaceholder, 0, logoAwayBoxLeft, logoAwayBoxTop)
	draw_rectangle(teamStatsBoxLeft, teamStatsBoxTop, teamStatsBoxRight, teamStatsBoxBottom, true)
	draw_rectangle(playerStatsBoxLeft, playerStatsBoxTop, playerStatsBoxRight, playerStatsBoxBottom, true)
	
	// draw match detail info
	draw_set_color(#5666F9)
	draw_set_halign(fa_center)
	draw_set_valign(fa_top)
	draw_set_font(fn_RobotoMedium14)
	draw_text(matchDetailsBoxCenter , matchDetailsBoxTop + 2, "Next Match")
	draw_set_color(#FFFFFF)
	draw_set_font(fn_RobotoRegular12)
	draw_text(matchDetailsBoxCenter , matchDetailsBoxTop + 24, "Sunday 22nd September 2024")
	draw_set_alpha(0.3)
	draw_line(matchDetailsDividerLeft, matchDetailsBoxTop + 48, matchDetailsDividerRight,matchDetailsBoxTop + 48)
	draw_set_alpha(currentAlpha)
	draw_set_font(fn_RobotoBlack16)
	draw_text(matchDetailsBoxCenter , matchDetailsBoxTop + 54, "Manchester City v Arsenal")
	draw_set_font(fn_RobotoRegular12)
	draw_text(matchDetailsBoxCenter , matchDetailsBoxTop + 78, "1st vs 2nd")
	draw_text(matchDetailsBoxCenter , matchDetailsBoxTop + 96, "Premier League")
	
	var matchDetailsStadiumY = matchDetailsBoxTop + 120
	var matchDetailsStadiumSize = sprite_get_width(spr_UltManStadiumWhite) * 0.25
	var stadiumName = "Emptyhad Stadium"
	var stadiumNamePadding = 4
	draw_sprite_ext(spr_UltManStadiumWhite,0,matchDetailsBoxCenter - matchDetailsStadiumSize / 2 - string_width(stadiumName)/2 - stadiumNamePadding / 2,
	matchDetailsStadiumY, 0.25, 0.25, 0, c_white, currentAlpha)
	draw_text(matchDetailsBoxCenter +  matchDetailsStadiumSize / 2 + stadiumNamePadding / 2, matchDetailsStadiumY, stadiumName)
	
	var matchDetailsWeatherY = matchDetailsBoxTop + 144
	var matchDetailsRainSize = sprite_get_width(spr_UltManRain) * 0.25
	var weatherName = "Rain 17°C"
	draw_sprite_ext(spr_UltManRain,0,matchDetailsBoxCenter - matchDetailsRainSize / 2 - string_width(weatherName)/2 - stadiumNamePadding / 2,
	matchDetailsWeatherY, 0.25, 0.25, 0, c_white, currentAlpha)
	draw_text(matchDetailsBoxCenter +  matchDetailsRainSize / 2 + stadiumNamePadding / 2, matchDetailsWeatherY, weatherName)
	
	
	// reset stuff
	draw_set_valign(currentVAlign)
	draw_set_halign(currentHAlign)
	draw_set_color(currentColour)
	draw_set_font(currentFont)
	draw_set_alpha(currentAlpha)
}