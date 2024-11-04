/// @description AI setup

enum UltManNpcState {

	HoldPosition,
	PressPlayer,
	MarkMan,
	
}

// Inherit the parent event
event_inherited();

state = UltManNpcState.HoldPosition
image_blend = c_ltgray
playerTeam = false
pressingDistance = 900

// Functions
function PerformAction(X,Y)
{
	if (instance_exists(obj_UltManBall.owner))
	{
		if (obj_UltManBall.owner.playerTeam = playerTeam)
		{
			if (obj_UltManBall.owner != id)
			{
				scr_UltManOffensiveStateControl(X,Y)
			}
		}
		else
		{
			scr_UltManDefensiveStateControl(X,Y)
		}
	}
	else
	{
		scr_UltManDefensiveStateControl(X,Y)
	}
	
}

function PerformBallcarrierAction(X,Y)
{
	if (instance_exists(obj_UltManBall.owner))
	{
		if (obj_UltManBall.owner.playerTeam = playerTeam)
		{
			if (obj_UltManBall.owner = id and obj_UltManBall.readyForPickup = true)
			{
				scr_UltManOffensiveStateControl(X,Y)
			}
		}
	}
}