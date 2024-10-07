/// @description Insert description here
// You can write your code in this editor
if (global.game_state == GAME_STATE.PAUSED) {
	return
}

scr_playerMovement()
getDamaged(obj_damagePlayer,true)

//death
	if (hp <= 0) {
		instance_destroy()
		show_message("You Died lol!")
		room_goto(rm_minigameMenu)
	}

