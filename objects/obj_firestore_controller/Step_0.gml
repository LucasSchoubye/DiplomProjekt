/// @description Test Read

if (keyboard_check_pressed(vk_enter))
{
	var listenerId = FirebaseFirestore("users/sUfBI3gM4qMOGGFAS5Xq").Read()
}

if (keyboard_check_pressed(vk_left))
{
	//show_message("StartSession()")
	StartSession("games/typeracer")
}