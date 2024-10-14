/// @description Insert description here
// You can write your code in this editor

// check if paused
if (screenPause()) {exit}

if (global.game_state == GAME_STATE.PAUSED) {
	return
}

if (instance_exists(obj_FtDPlayer)){
	
	// Shoot
	xspd = lengthdir_x(spd,dir)
	yspd = lengthdir_y(spd,dir)
	x += xspd
	y += yspd

	var afterImage = instance_create_depth(x,y,depth + 10,obj_FtDParticleDust)
		afterImage.sprite_index = sprite_index
		afterImage.image_index = image_index
		afterImage.image_blend = #FFFFF0
		afterImage.shrink = 0.06
		afterImage.fade = 0.03
		afterImage.image_xscale = image_xscale
		afterImage.image_yscale = image_yscale
}


// destroy
if (destroy == true) {
	instance_destroy()
}

//collision
if (place_meeting(x, y, [obj_wallBackDecor, obj_wallBack, obj_wallCorner, obj_wallDoor, obj_wallFront, obj_wallFrontDecor, obj_wallSide])) {
	destroy = true
}