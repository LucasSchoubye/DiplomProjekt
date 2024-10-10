// check if paused
if (screenPause() && global.game_state == GAME_STATE.RUNNING) {}
else {
	if (questionTimer == 0) {
		questionTimer = 0
	} else {
		questionTimer -= 1
	}
}
alarm_set(0,60)