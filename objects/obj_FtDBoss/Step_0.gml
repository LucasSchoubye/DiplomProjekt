// check if paused
if (screenPause()) {exit}

// remove bulletInst if just question unpaused
if (instance_exists(bulletInst) && global.game_state == GAME_STATE.PAUSED) {
	bulletInst.destroy = true
}

// exit if paused
if (global.game_state == GAME_STATE.PAUSED) {
	return
}
// State machine
if (enemy_state == ENEMY_STATE.CHASING)
	{ // Chase
		if (instance_exists(obj_FtDPlayer)){
			dir = point_direction(x,y, obj_FtDPlayer.x, obj_FtDPlayer.y)
		}
		spd = chaseSpd
		
		// transition to shoot state
		shootTimer++
		
		if (shootTimer > cooldown) {
			enemy_state = ENEMY_STATE.STOPPED
			
			shootTimer = 0
		}
} else if (enemy_state == ENEMY_STATE.STOPPED)
{ // pause
	if (instance_exists(obj_FtDPlayer)){
		dir = point_direction(x,y, obj_FtDPlayer.x, obj_FtDPlayer.y)		
	}
	spd = 0
	
	// stop animating
	image_index = 0
	
	// shoot a bullet
	shootTimer++
	
	if (shootTimer == 1) {
		bulletInst = instance_create_depth(x+bulletXoff*face,y+bulletYoff,depth,obj_fireball)		
	}
		
	if (shootTimer <= windupTimer && instance_exists(bulletInst)) {
		bulletInst.x = x + bulletXoff*face
		bulletInst.y = y + bulletYoff
	}
		
	if (shootTimer = windupTimer && instance_exists(bulletInst)) {
		bulletInst.attack_state = ATTACK_STATE.SHOOT
	}
	if (shootTimer > windupTimer+recoverTimer) {
		enemy_state = ENEMY_STATE.CHASING
		shootTimer = 0
		}
}



// chase the player
if (instance_exists(obj_FtDPlayer)){
	dir = point_direction(x,y, obj_FtDPlayer.x, obj_FtDPlayer.y)
}
	xspd = lengthdir_x(spd,dir)
	yspd = lengthdir_y(spd,dir)
	
	//collision
	if (place_meeting(x+xspd,y, obj_enemyParent) || place_meeting(x + xspd, y, [obj_wallBackDecor, obj_wallBack, obj_wallCorner, obj_wallDoor, obj_wallFront, obj_wallFrontDecor, obj_wallSide])) {
		xspd = 0
	}
	if (place_meeting(x,y+yspd, obj_enemyParent) || place_meeting(x, y + yspd, [obj_wallBackDecor, obj_wallBack, obj_wallCorner, obj_wallDoor, obj_wallFront, obj_wallFrontDecor, obj_wallSide])){
		yspd = 0
	}
	
	// Get correct face
	if (dir > 90 && dir < 270) {
		face = -1
	} else {
		face = 1
	}

	x += xspd
	y += yspd
	
	x = floor(x);
	y = floor(y);
//receive dmg
getDamaged(obj_damageEnemy)

//death
if (hp <= 0) {
	instance_destroy()
}



event_inherited()
