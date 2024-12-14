
var screenMiddleX = room_width/2
var LC = obj_languageController

var buttonWidth = 30
var buttonHeight = 30
var buttonBufferX = 30

if (room = rm_settings)
{
	draw_set_halign(fa_center)
	draw_set_font(fn_LatoBold40)
	
	// Title
	draw_text(screenMiddleX, room_height*0.1, LC.translate("Settings", Games.Menus))
	
	// Back button
	#region Back Button
	draw_set_font(fn_LatoSemiBold12)
	var buttonMiddleX = room_width*0.95
	var buttonMiddleY = room_height*0.05
	var buttonWidthBack = 100
	var buttonHeightBack = 25

	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	draw_roundrect(buttonMiddleX - buttonWidthBack/2, buttonMiddleY + buttonHeightBack/2,buttonMiddleX + buttonWidthBack/2, buttonMiddleY - buttonHeightBack/2,true)
	draw_set_alpha(1)

	draw_text(buttonMiddleX, buttonMiddleY, LC.translate("Back", Games.Menus))

	if (mouse_x > buttonMiddleX - buttonWidthBack/2 &&
		mouse_y < buttonMiddleX + buttonWidthBack/2 &&
		mouse_y > buttonMiddleY - buttonHeightBack/2 &&
		mouse_y < buttonMiddleY + buttonHeightBack/2)
	{
		draw_set_alpha(0.3)
		draw_roundrect(buttonMiddleX - buttonWidthBack/2, buttonMiddleY + buttonHeightBack/2,buttonMiddleX + buttonWidthBack/2, buttonMiddleY - buttonHeightBack/2,false)
		draw_set_alpha(1)

		if (mouse_check_button_pressed(mb_left))
		{
			room_goto(rm_menu)
		}
	}
	#endregion
	
	// Language
	draw_set_font(fn_lato16)
	var languageString = LC.translate("Language: ", Games.Menus)+LC.getLanguageString()
	draw_set_font(fn_lato16)
	draw_text(screenMiddleX, room_height*0.33, languageString)
	
	// Left button
	#region Left Button Language
	draw_roundrect(screenMiddleX - string_width(languageString)/2 - buttonWidth - buttonBufferX, 
				room_height*0.33 + buttonHeight/2, 
				screenMiddleX - string_width(languageString)/2 - buttonBufferX, 
				room_height*0.33 - buttonHeight/2, 
				true)
	draw_triangle(	screenMiddleX - string_width(languageString)/2 - buttonWidth - buttonBufferX + 5, room_height*0.33, // Left
					screenMiddleX - string_width(languageString)/2 - buttonBufferX - 5, room_height*0.33 - 8, // Top Right
					screenMiddleX - string_width(languageString)/2 - buttonBufferX - 5, room_height*0.33 + 8, // Bottom Right
					false)
				
	// if mouse inside button
	if (point_in_rectangle(mouse_x, mouse_y, 
				screenMiddleX - string_width(languageString)/2 - buttonWidth - buttonBufferX, 
				room_height*0.33 - buttonHeight/2, 
				screenMiddleX - string_width(languageString)/2 - buttonBufferX, 
				room_height*0.33 + buttonHeight/2))
	{
		draw_set_alpha(0.2)
		draw_roundrect(screenMiddleX - string_width(languageString)/2 - buttonWidth - buttonBufferX, 
				room_height*0.33 + buttonHeight/2, 
				screenMiddleX - string_width(languageString)/2 - buttonBufferX, 
				room_height*0.33 - buttonHeight/2, 
				false)
		draw_set_alpha(1)
		
		if(mouse_check_button_pressed(mb_left))
		{
			if (LC.languageChosen = Languages.Danish)
				LC.languageChosen = Languages.English
			else
				LC.languageChosen = Languages.Danish
		}
	}
	#endregion 
	
	// Right button
	#region Right Button Language
	draw_roundrect(screenMiddleX + string_width(languageString)/2 + buttonWidth + buttonBufferX, 
				room_height*0.33 + buttonHeight/2, 
				screenMiddleX + string_width(languageString)/2 + buttonBufferX, 
				room_height*0.33 - buttonHeight/2, 
				true)
	draw_triangle(	screenMiddleX + string_width(languageString)/2 + buttonWidth + buttonBufferX - 5, room_height*0.33, // Left
					screenMiddleX + string_width(languageString)/2 + buttonBufferX + 5, room_height*0.33 - 8, // Top Right
					screenMiddleX + string_width(languageString)/2 + buttonBufferX + 5, room_height*0.33 + 8, // Bottom Right
					false)
				
	// if mouse inside button
	if (point_in_rectangle(mouse_x, mouse_y, 
				screenMiddleX + string_width(languageString)/2 + buttonBufferX, 
				room_height*0.33 - buttonHeight/2, 
				screenMiddleX + string_width(languageString)/2 + buttonWidth + buttonBufferX, 
				room_height*0.33 + buttonHeight/2))
	{
		draw_set_alpha(0.2)
		draw_roundrect(screenMiddleX + string_width(languageString)/2 + buttonBufferX, 
				room_height*0.33 - buttonHeight/2, 
				screenMiddleX + string_width(languageString)/2 + buttonWidth + buttonBufferX, 
				room_height*0.33 + buttonHeight/2,
				false)
		draw_set_alpha(1)
		
		if(mouse_check_button_pressed(mb_left))
		{
			if (LC.languageChosen = Languages.Danish)
				LC.languageChosen = Languages.English
			else
				LC.languageChosen = Languages.Danish
		}
	}
	#endregion 
}