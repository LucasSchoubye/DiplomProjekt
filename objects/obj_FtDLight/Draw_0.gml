/// @description Draw Light

depth = 10

draw_set_alpha(0.02)
draw_set_color(#ffd8a0)


// Large ellipse
var ellipseWidth = room_width*0.45 + sin(current_time/500)*20
var ellipseHeight = room_height*0.45 + sin(current_time/500)*20
draw_ellipse(room_width/2 - ellipseWidth/2, room_height/2 - ellipseHeight/2, room_width/2 + ellipseWidth/2, room_height/2 + ellipseHeight/2,false)


// small ellipse
ellipseWidth = ellipseWidth*0.4 + sin(current_time/500)*20
ellipseHeight = ellipseHeight*0.4 + sin(current_time/500)*20
draw_ellipse(room_width/2 - ellipseWidth/2, room_height/2 - ellipseHeight/2, room_width/2 + ellipseWidth/2, room_height/2 + ellipseHeight/2,false)


// Reset
draw_set_alpha(1)
draw_set_color(c_white)