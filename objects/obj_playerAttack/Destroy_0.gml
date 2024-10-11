/// @description Insert description here
// You can write your code in this editor


var freezeTime = 15
var part = instance_create_depth(x,y,-100, obj_FtDParticleFlashing)
effect_create_above(ef_smoke, x, y, 5, c_white)

// Screen shake
if (instance_exists(obj_FtDPlayer))
{
	obj_FtDCamera.x += lengthdir_x(50,point_direction(x,y,obj_FtDPlayer.x, obj_FtDPlayer.y))
	obj_FtDCamera.y += lengthdir_y(50,point_direction(x,y,obj_FtDPlayer.x, obj_FtDPlayer.y))
}

while(current_time < freezeTime){}