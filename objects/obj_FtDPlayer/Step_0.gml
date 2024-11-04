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
	image_alpha = 1
	return
}

armorMovement()

if (global.player_state == PLAYER_STATE.MOVING) {
	getDamaged(obj_damagePlayer,true)	
	
} else if (global.player_state == PLAYER_STATE.ATTACKING) {
	attackOngoing = true
	// stop animating
	image_index = 0
	
	// shoot a bullet
	shootTimer++
	
	if (shootTimer == 1) {
		weaponEquipped()
	}
		
	if (shootTimer <= windupTimer && instance_exists(bulletInst)) {
		bulletInst.x = x
		bulletInst.y = y
		if (ekstraFireBall1 != undefined && ekstraFireBall2 != undefined) {
			ekstraFireBall1.x = x
			ekstraFireBall1.y = y
			ekstraFireBall2.x = x
			ekstraFireBall2.y = y
		}
	}
		
	if (shootTimer = windupTimer && instance_exists(bulletInst)) {
		bulletInst.dir = point_direction(x,y, obj_FtDBoss.x, obj_FtDBoss.y)
		bulletInst.attack_state = ATTACK_STATE.SHOOT
		if (ekstraFireBall1 != undefined && ekstraFireBall2 != undefined) {
			ekstraFireBall1.dir = point_direction(x,y, obj_FtDBoss.x-250, obj_FtDBoss.y-250)
			ekstraFireBall2.dir = point_direction(x,y, obj_FtDBoss.x+250, obj_FtDBoss.y+250)
			ekstraFireBall1.attack_state = ATTACK_STATE.SHOOT
			ekstraFireBall2.attack_state = ATTACK_STATE.SHOOT
		}
	}
	
	
	if (instance_exists(obj_FtDPlayerBlackHole)) {
		if (obj_FtDPlayerBlackHole.outOfRange == true) {
			bulletInst.destroy = true
		}
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
	audio_play_sound(sou_FtDGameOver,1,false)
	
	// destroy player
	instance_destroy()
	audio_stop_sound(sou_FtDFightMusicLoop);
}

//win
if (!instance_exists(obj_enemyParent)) {
	instance_create_depth(0,0,-10000, obj_FtDWinScreen)
	if(won == false) {
		audio_play_sound(sou_FtDWin,1,false)
		audio_play_sound(sou_FtDApplause,1,false)
		obj_FtDWinScreen.ftdGetPrize()
		won = true
	}
	audio_stop_sound(sou_FtDFightMusicLoop);
}
