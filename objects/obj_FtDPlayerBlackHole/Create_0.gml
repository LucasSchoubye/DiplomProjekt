/// @description Insert description here
// You can write your code in this editor
event_inherited()
destroy = false
dir = 0
spd = 45
xspd = 0
yspd = 0
face = 1
dmg = obj_FtDQuestionPause.correctAnswers*7
maxRange = 500
outOfRange = false

// state machine
attack_state = ATTACK_STATE.CHARGING