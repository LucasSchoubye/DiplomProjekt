/// Logic

// animation
draw_set_color(c_black)
draw_set_alpha(0.4)
draw_ellipse(x-25,y+10,x+25,y+30,false)
draw_set_color(c_white)
draw_set_alpha(1)
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

x -= clamp((x - targetX)/10, -100, 100)
y -= clamp((y - targetY)/9, -100, 100)

// ball carrier history
if(instance_exists(owner)){
	if(owner.playerStruct != obj_UltManGameController.playerControllerHistory[0] && owner.playerTeam){
		obj_UltManGameController.playerControllerHistory[1] = obj_UltManGameController.playerControllerHistory[0]
		obj_UltManGameController.playerControllerHistory[0] = owner.playerStruct
		global.celebratingPlayer = owner
	}
	else //if (owner.playerTeam = false)
	{
		global.celebratingPlayer = owner
	}
}

// Particles
if (point_distance(x,y,targetX,targetY) > 400)
{
	var part = instance_create_depth(x,y,-100, obj_FtDParticleDust2)
}