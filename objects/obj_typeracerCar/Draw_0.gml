/// @description Car animation
// You can write your code in this editor

draw_self()

animTarget = targetStartPos + (pos/endPos)*(targetEndPos-targetStartPos)
animPos -= (animPos - animTarget)/20

x = animPos

animCycle += 0.1
image_angle = sin(animCycle)*4 

if (pos = endPos)
{
	show_message("YOU WON")
	room_goto(rm_menu)
}

if (keyboard_check_pressed(vk_space))
{
	AnsweredCorrect()
}
if (keyboard_check_pressed(vk_escape))
{
	AnsweredIncorrect()
}