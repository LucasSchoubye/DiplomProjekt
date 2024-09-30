// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_UltManRunning(){
			// is line blocked
			if (collision_line(controlledPlayer.x, controlledPlayer.y, targetX, targetY, obj_UltManCone, true, true))
			{
				draw_set_color(c_maroon)
				playAllowed = false
			}	
			//draw_line(controlledPlayer.x, controlledPlayer.y, targetX, targetY)
			draw_line(controlledPlayer.x, controlledPlayer.y, targetX + controlledPlayer.accX, targetY   + controlledPlayer.accY)
			draw_set_color(c_white)
}