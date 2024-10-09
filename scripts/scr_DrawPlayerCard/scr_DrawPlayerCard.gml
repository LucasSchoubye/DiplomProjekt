// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_DrawPlayerCard(x1,y1,x2,y2,currentPlayer){
	
	var currentFont = draw_get_font()
	var currentHAlign = draw_get_halign()
	var currentVAlign = draw_get_valign()
	var centerX = (x1 + x2)/2
	var centerY = (y1 + y2)/2
	var currentPlayerLastName = currentPlayer.name[1]
	var currentPlayerNationality = currentPlayer.NatToString()
	var currentPlayerPos = currentPlayer.PosToString()
	var currentPlayerFlag = currentPlayer.NatToSprite()
	var newRow = 0
	var rowCounter = 0
	var cardWidth = abs(x2 - x1)
	var playerColour = ds_list_find_value(packs, currentPlayer.tier).packColour
	var attributeArray = ["topSpd", "dribbling", "shooting", "topShootSpd", "passing", "topPassSpd", "strength", "defence"]
	var attributeStringArray = ["Pac", "Dri", "Sho", "Sho Str", "Pas", "Pas Str", "Str", "Def"]
	
	// aligns correct for text
	draw_set_halign(fa_left)
	
	draw_set_font(fn_konk16);
	//draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	draw_set_color(#393944)
	draw_roundrect(x1,y1,x2,y2, false)
	draw_set_color(#212130)
	draw_roundrect(x1,centerY,x2,y2, false)
	draw_set_color(c_white)
	draw_roundrect(x1,y1,x2,y2, true)
	draw_set_color(#C9C9C9)
	draw_text(x1 + 10,y1 + 20, currentPlayer.name[0])
	draw_set_color(c_white)
	
	//checks if name is too long
	if(string_length(currentPlayerLastName) > 8)
	{
		draw_set_font(fn_konk16);
	}
	else
	{
		draw_set_font(fn_konk22);	
	}
	draw_text(x1 + 10,y1 + 45, currentPlayerLastName)
	draw_set_color(playerColour)
	
	// makes font different if their rating is above 100
	if (currentPlayer.overallRating >= 100)
	{
		draw_set_font(fn_LatoBold40);
		draw_text(x2-105,y1 + 40, currentPlayer.overallRating)
	}
	else
	{
		draw_set_font(fn_LatoBold56);
		draw_text(x2-100,y1 + 40, currentPlayer.overallRating)
	}
	draw_set_color(c_white)
	draw_set_font(fn_textLato);
	draw_text(x1 + 10, y1 + 110, "Position: ")
	draw_text(x2 - 100, y1 + 110, "Age: ")
	draw_set_font(fn_LatoSemiBold12);
	draw_sprite_ext(currentPlayerFlag, false, x1 + 10, y1 + 60, 0.075, 0.075, 0, c_white, 1)
	draw_text(x1 + 10 + string_width("Position: "), y1 + 110, currentPlayerPos)
	draw_text(x2 - 100 + string_width("Age: "), y1 + 110, currentPlayer.age)
	
	// Writes their attribute as a number and the string
	for (var i = 0; i < array_length(attributeArray); ++i) {
	    var attribute = attributeArray[i]
		var attributeString = attributeStringArray[i]
		draw_set_halign(fa_right)
		draw_set_font(fn_LatoSemiBold12);
		draw_text(x1 + (cardWidth / 2) * (1 + i - newRow * 2) - 10,centerY + 20 + newRow * 30 ,currentPlayer.CalculateRating(attribute))
		draw_set_halign(fa_left)
		draw_set_font(fn_RobotoMedium14);
		draw_text(x1 + (cardWidth / 2) * (i - newRow * 2) + 10,centerY + 20 + newRow * 30 ,attributeString)
		rowCounter++
		if(rowCounter = 2){
			rowCounter = 0
			newRow += 1
		}
	}
	
	draw_set_halign(currentHAlign)
	draw_set_valign(currentVAlign)
	draw_set_font(currentFont)
}