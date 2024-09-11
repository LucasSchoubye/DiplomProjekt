// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_UltManDrawLine(){

var ellipseWidth = 40
var ellipseHeight = 30
if (instance_exists(ballcarrier))
{
	draw_ellipse(ballcarrier.x - ellipseWidth, ballcarrier.y - ellipseHeight, ballcarrier.x + ellipseWidth, ballcarrier.y + ellipseHeight, true)
}

}