// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_UltManFindBestPassOption(goal, safePassDist){
	
	var ClosestToGoal = 100000
	global.bestPassPlayer = obj_UltManBall.owner
	var ballCarrier
	
	with(obj_UltManOpponent)
	{
		var passer = obj_UltManBall.owner
		var lenDirX = lengthdir_x(point_distance(passer.x,passer.y,targetX,targetY)-400, point_direction(passer.x,passer.y,targetX,targetY))
		var lenDirY = lengthdir_y(point_distance(passer.x,passer.y,targetX,targetY)-400, point_direction(passer.x,passer.y,targetX,targetY))
		
		// If you aren't the passer and the pass is legal
		if (passer != id and !collision_circle(targetX,targetY,safePassDist,obj_UltManPlayer,true,true) && point_distance(x,y,passer.x,passer.y) < passer.topPassSpd)
		{
			if (ClosestToGoal > point_distance(targetX,targetY,goal.x,goal.y))
			{
				global.bestPassPlayer = id
				ClosestToGoal = point_distance(targetX,targetY,goal.x,goal.y)
			}
		}
	}

	return global.bestPassPlayer
}