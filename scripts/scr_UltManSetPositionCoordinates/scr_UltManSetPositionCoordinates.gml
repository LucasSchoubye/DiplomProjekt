// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_UltManSetPositionCoordinates(position, playerTeam){

var upfieldRatio = obj_UltManBall.x/room_width
var widthRatio = obj_UltManBall.y/room_height

var posMaxX = 0
var posMinX = 0
var posMaxY = 0
var posMinY = 0

var teamSideShifting = 0.2

	switch(position)
	{
		case FootballPositions.GK:
			posMaxX = room_width*0.2
			posMinX = room_width*0.05
			posMaxY = formationStartY + room_height*teamSideShifting
			posMinY = formationStartY - room_height*teamSideShifting
		break;
		
		case FootballPositions.LB:
		case FootballPositions.RB:
			posMaxX = room_width*0.6
			posMinX = room_width*0.01
			posMaxY = formationStartY + room_height*teamSideShifting
			posMinY = formationStartY - room_height*teamSideShifting
		break;
		case FootballPositions.CB:
			posMaxX = room_width*0.5
			posMinX = room_width*0.05
			posMaxY = formationStartY + room_height*teamSideShifting
			posMinY = formationStartY - room_height*teamSideShifting
		break;
		
		case FootballPositions.CM:
			posMaxX = room_width*0.8
			posMinX = room_width*0.3
			posMaxY = formationStartY + room_height*teamSideShifting
			posMinY = formationStartY - room_height*teamSideShifting
		break;
		
		case FootballPositions.LM:
		case FootballPositions.RM:
			posMaxX = room_width*0.95
			posMinX = room_width*0.35
			posMaxY = formationStartY + room_height*teamSideShifting
			posMinY = formationStartY - room_height*teamSideShifting
		break;

		case FootballPositions.ST:
			posMaxX = room_width*0.96
			posMinX = room_width*0.45
			posMaxY = formationStartY + room_height*teamSideShifting
			posMinY = formationStartY - room_height*teamSideShifting
		break;
	}

// Set position
var posDiff = (posMaxX-posMinX)
var widthDiff = (posMaxY-posMinY)
formationPosX = posMinX + posDiff*upfieldRatio
formationPosY = posMinY + widthDiff*widthRatio

}