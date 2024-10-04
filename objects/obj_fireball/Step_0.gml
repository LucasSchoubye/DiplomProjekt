/// @description Insert description here
// You can write your code in this editor
xspd = lengthdir_x(spd,dir)
yspd = lengthdir_x(spd,dir)


x += xspd
y += yspd

// destroy
if (destroy == true) {
	instance_destroy()
}

//collision
if (place_meeting(x, y, [obj_wallBackDecor, obj_wallBack, obj_wallCorner, obj_wallDoor, obj_wallFront, obj_wallFrontDecor, obj_wallSide])) {
	destroy = true
}




