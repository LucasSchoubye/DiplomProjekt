/// @description 

instance_create_depth(x,y,-10000,obj_par_screenfade)
celebrationActive = false

obj_UltManBall.targetX = room_width/2
obj_UltManBall.targetY = room_height/2
obj_UltManBall.x = room_width/2
obj_UltManBall.y = room_height/2
obj_UltManBall.owner = undefined
	
with(obj_UltManPlayer)
{
	x = kickoffPos[0]
	y = kickoffPos[1]
	targetX = x
	targetY = y
}
	
if (!global.leftScored)
{
	instance_nearest(obj_UltManBall.x, obj_UltManBall.y, obj_UltManOpponent).targetX = obj_UltManBall.x
	instance_nearest(obj_UltManBall.x, obj_UltManBall.y, obj_UltManOpponent).targetY = obj_UltManBall.y
}
else
{
	instance_nearest(obj_UltManBall.x, obj_UltManBall.y, obj_UltManPlayer).targetX = obj_UltManBall.x
	instance_nearest(obj_UltManBall.x, obj_UltManBall.y, obj_UltManPlayer).targetY = obj_UltManBall.y
}