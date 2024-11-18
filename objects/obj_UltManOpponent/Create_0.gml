/// @description AI setup

enum UltManNpcState {

	HoldPosition,
	PressPlayer,
	MarkMan,
	
}

// Inherit the parent event
event_inherited();

switch(irandom(4))
{
	case 0:
		sprite_index = spr_UltManPlayer6
	break;
	
	case 1:
		sprite_index = spr_UltManPlayer7
	break;
	
	case 2:
		sprite_index = spr_UltManPlayer8
	break;
	
	case 3:
		sprite_index = spr_UltManPlayer9
	break;
	
	case 4:
		sprite_index = spr_UltManPlayer10
	break;
}

state = UltManNpcState.HoldPosition
//image_blend = c_ltgray
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