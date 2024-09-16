
state = UltManNpcState.PressPlayer

// animation
animCycle = 0
facing = 1
targetX = x
targetY = y

// gamestate
targetSpd = 400
targetShootSpd = 400
lastMoveDir = 0
lastMoveLen = 0

// Team variables
playerTeam = true
formationPosX = x
formationPosY = y

//stats
topSpd = 400
topShootSpd = 2000

// Game stats
strength = 200
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
	if (instance_exists(obj_UltManBall.owner))
	{
		if (obj_UltManBall.owner.playerTeam = false)
		{
			var opponent = obj_UltManBall.owner
			if (point_distance(x,y,obj_UltManBall.x,obj_UltManBall.y) < 250)
			{
				obj_UltManBall.owner = id
			}
		}
		else
		{
			audio_play_sound(sou_UltManKickLight, 1, false)
		}
	}
	
	if (instance_nearest(x,y,obj_UltManOpponent) < 100)
	{
		targetX += random_range(instance_nearest(x,y,obj_UltManOpponent).strength, instance_nearest(x,y,obj_UltManOpponent).strength*-1)
		targetY += random_range(instance_nearest(x,y,obj_UltManOpponent).strength, instance_nearest(x,y,obj_UltManOpponent).strength*-1)
	}
	
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

function PerformAction()
{

}