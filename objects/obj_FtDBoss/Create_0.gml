/// @description Insert description here
// You can write your code in this editor
event_inherited()
getDamagedCreate(3)

spd = 0
chaseSpd = 2
xspd = 0
yspd = 0
dir = 0
face = 1

// state machine 
enemy_state = ENEMY_STATE.CHASING

cooldown = 4*60
shootTimer = irandom(cooldown)
windupTimer = 60
recoverTimer = 30
bulletInst = noone

bulletXoff = 160
bulletYoff = -64