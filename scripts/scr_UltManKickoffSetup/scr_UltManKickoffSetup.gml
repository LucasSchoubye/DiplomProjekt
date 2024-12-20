// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_UltManKickoffSetup(leftScored, celebration = false){

	if (celebration = false)
	{
		obj_UltManBall.targetX = room_width/2
		obj_UltManBall.targetY = room_height/2
		obj_UltManBall.x = room_width/2
		obj_UltManBall.y = room_height/2
		obj_UltManBall.owner = undefined
		global.leftScored = leftScored
	
		with(obj_UltManPlayer)
		{
			x = kickoffPos[0]
			y = kickoffPos[1]
			targetX = x
			targetY = y
		}
	
		if (!leftScored)
		{
			instance_nearest(obj_UltManBall.x, obj_UltManBall.y, obj_UltManOpponent).targetX = obj_UltManBall.x
			instance_nearest(obj_UltManBall.x, obj_UltManBall.y, obj_UltManOpponent).targetY = obj_UltManBall.y
		}
		else
		{
			var closestPlayer = scr_assignClosestControlledPlayer(obj_UltManBall.x, obj_UltManBall.y)
			closestPlayer.targetX = obj_UltManBall.x
			closestPlayer.targetY = obj_UltManBall.y
		}
	}
	else
	{
		celebrationActive = true
		obj_UltManGameController.celebrationMusic = true
		alarm[1] = 60*4
		obj_UltManBall.x = 0//room_width/2
		obj_UltManBall.y = 0//room_height/2
		obj_UltManBall.targetX = 0//room_width/2
		obj_UltManBall.targetY = 0//room_height/2
		obj_UltManBall.owner = undefined
		global.leftScored = leftScored
	}
}