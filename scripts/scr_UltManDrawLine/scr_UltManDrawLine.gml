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
if (instance_exists(commandedPlayer))
{
	draw_set_color(c_lime)
	draw_ellipse(commandedPlayer.x - ellipseWidth, commandedPlayer.y - ellipseHeight, commandedPlayer.x + ellipseWidth, commandedPlayer.y + ellipseHeight, false)
	draw_set_color(c_white)
}

}

