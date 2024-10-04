/// @description Insert description here
// You can write your code in this editor

// chase the player
if (instance_exists(obj_FtDPlayer)){
	dir = point_direction(x,y, obj_FtDPlayer.x, obj_FtDPlayer.y)
}
	xspd = lengthdir_x(spd,dir)
	yspd = lengthdir_y(spd,dir)
	
	// Get correct face
	if (xspd > 0) {
		face = 1
	} else {
		face = -1
	}
	

	x += xspd
	y += yspd
//receive dmg
event_inherited()
