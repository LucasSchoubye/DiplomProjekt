function scr_ultManTransferMarket(){
	
	if (transfermarketPlayerScroll > ds_list_size(squad)*-30 + 19*30 && mouse_wheel_down())
	{
		transfermarketPlayerScroll -= 10
	}
	if (transfermarketPlayerScroll < 0 && mouse_wheel_up())
	{
		transfermarketPlayerScroll += 10
	}
	
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
	
	var sellBoxTop = room_height * 0.2;
	var sellBoxBottom = room_height * 1;
	var sellBoxLeft = room_width * 0.8;
	var sellBoxRight = room_width * 1;
	
	// draw balance
	draw_set_font(fn_RobotoBlack16)
	draw_text(room_width * 0.2125, room_height * 0.15, LC.translate("Balance: ") + string(obj_storeController.balance) + " CONTENT COINS")
	draw_set_font(currentFont)
	
	packWidth = room_width * 0.195;
	packHeight = room_height * 0.325;

	var totalPacks = ds_list_size(packs);
	var maxAvailablePackTier = 5;

	// Define the starting X and Y positions
	var startX = room_width * 0.2;  // Starting X position (20% of room width)
	var startY = room_height * 0.2;  // Starting Y position 

	// Define the maximum X position (room_width * 0.8)
	var endX = room_width * 0.8;  // Ending X position (80% of room width)
	var endY = room_height * 0.875;  // Ending Y position 

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
	
	
	
	draw_set_color(c_white)
	
	for (var i = 0; i < ds_list_size(squad); ++i) {
		var currentPlayer = ds_list_find_value(squad, i)
		playerTier = ds_list_find_value(packs, currentPlayer.tier).packEnum
		// Find the max tier of pack the player can buy based on starting 11
		if (i < 11 && playerTier < maxAvailablePackTier){
			maxAvailablePackTier = playerTier;
		}
	}
	
	// Loop through each pack in the ds_list and draw it
	for (var i = 0; i < totalPacks; i++) {
	    // Get the current pack from the list
	    var pack = ds_list_find_value(packs, i);
		var currentPackTier = pack.packEnum
	    // Check if we have placed the maximum number of packs in this row
	    if (packCounter == maxPacksPerRow) {
	        // Move to the next row
	        currentX = startX;  // Reset X position to the start
	        currentY += packHeight + dynamicSpacingY;  // Move down by pack height + dynamic vertical spacing
	        packCounter = 0;  // Reset the pack counter for the new row
	    }
	
	    // Draw the packs at the current X and Y positions
		depth = 3;
		if(maxAvailablePackTier+1 < currentPackTier){
			pack.DrawUnavailablePack(currentX, currentY, packWidth, packHeight);
		}
		else{
			pack.DrawPack(currentX, currentY, packWidth, packHeight);
		}
		depth = 0;
		
		// Check for mouse click on the pack to select a player based on its tier
        if (mouse_x > currentX + pack.contentPadding && mouse_x < currentX + packWidth - pack.contentPadding &&
            mouse_y > currentY + pack.packPlayerInfoY + 3 * pack.contentPadding && mouse_y < currentY + packHeight - pack.contentPadding) {
			if (obj_UltManManagerController.showSellPopup = false 
			&& obj_UltManManagerController.showCannotSellPopup = false 
			&& obj_UltManManagerController.showPopupCannotBuyPack = false) {
				if (mouse_check_button_pressed(mb_left)) {
					if(maxAvailablePackTier+1 < currentPackTier){
						obj_UltManManagerController.showPopupCannotBuyPack = true
					}
					else if(obj_storeController.balance >= pack.packCost) {
						
						// SCROLL TO BOTTOM AFTER ADDING THE PLAYER
				        var totalPlayers = ds_list_size(squad);
				        var maxVisiblePlayers = 18;  // Adjust this if more/less players fit on screen
        
				        if (totalPlayers > maxVisiblePlayers) {
				            transfermarketPlayerScroll = ds_list_size(squad) * -30 + maxVisiblePlayers * 30;
				        } else {
				            transfermarketPlayerScroll = 0;  // No need to scroll if list is smaller than the visible area
				        }
						
						// Show effect
						repeat(50)
						{
							newColour = merge_color(pack.packColour, c_white, random_range(0.1,0.5))
							effect_create_above(ef_firework, sellBoxLeft + irandom_range(1,250), sellBoxTop + (totalPlayers + 1) * 30 + transfermarketPlayerScroll, 1000, newColour)
							effect_create_above(ef_explosion, sellBoxLeft + irandom_range(1,250), sellBoxTop + (totalPlayers + 1) * 30 + transfermarketPlayerScroll, 1000, newColour)
						}
						
						// Update player balance
						obj_storeController.balance -= pack.packCost
						obj_firestore_controller.UpdateBalance()
						
						// Call the UltManPlayer function with the appropriate tier
			            newPlayer = new UltManPlayer(pack.packEnum); 
						ds_list_add(squad,newPlayer)
						obj_UltManManagerController.SaveGamestate()
					}
					else{
						obj_UltManManagerController.showPopupCannotAffordPack = true
					}
				}
			}
        }

	    // Update the X position for the next pack
	    currentX += packWidth + dynamicSpacingX;  // Add dynamic horizontal spacing between packs

	    // Increment the pack counter
	    packCounter++;
	}
	
	// Draw player sell list and sell button
	draw_set_font(fn_RobotoMedium14)
	for (var i = 0; i < ds_list_size(squad); ++i) {
	    var currentPlayer = ds_list_find_value(squad, i)
		var sellListSep = sellBoxTop + 30*(i+1) + transfermarketPlayerScroll
		
		playerTier = ds_list_find_value(packs, currentPlayer.tier).packEnum
		playerName = currentPlayer.name[0] + " " + currentPlayer.name[1]
		playerRating = currentPlayer.overallRating
		playerPosition = obj_languageController.translate(currentPlayer.PosToString())
		playerPositionHeight = string_height(playerPosition)
		playerColour = ds_list_find_value(packs, currentPlayer.tier).packColour
		
		// Shorten names if too long
		if (string_width(playerName) > 145) {
			playerName = string_copy(playerName,1, 13) + "...";
		}
		
		if(sellListSep > sellBoxTop && sellListSep < sellBoxBottom){
			if(i<11){
				draw_set_alpha(0.15)
				draw_rectangle(sellBoxLeft + 5, sellListSep - 30, sellBoxRight, sellListSep, false)
				draw_set_alpha(1)
			}
			
			draw_set_halign(fa_left)
			draw_set_color(playerColour);
			draw_text(sellBoxLeft + 10,sellListSep, playerName);
			draw_set_color(c_white)
			draw_set_halign(fa_center)
			draw_text(sellBoxLeft + 190,sellListSep, playerRating);
			draw_text(sellBoxLeft + 240,sellListSep, playerPosition);
			draw_set_halign(fa_left)
			
			// Check for hover over player
		    if (mouse_x > sellBoxLeft && mouse_x < sellBoxRight &&
		        mouse_y > sellListSep - 30 && mouse_y < sellListSep) {
				
		        hoveredPlayerIndex = i;  // Store the index of the hovered player
				depth = 0;
				
				//Draw player card
				currentPlayer.playerCardTimer--
				
				if(currentPlayer.playerCardTimer < 0){
					
					if(mouse_y < room_height / 2){
						scr_DrawPlayerCard(sellBoxLeft - 255,mouse_y - 100,sellBoxLeft - 5, mouse_y + 150 ,currentPlayer)
					}
					else{
						scr_DrawPlayerCard(sellBoxLeft - 255,mouse_y - 250,sellBoxLeft - 5, mouse_y ,currentPlayer)
					}
				}
				
		        // Draw red "SELL" button
		        draw_set_color(c_red);
				//draw_set_valign(fa_middle)
				scr_drawButton(sellBoxLeft + 210,sellListSep - 30, sellBoxRight - 10, sellListSep, LC.translate("SELL"))
		        draw_set_color(c_white);
            
				// Handle sell button click if player is in starting 11
		        if (mouse_check_button_pressed(mb_left) &&
		            mouse_x > sellBoxRight - 100 && mouse_x < sellBoxRight - 20 &&
		            mouse_y > sellListSep - playerPositionHeight && mouse_y < sellListSep 
					&& i < 11) {
                
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
					playerSellPrice = ds_list_find_value(packs, currentPlayer.tier).playerSellPrice
		        }
		    }
			else{
				currentPlayer.playerCardTimer = 30
			}
		}
	}
	
	// draw box above sell list for smooth scroll
	draw_set_color(#393944)
	draw_rectangle(room_width * 0.8,room_height * 0.175,room_width * 1,room_height * 0.2, false)
	// draw box below sell list for smooth scroll
	draw_rectangle(room_width * 0.8,room_height * 0.9675,room_width * 1,room_height * 1, false)
	
	// Confirmation popup for selling a player
	if (showSellPopup){
		draw_set_color(c_black);
		draw_set_alpha(0.8);
		draw_rectangle(room_width * 0.3, room_height * 0.3, room_width * 0.7, room_height * 0.5, false);
		draw_set_alpha(1);
		draw_set_color(c_white);
		draw_text(room_width * 0.35, room_height * 0.35, LC.translate("Are you sure you want to sell this player for ") + string(playerSellPrice) +  "?");
        
		// Draw "YES" button
		draw_set_color(c_green);
		scr_drawButton(room_width * 0.4, room_height * 0.40, room_width * 0.45, room_height * 0.45, LC.translate("YES"))
		draw_set_color(c_white);
        
		// Draw "NO" button
		draw_set_color(c_red);
		scr_drawButton(room_width * 0.55, room_height * 0.40, room_width * 0.6, room_height * 0.45, LC.translate("NO"))
		draw_set_color(c_white);
		// Handle "YES" and "NO" button clicks
		if (mouse_check_button_pressed(mb_left)) {
		    // Check for "YES" button click
		    if (mouse_x > room_width * 0.4 && mouse_x < room_width * 0.45 &&
		        mouse_y > room_height * 0.40 && mouse_y < room_height * 0.45) {
				// Update player balance
				obj_storeController.balance += playerSellPrice
				obj_firestore_controller.UpdateBalance()
				// Remove the player from the squad list
		        ds_list_delete(squad, playerToSell);
				obj_UltManManagerController.SaveGamestate()
		        showSellPopup = false;  // Close the popup
		    }
            
		    // Check for "NO" button click
		    if (mouse_x > room_width * 0.55 && mouse_x < room_width * 0.6 &&
		        mouse_y > room_height * 0.40 && mouse_y < room_height * 0.45) {
		        showSellPopup = false;  // Close the popup without selling
		    }
		}
	}
	
	// Cannot popups
    if (showPopupCannotBuyPack || showPopupCannotAffordPack || showCannotSellPopup) {
		// Rectangle coordinates
		var rect_left = room_width * 0.3;
		var rect_right = room_width * 0.7;
		var stringToShow = "Unknown error";

		// Calculate the center of the rectangle
		var rect_center_x = (rect_left + rect_right) / 2;

		// Set button size
		var button_width = room_width * 0.1;  // Width of the button (adjust as needed)

		// Calculate the button's coordinates to center it
		var button_left = rect_center_x - button_width / 2;
		var button_right = rect_center_x + button_width / 2;
		var button_top = room_height * 0.3875;
		var button_bot = room_height * 0.4375;
		var textXStart = room_width * 0.3125
		var textYStart = room_height * 0.275
        draw_set_color(c_black);
        draw_set_alpha(0.8);
        draw_rectangle(room_width * 0.3, room_height * 0.25, room_width * 0.7, room_height * 0.45, false);
        draw_set_alpha(1);
        draw_set_color(c_white);
		if (showPopupCannotBuyPack){
			stringToShow = LC.translate("Get a full starting 11 of your current available pack tier to get the next tier of pack");
		}
		else if (showPopupCannotAffordPack){
			stringToShow = LC.translate("You do you possess the sufficient funds");
			textXStart = rect_center_x
			draw_set_halign(fa_center)
		}
		else if (showCannotSellPopup){
			stringToShow = LC.translate("This player is currently in your starting 11 and cannot be sold, please remove them from your starting 11 to be able to sell")
		}
		draw_set_valign(fa_top)
		draw_text_ext(textXStart, textYStart, 
		stringToShow, 25,room_width * 0.6875 - room_width * 0.3)
        
        // Draw "OK" button
		draw_set_color(#4994ec);
		scr_drawButton(button_left, button_top, button_right, button_bot, "OK")
        draw_set_color(c_white);
      
        // Handle "OK" button clicks
        if (mouse_check_button_pressed(mb_left)) {
            // Check for "OK" button click
            if (mouse_x > button_left && mouse_x < button_right &&
                mouse_y > button_top && mouse_y < button_bot) {
                showPopupCannotBuyPack = false;  // Close the popup
				showCannotSellPopup = false;
				showPopupCannotAffordPack = false;
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