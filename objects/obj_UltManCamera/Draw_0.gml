
var player = obj_UltManGameController.controlledPlayer

if (obj_UltManGameController.selectedAction = ActionType.Run)
{
	targetX = (player.x*3 + mouse_x)/4
	targetY = (player.y*3 + mouse_y)/4
}
else if (obj_UltManGameController.selectedAction = ActionType.Shoot)
{
	if (instance_exists(obj_UltManGameController.ballcarrier))
	{
		if (obj_UltManGameController.ballcarrier.id = player.id)
		{
			targetX = (player.x*1.5 + mouse_x)/2.5
			targetY = (player.y*1.5 + mouse_y)/2.5
		}
		else
		{
			targetX = (obj_UltManBall.x*3 + mouse_x)/4
			targetY = (obj_UltManBall.y*3 + mouse_y)/4
		}
	}
	else
	{
		targetX = (obj_UltManBall.x*3 + mouse_x)/4
		targetY = (obj_UltManBall.y*3 + mouse_y)/4
	}
}

x -= (x - targetX)/3
y -= (y - targetY)/3