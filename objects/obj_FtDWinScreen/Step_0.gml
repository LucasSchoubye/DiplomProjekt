restartKey = keyboard_check(ord("R"))
quitKey = keyboard_check(ord("Q"))

// fade in
alpha += alphaSpd
alpha = clamp(alpha,0,1)


// restart
if (restartKey && alpha >= 1) {
	room_restart()
}

// quit
if (quitKey && alpha >= 1) {
	room_goto(rm_minigameMenu)
	audio_stop_sound(sou_FtDFightMusicLoop);
	audio_stop_sound(sou_FtDApplause);
	audio_stop_sound(sou_FtDWin);
	window_set_cursor(cr_default);
}