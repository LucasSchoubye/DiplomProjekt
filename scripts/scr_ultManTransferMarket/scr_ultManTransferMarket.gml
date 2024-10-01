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
            if (mouse_check_button_pressed(mb_left)) {
                // Call the UltManPlayer function with the appropriate tier
                newPlayer = new UltManPlayer(pack.packEnum); 
				ds_list_add(squad,newPlayer)
            }
        }

	    // Update the X position for the next pack
	    currentX += packWidth + dynamicSpacingX;  // Add dynamic horizontal spacing between packs

	    // Increment the pack counter
	    packCounter++;
	}
	
	
	draw_set_font(fn_RobotoMedium8)
	for (var i = 0; i < ds_list_size(squad); ++i) {
	    var currentPlayer = ds_list_find_value(squad, i)
		var sellListSep = sellBoxTop + 30*(i+1)
		
		playerName = currentPlayer.name[0] + " " + currentPlayer.name[1]
		playerRating = currentPlayer.overallRating
		playerPosition = currentPlayer.PosToString()
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
	}
	
	// reset stuff
	draw_set_valign(currentVAlign)
	draw_set_halign(currentHAlign)
	draw_set_color(currentColour)
	draw_set_font(currentFont)
	draw_set_alpha(currentAlpha)
	
}