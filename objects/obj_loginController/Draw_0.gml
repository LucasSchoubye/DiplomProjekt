/// @description Draw event
window_set_cursor(cr_none)
var LC = obj_languageController
image_speed = 1

if (room = rm_login)
{
	
	// Variables
	var roomMidWidth = (room_width/4)*3
	var roomMidWidth = (room_width/4)*3
	var roomQuarterWidth = (room_width/4)
	var roomMidHeight = room_width/2
	var selectionBuffer = 230
	var textBuffer = 150
	
	// Title
	draw_set_font(fn_titleLato)
	draw_set_halign(fa_center)
	draw_text(roomMidWidth, room_height*0.35, "Login Menu")
	
	// Left box
	draw_set_alpha(0.3 + sin(current_time/600)*0.02)
	draw_rectangle_color(0,0,room_width/2, room_height, #191115, #191115, c_white, c_white, false)
	draw_set_alpha(1)
	
	// Left box text
	draw_text(roomQuarterWidth, room_height*0.1, LC.translate("News Title", Games.Menus))
	draw_set_font(fn_textLato)
	draw_text(roomQuarterWidth, room_height*0.9, LC.translate("Don't have an account?   Contact your school", Games.Menus))
	draw_set_alpha(0.8)
	draw_text(roomQuarterWidth, room_height*0.9 + 25, LC.translate("Information found here!",Games.Menus))
	draw_set_alpha(1)
	//draw_sprite_stretched(spr_newsGif,image_index,room_width*0.05,room_height*0.15,room_width*0.45-room_width*0.05,room_height*0.85-room_height*0.15)
	draw_roundrect(room_width*0.05,room_height*0.15,room_width*0.45,room_height*0.85,true)
	
	// Open Url when clicked on read more
	if (mouse_x > roomQuarterWidth - 100
		&& mouse_x < roomQuarterWidth + 100
		&& mouse_y > room_height*0.9 + 25 - 20
		&& mouse_y < room_height*0.9 + 25 + 20)
	{
		draw_line(roomQuarterWidth - string_width(LC.translate("Information found here!",Games.Menus))/2,
					room_height*0.9 + 35,
					roomQuarterWidth + string_width(LC.translate("Information found here!",Games.Menus))/2,
					room_height*0.9 + 35)
		
		if mouse_check_button_pressed(mb_left)
			url_open("https://www.google.com/search?q=link+til+vores+hjemmeside&oq=link+til+vores+hjemmeside&gs_lcrp=EgRlZGdlKgYIABBFGDkyBggAEEUYOTIHCAEQIRifBTIHCAIQIRifBTIHCAMQIRifBTIHCAQQIRifBTIHCAUQIRifBTIHCAYQIRifBTIHCAcQIRifBdIBCDQ3MzVqMWoxqAIAsAIA&sourceid=chrome&ie=UTF-8")
	}
	
	draw_set_font(fn_lato16)
	draw_set_valign(fa_middle)
	draw_set_halign(fa_left)
	
	draw_text(roomQuarterWidth*2 + textBuffer, room_height*0.45, LC.translate("Username: ",Games.Menus))
	draw_text(roomQuarterWidth*2 + textBuffer, room_height*0.45 + 30, LC.translate("Password: ",Games.Menus))
	
	// Convert password into * characters
	var passwordToAsterisks = ""
	for (var i = 0; i < string_length(string(password)); ++i) {
	    passwordToAsterisks = passwordToAsterisks + "*"
	}
	
	draw_set_halign(fa_center)
	draw_text(roomMidWidth, room_height*0.45, string(username))
	draw_set_valign(fa_middle)
	draw_text(roomMidWidth, room_height*0.45 + 30, passwordToAsterisks)
	draw_set_valign(fa_middle)
	
	// Draw typing cursor
	draw_set_alpha(1 + sin(current_time/100))
	if (selectedUsername)
		draw_text(roomMidWidth + string_width(username)/2 +2, room_height*0.45, "I")
	else
		draw_text(roomMidWidth + string_width(passwordToAsterisks)/2 + 2, room_height*0.45+30, "I")
	draw_set_alpha(1)
	
	// Change selectedUsername on mouseclick
	if (mouse_check_button_pressed(mb_left) 
		&& mouse_x > roomMidWidth - 200
		&& mouse_x < roomMidWidth + 200
		&& mouse_y > room_height*0.45 - 50
		&& mouse_y < room_height*0.45 + 50)
	{
		if (mouse_y > room_height*0.45 + 5)
			selectedUsername = false
		else
			selectedUsername = true
	}

	// Draw selection
	var targetString = username
	if (selectedUsername)
	{
		// username
		draw_circle(roomQuarterWidth*2 + textBuffer - 20, room_height*0.45, 5, true)
		if (keyboard_check_pressed(vk_anykey))
		{
			if (charIsValid() and !keyboard_check_pressed(vk_shift))
				username = username + keyboard_lastchar
			if (keyboard_check_pressed(vk_backspace))
				username = string_delete(username, string_length(username), 1)
		}
	}
	else
	{
		// Password
		draw_circle(roomQuarterWidth*2 + textBuffer - 20, room_height*0.45 + 30, 5, true)
		if (keyboard_check_pressed(vk_anykey))
		{
			if (charIsValid() and !keyboard_check_pressed(vk_shift))
				password = password + keyboard_lastchar
			if (keyboard_check_pressed(vk_backspace))
				password = string_delete(password, string_length(password), 1)
		}
		
	}
	
	if (keyboard_check_pressed(vk_enter) or keyboard_check_pressed(vk_tab) or keyboard_check_pressed(vk_up) or keyboard_check_pressed(vk_down))
	{
		selectedUsername = !selectedUsername
	}

	// Draw login button
	var boxTop = room_height*0.55
	var boxBot = room_height*0.55 + 50
	var boxLeft = roomMidWidth + 100
	var boxRight = roomMidWidth - 100
	
	draw_set_alpha(0.15)
	draw_roundrect_ext(boxLeft, boxTop, boxRight, boxBot, 50, 100, false)
	draw_set_alpha(0.8)
	draw_roundrect_ext(boxLeft, boxTop, boxRight, boxBot, 50, 100, true)
	draw_set_alpha(1)
	draw_set_font(fn_textLato)
	draw_text(roomMidWidth, room_height*0.55 + 25, "Login")
	
	if (mouse_x > boxRight && mouse_x < boxLeft && mouse_y > boxTop && mouse_y < boxBot)
	{
		draw_set_alpha(0.1)
		draw_roundrect_ext(boxLeft, boxTop, boxRight, boxBot, 50, 100, false)
		draw_set_alpha(1)
		
		if (mouse_check_button_pressed(mb_left))
		{
			room_goto(rm_loginWaiting)
			if (instance_exists(obj_firestore_controller))
			{
				obj_firestore_controller.RequestAuthUser(username,password)
			}
		}
	}


	// Keyboard check
	function charIsValid() {
	    var key_pressed = keyboard_lastchar;

		if(keyboard_check_pressed(vk_shift) or 
			keyboard_check_pressed(vk_up) or
			keyboard_check_pressed(vk_down) or
			keyboard_check_pressed(vk_right) or
			keyboard_check_pressed(vk_left) or
			keyboard_check_pressed(vk_control) or
			keyboard_check_pressed(vk_alt) or
			keyboard_check_pressed(vk_lcontrol) or
			keyboard_check_pressed(vk_tab))
			return false

	    // Check if the key pressed is a letter or a number
	    if ((key_pressed >= "0" && key_pressed <= "9") || (key_pressed >= "A" && key_pressed <= "Z") || (key_pressed >= "a" && key_pressed <= "z") || key_pressed = "@" || key_pressed = ".") {
	        return true;
	    } else {
	        return false;
	    }
	}
}

// Waiting
if (room = rm_loginWaiting)
{
	draw_set_font(fn_textLato)
	draw_text(room_width/2, 300, LC.translate("Logging In...", Games.Menus))
}