// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_UltManRunToBall(){

	var PosX = x + lengthdir_x(topSpd,point_direction(x,y,obj_UltManBall.x,obj_UltManBall.y))
	var PosY = y + lengthdir_y(topSpd,point_direction(x,y,obj_UltManBall.x,obj_UltManBall.y))	
			
	MoveToPos(PosX,PosY)
}