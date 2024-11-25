/// @description Set Variables

cursor_sprite = spr_UltManCursor

// End looping sound
audio_stop_sound(sou_UltManCheer)

recapList = ds_list_create()
scoreline = obj_UltManManagerController.lastScoreline
totalReward = 0

// Rewards
winReward = 20
drawReward = 10
lostReward = 5
cleanSheetReward = 10
goalReward = 5

// Result text



// Functions
function PlaySecondHalf()
{
	room_goto(rm_UltManMatch)
	obj_UltManManagerController.lastScoreline = scoreline
	obj_UltManManagerController.halftimeCompleted = true
	obj_UltManManagerController.halftimeTimerReset = false
}