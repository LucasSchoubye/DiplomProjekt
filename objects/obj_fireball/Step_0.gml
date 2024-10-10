/// @description Insert description here
// You can write your code in this editor

// check if paused
if (screenPause()) {exit}

if (global.game_state == GAME_STATE.PAUSED) {
	return
}
if (instance_exists(obj_FtDPlayer)){
	
	// State Machine
	if (attack_state == ATTACK_STATE.CHARGING)
	{ // aim for player
		dir = point_direction(x,y, obj_FtDPlayer.x, obj_FtDPlayer.y)
	
		
		// Get correct face
		if (obj_FtDBoss.dir > 90 && obj_FtDBoss.dir < 270) {
			face = -1
		} else {
			face = 1
		}
		
		// set depth to make player more visible
		depth = -y - 30
	} else if (attack_state == ATTACK_STATE.SHOOT) 
	{ // Shoot
		xspd = lengthdir_x(spd,dir)
		yspd = lengthdir_y(spd,dir)
		x += xspd
		y += yspd
	
		// Homing
		x += lengthdir_x(25,dir)
		y += lengthdir_y(25,dir)

		var afterImage = instance_create_depth(x,y,depth + 10,obj_FtDParticleDust)
			afterImage.sprite_index = sprite_index
			afterImage.image_index = image_index
			afterImage.image_blend = #FFFFF0
			afterImage.shrink = 0.06
			afterImage.fade = 0.03
	}
}

	// destroy
	if (destroy == true) {
		instance_destroy()
	}

	//collision
	if (place_meeting(x, y, [obj_wallBackDecor, obj_wallBack, obj_wallCorner, obj_wallDoor, obj_wallFront, obj_wallFrontDecor, obj_wallSide])) {
		destroy = true
	}

