

if (global.game_state == GAME_STATE.PAUSED && obj_FtDPlayer.hp > 0) {
	layer_background_visible(back,true)
	scr_drawMultipleChoice(optionsMenu, id)
}