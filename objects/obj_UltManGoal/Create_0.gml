/// @description 

goalHeight = room_height*0.15
goalDepth = 300
facing = 1

function CheckBallHasScored() 
{
	if (facing = 1) // Left
	{
		if (obj_UltManBall.x < x && obj_UltManBall.x > 0 &&
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