/// @description Insert description here
// You can write your code in this editor

if (keyboard_check_pressed(vk_escape)) {
	if (global.game_state == GAME_STATE.RUNNING)
	{
		global.game_state = GAME_STATE.PAUSED
		layer_background_visible(back,true)
	} else if (global.game_state == GAME_STATE.PAUSED) {
		global.game_state = GAME_STATE.RUNNING
		layer_background_visible(back,false)
	}
}
