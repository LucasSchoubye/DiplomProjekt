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


draw_arrow(obj_typeracerCar.x+room_width*0.1,obj_typeracerCar.y,obj_typeracerCar.x+room_width*0.05,obj_typeracerCar.y,50)
draw_set_halign(fa_left)
draw_text(obj_typeracerCar.x+room_width*0.11,obj_typeracerCar.y,obj_firestore_controller.username+"!")
draw_set_halign(fa_center)

	

if (pos = endPos)
{
	win()
}

// FOR DEV DEBUGGING
if (keyboard_check_pressed(vk_lcontrol))
{
	AnsweredCorrect()
}
if (keyboard_check_pressed(vk_escape))
{
	AnsweredIncorrect()
}