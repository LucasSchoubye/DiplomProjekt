/// @description 

goalHeight = room_height*0.15
goalDepth = 300
facing = 1

function CheckBallHasScored() 
{
	if (facing = 1) // Left
	{
		if (obj_UltManBall.x < 0 && obj_UltManBall.x > x &&
			obj_UltManBall.y > y - goalHeight/2 && obj_UltManBall.y < y + goalHeight/2)
		{
			return true
		}
	}
	else // right
	{
		if (obj_UltManBall.x > x && obj_UltManBall.x < room_width &&
			obj_UltManBall.y > y - goalHeight/2 && obj_UltManBall.y < y + goalHeight/2)
		{
			return true
		}
	}
	
	// No goal
	return false
}

function CheckMouseCollision() 
{
	if (facing = 1) // Left
	{
		if (mouse_x < x && mouse_x > 0 &&
			mouse_y > y - goalHeight/2 && mouse_y < y + goalHeight/2)
		{
			if (!scr_doLinesCross(mouse_x, mouse_y, obj_UltManBall.x, obj_UltManBall.y, x, y - goalHeight/2, 0, y - goalHeight/2) &&
			!scr_doLinesCross(mouse_x, mouse_y, obj_UltManBall.x, obj_UltManBall.y, x, y + goalHeight/2, 0, y + goalHeight/2))
			return true
		}
	}
	else // right
	{
		if (mouse_x > x && mouse_x < room_width &&
			mouse_y > y - goalHeight/2 && mouse_y < y + goalHeight/2)
		{
			if (!scr_doLinesCross(mouse_x, mouse_y, obj_UltManBall.x, obj_UltManBall.y, x, y - goalHeight/2, room_width, y - goalHeight/2) &&
			!scr_doLinesCross(mouse_x, mouse_y, obj_UltManBall.x, obj_UltManBall.y, x, y + goalHeight/2, room_width, y + goalHeight/2))
			return true
		}
	}
	
	// No goal
	return false
}