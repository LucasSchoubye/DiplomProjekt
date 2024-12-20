// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_UltManPassing(){
			
	// Check if play is legal
	if (instance_exists(ballcarrier))
	{
		if (ballcarrier.id != controlledPlayer.id or 
			collision_line(controlledPlayer.x, controlledPlayer.y, targetX, targetY, obj_UltManOpponent, true, true) or
			targetX > obj_UltManGameController.goals[1].x)
			{
				playAllowed = false
				for (var i = 0; i < 10; ++i) {
	    
					var dist = point_distance(obj_UltManBall.x,obj_UltManBall.y,targetX, targetY)
					var dir = point_direction(obj_UltManBall.x,obj_UltManBall.y,targetX, targetY)	
					var alphaDist = point_distance(obj_UltManBall.x,obj_UltManBall.y,targetX, targetY)
			
					draw_sprite_ext(spr_FtDParticleBasic, 0 , obj_UltManBall.x + lengthdir_x((dist/10)*(i+1), dir), obj_UltManBall.y + lengthdir_y((dist/10)*(i+1), dir), 1+i*0.3, 1+i*0.3, dir, c_red, 1-i*0.1)

				}
			}
	}
	else
	{
		playAllowed = false
	}
		
	// If allowed
	if (playAllowed = true)	
	{
		for (var i = 0; i < 10; ++i) {
	    
			var dist = point_distance(obj_UltManBall.x,obj_UltManBall.y,targetX, targetY)
			var dir = point_direction(obj_UltManBall.x,obj_UltManBall.y,targetX, targetY)	
			var alphaDist = point_distance(obj_UltManBall.x,obj_UltManBall.y,targetX, targetY)
			
			draw_sprite_ext(spr_FtDParticleBasic, 0 , obj_UltManBall.x + lengthdir_x((dist/10)*(i+1), dir), obj_UltManBall.y + lengthdir_y((dist/10)*(i+1), dir), 1+i*0.3, 1+i*0.3, dir, c_white, 1-i*0.1)
		}
	}
}