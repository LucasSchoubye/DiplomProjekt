/// @description AI setup

enum UltManNpcState {

	HoldPosition,
	PressPlayer,
	
}

// Inherit the parent event
event_inherited();

state = UltManNpcState.HoldPosition
image_blend = c_ltgray
playerTeam = false
defence = 1000



// Functions
function PerformAction(X,Y)
{
	switch(state)
	{
		case UltManNpcState.HoldPosition:
			if (instance_exists(obj_UltManBall.owner))
			{
				if (obj_UltManBall.owner.playerTeam and 
					instance_nearest(obj_UltManBall.x, obj_UltManBall.y, obj_UltManOpponent) = id)
				{
					state = UltManNpcState.PressPlayer
				}
				else
				{
					MoveIntoPosition()
				}
			}
		break
		
		case UltManNpcState.PressPlayer:
			switch(position)
			{
				case FootballPositions.CB:
				case FootballPositions.CDM:
				case FootballPositions.GK:
				case FootballPositions.LB:
				case FootballPositions.LWB:
				case FootballPositions.RB:
				case FootballPositions.RWB:
					scr_UltManPressDefence()
				break;
				default:
					scr_UltManPressOffense()
			}
		break
	}
}