// check if paused
if (screenPause()) {exit}
if (!instance_exists(obj_FtDPlayer)) {instance_destroy()}
// State Machine
if (attack_state == ATTACK_STATE.CHARGING)
{
		
	
	// set depth to make player more visible
	depth = -y - 30
} else if (attack_state == ATTACK_STATE.SHOOT) 
{ // Shoot 3 balls
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
