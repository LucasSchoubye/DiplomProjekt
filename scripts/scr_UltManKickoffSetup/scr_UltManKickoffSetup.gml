// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_UltManKickoffSetup(){

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

}