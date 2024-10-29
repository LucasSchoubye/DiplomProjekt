/// @description Insert description here
// You can write your code in this editor
event_inherited()
destroy = false
dir = 0
spd = 15
xspd = 0
yspd = 0
face = 1
if (obj_FtDPlayer) { dir = point_direction(x,y, obj_FtDPlayer.x, obj_FtDPlayer.y)}
else { dir = point_direction(x,y, random(1).x,random(1).y)}

image_xscale = 0.5
image_yscale = 0.5

// state machine
attack_state = ATTACK_STATE.SHOOT

