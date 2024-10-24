if (room = rm_UltManOverview){
	audio_stop_sound(sou_UltManCheer)

	var menuX = room_width * 0.0225
	var menuY = room_height * 0.15
	var menuClubNameX = room_width * 0.0225
	var menuClubNameY = room_height * 0.0225
	var menuTitlePaddingY = 40
	var menuPaddingY = 50
	var menuDividerPadding = (menuPaddingY - string_height("I")) / 2
	var menuDividerLeft = room_width * 0.0125
	var menuDividerRight = room_width * 0.1875
	var menuWidthMax = 50
	var clickAbleMenuPaddingY = 50

	// Button position and size
	var buttonX = room_width * 0.85
	var buttonY = room_height * 0.035
	var buttonWidth = room_width * 0.9925
	var buttonHeight = room_height * 0.0965
	var buttonText = "Play Match"
	var titleHeight = (string_height(clubName) / 2)
	
	teamStats = [["Matches Played",spr_UltManFootball, obj_UltManManagerController.playerClub.matchesPlayed],
	["Win Percentage",spr_UltManPercentage, obj_UltManManagerController.playerClub.winPercentage],
	["Goals Scored", spr_UltManCheckmark, obj_UltManManagerController.playerClub.goalsScored],
	["Goals Conceded",spr_UltManCancel, obj_UltManManagerController.playerClub.goalsConceded],
	["Yellow Cards", spr_UltManWarning, obj_UltManManagerController.playerClub.yellowCards],
	["Red Cards",spr_UltManRedCard, obj_UltManManagerController.playerClub.redCards]]

	draw_set_font(fn_titleLato);

	// Draw clubname
	draw_set_valign(fa_top)
	draw_set_halign(fa_left)
	draw_text(menuClubNameX, menuClubNameY, clubName)

	draw_set_font(fn_sideBarOptionsRoboto);
	draw_set_valign(fa_bottom)

	// Draw menu elements
	for (var i = 0; i < ds_list_size(menuOptions); ++i) {
    
		if(i = currentMenu){
			draw_set_color(#5666F9)
		}
		draw_text(menuX, menuY + i*menuPaddingY, ds_list_find_value(menuOptions, i))
		draw_set_color(c_white)
		var menuOptionWidth = string_width(ds_list_find_value(menuOptions, i))
	
		if( ds_list_find_value(menuOptions, i) = "Fixtures" ){
			draw_set_alpha(0.3)
			draw_line(menuDividerLeft, menuY + ((i-1)*menuPaddingY)+menuDividerPadding,
			menuDividerRight,menuY + ((i-1)*menuPaddingY)+menuDividerPadding)
			draw_line(menuDividerLeft, menuY + ((i)*menuPaddingY)+menuDividerPadding,
			menuDividerRight,menuY + ((i)*menuPaddingY)+menuDividerPadding)
			draw_set_alpha(1)
		}
		
		// Take actions based on selected menu item
		if (mouse_y > menuY - menuPaddingY && mouse_y < menuY + menuPaddingY*(ds_list_size(menuOptions)-1) && 
			mouse_x > menuX && mouse_x < menuX + menuOptionWidth)
		{
			if (mouse_y > menuY + (i-1)*menuPaddingY && mouse_y < menuY + (i)*menuPaddingY)
			{
				selectedMenuOption = i
			}
			if (i == selectedMenuOption)
			{
				draw_line(menuX, menuY + i*menuPaddingY, menuX + menuOptionWidth, menuY + i*menuPaddingY)
				if (mouse_check_button_pressed(mb_left)){
					currentMenu = i;
				}
			}

		}
		else
		{
			selectedMenuOption = undefined
		}
	}


	// Sets button colour and draws button
	draw_set_color(#3B95FF)
	if (scr_drawButton(buttonX, buttonY - titleHeight,buttonWidth, buttonHeight - titleHeight, buttonText ))
	{
		room_goto(rm_UltManMatch)
	}

	draw_set_color(#ffffff)

// draw submenu
switch(currentMenu){
	case ultManMenus.Home:
		scr_ultManHome()
		break;
	case ultManMenus.Tactics:
		scr_ultManTactics()
		break;
	case ultManMenus.Fixtures:
		scr_ultManFixtures()
		break;
	case ultManMenus.Transfermarket:
		scr_ultManTransferMarket()
		break;
	case ultManMenus.Quit:
		room_goto(rm_menu)
		currentMenu = ultManMenus.Home
		obj_firestore_controller.EndSession()
		break;
	}
}
else if (room = rm_UltManMatch && halftimeTimerReset = false)
{
	obj_UltManGameController.timer = 45
	halftimeTimerReset = true
}
