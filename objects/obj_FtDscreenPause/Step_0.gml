restartKey = keyboard_check(ord("R"))
quitKey = keyboard_check(ord("Q"))



// restart
if (restartKey) {
	room_restart()
}

// quit
if (quitKey) {
	room_goto(rm_minigameMenu)
	audio_stop_sound(sou_FtDFightMusicLoop);
	window_set_cursor(cr_default)
}