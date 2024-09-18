// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_UltManDrawField(){

var roomWidthBuffer = 300
var roomMidWidth = room_width/2
var roomMidHeight = room_height/2
var penaltyBoxWidth = room_width*0.17
var penaltyBoxHeightStart = room_height*0.30
var penaltyBoxHeightEnd = room_height-room_height*0.30
var yardBoxHeightStart = room_height*0.40
var yardBoxHeightEnd = room_height-room_height*0.40
var yardBoxWidth = room_width*0.06

	// Draw end of field
	draw_set_alpha(1)
	draw_rectangle_color(0,0,roomWidthBuffer,room_height,c_dkgray, c_dkgray, c_dkgray, c_dkgray, false)
	draw_rectangle_color(room_width,0,room_width-roomWidthBuffer,room_height,c_dkgray, c_dkgray, c_dkgray, c_dkgray, false)

	// Middle and circle
	draw_line(roomMidWidth, room_height, roomMidWidth, 0)	
	draw_circle(roomMidWidth, roomMidHeight, room_height/6, true)
	
	// Penalty Boxes
	draw_rectangle(roomWidthBuffer, penaltyBoxHeightStart, penaltyBoxWidth + roomWidthBuffer, penaltyBoxHeightEnd, true)
	draw_rectangle(room_width - roomWidthBuffer, penaltyBoxHeightStart, room_width - penaltyBoxWidth - roomWidthBuffer, penaltyBoxHeightEnd, true)
	
	// 6-yard box
	draw_rectangle(roomWidthBuffer, yardBoxHeightStart, yardBoxWidth + roomWidthBuffer, yardBoxHeightEnd, true)
	draw_rectangle(room_width - roomWidthBuffer, yardBoxHeightStart, room_width - yardBoxWidth - roomWidthBuffer, yardBoxHeightEnd, true)

}