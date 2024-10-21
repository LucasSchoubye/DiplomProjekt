
// check if paused
if (screenPause()) {exit}

// State Machine
if (attack_state == ATTACK_STATE.CHARGING)
{ // aim for player
	if (instance_exists(obj_FtDBoss)){
		dir = point_direction(x,y, obj_FtDBoss.x, obj_FtDBoss.y)
	}
		
	
		
	// set depth to make player more visible
	depth = -y - 30
} else if (attack_state == ATTACK_STATE.SHOOT) 
{ // Shoot
	xspd = lengthdir_x(spd,dir)
	yspd = lengthdir_y(spd,dir)
	x += xspd
	y += yspd

	var flash = instance_create_depth(x,y,depth + 10,obj_FtDParticleFlashing)
	flash.baseSize = 5
	flash.decaySize = 3
}


// destroy
if (destroy == true) {
	instance_destroy()
}