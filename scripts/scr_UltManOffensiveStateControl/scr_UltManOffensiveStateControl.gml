// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_UltManOffensiveStateControl(X,Y){

	state = UltManNpcState.HoldPosition
	var nearTeammate = instance_furthest(x,y,obj_UltManOpponent)
	var nearOpp = scr_assignClosestControlledPlayer(x,y)
	var oppGoal = obj_UltManGameController.goals[obj_UltManGameController.playerTeamIndex]
	var goalMoveX = lengthdir_x(topSpd, point_direction(x,y,oppGoal.x,oppGoal.y))
	var goalMoveY = lengthdir_y(topSpd, point_direction(x,y,oppGoal.x,oppGoal.y))
	var safeDist = topSpd*2//topSpd*2
	var pullbackDist = topSpd*3//topSpd*2
	
	
	if (obj_UltManBall.owner = id)
	{
		if (point_distance(targetX, targetY, nearOpp.x, nearOpp.y) > safeDist)
		{
			MoveToPos(targetX  + goalMoveX, targetY  + goalMoveY)
		}
		else
		{
			var nearTeammate = scr_UltManFindBestPassOption(oppGoal, topSpd*0.8)
			
			if (nearTeammate != id)
			{
				audio_play_sound(sou_UltManKickLight, 1, false)
				ShootToPos(nearTeammate.targetX, nearTeammate.targetY, )
			}
			else
			{
				// Pull Back
				MoveToPos(targetX  - goalMoveX, targetY  - goalMoveY)
			}
			
		}
	}
	else
	{
		MoveIntoPosition(X,Y)
	}

}