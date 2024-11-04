/// @description Insert description here
// You can write your code in this editor

draw_self()

var part = instance_create_depth(x,y,0,obj_FtDParticleFire)

part.direction = 90 + random_range(-20,20)
part.speed = 3
part.depth = -10000

// Draw light
draw_set_alpha(0.01)
draw_set_color(c_white)
draw_circle(x,y - 40,100 + sin(current_time/80)*20,false)
draw_circle(x,y - 40,100 + cos(current_time/80)*20,false)
draw_set_color(c_white)
draw_set_alpha(1)