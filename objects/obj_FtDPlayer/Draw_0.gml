/// @description Insert description here
// You can write your code in this editor
//draw_self()

// Draw shadow
shadowOffset = 25
draw_set_color(c_dkgray)
draw_set_alpha(0.2)
draw_ellipse(animX-sprite_width/2, animY + 10 + shadowOffset, animX+sprite_width/2, animY - 10 + shadowOffset, false)
draw_set_alpha(1)
draw_set_color(c_white)

// Draw Player
draw_sprite_ext(sprite_index, 0, animX, animY + sin(animCycle)*6, targetFacing, 1, -lean*targetFacing + sin(animCycle), c_white, image_alpha)

// Draw Weapon
draw_sprite_ext(weaponSprite, 0, animX, animY - 20 + sin(animCycle)*8 + sin(current_time/400)*6, targetFacing, 1, lean*targetFacing*3.8 + sin(animCycle)*5, c_white, image_alpha)

// Dust
if (smokeTimer < 0)
{
	smokeTimer = 10
	instance_create_depth(animX,animY+shadowOffset,depth + 10,obj_FtDParticleDust)
	
	// Play sound
	audio_play_sound(sou_FtDFootstep,1,false,0.2,0,random_range(0.9,1.1))
	
	if (keyboard_check(vk_shift))
	{
		var afterImage = instance_create_depth(animX,animY,depth + 10,obj_FtDParticleDust)
		afterImage.sprite_index = sprite_index
		afterImage.image_index = image_index
		afterImage.image_blend = c_ltgray
		afterImage.image_angle = -lean*targetFacing + sin(animCycle)
		afterImage.shrink = 0.001
		afterImage.fade = 0.03
	}
}

// Charge Up animation
if (global.game_state == GAME_STATE.PAUSED)
{
	//animCycle += 0.4
	repeat(obj_FtDQuestionPause.correctAnswers + 1)
	{
		targetLean = 0
		var part = instance_create_depth(animX + random_range(-50,50), animY + 30, -10, obj_FtDParticleDust)
		part.speed = 2 + obj_FtDQuestionPause.correctAnswers*2
		part.direction = 90 + random_range(-5,5)
		part.image_xscale = obj_FtDQuestionPause.correctAnswers*0.5 + 1
		part.image_yscale = obj_FtDQuestionPause.correctAnswers*0.5 + 1
		part.fade = part.fade*2
	}
}

// Animation
facing -= (facing - targetFacing)/3
lean -= (lean - targetLean)/30
animX -= (animX - x)/4
animY -= (animY - y)/4