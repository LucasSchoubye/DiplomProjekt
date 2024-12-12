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
	
	var LC = obj_languageController
	
	// draw boxes
	//draw_rectangle(matchBoxLeft, matchBoxTop, matchBoxRight, matchBoxBottom, true)
	//draw_sprite(spr_manaquaPlaceholder, 0, logoHomeBoxLeft, logoHomeBoxTop)
	//draw_rectangle(matchDetailsBoxLeft, matchDetailsBoxTop, matchDetailsBoxRight, matchDetailsBoxBottom, true)
	//draw_sprite(spr_arsenalPlaceholder, 0, logoAwayBoxLeft, logoAwayBoxTop)
	
	// draw match detail info
	draw_set_color(#5666F9)
	draw_set_halign(fa_center)
	draw_set_valign(fa_top)
	draw_set_font(fn_RobotoMedium14)
	draw_text(matchDetailsBoxCenter , matchDetailsBoxTop + 20, LC.translate("Next Match - Week ")+string(gameweekCounter+1))
	draw_set_color(#FFFFFF)
	draw_set_font(fn_RobotoRegular12)
	//draw_text(matchDetailsBoxCenter , matchDetailsBoxTop + 24, "Sunday 22nd September 2024")
	
	// draw dividers
	draw_set_alpha(0.3)
	draw_line(matchDetailsDividerLeft, matchDetailsBoxTop + 48, matchDetailsDividerRight,matchDetailsBoxTop + 48)
	draw_line(matchDetailsDividerLeft, matchDetailsBoxTop + 166, matchDetailsDividerRight,matchDetailsBoxTop + 166)
	draw_set_alpha(currentAlpha)
	
	//draw_set_font(fn_RobotoBlack16)
	draw_set_font(fn_konk18)
	try
	{
		draw_text(matchDetailsBoxCenter , matchDetailsBoxTop + 64, string_copy(playerOpponentTeam.clubName, 0, 13)+". v "+string_copy(clubName, 0, 13)+".")
	}
	catch(error){}
	
	draw_set_font(fn_RobotoBlack16)
	draw_text(matchDetailsBoxCenter , matchDetailsBoxTop + 112,  ordinalNumber(ds_list_find_index(teamList, playerOpponentTeam)+1)+". vs "+ordinalNumber(ds_list_find_index(teamList, playerClub)+1)+".")
	//draw_text(matchDetailsBoxCenter , matchDetailsBoxTop + 136, "Premier League")
	
	draw_set_font(fn_RobotoRegular12)
	
	var matchDetailsStadiumY = matchDetailsBoxTop + 144
	var matchDetailsStadiumSize = sprite_get_width(spr_UltManStadiumWhite) * 0.25
	var stadiumName = "Emptyhad Stadium"
	var stadiumNamePadding = 4
	//draw_sprite_ext(spr_UltManStadiumWhite,0,matchDetailsBoxCenter - matchDetailsStadiumSize / 2 - string_width(stadiumName)/2 - stadiumNamePadding / 2,
	//matchDetailsStadiumY, 0.25, 0.25, 0, c_white, currentAlpha)
	//draw_text(matchDetailsBoxCenter +  matchDetailsStadiumSize / 2 + stadiumNamePadding / 2, matchDetailsStadiumY, stadiumName)
	
	var matchDetailsWeatherY = matchDetailsBoxTop + 144
	var matchDetailsRainSize = sprite_get_width(spr_UltManRain) * 0.25
	var weatherName = "Rain 17°C"
	//draw_sprite_ext(spr_UltManRain,0,matchDetailsBoxCenter - matchDetailsRainSize / 2 - string_width(weatherName)/2 - stadiumNamePadding / 2,
	//matchDetailsWeatherY, 0.25, 0.25, 0, c_white, currentAlpha)
	//draw_text(matchDetailsBoxCenter +  matchDetailsRainSize / 2 + stadiumNamePadding / 2, matchDetailsWeatherY, weatherName)
	draw_set_font(fn_RobotoBlack8)
	//draw_text(matchDetailsBoxCenter, matchDetailsBoxTop + 175, "PREVIOUS MEETINGS")
	
	draw_set_font(fn_RobotoBlack14)
	
	var previousMeetings = [0,0,1,1,2]
	var previousMeetingsY = matchDetailsBoxTop + 190
	var previousMeetingsPaddingX = 20
	var previousMeetingsX = matchDetailsBoxCenter
	draw_set_halign(fa_center)
	
	//for (var i = 0; i < array_length(previousMeetings); ++i) {
	
	//	var resultText = "";
	//	var resultColor = c_white;
		
	//	switch (previousMeetings[i]) {
    //    case 0:
    //        resultText = "L";
    //        resultColor = #BA1414;
    //        break;
    //    case 1:
    //        resultText = "W";
    //        resultColor = #007B1B;
    //        break;
    //    case 2:
    //        resultText = "D";
    //        resultColor = #929292;
    //        break;
	//	}
		
	//	draw_set_color(resultColor)
	//	draw_text(previousMeetingsX - 2*previousMeetingsPaddingX + i * previousMeetingsPaddingX, previousMeetingsY, resultText)
	//}
	
	// draw League Table
	var rowHeight = 30
	var leagueTableLeft = room_width * 0.75;
	var leagueTableRight = room_width * 0.975;
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
	draw_text(leagueTableRight - numberPadding*4,leagueTableTop, LC.translate("P"));
	draw_text(leagueTableRight - numberPadding*3,leagueTableTop, LC.translate("W"));
	draw_text(leagueTableRight - numberPadding*2,leagueTableTop, LC.translate("D"));
	draw_text(leagueTableRight - numberPadding,leagueTableTop, LC.translate("L"));
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
	draw_set_font(fn_RobotoBlack16)
	
	var teamStatsBoxTop = room_height * 0.425;
	var teamStatsBoxBottom = room_height * 0.9;
	var teamStatsBoxLeft = room_width * 0.2;
	var teamStatsBoxRight = room_width * 0.45;
	var teamStatsBoxCenter = (teamStatsBoxLeft + teamStatsBoxRight) / 2
	var teamStatsStart = teamStatsBoxLeft + 75
	var teamStatsRow = 50
	draw_text(teamStatsBoxCenter, room_height * 0.40, LC.translate("Team Stats"))
	draw_set_halign(fa_left)
	try{
		for (var i = 0; i < array_length(teamStats); ++i) {
			draw_set_color(c_white)
			draw_set_font(fn_RobotoBlack16)
			var teamStatsSpace = teamStatsBoxTop + teamStatsRow*(i+1) - 30
			var statName = teamStats[i][0]
			var statSprite = teamStats[i][1]
			var statNumber = teamStats[i][2]
			var statNumberSize = string_width(string(statNumber))
			var statPlacement = teamStatsBoxTop + teamStatsRow*(i+1)
			draw_sprite_stretched(statSprite,false,teamStatsStart, teamStatsSpace, 47, 47)
			draw_text(teamStatsStart + 56, teamStatsSpace , string(statNumber))
			draw_set_font(fn_RobotoRegular12)
			draw_set_color(c_grey)
			draw_text(teamStatsStart + 56, teamStatsSpace + 25  , statName)
		}
	}
	catch(error){}
	
	draw_set_color(c_white)
	draw_set_font(fn_RobotoBlack16)
	
	var playerStatsBoxTop = room_height * 0.425;
	var playerStatsBoxBottom = room_height * 0.9;
	var playerStatsBoxLeft = room_width * 0.45;
	var playerStatsBoxRight = room_width * 0.7;
	var playerStatsBoxCenter = (playerStatsBoxLeft + playerStatsBoxRight) / 2
	var playerStatsBoxStart = playerStatsBoxLeft + 75;
	var maxGoalsScored = 0
	var maxGoalsScoredPlayerName = undefined
	var maxAssists = 0
	var maxAssistsPlayerName = undefined
	var maxTackles = 0
	var maxTacklesPlayerName = undefined
	var maxAttemptedPasses = 0
	var maxAttemptedPassesPlayerName = undefined
	var maxAttemptedShots = 0
	var maxAttemptedShotsPlayerName = undefined	
	var maxTouches = 0
	var maxTouchesPlayerName = undefined	
	draw_set_halign(fa_center)
	draw_text(playerStatsBoxCenter, room_height * 0.40, LC.translate("Player Stats"))
	draw_set_halign(fa_left)
	
	
	var playerStatsRow = 50
	try{
		for (var i = 0; i < ds_list_size(squad); ++i) {
			var player = ds_list_find_value(squad, i)
			
			if(player.goalsScored >= maxGoalsScored){
				maxGoalsScored = player.goalsScored
				maxGoalsScoredPlayerName = player.name[0] + " " + player.name[1]
			}
			if(player.assists >= maxAssists){
				maxAssists = player.assists
				maxAssistsPlayerName = player.name[0] + " " + player.name[1]
			}
			if(player.tackles >= maxTackles){
				maxTackles = player.tackles
				maxTacklesPlayerName = player.name[0] + " " + player.name[1]
			}
			if(player.attemptedPasses >= maxAttemptedPasses){
				maxAttemptedPasses = player.attemptedPasses
				maxAttemptedPassesPlayerName = player.name[0] + " " + player.name[1]
			}
			if(player.attemptedShots >= maxAttemptedShots){
				maxAttemptedShots = player.attemptedShots
				maxAttemptedShotsPlayerName = player.name[0] + " " + player.name[1]
			}
			if(player.touches >= maxTouches){
				maxTouches = player.touches
				maxTouchesPlayerName = player.name[0] + " " + player.name[1]
			}
		}
		draw_sprite_stretched(spr_UltManGoalscorer,false,playerStatsBoxStart, playerStatsBoxTop + playerStatsRow*(1) - 30, 47, 47)
		draw_text(playerStatsBoxStart + 56, playerStatsBoxTop + playerStatsRow*(1) - 30 , string(maxGoalsScored) + " " + maxGoalsScoredPlayerName)
		
		draw_sprite_stretched(spr_UltManAssist,false,playerStatsBoxStart, playerStatsBoxTop + playerStatsRow*(2) - 30, 47, 47)
		draw_text(playerStatsBoxStart + 56, playerStatsBoxTop + playerStatsRow*(2) - 30 , string(maxAssists) + " " + maxAssistsPlayerName)
			
		draw_sprite_stretched(spr_UltManShield,false,playerStatsBoxStart, playerStatsBoxTop + playerStatsRow*(3) - 30, 47, 47)
		draw_text(playerStatsBoxStart + 56, playerStatsBoxTop + playerStatsRow*(3) - 30 , string(maxTackles) + " " + maxTacklesPlayerName)
			
		draw_sprite_stretched(spr_UltManPasses,false,playerStatsBoxStart, playerStatsBoxTop + playerStatsRow*(4) - 30, 47, 47)
		draw_text(playerStatsBoxStart + 56, playerStatsBoxTop + playerStatsRow*(4) - 30 , string(maxAttemptedPasses) + " " + maxAttemptedPassesPlayerName)
		
		draw_sprite_stretched(spr_UltManTarget,false,playerStatsBoxStart, playerStatsBoxTop + playerStatsRow*(5) - 30, 47, 47)
		draw_text(playerStatsBoxStart + 56, playerStatsBoxTop + playerStatsRow*(5) - 30 , string(maxAttemptedShots) + " " + maxAttemptedShotsPlayerName)
		
		draw_sprite_stretched(spr_UltManTouches,false,playerStatsBoxStart, playerStatsBoxTop + playerStatsRow*(6) - 30, 47, 47)
		draw_text(playerStatsBoxStart + 56, playerStatsBoxTop + playerStatsRow*(6) - 30 , string(maxTouches) + " " + maxTouchesPlayerName)
		
		draw_set_font(fn_RobotoRegular12)
		draw_set_color(c_grey)
		draw_text(playerStatsBoxStart + 56, playerStatsBoxTop + playerStatsRow*(1) - 5 , LC.translate("Top Goalscorer"))
		draw_text(playerStatsBoxStart + 56, playerStatsBoxTop + playerStatsRow*(2) - 5 , LC.translate("Most Assists"))
		draw_text(playerStatsBoxStart + 56, playerStatsBoxTop + playerStatsRow*(3) - 5 , LC.translate("Most Tackles"))
		draw_text(playerStatsBoxStart + 56, playerStatsBoxTop + playerStatsRow*(4) - 5 , LC.translate("Attempted Passes"))
		draw_text(playerStatsBoxStart + 56, playerStatsBoxTop + playerStatsRow*(5) - 5 , LC.translate("Attempted Shots"))
		draw_text(playerStatsBoxStart + 56, playerStatsBoxTop + playerStatsRow*(6) - 5 , LC.translate("Most Touches"))
	}
	catch(error){}
	
	//draw_rectangle(teamStatsBoxLeft, teamStatsBoxTop, teamStatsBoxRight, teamStatsBoxBottom, true)
	//draw_rectangle(playerStatsBoxLeft, playerStatsBoxTop, playerStatsBoxRight, playerStatsBoxBottom, true)
	
	// reset stuff
	draw_set_valign(currentVAlign)
	draw_set_halign(currentHAlign)
	draw_set_color(currentColour)
	draw_set_font(currentFont)
	draw_set_alpha(currentAlpha)
}

function ordinalNumber(number)
{
	switch(number)
	{
		case 1:
			return "1st"
		case 2:
			return "2nd"
		case 3:
			return "3rd"
		default:
			return string(number)+"th"
	}
}