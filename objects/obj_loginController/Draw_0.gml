/// @description Draw event

image_speed = 1

if (room = rm_login)
{
	// Variables
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
	draw_text(roomQuarterWidth, room_height*0.1, "News Title")
	draw_set_font(fn_textLato)
	draw_text(roomQuarterWidth, room_height*0.9, "Don't have an account?   Contact your school")
	draw_set_alpha(0.8)
	draw_text(roomQuarterWidth, room_height*0.9 + 25, "Information found here!")
	draw_set_alpha(1)
	//draw_sprite_stretched(spr_newsGif,image_index,room_width*0.05,room_height*0.15,room_width*0.45-room_width*0.05,room_height*0.85-room_height*0.15)
	draw_roundrect(room_width*0.05,room_height*0.15,room_width*0.45,room_height*0.85,true)
	
	draw_set_font(fn_textLato)
	draw_set_valign(fa_middle)
	draw_set_halign(fa_center)
	
	draw_text(roomMidWidth - textBuffer, room_height*0.45, "Username: ")
	draw_text(roomMidWidth - textBuffer, room_height*0.45 + 30, "Password: ")
	draw_text(roomMidWidth, room_height*0.45, string(username))
	draw_text(roomMidWidth, room_height*0.45 + 30, string(password))

	// Draw selection
	var targetString = username
	if (selectedUsername)
	{
		draw_circle(roomMidWidth - selectionBuffer, room_height*0.45, 5, true)
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
		draw_circle(roomMidWidth - selectionBuffer, room_height*0.45 + 30, 5, true)
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
	draw_text(room_width/2, 300, "Logging In...")
}