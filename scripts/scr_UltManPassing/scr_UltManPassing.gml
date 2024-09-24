// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_UltManPassing(){
			
			if (instance_exists(ballcarrier))
			{
				if (ballcarrier.id != controlledPlayer.id or 
					collision_line(controlledPlayer.x, controlledPlayer.y, targetX, targetY, obj_UltManOpponent, true, true))
					{
						playAllowed = false
						draw_line_color(obj_UltManBall.x, obj_UltManBall.y, targetX, targetY, c_maroon, c_maroon)
					}
			}
			else
			{
				playAllowed = false
			}
		
			if (playAllowed = true)	
				draw_line(obj_UltManBall.x, obj_UltManBall.y, targetX, targetY)
}