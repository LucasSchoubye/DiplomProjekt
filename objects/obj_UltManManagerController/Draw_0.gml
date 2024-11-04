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
			// Player clicks change club name
	if(mouse_y > menuClubNameY && mouse_y < menuClubNameY + string_height(clubName) && 
			mouse_x > menuClubNameX && mouse_x < menuClubNameX + string_width(clubName)){
		draw_set_alpha(0.2)
		draw_text(menuClubNameX + string_width(clubName) + 20, menuClubNameY, "Press club name to change")
		if(mouse_check_button_pressed(mb_left)){
			changeClubNamePopup = true;			
		}
	}
	draw_set_alpha(1)
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
if (changeClubNamePopup){
		draw_set_color(c_black);
		draw_set_alpha(0.8);
		draw_rectangle(room_width * 0.3, room_height * 0.3, room_width * 0.7, room_height * 0.55, false);
		draw_set_alpha(1);
		draw_set_color(c_white);
		draw_text(room_width * 0.35, room_height * 0.35, "New clubname");
		
		draw_roundrect(room_width * 0.35,room_height*0.375,room_width * 0.65,room_height*0.425, true)
		try{
		draw_text(room_width * 0.3625, room_height*0.4175, string(newClubName))	
		draw_set_alpha(sin(current_time/75))
		draw_text(room_width * 0.3625 + string_width(newClubName) - 2, room_height * 0.4175, "|");
		draw_set_alpha(1)
		//show_message(string(font_get_name(draw_get_font())))
		if (keyboard_check_pressed(vk_anykey))
		{
			if ( charValidClub() and !keyboard_check_pressed(vk_shift))
				newClubName = newClubName + keyboard_lastchar
			if(keyboard_check_pressed(vk_backspace))
				newClubName = string_delete(newClubName, string_length(newClubName), 1)
		}
		}
		catch(err){
			show_message(string(err))
		}
        
		// Draw "Change" button
		draw_set_color(#3B95FF);
		scr_drawButton(room_width * 0.55, room_height * 0.475, room_width * 0.6, room_height * 0.525, "Change")
		draw_set_color(c_white);
        
		// Draw "Cancel" button
		draw_set_color(c_red);
		scr_drawButton(room_width * 0.4, room_height * 0.475, room_width * 0.45, room_height * 0.525, "Cancel")
		draw_set_color(c_white);
		// Handle "Change" and "Cancel" button clicks
		if (mouse_check_button_pressed(mb_left)) {
			//draw_circle(room_width * 0.4, room_height*0.40, 5, true)
		    // Check for "Change" button click
		    if (mouse_x > room_width * 0.55 && mouse_x < room_width * 0.6 &&
		        mouse_y > room_height * 0.475 && mouse_y < room_height * 0.525) {
				// Changes clubname
				playerClub.clubName = newClubName;
				clubName = newClubName;
				obj_UltManManagerController.SaveGamestate()
		        changeClubNamePopup = false;  // Close the popup
		    }
            
		    // Check for "Cancel" button click
		    if (mouse_x > room_width * 0.4 && mouse_x < room_width * 0.45 &&
		        mouse_y > room_height * 0.475 && mouse_y < room_height * 0.525) {
		        changeClubNamePopup = false;  // Close the popup without selling
		    }
		}
		
		// Keyboard check
		function charValidClub() {
		    var key_pressed = keyboard_lastchar;

			if(keyboard_check_pressed(vk_shift) or 
				keyboard_check_pressed(vk_up) or
				keyboard_check_pressed(vk_down) or
				keyboard_check_pressed(vk_tab))
				return false

		    // Check if the key pressed is a letter or a number
		    if ((key_pressed >= "0" && key_pressed <= "9") 
			|| (key_pressed >= "A" && key_pressed <= "Å") 
			|| (key_pressed >= "a" && key_pressed <= "z")
			|| key_pressed == "æ" || key_pressed == "ø" || key_pressed == "å"
			|| key_pressed == " ") {
		        return true;
		    } else {
		        return false;
		    }
		}
	}
else if (room = rm_UltManMatch && halftimeTimerReset = false)
{
	obj_UltManGameController.timer = 45
	halftimeTimerReset = true
}
