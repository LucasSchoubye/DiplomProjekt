// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_UltManTacticPlayerBox(){
	
	if (tacticsPlayerScroll > ds_list_size(squad)*-30 + 20*30 && mouse_wheel_down())
	{
		tacticsPlayerScroll -= 10
	}
	if (tacticsPlayerScroll < 30 && mouse_wheel_up())
	{
		tacticsPlayerScroll += 10
	}
	
	var playerBoxTop = room_height * 0.12;
	var playerBoxBottom = room_height * 1;
	var playerBoxLeft = room_width * 0.7;
	var playerBoxRight = room_width * 0.98;
	var playerBoxMidX = (playerBoxLeft + playerBoxRight)/2;
	
	var playerBoxHeight = (playerBoxBottom - playerBoxTop)
	
	draw_rectangle(playerBoxLeft, playerBoxTop, playerBoxRight, playerBoxBottom, true)
	
	for (var i = 0; i < ds_list_size(squad); ++i) {
	    var player = ds_list_find_value(squad, i)
		
		if (playerBoxTop + (i)*30 + tacticsPlayerScroll > playerBoxTop)
		{
		
			// Draw Player Outline
			if (i < 11)
			{
				draw_set_color(GetColorFromPos(player.position))
				draw_set_alpha(0.15)
				draw_rectangle(playerBoxLeft, playerBoxTop + (i)*30 + tacticsPlayerScroll, playerBoxRight, playerBoxTop + (i+1)*30 + tacticsPlayerScroll, false)
			}
			else if (i > 11 + 5)
			{
				draw_set_color(c_ltgray)
				draw_set_alpha(0.25)
				draw_rectangle(playerBoxLeft, playerBoxTop + (i)*30 + tacticsPlayerScroll, playerBoxRight, playerBoxTop + (i+1)*30 + tacticsPlayerScroll, false)
			}
			draw_set_color(c_white)
			draw_set_alpha(1)
		
			// Draw Swapping
			if (ds_list_find_value(squad, i) = fromPlayer)
				draw_rectangle(playerBoxLeft + 2, playerBoxTop + (i)*30 + tacticsPlayerScroll, playerBoxRight - 2, playerBoxTop + (i+1)*30 + tacticsPlayerScroll, true)
		
			// Draw player details
			draw_set_halign(fa_left)
			draw_set_valign(fa_top)
			draw_set_font(fn_RobotoBlack8)
			draw_text(playerBoxLeft + 20,playerBoxTop + (i+0.4)*30 + tacticsPlayerScroll,player.PosToString())
			draw_sprite_ext(spr_UltManPerson, 0, playerBoxLeft + 63,playerBoxTop + (i+0.4)*30 - 2 + tacticsPlayerScroll, 0.15, string_height(player.name[1])*0.01, 0, c_white, 0.3)
			draw_text(playerBoxLeft + 70,playerBoxTop + (i+0.4)*30 + tacticsPlayerScroll,player.name[0] + " " + player.name[1])
		
			draw_set_halign(fa_center)
			draw_text(playerBoxRight - 90,playerBoxTop + (i+0.4)*30 + tacticsPlayerScroll,player.age)
			draw_text(playerBoxRight - 60,playerBoxTop + (i+0.4)*30 + tacticsPlayerScroll,string(player.condition)+"%")
			draw_text(playerBoxRight - 30,playerBoxTop + (i+0.4)*30 + tacticsPlayerScroll,player.overallRating)
		
		
			// Draw Selected
			if (mouse_y - playerBoxTop < 30*(i+1)+tacticsPlayerScroll && mouse_y - playerBoxTop > 30*(i)+tacticsPlayerScroll &&
				mouse_x > playerBoxLeft && mouse_x < playerBoxRight)
			{
				draw_set_alpha(0.2)
				draw_rectangle(playerBoxLeft, playerBoxTop + (i)*30 + tacticsPlayerScroll, playerBoxRight, playerBoxTop + (i+1)*30 + tacticsPlayerScroll, false)
				draw_set_alpha(1)
			
				if (mouse_check_button_pressed(mb_left))
				{
					fromPlayer = ds_list_find_value(squad, i)
				}
		
				// Swap player
				if (mouse_check_button_released(mb_left))
				{
				
					if (fromPlayer != undefined)
					{
					
						// If player is in starting squad
						if (i < 11 or ds_list_find_index(squad, fromPlayer) < 11)
						{
							var toPlayerCoor = [undefined,undefined]
							var fromPlayerCoor = [undefined,undefined]
						
							// Swapping from bench to starting 11
							var toPlayer = ds_list_find_value(squad, i)
							for (var column = 0; column < array_length(formationColumns); ++column) {
							
								if (ds_list_find_index(formationColumns[column], toPlayer) > -1)
								{
									toPlayerCoor = [column, ds_list_find_index(formationColumns[column], toPlayer)]
									break
								}
							}
							
							if (ds_list_find_index(squad, fromPlayer) < 11)
							{
								// Swapping two starting players
								for (var column = 0; column < array_length(formationColumns); ++column) {
							
									if (ds_list_find_index(formationColumns[column], fromPlayer) > -1)// && column != firstColumn)
									{									
										fromPlayerCoor = [column, ds_list_find_index(formationColumns[column], fromPlayer)]
										break
									}
								}
						
								// Switch
								if (toPlayerCoor[0] != undefined)
								{
									ds_list_replace(formationColumns[toPlayerCoor[0]], toPlayerCoor[1], fromPlayer)
									if (fromPlayerCoor[0] != undefined)
									{
										toPlayer.UpdatePosition(fromPlayerCoor[0], fromPlayerCoor[1], ds_list_size(formationColumns[fromPlayerCoor[0]]))
									}
									else
									{
										toPlayer.position = FootballPositions.SUB
									}
								}
								if (fromPlayerCoor[0] != undefined)
								{
									ds_list_replace(formationColumns[fromPlayerCoor[0]], fromPlayerCoor[1], toPlayer)
									if (toPlayerCoor[0] != undefined)
									{
										fromPlayer.UpdatePosition(toPlayerCoor[0], toPlayerCoor[1], ds_list_size(formationColumns[toPlayerCoor[0]]))
									}
									else
									{
										fromPlayer.position = FootballPositions.SUB
										toPlayer.UpdatePosition(fromPlayerCoor[0], fromPlayerCoor[1], ds_list_size(formationColumns[fromPlayerCoor[0]]))
									}
								}
								
						
							}
							else
							{
								ds_list_replace(formationColumns[toPlayerCoor[0]], toPlayerCoor[1], fromPlayer)
								fromPlayer.UpdatePosition(toPlayerCoor[0], toPlayerCoor[1], ds_list_size(formationColumns[toPlayerCoor[0]]))
								toPlayer.position = FootballPositions.SUB
							}
						}
					
						// Swap Position in Squad
						switch_ds_list_values(squad, fromPlayer, ds_list_find_value(squad, i))
						ResetStartingSquadOrder()
						obj_UltManManagerController.SaveGamestate()
					}
					fromPlayer = undefined
				}
			}
		}
	}
	
	// Draw Smooth scroll box
	draw_set_color(#393944)
	draw_rectangle(playerBoxLeft, playerBoxTop, playerBoxRight, playerBoxTop+30, false)
	draw_set_color(c_white)
	
	// Release player
	if (mouse_check_button_released(mb_left))
	{
		fromPlayer = undefined
	}
}

function switch_ds_list_values(ds_list_id, value1, value2) {
    // Find the indices of the values
    var index1 = ds_list_find_index(ds_list_id, value1);
    var index2 = ds_list_find_index(ds_list_id, value2);
    
    // Check if both values exist in the ds_list
    if (index1 != -1 && index2 != -1) {
        // Switch the values if both are found
        var temp = ds_list_find_value(ds_list_id, index1);
        
        ds_list_replace(ds_list_id, index1, ds_list_find_value(ds_list_id, index2));
        ds_list_replace(ds_list_id, index2, temp);
    }
}

// Helper function to find the index of a value in a ds_list
function ds_list_find_index(ds_list_id, value) {
    var size = ds_list_size(ds_list_id);
    
    // Iterate through the list to find the index of the value
    for (var i = 0; i < size; i++) {
        if (ds_list_find_value(ds_list_id, i) == value) {
            return i;
        }
    }
    
    // Return -1 if the value is not found
    return -1;
}

function MovePlayerColumn(fromColumn, toColumn)
{
	var player = obj_UltManManagerController.fieldViewFromPlayer
	
	if (player != undefined && toColumn != undefined && ds_list_find_index(player.playableColumns, toColumn) != -1)
	{
		var insertIndex = GetPlayerInsertPos()
		
		if (toColumn != fromColumn)
		{
			ds_list_insert(obj_UltManManagerController.formationColumns[toColumn], insertIndex, player)
			ds_list_delete(obj_UltManManagerController.formationColumns[fromColumn], ds_list_find_index(obj_UltManManagerController.formationColumns[fromColumn], player))
		}
		else
		{
			ds_list_delete(obj_UltManManagerController.formationColumns[fromColumn], ds_list_find_index(obj_UltManManagerController.formationColumns[fromColumn], player))
			insertIndex = GetPlayerInsertPos()
			ds_list_insert(obj_UltManManagerController.formationColumns[toColumn], insertIndex, player)
		}
		
		// Update positions from old list
		for (var i = 0; i < ds_list_size(formationColumns[fromColumn]); ++i) {
		    // code here
			ds_list_find_value(formationColumns[fromColumn], i).UpdatePosition(fromColumn, i, ds_list_size(formationColumns[fromColumn]))

		}
		
		// Update positions from new list
		if (ds_list_size(formationColumns[toColumn]) > 0)
		{
			for (var i = 0; i < ds_list_size(formationColumns[toColumn]); ++i) {
				ds_list_find_value(formationColumns[toColumn], i).UpdatePosition(toColumn, i, ds_list_size(formationColumns[toColumn]))
			}
		}
	}
	
	// Clean up
	ResetStartingSquadOrder()
	obj_UltManManagerController.fieldViewFromPlayer = undefined
	obj_UltManManagerController.SaveGamestate()
}

function GetPlayerInsertPos()
{
	var column = undefined
	
	// Find Column
	for (var i = 0; i < 6; ++i) {
		if (mouse_y > obj_UltManManagerController.fieldBoxTop + obj_UltManManagerController.fieldBoxHeight/7*(0.7+i) &&
			mouse_y < obj_UltManManagerController.fieldBoxTop + obj_UltManManagerController.fieldBoxHeight/7*(1.7+i))
		{
			column = i
		}
	}
	
	// Find index from mouse_x
	for (var i = 0; i < formationColumns[column]; ++i) {
	    if (i = 0 && mouse_x < fieldBoxLeft + fieldBoxWidth/(ds_list_size(formationColumns[column])+2)*(i+1))
		{
			return 0
		}
		else if (mouse_x > fieldBoxLeft + fieldBoxWidth/(ds_list_size(formationColumns[column])+1)*(i) &&
				mouse_x < fieldBoxLeft + fieldBoxWidth/(ds_list_size(formationColumns[column])+1)*(i+1))
		{
			return i
		}
	}
	
			return ds_list_size(formationColumns[column])
	
}