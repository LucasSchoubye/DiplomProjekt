/// @description 

var freezeTime = current_time + 5
draw_circle(x,y,4000,false)

repeat(5)
{
	var part = instance_create_depth(x,y,-100, obj_FtDParticleDust2)
	part.speed = random_range(10,20)
	part.direction = point_direction(x,y,room_width/2, room_height/2) + random_range(90,-90)
}
var part = instance_create_depth(x,y,-100, obj_FtDParticleFlashing)
part.decaySize = 5
part.baseSize = 5
effect_create_above(ef_smoke, x, y, 5, c_white)
effect_create_above(ef_spark, x, y, 15, c_white)

// Screen shake
if (instance_exists(obj_FtDPlayer))
{
	obj_FtDCamera.x += lengthdir_x(20,point_direction(x,y,obj_FtDPlayer.x, obj_FtDPlayer.y))
	obj_FtDCamera.y += lengthdir_y(20,point_direction(x,y,obj_FtDPlayer.x, obj_FtDPlayer.y))
}

while(current_time < freezeTime){}
audio_play_sound(sou_FtDExplosion, 1, false, 1)