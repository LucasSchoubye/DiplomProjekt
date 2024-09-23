/// Logic

// animation
draw_self()
image_xscale = 0.5
image_yscale = 0.5
depth = -y

// Variables
var pickupDist = 100

if (instance_exists(owner))
{
	targetX = owner.x + lengthdir_x(owner.lastMoveLen, owner.lastMoveDir)*0.5
	targetY = owner.y + lengthdir_y(owner.lastMoveLen, owner.lastMoveDir)*0.5
}
else if (readyForPickup = true)
{
	var nearPlayer = instance_nearest(x,y,obj_UltManPlayer)
	if (point_distance(x,y,nearPlayer.x,nearPlayer.y) < pickupDist)
	{
		owner = nearPlayer
	}
}

x -= (x - targetX)/10
y -= (y - targetY)/9

// Score goals
