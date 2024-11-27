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

scr_UltManKickoffSetup(global.leftScored, false)