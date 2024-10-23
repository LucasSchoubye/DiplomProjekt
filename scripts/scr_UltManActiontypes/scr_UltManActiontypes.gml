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
			
				if (obj_UltManBall.owner = controlledPlayer)
				{
					var targetGoal = obj_UltManGameController.goals[obj_UltManGameController.targetGoalIndex]
					if (targetGoal.CheckMouseCollision())
					{
						if (point_distance(obj_UltManBall.x, obj_UltManBall.y, mouse_x, mouse_y) < controlledPlayer.topShootSpd)
						{
							// Shoot on target
							for (var i = 0; i < 20; ++i) {
	    
								var dist = point_distance(obj_UltManBall.x,obj_UltManBall.y,mouse_x, mouse_y)
								var dire = point_direction(obj_UltManBall.x,obj_UltManBall.y,mouse_x, mouse_y)	
								var alphaDist = point_distance(obj_UltManBall.x,obj_UltManBall.y,mouse_x, mouse_y)
			
								//draw_sprite_ext(spr_FtDParticleBasic, 0 , targetX/i + controlledPlayer.accX/i, targetY/i + controlledPlayer.accY/i, dist/200, dist/200, 0, c_white, 1)
								draw_sprite_ext(spr_FtDParticleBasic, 0 , obj_UltManBall.x + lengthdir_x((dist/20)*(i+1), dire), obj_UltManBall.y + lengthdir_y((dist/20)*(i+1), dire), 1+i*0.15, 1+i*0.15, dire, c_white, 1-i*0.05 + sin(current_time/50)*0.1)

							}
						}
						else
						{
							playAllowed = false
							for (var i = 0; i < 20; ++i) {
	    
								var dist = point_distance(obj_UltManBall.x,obj_UltManBall.y,mouse_x, mouse_y)
								var dire = point_direction(obj_UltManBall.x,obj_UltManBall.y,mouse_x, mouse_y)	
								var alphaDist = point_distance(obj_UltManBall.x,obj_UltManBall.y,mouse_x, mouse_y)
			
								//draw_sprite_ext(spr_FtDParticleBasic, 0 , targetX/i + controlledPlayer.accX/i, targetY/i + controlledPlayer.accY/i, dist/200, dist/200, 0, c_white, 1)
								draw_sprite_ext(spr_FtDParticleBasic, 0 , obj_UltManBall.x + lengthdir_x((dist/20)*(i+1), dire), obj_UltManBall.y + lengthdir_y((dist/20)*(i+1), dire), 1+i*0.15, 1+i*0.15, dire, c_red, 1-i*0.05 + sin(current_time/50)*0.1)

							}
						}
						goalAttempt = true
					}
					else
					{
						//Pass
						targetX = controlledPlayer.x + lengthdir_x(controlledPlayer.targetShootSpd, dir)
						targetY = controlledPlayer.y + lengthdir_y(controlledPlayer.targetShootSpd, dir)
						scr_UltManPassing()
					}
				}
				else
				{
					playAllowed = false
				}
			break;
		}
	}
	else
	{
		// Draw frozen action
		var drawLineObject = obj_UltManBall
		draw_line(drawLineObject.x,drawLineObject.y,frozenTargetX,frozenTargetY)
	}
	
	// Freeze Game
	if (mouse_check_button_pressed(mb_left) && selectedAction != ActionType.Run && playAllowed)
	{
		var commandedPlayerMod = 0
		if (instance_exists(commandedPlayer))
			commandedPlayerMod = 1
		
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
		skillCheckAmount = round(point_distance(frozenTargetX, frozenTargetY, controlledPlayer.x, controlledPlayer.y)/600) + commandedPlayerMod
		skillCheckAttemptsCounter = 0
		skillCheckCorrectCounter = 0
		frozenShotMissed = false
		alarm[0] = 2
	}
	
	if (mouse_check_button_pressed(mb_left) && playAllowed && questionMenuActive = false)
	{
		scr_UltManDoActionType(selectedAction, targetX, targetY, goalAttempt)
	}
}