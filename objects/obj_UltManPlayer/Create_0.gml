
state = UltManNpcState.HoldPosition

switch(irandom(4))
{
	case 0:
		sprite_index = spr_UltManPlayer
	break;
	
	case 1:
		sprite_index = spr_UltManPlayer2
	break;
	
	case 2:
		sprite_index = spr_UltManPlayer3
	break;
	
	case 3:
		sprite_index = spr_UltManPlayer4
	break;
	
	case 4:
		sprite_index = spr_UltManPlayer5
	break;
}

// player struct
playerStruct = undefined

// animation
animCycle = random_range(0,360)
facing = 1
targetX = x
targetY = y
name = ["",""]

// gamestate
targetSpd = 400
targetShootSpd = 400
lastMoveDir = 0
lastMoveLen = 0
accX = lengthdir_x(lastMoveLen, lastMoveDir)*0.5
accY = lengthdir_y(lastMoveLen, lastMoveDir)*0.5
tackleCooldown = false
manMarkDist = 1400

// Team variables
position = FootballPositions.CB
playerTeam = true
formationStartY = y
formationPosX = x
formationPosY = y
kickoffPos = [x,y]

//stats
topSpd = 300
topShootSpd = 2000
topPassSpd = 2000
shooting = 200
passing = 200
strength = 300
defence = 200
dribbling = 200

// Methods
function MoveToPos(X,Y)
{
	if (X > x)
		facing = 1
	else
		facing = -1
	
	// Remember last touch
	lastMoveDir = point_direction(x, y, X, Y)
	lastMoveLen = point_distance(x, y, X, Y)
	
	// Set new target dist
	targetX = X 
	targetY = Y
	
	// Tackle
	if (instance_exists(obj_UltManBall.owner) && tackleCooldown = false)
	{
		if (obj_UltManBall.owner.playerTeam = false and playerTeam = true)
		{
			var opponent = obj_UltManBall.owner
			if (point_distance(targetX,targetY,obj_UltManBall.x,obj_UltManBall.y) < 250 or
				point_distance(x,y,obj_UltManBall.x,obj_UltManBall.y) < 100)
			{
				var dir = point_distance(opponent.x, opponent.y, obj_UltManBall.x, obj_UltManBall.y)
				obj_UltManBall.owner.targetX += lengthdir_x(strength, dir) + 180
				obj_UltManBall.owner.targetY += lengthdir_y(strength, dir) + 180
				obj_UltManBall.owner.tackleCooldown = true
				obj_UltManBall.owner.image_angle -= (strength/10)*obj_UltManBall.owner.facing
				obj_UltManBall.owner = id
				if(playerStruct != undefined){
					playerStruct.tackles++
				}
				tackleCooldown = true
				audio_play_sound(sou_UltManKickLight, 1, false, 1, 0, 0.7)
				
				repeat(5)
				{
					var part = instance_create_depth(obj_UltManBall.x,obj_UltManBall.y,-100, obj_FtDParticleDust2)
					part.speed = random_range(10,20)
					part.direction = random(360)
				}
			}
		}
		else
		{
			audio_play_sound(sou_UltManKickLight, 1, false)
			if(playerStruct != undefined){
				playerStruct.touches++
			}
			
		}
	}
	else
	{
		tackleCooldown = false
	}
	
	var nearestOpponent = instance_nearest(x,y,obj_UltManOpponent)
	if (distance_to_object(nearestOpponent) < 20 && !playerTeam)
	{
		targetX += random_range(instance_nearest(x,y,obj_UltManOpponent).strength, instance_nearest(x,y,obj_UltManOpponent).strength*-1)
		targetY += random_range(instance_nearest(x,y,obj_UltManOpponent).strength, instance_nearest(x,y,obj_UltManOpponent).strength*-1)
	}
	
	image_angle += -15*facing
	
}

function ShootToPos(X,Y)
{
	var ball = obj_UltManBall
	
	targetX = ball.x
	targetY = ball.y
	
	ball.owner = undefined
	ball.targetX = X
	ball.targetY = Y
	ball.alarm[0] = 20
	ball.readyForPickup = false
}

function MoveIntoPosition(X,Y)
{
	scr_UltManSetPositionCoordinates(position, playerTeam)	

	// Man-marking
	var nearOpp = scr_assignClosestControlledPlayer(x,y)
	if (id.object_index = obj_UltManPlayer)
		nearOpp = instance_nearest(x,y,obj_UltManOpponent)
		
	if (instance_exists(obj_UltManBall.owner))
	{
		if (point_distance(x, y, nearOpp.x, nearOpp.y) < manMarkDist and 
			obj_UltManBall.owner.playerTeam != playerTeam and
			instance_nearest(nearOpp.x, nearOpp.y,obj_UltManOpponent) = id and
			position != FootballPositions.GK)
		{
			state = UltManNpcState.MarkMan
			PerformAction(X,Y)
		}
		else
		{
			// Move towards position
			if (point_distance(x,y,formationPosX,formationPosY) > topSpd)
			{
				var dir = point_direction(x,y,formationPosX,formationPosY)
				targetX = x + lengthdir_x(topSpd, dir)
				targetY = y + lengthdir_y(topSpd, dir)
			}
			else
			{
				targetX = formationPosX
				targetY = formationPosY
			}
		}
	}
	else
	{
		// Move towards position
		if (point_distance(x,y,formationPosX,formationPosY) > topSpd)
		{
			var dir = point_direction(x,y,formationPosX,formationPosY)
			targetX = x + lengthdir_x(topSpd, dir)
			targetY = y + lengthdir_y(topSpd, dir)
		}
		else
		{
			targetX = formationPosX
			targetY = formationPosY
		}
	}
}

function PerformAction(X,Y)
{
	if (obj_UltManBall.owner != undefined)
	{
		// Team has the ball
		if (obj_UltManBall.owner.playerTeam = playerTeam)
		{
			MoveIntoPosition()
		}
		else
		// Team does NOT have the ball
		{
			MoveIntoPosition()
		}
	}
}