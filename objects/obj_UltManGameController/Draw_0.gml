
// 

scr_UltManDrawLine()

// Player control
controlledPlayer = instance_nearest(obj_UltManBall.x, obj_UltManBall.y, obj_UltManPlayer)
ballcarrier = obj_UltManBall.owner

var len = controlledPlayer.targetSpd
var dir = point_direction(controlledPlayer.x,controlledPlayer.y,mouse_x,mouse_y)
var lenX = lengthdir_x(len, dir)
var lenY = lengthdir_y(len, dir)
var targetX = controlledPlayer.x+lenX
var targetY = controlledPlayer.y+lenY
var playAllowed = true
	
// Action type selected
if (keyboard_check(vk_shift))
{
	selectedAction = ActionType.Shoot
}
else
{
	selectedAction = ActionType.Run
}
	
switch(selectedAction)
{
	case ActionType.Run:
		// is line blocked
		if (collision_line(controlledPlayer.x, controlledPlayer.y, targetX, targetY, obj_UltManCone, true, true))
		{
			draw_set_color(c_maroon)
			playAllowed = false
		}	
		draw_line(controlledPlayer.x, controlledPlayer.y, targetX, targetY)
		draw_set_color(c_white)
	break;
	case ActionType.Shoot:
		targetX = controlledPlayer.x + lengthdir_x(controlledPlayer.targetShootSpd, dir)
		targetY = controlledPlayer.y + lengthdir_y(controlledPlayer.targetShootSpd, dir)
		if (instance_exists(ballcarrier))
		{
			if (ballcarrier.id != controlledPlayer.id)
				playAllowed = false
		}
		else
		{
			playAllowed = false
		}
		
		if (playAllowed = true)	
			draw_line(obj_UltManBall.x, obj_UltManBall.y, targetX, targetY)
	break;
}

if (mouse_check_button(mb_left) && playAllowed)
{
	switch(selectedAction)
	{
		case ActionType.Run:
			controlledPlayer.MoveToPos(targetX, targetY)
		break;
		case ActionType.Shoot:
			controlledPlayer.ShootToPos(targetX, targetY)
		break;
	}
}

