/// @description Insert description here
// You can write your code in this editor
event_inherited()

hp = 100
spd = 0
chaseSpd = 2
xspd = 0
yspd = 0
dir = 0
face = 1

// state machine 
state = 1

windupTimer = 60
shootTimer = 0
recoverTimer = 30
bulletInst = noone
cooldown = 4*60

bulletXoff = 160
bulletYoff = -64