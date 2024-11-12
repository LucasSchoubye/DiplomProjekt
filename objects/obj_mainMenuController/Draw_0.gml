/// Menu control

if (room = rm_menu)
{
	var LC = obj_languageController
	
	// Setup view variables
	var optionBuffer = 30
	var selectionBuffer = 180
	var screenTop = 100
	var optionsTop = room_height - ds_list_size(options)*optionBuffer - 160
	var screenMidX = 100
	var screenMidY = room_width/2
	var titleBuffer = 50
	var screenLeft = 100
	
	// Animation
	animTimer+= 1/20
	animColor = make_colour_rgb(204, sin(animTimer)*30 + 30, 255);
	
	// draw background
	var horizon = room_height*0.6
	draw_rectangle_color(0,0,room_width,horizon,c_black,c_black,animColor, animColor,false)
	draw_set_color(c_black)
	// draw ground
	for (var i = 0; i < 40; ++i) {
	    draw_line_color(room_width/2 + i*10 - 20*10,horizon,i+(room_width/40)*(i) + i*50 - 20*50,room_height,c_black,animColor)
	}
	// Draw building
	for (var q = 0; q < array_length(skylineArray); ++q) {
		switch(q)
		{
			case 0:
				draw_set_alpha(0.3)
			break;
			case 1:
				draw_set_alpha(0.6)
			break;
			case 2:
				draw_set_alpha(0.8)
			break;
			case 3:
				draw_set_alpha(1)
			break;
		}
		for (var i = 0; i < array_length(skylineArray[q]); ++i) {
		    draw_rectangle((room_width/array_length(skylineArray[q]))*(i+1)-1,horizon + q*10, (room_width/array_length(skylineArray[q]))*i, horizon - skylineArray[q][i]+q*10, false)
		}
	}

	// Draw Text
	draw_set_alpha(1)
	draw_set_font(fn_longShot80)
	scr_drawOutlineText(screenMidX,screenTop,c_black,c_white,"Main Menu")
	draw_set_font(fn_lato16)
	draw_text(screenLeft,screenTop + titleBuffer,LC.translate("Welcome back ",Games.Menus)+obj_firestore_controller.username+"!")

	// Draw options and logic
	for (var i = 0; i < ds_list_size(options); ++i) {
		draw_set_halign(fa_left)
		draw_set_valign(fa_middle)
		var optionY = optionsTop + optionBuffer * i + titleBuffer;
		// draw a list of all options in list
		draw_text(screenLeft,optionsTop + optionBuffer*i + titleBuffer, LC.translate(ds_list_find_value(options, i), Games.Menus))
	
		// If selected, draw pointer
		if (selectedOption = i)
		{
			//draw_circle(screenLeft - 30,optionsTop + optionBuffer*i + titleBuffer,10,false)
			draw_line(screenLeft, optionsTop + optionBuffer*(i+0.5) + titleBuffer, screenLeft + string_width(LC.translate(ds_list_find_value(options, i), Games.Menus)), optionsTop + optionBuffer*(i+0.5) + titleBuffer)
		}
		
		#region Logic
		// Check if the mouse is hovering over hte option
		if (mouse_x >= screenLeft && mouse_x <= screenLeft + 200 
		&& mouse_y >= optionY - 10 && mouse_y <= optionY + 10){
			selectedOption = i;
			

			// If mouse clicked, choose option
			if (mouse_check_button_pressed(mb_left))
			{
				switch(ds_list_find_value(options, selectedOption))
				{
					case "Mini Games":
						room_goto(rm_minigameMenu)
						obj_firestore_controller.RequestAllowedGames()
					break 
					case "Inventory":
						room_goto(rm_inventory)
					break 
					case "Store":
						room_goto(rm_store)
					break
					case "Quit":
						game_end()
					break
				}
			}
		
		}
	}

	// Move selected option
	if (keyboard_check_pressed(vk_up)){selectedOption--}
	if (keyboard_check_pressed(vk_down)){selectedOption++}

	// Keep selected option within the list size
	if (selectedOption > ds_list_size(options)-1)
	{
		selectedOption = 0
	}
	if (selectedOption < 0)
	{
		selectedOption = ds_list_size(options)-1
	}

	// perform action
	if (keyboard_check_pressed(vk_space))
	{
		switch(ds_list_find_value(options, selectedOption))
		{
			case "Mini Games":
				room_goto(rm_minigameMenu)
			break 
			case "Inventory":
				room_goto(rm_inventory)
			break
			case "Store":
				room_goto(rm_store)
			break
			case "Quit":
				game_end()
			break
		}
	}
	#endregion
}