// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_UltManActiontypes(){

var goalAttempt = false

	switch(selectedAction)
	{
		case ActionType.Run:
			scr_UltManRunning()
		break;
		case ActionType.Shoot:
			
			var targetGoal = obj_UltManGameController.goals[obj_UltManGameController.targetGoalIndex]
			if (targetGoal.CheckMouseCollision())
			{
				// Shoot on target
				draw_text(mouse_x, mouse_y, "SHOT ON GOAL")
				draw_line(obj_UltManBall.x, obj_UltManBall.y, mouse_x, mouse_y)
				
				goalAttempt = true
			}
			else
			{
				//Pass
				scr_UltManPassing()
			}
			
			
		break;
		
		
	}

	if (mouse_check_button_pressed(mb_left) && playAllowed)
	{
		// Increase timer
		obj_UltManGameController.timer += 0.33
	
		// Player Performs their move
		switch(selectedAction)
		{
			case ActionType.Run:
				controlledPlayer.MoveToPos(targetX, targetY)
			break;
			case ActionType.Shoot:
				if (goalAttempt = true)
					controlledPlayer.ShootToPos(mouse_x, mouse_y)
				else
					controlledPlayer.ShootToPos(targetX, targetY)
			break;
		}
		
		// Team perform their move
		with(obj_UltManPlayer)
		{
			if (obj_UltManGameController.commandedPlayer != id &&
				obj_UltManGameController.controlledPlayer != id &&
				playerTeam = true)
			{
				PerformAction(targetX, targetY)
			}
		}
	
		// Perform command move
		if (instance_exists(obj_UltManGameController.commandedPlayer))
		{		
			obj_UltManGameController.commandedPlayer.MoveToPos(obj_UltManGameController.commandTargetX, obj_UltManGameController.commandTargetY)
			obj_UltManGameController.commandTargetX = undefined
			obj_UltManGameController.commandTargetY = undefined
			obj_UltManGameController.commandedPlayer = undefined
		}
		
		// All opponents perform their move
		with(obj_UltManOpponent)
		{
			PerformAction(targetX, targetY)
		}

	}

}