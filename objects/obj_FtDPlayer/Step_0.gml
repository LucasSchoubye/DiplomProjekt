// set pause key
pauseKey = keyboard_check_pressed(vk_escape)

// pause
if (pauseKey && global.game_state == GAME_STATE.RUNNING) {
	if (!instance_exists(obj_FtDscreenPause)) {
		instance_create_depth(0,0,0,obj_FtDscreenPause)
	} else {
		instance_destroy(obj_FtDscreenPause)
	}
}

// check if paused
if (screenPause()) {exit}

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
		obj_FtDQuestionPause.answeredQuestions = 0
		obj_FtDQuestionPause.correctAnswers = 0
	}
}

//death
if (hp <= 0) {
	// create game over object
	instance_create_depth(0,0,-10000, obj_FtDGameOverScreen)
	
	// destroy player
	instance_destroy()
}

//win
if (!instance_exists(obj_enemyParent)) {
	show_message("You Defeated the bossman!!!")
	win()
	room_goto(rm_minigameMenu)
}
