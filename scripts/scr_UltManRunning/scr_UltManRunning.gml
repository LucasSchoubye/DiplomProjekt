// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_UltManRunning(){
			// is line blocked
			if (collision_line(controlledPlayer.x, controlledPlayer.y, targetX, targetY, obj_UltManCone, true, true))
			{
				draw_set_color(c_maroon)
				playAllowed = false
			}	
			draw_set_color(c_white)
			
			var dist = point_distance(controlledPlayer.x,controlledPlayer.y,targetX, targetY)

	for (var i = 0; i < 4; ++i) {
	    
		var dist = point_distance(controlledPlayer.x,controlledPlayer.y,targetX, targetY)
		var dir = point_direction(controlledPlayer.x,controlledPlayer.y,targetX, targetY)	
		var alphaDist = point_distance(controlledPlayer.x,controlledPlayer.y,((targetX)), ((targetY)))
			
		draw_sprite_ext(spr_FtDParticleBasic, 0 , controlledPlayer.x + lengthdir_x((dist/4)*(i+1), dir), controlledPlayer.y + lengthdir_y((dist/4)*(i+1), dir), 1+i*0.5, 1+i*0.5, dir, c_white, 1-i*0.2)
	}
}