
var player = obj_UltManBall

if (obj_UltManGameController.selectedAction = ActionType.Run)
{
	targetX = (player.x*3 + mouse_x)/4
	targetY = (player.y*3 + mouse_y)/4
}
else if (obj_UltManGameController.selectedAction = ActionType.Shoot)
{
	if (instance_exists(obj_UltManGameController.ballcarrier))
	{
		if (obj_UltManGameController.ballcarrier.id = player.owner.id)
		{
			targetX = (player.x + mouse_x)/2
			targetY = (player.y + mouse_y)/2
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