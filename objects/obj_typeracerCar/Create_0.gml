/// Set variables

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

function AnsweredCorrect() 
{
	pos++
	with (obj_typeracerRoadLines) {
		alarm[0] = 20
		speed = 20
	}
}