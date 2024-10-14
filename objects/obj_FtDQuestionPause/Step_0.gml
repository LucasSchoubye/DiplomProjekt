/// @description Insert description here
// You can write your code in this editor

if (!instance_exists(obj_FtDPlayer)) {
	return
}
	
if (obj_FtDController.questionTimer == 0) {
	if (global.game_state == GAME_STATE.RUNNING)
	{ // PAUSE GAME
		global.game_state = GAME_STATE.PAUSED
		obj_FtDController.questionTimer = 120
		
	} else if (global.game_state == GAME_STATE.PAUSED) {
		// UNPAUSE IF PLAYER ATTACK IS FINISHED
		layer_background_visible(back,false)
		global.player_state = PLAYER_STATE.ATTACKING
		global.game_state = GAME_STATE.RUNNING
		obj_FtDController.questionTimer = dodgeTime
	}
} else if (answeredQuestions == 3 && global.game_state == GAME_STATE.PAUSED) {
	layer_background_visible(back,false)
	global.player_state = PLAYER_STATE.ATTACKING
	global.game_state = GAME_STATE.RUNNING
	obj_FtDController.questionTimer = dodgeTime
}

