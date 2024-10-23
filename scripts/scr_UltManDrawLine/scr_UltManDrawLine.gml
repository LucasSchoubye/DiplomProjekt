// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_UltManDrawLine(){

var ellipseWidth = 40
var ellipseHeight = 30

// Draw player with ball
if (instance_exists(ballcarrier))
{
	draw_ellipse(ballcarrier.x - ellipseWidth, ballcarrier.y - ellipseHeight, ballcarrier.x + ellipseWidth, ballcarrier.y + ellipseHeight, true)
}

// Draw commanded player
if (instance_exists(commandedPlayer) and commandTargetX != undefined and commandTargetY != undefined)
{
	for (var i = 0; i < 4; ++i) {
	    
		var dist = point_distance(commandedPlayer.x, commandedPlayer.y, commandTargetX, commandTargetY)
		var dir = point_direction(commandedPlayer.x, commandedPlayer.y, commandTargetX, commandTargetY)	
		var alphaDist = point_distance(commandedPlayer.x, commandedPlayer.y, commandTargetX, commandTargetY)
			
		draw_sprite_ext(spr_FtDParticleBasic, 0 , commandedPlayer.x + lengthdir_x((dist/4)*(i+1), dir), commandedPlayer.y + lengthdir_y((dist/4)*(i+1), dir), 1+i*0.5, 1+i*0.5, dir, c_lime, 1-i*0.2)
	}
}

}

