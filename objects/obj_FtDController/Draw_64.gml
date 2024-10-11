/// @description Insert description here
// You can write your code in this editor
scr_HUD()
var timerStartx = view_wport[0]*0.95

draw_text(timerStartx,40,"Time: " + string(questionTimer))

//draw_partial_circle_outline(timerStartx,40,35,(questionTimer/obj_FtDQuestionPause.dodgeTime)*360,2)
