// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_UltManTacticPlayerBox(){

	var playerBoxTop = room_height * 0.12;
	var playerBoxBottom = room_height * 1;
	var playerBoxLeft = room_width * 0.7;
	var playerBoxRight = room_width * 0.98;
	var playerBoxMidX = (playerBoxLeft + playerBoxRight)/2;
	
	var playerBoxHeight = (playerBoxBottom - playerBoxTop)
	
	draw_rectangle(playerBoxLeft, playerBoxTop, playerBoxRight, playerBoxBottom, true)
	
	for (var i = 0; i < ds_list_size(squad); ++i) {
	    var player = ds_list_find_value(squad, i)
		
		// Draw Player Outline
		if (i < 11)
		{
			draw_set_color(GetColorFromPos(player.position))
			draw_set_alpha(0.15)
			draw_rectangle(playerBoxLeft, playerBoxTop + (i)*30, playerBoxRight, playerBoxTop + (i+1)*30, false)
		}
		else if (i > 11 + 5)
		{
			draw_set_color(c_ltgray)
			draw_set_alpha(0.25)
			draw_rectangle(playerBoxLeft, playerBoxTop + (i)*30, playerBoxRight, playerBoxTop + (i+1)*30, false)
		}
		draw_set_color(c_white)
		draw_set_alpha(1)
		
		// Draw Swapping
		if (ds_list_find_value(squad, i) = swappingPlayer)
			draw_rectangle(playerBoxLeft + 2, playerBoxTop + (i)*30, playerBoxRight - 2, playerBoxTop + (i+1)*30, true)
		
		// Draw player details
		draw_set_halign(fa_left)
		draw_set_valign(fa_top)
		draw_set_font(fn_RobotoBlack8)
		draw_text(playerBoxLeft + 20,playerBoxTop + (i+0.4)*30,player.PosToString())
		draw_sprite_ext(spr_UltManPerson, 0, playerBoxLeft + 63,playerBoxTop + (i+0.4)*30 - 2, 0.15, string_height(player.name[1])*0.01, 0, c_white, 0.3)
		draw_text(playerBoxLeft + 70,playerBoxTop + (i+0.4)*30,player.name[0] + " " + player.name[1])
		
		draw_set_halign(fa_center)
		draw_text(playerBoxRight - 90,playerBoxTop + (i+0.4)*30,player.age)
		draw_text(playerBoxRight - 60,playerBoxTop + (i+0.4)*30,string(player.condition)+"%")
		draw_text(playerBoxRight - 30,playerBoxTop + (i+0.4)*30,player.overallRating)
		
		// Draw Selected
		if (mouse_y - playerBoxTop < 30*(i+1) && mouse_y - playerBoxTop > 30*(i) &&
			mouse_x > playerBoxLeft && mouse_x < playerBoxRight)
		{
			draw_set_alpha(0.2)
			draw_rectangle(playerBoxLeft, playerBoxTop + (i)*30, playerBoxRight, playerBoxTop + (i+1)*30, false)
			draw_set_alpha(1)
			
			if (mouse_check_button_pressed(mb_left))
			{
				swappingPlayer = ds_list_find_value(squad, i)
			}
		
			// Swap player
			if (mouse_check_button_released(mb_left))
			{
				if (swappingPlayer != undefined)
				{
					// If player is in starting squad
						var startingPlayer = ds_list_find_value(squad, i)
						
						for (var column = 0; column < array_length(formationColumns); ++column) {
							
							if (ds_list_find_index(formationColumns[column], startingPlayer) > 0)
							{
								ds_list_replace(formationColumns[column], ds_list_find_index(formationColumns[column], startingPlayer), swappingPlayer)
							}
						}
					
					// Swap Position in Squad
					switch_ds_list_values(squad, swappingPlayer, ds_list_find_value(squad, i))
				}
				swappingPlayer = undefined
			}
		}
	}
	
	
	// Release player
	if (mouse_check_button_released(mb_left))
	{
		swappingPlayer = undefined
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