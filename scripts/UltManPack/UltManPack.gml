function UltManPack(tier) constructor {
	
	packSprite = spr_UltManWhiteMedal
	packPriceY = (sprite_get_height(packSprite)*0.075) + 20
	packTitleY = (sprite_get_height(packSprite)*0.075) + 40
	packPlayerInfoY = (sprite_get_height(packSprite)*0.075) + 60
	packButtonY = (sprite_get_height(packSprite)*0.075) + 60
	textPadding = 10
	packColour = c_white;
	packTitle = ""
	packCost = 0
	packPlayerInfo = ""
	packEnum = tier
	
	//animation
	animCounter = 0
	
	function TierInformation(tier){
		switch(tier)
		{
			case UltManPackTier.Bronze:
				packColour = #8A6225
				packTitle = "Bronze Pack"
				packCost = 10
				packPlayerInfo = "1 45+ Rated Player"
				playerSellPrice = 5
				break
			case UltManPackTier.Silver:
				packColour = #A9A49D
				packTitle = "Silver Pack"
				packCost = 25
				packPlayerInfo = "1 55+ Rated Player"
				playerSellPrice = 15
				break
			case UltManPackTier.Gold:
				packColour = #FFDB20
				packTitle = "Gold Pack"
				packCost = 50
				packPlayerInfo = "1 65+ Rated Player"
				playerSellPrice = 25
				break
			case UltManPackTier.Ruby:
				packColour = #e0115f
				packTitle = "Ruby Pack"
				packCost = 75
				packPlayerInfo = "1 75+ Rated Player"
				playerSellPrice = 40
				break
			case UltManPackTier.Obsidian:
				packColour = #5B4965
				packTitle = "Obsidian Pack"
				packCost = 100
				packPlayerInfo = "1 85+ Rated Player"
				playerSellPrice = 50
				break
			case UltManPackTier.Legendary:
				packColour = #F100E9
				packTitle = "Legendary Pack"
				packCost = 150
				packPlayerInfo = "1 95+ Rated Player"
				playerSellPrice = 75
				break
		}
		return {packColour, packTitle, packCost, packPlayerInfo}
	}
	
	TierInformation(tier)
	
	function DrawPack(xValue, yValue, packWidth, packHeight) {

	    // Set the dimensions for the background rectangle
	    var rectX1 = xValue;
	    var rectY1 = yValue;
	    var rectX2 = xValue + packWidth;
	    var rectY2 = yValue + packHeight;

	    // Draw a rounded rectangle (white background) that fits the exact size of the pack
	    draw_set_color(c_black);
		draw_set_alpha(0.5);
	    draw_roundrect(rectX1, rectY1, rectX2, rectY2, false); // Last parameter is the radius for rounded corners
		draw_set_alpha(1);
	    // Set padding for contents inside the rectangle
	    var contentPadding = 10;

	    // Draw the sprite centered horizontally within the pack background
	    var spriteWidth = sprite_get_width(packSprite) * 0.075;
	    var spriteX = xValue + contentPadding + ((packWidth - (2 * contentPadding)) / 2) - (spriteWidth / 2); // Center the sprite
	    draw_sprite_ext(packSprite, 0, spriteX, yValue + contentPadding, 0.075, 0.075, 0, packColour, draw_get_alpha());

	    // Set font and color for the text
	    draw_set_font(fn_RobotoMedium14);
		
	    // Center the price text within the white background
		var priceTextNonCon = packCost
	    var priceText = string(priceTextNonCon) + " CONTENT COINS";
	    var priceTextWidth = string_width(priceText);
	    var centeredPriceX = xValue + contentPadding + ((packWidth - (2 * contentPadding)) / 2) - (priceTextWidth / 2); // Center text
	    draw_set_color(#528aca);
	    draw_text(centeredPriceX, yValue + packPriceY + contentPadding, priceText);  // Position price text under the sprite

	    // Center the pack title
	    var titleTextWidth = string_width(packTitle);
	    var centeredTitleX = xValue + contentPadding + ((packWidth - (2 * contentPadding)) / 2) - (titleTextWidth / 2);  // Center title text
	    draw_set_color(packColour);
	    draw_text(centeredTitleX, yValue + packTitleY + 1.5*contentPadding, packTitle);  // Position title text below price text

	    // Center the player info text
	    var playerInfoText = packPlayerInfo;
	    var playerInfoTextWidth = string_width(playerInfoText);
	    var centeredPlayerInfoX = xValue + contentPadding + ((packWidth - (2 * contentPadding)) / 2) - (playerInfoTextWidth / 2);  // Center text
	    draw_set_color(c_white);
	    draw_text(centeredPlayerInfoX, yValue + packPlayerInfoY + 2 * contentPadding, playerInfoText);  // Position player info text below title

	    // Draw the buy button within the white background
		draw_set_color(#528aca);
	    scr_drawPackButton(xValue + contentPadding, yValue + packPlayerInfoY + 3 * contentPadding, 
	                   xValue + packWidth - contentPadding, yValue + packHeight - contentPadding, "BUY");

	    // Reset color and alpha
	    draw_set_color(c_white);
	    draw_set_alpha(1);
	}
	
	function DrawUnavailablePack(xValue, yValue, packWidth, packHeight) {

	    // Set the dimensions for the background rectangle
	    var rectX1 = xValue;
	    var rectY1 = yValue;
	    var rectX2 = xValue + packWidth;
	    var rectY2 = yValue + packHeight;

	    // Draw a rounded rectangle (black background) that fits the exact size of the pack
	    draw_set_color(c_black);
		draw_set_alpha(0.5);
	    draw_roundrect(rectX1, rectY1, rectX2, rectY2, false); // Last parameter is the radius for rounded corners
		draw_set_alpha(1);
	    // Set padding for contents inside the rectangle
	    var contentPadding = 10;

	    // Draw the sprite centered horizontally within the pack background
	    var spriteWidth = sprite_get_width(packSprite) * 0.075;
	    var spriteX = xValue + contentPadding + ((packWidth - (2 * contentPadding)) / 2) - (spriteWidth / 2); // Center the sprite
	    draw_sprite_ext(packSprite, 0, spriteX, yValue + contentPadding, 0.075, 0.075, 0, packColour, draw_get_alpha());

	    // Set font and color for the text
	    draw_set_font(fn_RobotoMedium14);
		
	    // Center the price text within the white background
		var priceTextNonCon = packCost
	    var priceText = string(priceTextNonCon) + " CONTENT COINS";
	    var priceTextWidth = string_width(priceText);
	    var centeredPriceX = xValue + contentPadding + ((packWidth - (2 * contentPadding)) / 2) - (priceTextWidth / 2); // Center text
	    draw_set_color(#528aca);
	    draw_text(centeredPriceX, yValue + packPriceY + contentPadding, priceText);  // Position price text under the sprite

	    // Center the pack title
	    var titleTextWidth = string_width(packTitle);
	    var centeredTitleX = xValue + contentPadding + ((packWidth - (2 * contentPadding)) / 2) - (titleTextWidth / 2);  // Center title text
	    draw_set_color(packColour);
	    draw_text(centeredTitleX, yValue + packTitleY + 1.5*contentPadding, packTitle);  // Position title text below price text

	    // Center the player info text
	    var playerInfoText = packPlayerInfo;
	    var playerInfoTextWidth = string_width(playerInfoText);
	    var centeredPlayerInfoX = xValue + contentPadding + ((packWidth - (2 * contentPadding)) / 2) - (playerInfoTextWidth / 2);  // Center text
	    draw_set_color(c_white);
	    draw_text(centeredPlayerInfoX, yValue + packPlayerInfoY + 2 * contentPadding, playerInfoText);  // Position player info text below title

	    // Draw the unavailable button within the white background
		draw_set_color(c_gray);
	    scr_drawPackButton(xValue + contentPadding, yValue + packPlayerInfoY + 3 * contentPadding, 
	                   xValue + packWidth - contentPadding, yValue + packHeight - contentPadding, "UNAVAILABLE");

	    // Reset color and alpha
	    draw_set_color(c_white);
	    draw_set_alpha(1);
	}

}	