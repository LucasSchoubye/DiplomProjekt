/// @description 

var freezeTime = current_time + 50
draw_circle(x,y,4000,false)

repeat(5)
{
	var part = instance_create_depth(x,y,-100, obj_FtDParticleDust2)
	part.speed = random_range(10,20)
	part.direction = point_direction(x,y,room_width/2, room_height/2) + random_range(90,-90)
}
var part = instance_create_depth(x,y,-100, obj_FtDParticleFlashing)
effect_create_above(ef_smoke, x, y, 5, c_white)
effect_create_above(ef_spark, x, y, 15, c_white)

// Screen shake
if (instance_exists(obj_FtDPlayer))
{
	obj_FtDCamera.x += lengthdir_x(200,point_direction(x,y,obj_FtDPlayer.x, obj_FtDPlayer.y))
	obj_FtDCamera.y += lengthdir_y(200,point_direction(x,y,obj_FtDPlayer.x, obj_FtDPlayer.y))
}

while(current_time < freezeTime){}
audio_play_sound(sou_FtDExplosion, 1, false,3)

if (place_meeting(x, y, [obj_wallBackDecor, obj_wallBack, obj_wallCorner, obj_wallDoor, obj_wallFront, obj_wallFrontDecor, obj_wallSide]))

	for (var i = 0; i < 6; ++i) {
	    // code here
		var smallFireball = instance_create_depth(x + lengthdir_x(100, -60*(i)), y + lengthdir_y(100,-60*(i)),-10,obj_fireballSmall)
		direction = -60*i
	
}