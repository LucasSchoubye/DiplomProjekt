/// Menu control

if (room = rm_menu)
{
	// Setup view variables
	var screenTop = 100
	var screenMidX = room_width/2
	var screenMidY = room_width/2
	var titleBuffer = 50
	var optionBuffer = 20
	var selectionBuffer = 180

	// Draw Text
	draw_text(screenMidX,screenTop,"Main Menu")
	draw_text(300,screenTop,"Welcome back, "+obj_firestore_controller.username)

	for (var i = 0; i < ds_list_size(options); ++i) {
    
		// dr
		draw_set_halign(fa_middle)
		draw_set_valign(fa_middle)
		var optionY = screenTop + optionBuffer * i + titleBuffer;
		// draw a list of all options in list
		draw_text(screenMidX,screenTop + optionBuffer*i + titleBuffer,ds_list_find_value(options, i))
	
		// If selected, draw pointer
		if (selectedOption = i)
		{
			draw_circle(screenMidX - selectionBuffer,optionY,5,true)
		}
		
		// Check if the mouse is hovering over hte option
		if (mouse_x >= screenMidX - 500 & mouse_x <= screenMidX + 50 
		&& mouse_y >= optionY - 10 && mouse_y <= optionY + 10){
			selectedOption = i;
			
			// If mouse clicked, choose option
			if (mouse_check_button_pressed(mb_left))
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
}