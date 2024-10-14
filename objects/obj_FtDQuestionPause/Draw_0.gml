

if (global.game_state == GAME_STATE.PAUSED && obj_FtDPlayer.hp > 0) {
	
	draw_set_font(fn_lato16)
	
	layer_background_visible(back,true)
	scr_drawMultipleChoice(optionsMenu, id)
}