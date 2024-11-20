

if (global.game_state == GAME_STATE.PAUSED && obj_FtDPlayer.hp > 0) {
	draw_set_font(fn_lato16)
	layer_background_visible(back,true)
	scr_drawMultipleChoice(optionsMenu, id)
	if (mouseWithinAnswerBox == true) {
		window_set_cursor(cr_handpoint)
	} else {
		window_set_cursor(cr_default)
	}
} else {
	window_set_cursor(cr_none)
}