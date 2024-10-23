/// @description Car animation
// You can write your code in this editor

draw_self()
image_xscale = 0.05
image_yscale = 0.05

animTarget = targetStartPos + (pos/endPos)*(targetEndPos-targetStartPos)
animPos -= (animPos - animTarget)/20

x = animPos

animCycle += 0.1
image_angle = sin(animCycle)*4 

if (pos = endPos)
{
	win()
}

if (keyboard_check_pressed(vk_space))
{
	AnsweredCorrect()
}
if (keyboard_check_pressed(vk_escape))
{
	AnsweredIncorrect()
}