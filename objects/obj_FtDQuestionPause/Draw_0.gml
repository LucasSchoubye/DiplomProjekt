

if (global.game_state == GAME_STATE.PAUSED && obj_FtDPlayer.hp > 0) {
	layer_background_visible(back,true)
	scr_drawMultipleChoice(optionsMenu, id)
	cursor_sprite = spr_UltManCursor
} else {
	window_set_cursor(cr_none)
	cursor_sprite = -1
}