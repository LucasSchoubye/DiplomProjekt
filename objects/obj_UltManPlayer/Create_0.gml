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

//stats
topSpd = 400
topShootSpd = 2000


// Methods
function MoveToPos(X,Y)
{
	if (mouse_x > x)
		facing = 1
	else
		facing = -1
	
	// Remember last touch
	lastMoveDir = point_direction(x, y, X, Y)
	lastMoveLen = point_distance(x, y, X, Y)
	
	// Set new target dist
	targetX = X
	targetY = Y
}

function ShootToPos(X,Y)
{
	
	var ball = obj_UltManBall
	
	targetX = ball.x
	targetY = ball.y
	
	ball.owner = undefined
	ball.targetX = X
	ball.targetY = Y
	
}