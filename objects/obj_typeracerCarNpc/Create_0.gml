/// @description Insert description here
// You can write your code in this editor

difficulty = random_range(0.3,1.1)

// Inherit the parent event
event_inherited();

image_blend = c_aqua

function win()
{
	show_message("YOU SUCK LOSER!!!")
	room_goto(rm_menu)
}

function AnsweredCorrect()
{
	
}
function AnsweredIncorrect()
{
	
}

alarm[1] = random_range(60*4,60*11)