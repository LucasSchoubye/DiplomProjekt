/// @description AI setup

enum UltManNpcState {

	HoldPosition,
	PressPlayer,
	
}

// Inherit the parent event
event_inherited();

state = UltManNpcState.PressPlayer
image_blend = c_ltgray
playerTeam = false

// Functions
function PerformAction()
{
	switch(state)
	{
		case UltManNpcState.HoldPosition:
		break
		
		case UltManNpcState.PressPlayer:
			var player = obj_UltManGameController.controlledPlayer
			var PosX = x + lengthdir_x(topSpd,point_direction(x,y,player.x,player.y))
			var PosY = y + lengthdir_y(topSpd,point_direction(x,y,player.x,player.y))
			MoveToPos(PosX,PosY)
			
			if (point_distance(x,y,obj_UltManBall.x, obj_UltManBall.y) < 300)
			{
				obj_UltManBall.owner = id
				state = UltManNpcState.HoldPosition
				obj_UltManBall.readyForPickup = false
				obj_UltManBall.alarm[0] = 30
			}
		break
	}
}