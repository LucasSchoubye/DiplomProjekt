
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

	if (distance_to_object(obj_FtDPlayer) > maxRange) {
		outOfRange = true
	}
}


// destroy
if (destroy == true) {
	instance_destroy()
}