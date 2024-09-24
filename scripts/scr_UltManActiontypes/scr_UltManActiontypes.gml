// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_UltManActiontypes(){

	var goalAttempt = false
	
	// Action selection
	if (!questionMenuActive)
	{
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
					draw_line(obj_UltManBall.x, obj_UltManBall.y, mouse_x, mouse_y)
				
					goalAttempt = true
				}
				else
				{
					//Pass
					targetX = controlledPlayer.x + lengthdir_x(controlledPlayer.targetShootSpd, dir)
					targetY = controlledPlayer.y + lengthdir_y(controlledPlayer.targetShootSpd, dir)
					scr_UltManPassing()
				}
			break;
		}
	}
	else
	{
		// Draw frozen action
		var drawLineObject = controlledPlayer
		if (selectedAction = ActionType.Shoot)
		{
			drawLineObject = obj_UltManBall
		}
			
		draw_line(drawLineObject.x,drawLineObject.y,frozenTargetX,frozenTargetY)
	}
	
	// Freeze Game
	if (mouse_check_button_pressed(mb_left) && selectedAction != ActionType.Run && playAllowed)
	{
		questionMenuActive = true
		frozenTargetX = targetX
		frozenTargetY = targetY
		
		if (goalAttempt)
		{
			frozenTargetX = mouse_x
			frozenTargetY = mouse_y
		}
		
		frozenActionType = selectedAction
		frozenGoalAttempt = goalAttempt
		skillCheckAmount = 3
		skillCheckAttemptsCounter = 0
		skillCheckCorrectCounter = 0
		frozenShotMissed = false
	}
	
	if (mouse_check_button_pressed(mb_left) && playAllowed && questionMenuActive = false)
	{
		scr_UltManDoActionType(selectedAction, targetX, targetY, goalAttempt)
	}
}