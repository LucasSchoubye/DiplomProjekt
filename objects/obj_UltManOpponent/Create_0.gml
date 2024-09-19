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
pressingDistance = 1300



// Functions
function PerformAction(X,Y)
{
	switch(state)
	{
		case UltManNpcState.HoldPosition:
			if (instance_exists(obj_UltManBall.owner))
			{
				if (obj_UltManBall.owner.playerTeam != playerTeam and 
					(instance_nearest(obj_UltManBall.x, obj_UltManBall.y, obj_UltManOpponent = id)
					or point_distance(obj_UltManBall.owner.x, obj_UltManBall.owner.y, x, y) < pressingDistance))
				{
					state = UltManNpcState.PressPlayer
				}
				else
				{
					MoveIntoPosition()
				}
			}
			else
			{
				if (point_distance(obj_UltManBall.x, obj_UltManBall.y, x, y) < 1200 && position != FootballPositions.GK)
				{
					scr_UltManRunToBall()
				}
				else
				{
					MoveIntoPosition()
				}
			}
		break
		
		case UltManNpcState.PressPlayer:
			if (obj_UltManBall.owner = undefined)
			{
				state = UltManNpcState.HoldPosition
				PerformAction(X,Y)
				break;
			}
		
			switch(position)
			{
				case FootballPositions.GK:
					scr_UltManKeeperPosition()
				break;
				case FootballPositions.CB:
				case FootballPositions.CDM:
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