/// @description Insert description here
// You can write your code in this editor
if (global.game_state == GAME_STATE.PAUSED) {
	return
}

scr_playerMovement()

if (global.player_state == PLAYER_STATE.MOVING) {
	getDamaged(obj_damagePlayer,true)	
	
} else if (global.player_state == PLAYER_STATE.ATTACKING) {
	attackOngoing = true
	// stop animating
	image_index = 0
	
	// shoot a bullet
	shootTimer++
	
	if (shootTimer == 1) {
		bulletInst = instance_create_depth(x,y,depth,obj_playerAttack)		
	}
		
	if (shootTimer <= windupTimer && instance_exists(bulletInst)) {
		bulletInst.x = x
		bulletInst.y = y
	}
		
	if (shootTimer = windupTimer && instance_exists(bulletInst)) {
		bulletInst.attack_state = ATTACK_STATE.SHOOT
	}
	
	if (bulletInst.destroy == true) {
		attackOngoing = false
		global.player_state = PLAYER_STATE.MOVING
		shootTimer = 0
		obj_Pause.answeredQuestions = 0
		obj_Pause.correctAnswers = 0
	}
}

//death
if (hp <= 0) {
	instance_destroy()
	show_message("You Died lol!")
	room_goto(rm_minigameMenu)
}

