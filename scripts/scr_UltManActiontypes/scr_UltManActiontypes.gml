// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_UltManActiontypes(){

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

}