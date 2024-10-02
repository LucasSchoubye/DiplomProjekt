function scr_ultManTransferMarket(){
	
	// get current settings
	var currentColour = draw_get_color()
	var currentVAlign = draw_get_valign()
	var currentHAlign = draw_get_halign()
	var currentFont = draw_get_font()
	var currentAlpha = draw_get_alpha()
	
	var matchBoxTop = room_height * 0.1;
	var matchBoxBottom = room_height * 1;
	var matchBoxLeft = room_width * 0.2;
	var matchBoxRight = room_width * 0.8;
	
	var sellBoxTop = room_height * 0.1;
	var sellBoxBottom = room_height * 1;
	var sellBoxLeft = room_width * 0.8;
	var sellBoxRight = room_width * 1;
	
	// draw boxes
	draw_rectangle(matchBoxLeft, matchBoxTop, matchBoxRight, matchBoxBottom, true)
	
	draw_rectangle(sellBoxLeft, sellBoxTop, sellBoxRight, sellBoxBottom, true)
	
	packWidth = room_width * 0.195;
	packHeight = room_height * 0.325;

	var totalPacks = ds_list_size(packs);

	// Define the starting X and Y positions
	var startX = room_width * 0.2;  // Starting X position (20% of room width)
	var startY = room_height * 0.125;  // Starting Y position (12.5% of room height)

	// Define the maximum X position (room_width * 0.8)
	var endX = room_width * 0.8;  // Ending X position (80% of room width)
	var endY = room_height * 0.8;  // Ending Y position (87.5% of room height)

	// Calculate how many packs can fit per row based on the pack width and available space
	var availableWidth = endX - startX;  // The available width between 20% and 80% of the room
	var maxPacksPerRow = floor(availableWidth / packWidth);  // Maximum packs that can fit in one row

	// Calculate the dynamic horizontal spacing between packs
	var dynamicSpacingX = (availableWidth - (maxPacksPerRow * packWidth)) / (maxPacksPerRow - 1);

	// Calculate the number of rows needed and the dynamic vertical spacing
	var totalRows = ceil(totalPacks / maxPacksPerRow);  // Total number of rows
	var availableHeight = endY - startY;  // The available height between 12.5% and 87.5% of the room
	var dynamicSpacingY = (availableHeight - (totalRows * packHeight)) / (totalRows - 1);  // Dynamic vertical spacing between rows

	// Initialize the current X and Y positions
	var currentX = startX;
	var currentY = startY;
	var packCounter = 0;  // To count how many packs have been placed in the current row

	// Loop through each pack in the ds_list and draw it
	for (var i = 0; i < totalPacks; i++) {
	    // Get the current pack from the list
	    var pack = ds_list_find_value(packs, i);
	    // Check if we have placed the maximum number of packs in this row
	    if (packCounter == maxPacksPerRow) {
	        // Move to the next row
	        currentX = startX;  // Reset X position to the start
	        currentY += packHeight + dynamicSpacingY;  // Move down by pack height + dynamic vertical spacing
	        packCounter = 0;  // Reset the pack counter for the new row
	    }

	    // Draw the pack at the current X and Y positions
	    pack.DrawPack(currentX, currentY, packWidth, packHeight);
		
		// Check for mouse click on the pack to select a player based on its tier
        if (mouse_x > currentX && mouse_x < currentX + packWidth &&
            mouse_y > currentY && mouse_y < currentY + packHeight) {
				if (obj_UltManManagerController.showSellPopup = false && showCannotSellPopup = false) {
					if (mouse_check_button_pressed(mb_left)) {
		                // Call the UltManPlayer function with the appropriate tier
		                newPlayer = new UltManPlayer(pack.packEnum); 
						ds_list_add(squad,newPlayer)
		            }
				}
        }

	    // Update the X position for the next pack
	    currentX += packWidth + dynamicSpacingX;  // Add dynamic horizontal spacing between packs

	    // Increment the pack counter
	    packCounter++;
	}
	
	// Draw player sell list and sell button
	draw_set_font(fn_RobotoMedium8)
	for (var i = 0; i < ds_list_size(squad); ++i) {
	    var currentPlayer = ds_list_find_value(squad, i)
		var sellListSep = sellBoxTop + 30*(i+1)
		
		playerName = currentPlayer.name[0] + " " + currentPlayer.name[1]
		playerRating = currentPlayer.overallRating
		playerPosition = currentPlayer.PosToString()
		playerPositionHeight = string_height(playerPosition)
		playerColour = ds_list_find_value(packs, currentPlayer.tier).packColour
		if (string_width(playerName) > 150) {
		    playerName = string_copy(playerName,1, 14);
		}
		draw_set_halign(fa_left)
		draw_set_color(playerColour);
		draw_text(sellBoxLeft + 20,sellListSep, playerName);
		draw_set_color(c_white)
		draw_text(sellBoxLeft + 180,sellListSep, playerRating);
		draw_text(sellBoxLeft + 220,sellListSep, playerPosition);
		
		// Check for hover over player
        if (mouse_x > sellBoxLeft && mouse_x < sellBoxRight &&
            mouse_y > sellListSep - playerPositionHeight && mouse_y < sellListSep) {
            
            hoveredPlayerIndex = i;  // Store the index of the hovered player
            
            // Draw red "SELL" button
            draw_set_color(c_red);
			scr_drawButton(sellBoxLeft + 210,sellListSep - playerPositionHeight, sellBoxRight - 10, sellListSep, "SELL")
            draw_set_color(c_white);
            
			// Handle sell button click if player is in starting 11
            if (mouse_check_button_pressed(mb_left) &&
                mouse_x > sellBoxRight - 100 && mouse_x < sellBoxRight - 20 &&
                mouse_y > sellListSep - playerPositionHeight && mouse_y < sellListSep && i < 11) {
                
                // Show cannot sell popup
				obj_UltManManagerController.showCannotSellPopup = true;
            }
			// Handle sell button click
			else if (mouse_check_button_pressed(mb_left) &&
                mouse_x > sellBoxRight - 100 && mouse_x < sellBoxRight - 20 &&
                mouse_y > sellListSep - playerPositionHeight && mouse_y < sellListSep) {
                
                // Show confirmation popup
                obj_UltManManagerController.showSellPopup = true;
                playerToSell = i;  // Store the player index to be sold
            }
        }
	}
	
	// Confirmation popup for selling a player
    if (showSellPopup) {
        draw_set_color(c_black);
        draw_set_alpha(0.8);
        draw_rectangle(room_width * 0.3, room_height * 0.3, room_width * 0.7, room_height * 0.5, false);
        draw_set_alpha(1);
        draw_set_color(c_white);
        draw_text(room_width * 0.35, room_height * 0.35, "Are you sure you want to sell this player?");
        
        // Draw "YES" button
		draw_set_color(c_green);
		scr_drawButton(room_width * 0.4, room_height * 0.40, room_width * 0.45, room_height * 0.45, "YES")
        draw_set_color(c_white);
        
        // Draw "NO" button
        draw_set_color(c_red);
		scr_drawButton(room_width * 0.55, room_height * 0.40, room_width * 0.6, room_height * 0.45, "NO")
        draw_set_color(c_white);
        // Handle "YES" and "NO" button clicks
        if (mouse_check_button_pressed(mb_left)) {
            // Check for "YES" button click
            if (mouse_x > room_width * 0.4 && mouse_x < room_width * 0.45 &&
                mouse_y > room_height * 0.40 && mouse_y < room_height * 0.45) {
                // Remove the player from the squad list
                ds_list_delete(squad, playerToSell);
                showSellPopup = false;  // Close the popup
            }
            
            // Check for "NO" button click
            if (mouse_x > room_width * 0.55 && mouse_x < room_width * 0.6 &&
                mouse_y > room_height * 0.40 && mouse_y < room_height * 0.45) {
                showSellPopup = false;  // Close the popup without selling
            }
        }
    }
	
	// Cannot sell popup
    if (showCannotSellPopup) {
		// Rectangle coordinates
		var rect_left = room_width * 0.3;
		var rect_right = room_width * 0.7;

		// Calculate the center of the rectangle
		var rect_center_x = (rect_left + rect_right) / 2;

		// Set button size
		var button_width = room_width * 0.1;  // Width of the button (adjust as needed)

		// Calculate the button's coordinates to center it
		var button_left = rect_center_x - button_width / 2;
		var button_right = rect_center_x + button_width / 2;
        draw_set_color(c_black);
        draw_set_alpha(0.8);
        draw_rectangle(room_width * 0.3, room_height * 0.3, room_width * 0.7, room_height * 0.5, false);
        draw_set_alpha(1);
        draw_set_color(c_white);
		draw_text_ext(room_width * 0.3125, room_height * 0.4125, 
		"This player is currently in your starting 11 and cannot be sold, please remove them from your starting 11 to be able to sell",
		25,room_width * 0.6875 - room_width * 0.3)
        
        // Draw "OK" button
		draw_set_color(#4994ec);
		scr_drawButton(button_left, room_height * 0.425, button_right, room_height * 0.475, "OK")
        draw_set_color(c_white);
      
        // Handle "OK" button clicks
        if (mouse_check_button_pressed(mb_left)) {
            // Check for "OK" button click
            if (mouse_x > button_left && mouse_x < button_right &&
                mouse_y > room_height * 0.425 && mouse_y < room_height * 0.475) {
                showCannotSellPopup = false;  // Close the popup
            }
        }
    }
	
	// reset stuff
	draw_set_valign(currentVAlign)
	draw_set_halign(currentHAlign)
	draw_set_color(currentColour)
	draw_set_font(currentFont)
	draw_set_alpha(currentAlpha)
	
}