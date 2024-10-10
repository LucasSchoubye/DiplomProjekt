/// @description Insert description here
// You can write your code in this editor
getDamagedCreate(5,true)

global.player_state = PLAYER_STATE.MOVING
windupTimer = 60
shootTimer = 0
bulletInst = noone
cooldown = 4*60
attackOngoing = false


bulletXoff = 160
bulletYoff = -64

// Animation
animCycle = 0
facing = 1
targetFacing = 1
lean = 0
targetLean = 1
smokeTimer = 0
weaponSprite = spr_FtDKatana
animX = x
animY = y