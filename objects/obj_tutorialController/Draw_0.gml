/// @description Insert description here
// You can write your code in this edito

var backgroundColor = #191115
//#191115

// Draw Background
draw_set_alpha(0.3)
draw_rectangle_color(0,0,room_width,room_height*0.3, c_white, c_white, backgroundColor, backgroundColor, false)
draw_rectangle_color(0,room_height*0.7,room_width,room_height, backgroundColor, backgroundColor, c_white, c_white, false)

// Draw Picture
var pictureTop = room_height*0.15
var pictureBot = room_height*0.75
var pictureLeft = room_width*0.025
var pictureRight = room_width*0.65

draw_set_alpha(1)
draw_roundrect(pictureLeft, pictureTop, pictureRight, pictureBot, true)

// Draw control box
draw_set_alpha(0.15)
draw_rectangle(pictureRight+1,room_height*0.2,room_width,room_height*0.725,false)
draw_set_alpha(1)
draw_rectangle(pictureRight+1,room_height*0.2,room_width,room_height*0.725,true)
draw_set_color(c_white)

// Draw Title and Controls
draw_set_font(fn_titleLato)
draw_set_valign(fa_middle)
draw_set_halign(fa_left)
scr_drawOutlineText(room_width*0.015, room_height*0.075, c_black, c_white, "Game Title")
draw_set_font(fn_lato16)
//draw_text(pictureRight + 10, room_height*0.25, "Controls:")
scr_drawOutlineText(pictureRight + 10, room_height*0.25, c_black, c_white,  "Controls:")