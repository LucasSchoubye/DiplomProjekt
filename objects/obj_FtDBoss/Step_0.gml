/// @description Insert description here
// You can write your code in this editor
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
	instance_destroy(obj_FtDBoss)
	show_message("You Defeated the bossman!!!")
	win()
	room_goto(rm_minigameMenu)
}

event_inherited()
