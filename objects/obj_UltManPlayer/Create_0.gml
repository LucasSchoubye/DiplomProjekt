
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