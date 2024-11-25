/// Set variablesbalance = obj_storeController.inventoryElements

prize = 400 - global.typeracerPlacement*75

// Logical pos
pos = 0
endPos = 15

// target pos
targetStartPos = room_width*0.1
targetEndPos = room_width

animCycle = random_range(0,40)
animTarget = targetStartPos
animPos = targetStartPos
alarm[0] = 1

function win()
{
	obj_storeController.balance = real(obj_storeController.balance)+prize
	obj_firestore_controller.UpdateBalance()
	global.typeracerPlacement = 1
	with(obj_typeracerCarNpc)
	{
		if (x > obj_typeracerCar.x)
			global.typeracerPlacement++
	}
	audio_stop_sound(sou_TyperacerBgMusic)
	audio_play_sound(sou_TyperacerFinish,1,false)
	audio_play_sound(sou_FtDApplause,1,false)
	room_goto(rm_typeracerWin)
}

function AnsweredCorrect() 
{
	audio_play_sound(sou_fastCar,1,false, 1, 0.3, random_range(1.25,0.75))
	pos++
	with (obj_typeracerRoadLines) {
		alarm[0] = 20
		speed = 20
	}
}

function AnsweredIncorrect() 
{
	audio_play_sound(sou_breakCar,1,false, 0.3, 0.4, 0.9)
	pos--
	if (pos < 0)
	{
		pos = 0
	}
	with (obj_typeracerRoadLines) {
		alarm[0] = 20
		speed = 8
	}
}