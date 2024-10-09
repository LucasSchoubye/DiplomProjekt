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
}