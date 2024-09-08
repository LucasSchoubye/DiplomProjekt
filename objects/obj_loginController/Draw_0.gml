/// @description Draw event

var roomMidWidth = room_width/2
var roomMidHeight = room_width/2

var selectionBuffer = 230
var textBuffer = 150

draw_set_valign(fa_center)
draw_set_halign(fa_center)

draw_text(roomMidWidth, 425, "Login")

draw_text(roomMidWidth - textBuffer, 300, "Username: ")
draw_text(roomMidWidth - textBuffer, 320, "Password: ")
draw_text(roomMidWidth, 300, string(username))
draw_text(roomMidWidth, 320, string(password))



// Draw selection
var targetString = username
if (selectedUsername)
{
	draw_circle(roomMidWidth - selectionBuffer, 300, 5, true)
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
	draw_circle(roomMidWidth - selectionBuffer, 320, 5, true)
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

// Draw button
var boxTop = 400
var boxBot = 450
var boxLeft = roomMidWidth + 100
var boxRight = roomMidWidth - 100

draw_rectangle(boxLeft, boxTop, boxRight, boxBot, true)
if (mouse_check_button_pressed(mb_left) && mouse_x > boxRight && mouse_x < boxLeft && mouse_y > boxTop && mouse_y < boxBot)
{
	if (instance_exists(obj_firestore_controller))
	{
		show_debug_message(sha1_string_utf8(password))
		obj_firestore_controller.RequestLogin(username,password)
	}
}


// Keyboard check
function charIsValid() {
    var key_pressed = keyboard_lastchar;

	if(keyboard_check_pressed(vk_shift) or 
		keyboard_check_pressed(vk_up) or
		keyboard_check_pressed(vk_down) or
		keyboard_check_pressed(vk_tab))
		return false

    // Check if the key pressed is a letter or a number
    if ((key_pressed >= "0" && key_pressed <= "9") || (key_pressed >= "A" && key_pressed <= "Z") || (key_pressed >= "a" && key_pressed <= "z")) {
        return true;
    } else {
        return false;
    }
}