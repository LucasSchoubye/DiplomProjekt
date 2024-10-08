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
	
	// draw boxes
	draw_rectangle(matchBoxLeft, matchBoxTop, matchBoxRight, matchBoxBottom, true)
	draw_sprite(spr_manBluePlaceholder, 0, logoHomeBoxLeft, logoHomeBoxTop)
	//draw_rectangle(matchDetailsBoxLeft, matchDetailsBoxTop, matchDetailsBoxRight, matchDetailsBoxBottom, true)
	draw_sprite(spr_arsenalPlaceholder, 0, logoAwayBoxLeft, logoAwayBoxTop)
	
	// draw match detail info
	draw_set_color(#5666F9)
	draw_set_halign(fa_center)
	draw_set_valign(fa_top)
	draw_set_font(fn_RobotoMedium14)
	draw_text(matchDetailsBoxCenter , matchDetailsBoxTop + 2, "Next Match")
	draw_set_color(#FFFFFF)
	draw_set_font(fn_RobotoRegular12)
	draw_text(matchDetailsBoxCenter , matchDetailsBoxTop + 24, "Sunday 22nd September 2024")
	
	// draw dividers
	draw_set_alpha(0.3)
	draw_line(matchDetailsDividerLeft, matchDetailsBoxTop + 48, matchDetailsDividerRight,matchDetailsBoxTop + 48)
	draw_line(matchDetailsDividerLeft, matchDetailsBoxTop + 166, matchDetailsDividerRight,matchDetailsBoxTop + 166)
	draw_set_alpha(currentAlpha)
	
	draw_set_font(fn_RobotoBlack16)
	try
	{
		draw_text(matchDetailsBoxCenter , matchDetailsBoxTop + 54, string_copy(playerOpponentTeam.clubName, 0, 13)+". v "+string_copy(clubName, 0, 13)+".")
	}
	catch(error){}
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
	draw_set_font(fn_RobotoBlack8)
	draw_text(matchDetailsBoxCenter, matchDetailsBoxTop + 175, "PREVIOUS MEETINGS")
	
	draw_set_font(fn_RobotoBlack14)
	
	var previousMeetings = [0,0,1,1,2]
	var previousMeetingsY = matchDetailsBoxTop + 190
	var previousMeetingsPaddingX = 20
	var previousMeetingsX = matchDetailsBoxCenter
	draw_set_halign(fa_center)
	
	for (var i = 0; i < array_length(previousMeetings); ++i) {
	
		var resultText = "";
		var resultColor = c_white;
		
		switch (previousMeetings[i]) {
        case 0:
            resultText = "L";
            resultColor = #BA1414;
            break;
        case 1:
            resultText = "W";
            resultColor = #007B1B;
            break;
        case 2:
            resultText = "D";
            resultColor = #929292;
            break;
		}
		
		draw_set_color(resultColor)
		draw_text(previousMeetingsX - 2*previousMeetingsPaddingX + i * previousMeetingsPaddingX, previousMeetingsY, resultText)
	}
	
	// draw League Table
	var rowHeight = 30
	var leagueTableLeft = room_width * 0.725;
	var leagueTableRight = room_width * 0.95;
	var leagueTableTop = room_height * 0.08 + rowHeight;
	var numberPadding = 25
	
	// Draw table
	draw_set_color(c_white)
	draw_set_alpha(0.1)
	draw_roundrect(leagueTableLeft - numberPadding/1.5, leagueTableTop+rowHeight/1.5, leagueTableRight + numberPadding/1.5, leagueTableTop + rowHeight*(ds_list_size(teamList)+1), false)
	draw_set_alpha(1)
	
	draw_set_font(fn_textLato)
	// Draw first row
	draw_text(leagueTableLeft,leagueTableTop, "PL");
	draw_set_halign(fa_center)
	draw_text(leagueTableRight - numberPadding*4,leagueTableTop, "P");
	draw_text(leagueTableRight - numberPadding*3,leagueTableTop, "W");
	draw_text(leagueTableRight - numberPadding*2,leagueTableTop, "D");
	draw_text(leagueTableRight - numberPadding,leagueTableTop, "L");
	draw_text(leagueTableRight, leagueTableTop, "Pts.");
	
	for (var i = 0; i < ds_list_size(teamList); ++i) {
		var team = ds_list_find_value(teamList, i)
		
		// Draw Name
		var shownTeamName = team.clubName;
		if (string_width(shownTeamName) > 150) {
		    shownTeamName = string_copy(shownTeamName,1, 14);
		}
		
		// Draw Numbers
		var sepLenght = leagueTableTop + rowHeight*(i+1)
		draw_set_halign(fa_center)
		draw_text(leagueTableLeft,sepLenght, i+1);
		draw_set_halign(fa_left)
		draw_text(leagueTableLeft + 20,sepLenght, shownTeamName);
		draw_set_halign(fa_center)
		draw_text(leagueTableRight - numberPadding*4,sepLenght, team.matchesPlayed);
		draw_text(leagueTableRight - numberPadding*3,sepLenght, team.matchesWon);
		draw_text(leagueTableRight - numberPadding*2,sepLenght, team.matchesDrawn);
		draw_text(leagueTableRight - numberPadding,sepLenght, team.matchesLost);
		draw_text(leagueTableRight, sepLenght, team.totalPoints);
		
		// Draw selected team
		if (team.clubName = obj_UltManManagerController.clubName)
		{
			draw_set_alpha(0.2)
			draw_rectangle(leagueTableLeft - numberPadding/1.5, leagueTableTop + rowHeight*(i+1) - rowHeight/6, leagueTableRight + numberPadding/1.5, leagueTableTop + rowHeight*(i+2) - rowHeight/6, false)
			draw_set_alpha(1)
		}
		
		// Draw Opponent Team
		if (team.clubName = obj_UltManManagerController.playerOpponentTeam.clubName)
		{
			draw_set_alpha(0.6)
			draw_rectangle(leagueTableLeft - numberPadding/1.5, leagueTableTop + rowHeight*(i+1) - rowHeight/6, leagueTableRight + numberPadding/1.5, leagueTableTop + rowHeight*(i+2) - rowHeight/6, true)
			draw_set_alpha(1)
		}
	}
	
	draw_set_color(c_white)
	draw_set_halign(fa_center)
	draw_set_font(fn_RobotoMedium14)
	
	var teamStatsBoxTop = room_height * 0.45;
	var teamStatsBoxBottom = room_height * 0.9;
	var teamStatsBoxLeft = room_width * 0.2;
	var teamStatsBoxRight = room_width * 0.45;
	var teamStatsBoxCenter = (teamStatsBoxLeft + teamStatsBoxRight) / 2
	draw_text(teamStatsBoxCenter, room_height * 0.4625, "Team Stats")
	
	//var teamStats = [[spr_leagueImage,21],[spr_goalsScored, 51],[spr_goalsConceded, 12],[spr_yellowCards, 38],[spr_redCards, 1]]
	
	var playerStatsBoxTop = room_height * 0.45;
	var playerStatsBoxBottom = room_height * 0.9;
	var playerStatsBoxLeft = room_width * 0.45;
	var playerStatsBoxRight = room_width * 0.7;
	var playerStatsBoxCenter = (playerStatsBoxLeft + playerStatsBoxRight) / 2
	draw_text(playerStatsBoxCenter, room_height * 0.4625, "Player Stats")
	
	draw_rectangle(teamStatsBoxLeft, teamStatsBoxTop, teamStatsBoxRight, teamStatsBoxBottom, true)
	draw_rectangle(playerStatsBoxLeft, playerStatsBoxTop, playerStatsBoxRight, playerStatsBoxBottom, true)
	
	// reset stuff
	draw_set_valign(currentVAlign)
	draw_set_halign(currentHAlign)
	draw_set_color(currentColour)
	draw_set_font(currentFont)
	draw_set_alpha(currentAlpha)
}