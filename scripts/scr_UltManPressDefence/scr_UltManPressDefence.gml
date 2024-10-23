// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_UltManPressDefence(){

	var player = obj_UltManBall.owner
	var goal = obj_UltManGameController.goals[1]
	var ball = obj_UltManBall
	
	if (playerTeam)
	{
		goal = obj_UltManGameController.goals[0]
	}
	
	if (instance_exists(player))
	{
		if (point_distance(player.x, player.y, goal.x, goal.y) > room_width*0.15 and
			point_distance(player.x, player.y, x, y) > topSpd)
		{
			var shotDir = point_direction(ball.x, ball.y, goal.x, goal.y)
			var moveDir = point_direction(player.x, player.y, mouse_x, mouse_y)
			var moveX = player.x + lengthdir_x(topSpd, moveDir)
			var moveY = player.y + lengthdir_y(topSpd, moveDir)
		
			if (kickoffPos[1] > room_height/2)
			{
				shotDir = point_direction(moveX, moveY, goal.x, goal.y + goal.goalHeight/3)
			}
			else
			{
				shotDir = point_direction(moveX, moveY, goal.x, goal.y - goal.goalHeight/3)
			}
	
			var shotStoppingPosX = 0
		
			var X = moveX + lengthdir_x(topSpd*1.1, shotDir)
			var Y = moveY + lengthdir_y(topSpd*1.1, shotDir)
			
			var len = topSpd*1.5
			if (len > point_distance(targetX,targetY,X,Y))
				len = point_distance(targetX,targetY,X,Y)
			var dir = point_direction(targetX, targetY, X, Y)
			
			targetX += lengthdir_x(len, dir)
			targetY += lengthdir_y(len, dir)
			
			if (player.playerTeam = playerTeam)
			{
				state = UltManNpcState.HoldPosition
			}
		}
		else
		{
			scr_UltManPressOffense()
		}
	}

}