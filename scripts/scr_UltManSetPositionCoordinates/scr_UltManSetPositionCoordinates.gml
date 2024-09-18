// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_UltManSetPositionCoordinates(position, playerTeam){

var upfieldRatio = obj_UltManBall.x/room_width
var widthRatio = obj_UltManBall.y/room_height

var posMaxX = 0
var posMinX = 0
var posMaxY = 0
var posMinY = 0

var rightTeamPosMod1 = 0
var rightTeamPosMod2 = -1

if (playerTeam = false)
{
	rightTeamPosMod1 = room_width
	rightTeamPosMod2 = 1
}

var teamSideShifting = 0.2

	switch(position)
	{
		case FootballPositions.GK:
			posMaxX = rightTeamPosMod1 - room_width*rightTeamPosMod2*0.2
			posMinX = rightTeamPosMod1 - room_width*rightTeamPosMod2*0.05
			posMaxY = formationStartY + room_height*teamSideShifting
			posMinY = formationStartY - room_height*teamSideShifting
		break;
		
		case FootballPositions.LB:
		case FootballPositions.RB:
			posMaxX = rightTeamPosMod1 - room_width*rightTeamPosMod2*0.6
			posMinX = rightTeamPosMod1 - room_width*rightTeamPosMod2*0.01
			posMaxY = formationStartY + room_height*teamSideShifting
			posMinY = formationStartY - room_height*teamSideShifting
		break;
		case FootballPositions.CB:
			posMaxX = rightTeamPosMod1 - room_width*rightTeamPosMod2*0.5
			posMinX = rightTeamPosMod1 - room_width*rightTeamPosMod2*0.05
			posMaxY = formationStartY + room_height*teamSideShifting
			posMinY = formationStartY - room_height*teamSideShifting
		break;
		
		case FootballPositions.CM:
			posMaxX = rightTeamPosMod1 - room_width*rightTeamPosMod2*0.8
			posMinX = rightTeamPosMod1 - room_width*rightTeamPosMod2*0.3
			posMaxY = formationStartY + room_height*teamSideShifting
			posMinY = formationStartY - room_height*teamSideShifting
		break;
		
		case FootballPositions.LM:
		case FootballPositions.RM:
			posMaxX = rightTeamPosMod1 - room_width*rightTeamPosMod2*0.95
			posMinX = rightTeamPosMod1 - room_width*rightTeamPosMod2*0.35
			posMaxY = formationStartY + room_height*teamSideShifting
			posMinY = formationStartY - room_height*teamSideShifting
		break;

		case FootballPositions.ST:
			posMaxX = rightTeamPosMod1 - room_width*rightTeamPosMod2*0.96
			posMinX = rightTeamPosMod1 - room_width*rightTeamPosMod2*0.45
			posMaxY = formationStartY + room_height*teamSideShifting
			posMinY = formationStartY - room_height*teamSideShifting
		break;
	}

// Set position

if (playerTeam = false)
{
	var temp = posMaxX
	posMaxX = posMinX
	posMinX = temp
}

var posDiff = (posMaxX-posMinX)
var widthDiff = (posMaxY-posMinY)
formationPosX = posMinX + posDiff*upfieldRatio
formationPosY = posMinY + widthDiff*widthRatio

}