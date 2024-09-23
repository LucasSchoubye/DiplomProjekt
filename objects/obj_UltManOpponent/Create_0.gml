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
defence = 1000
pressingDistance = 900
topSpd = topSpd*1.2



// Functions
function PerformAction(X,Y)
{
	switch(state)
	{
		case UltManNpcState.HoldPosition:
			if (instance_exists(obj_UltManBall.owner))
			{
				if (obj_UltManBall.owner.playerTeam != playerTeam and 
					(instance_nearest(obj_UltManBall.x, obj_UltManBall.y, obj_UltManOpponent) = id
					or point_distance(obj_UltManBall.owner.x, obj_UltManBall.owner.y, x, y) < pressingDistance))
				{
					state = UltManNpcState.PressPlayer
					PerformAction(X,Y)
				}
				else
				{
					MoveIntoPosition(X,Y)
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
					MoveIntoPosition(X,Y)
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
		
		case UltManNpcState.MarkMan:
			
			// Set nearest opponent
			var nearOpp = scr_assignClosestControlledPlayer(x,y)
			if (id.object_index = obj_UltManPlayer)
				nearOpp = instance_nearest(x,y,obj_UltManOpponent)
			
			if (instance_exists(obj_UltManBall.owner))
			{
				if (obj_UltManBall.owner.playerTeam = playerTeam)
				{
					state = UltManNpcState.HoldPosition
					PerformAction(X,Y)
					break
				}
				
				if (nearOpp = obj_UltManBall.owner or 
					instance_nearest(obj_UltManBall.owner.x, obj_UltManBall.owner.y, obj_UltManOpponent) = id)
				{
					state = UltManNpcState.PressPlayer
					scr_UltManPressOffense()
					break;
				}
			}

			// Mark if i am closest and within my zone
			if (point_distance(x, y, nearOpp.x, nearOpp.y) < manMarkDist and 
				instance_nearest(nearOpp.x, nearOpp.y,obj_UltManOpponent) = id)
			{
				var manMarkX = nearOpp.targetX + lengthdir_x(200, point_direction(x,y,obj_UltManBall.x,obj_UltManBall.y))
				var manMarkY = nearOpp.targetY + lengthdir_y(200, point_direction(x,y,obj_UltManBall.x,obj_UltManBall.y))
				var dir = point_direction(x,y,manMarkX,manMarkY)
		
				// Move towards Man Marking position
				if (point_distance(x,y,manMarkX,manMarkY) > topSpd)
				{
					var dir = point_direction(x,y,manMarkX,manMarkY)
					targetX = x + lengthdir_x(topSpd, dir)
					targetY = y + lengthdir_y(topSpd, dir)
				}
				else
				{
					targetX = manMarkX
					targetY = manMarkY
				}
			}
			else
			{
				state = UltManNpcState.HoldPosition
				PerformAction(X,Y)
			}
		break;
	}
}