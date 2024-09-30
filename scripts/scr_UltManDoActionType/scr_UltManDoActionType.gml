// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_UltManDoActionType(selectedAction, targetX, targetY, goalAttempt){

		// Increase timer
		obj_UltManGameController.timer += 0.66
	
		// Player Performs their move
		switch(selectedAction)
		{
			case ActionType.Run:
				controlledPlayer.MoveToPos(targetX, targetY)
			break;
			case ActionType.Shoot:
				if (goalAttempt = true)
					controlledPlayer.ShootToPos(targetX, targetY)
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
		
		with(obj_UltManOpponent)
		{
			PerformBallcarrierAction(targetX,targetY)
		}
}