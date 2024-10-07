if (global.game_state == GAME_STATE.PAUSED) {
	questionTimer = questionTimer
} else {
	questionTimer -= 1
}
alarm_set(0,60)