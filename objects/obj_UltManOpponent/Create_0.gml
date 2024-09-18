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
defence = 1000

// Functions
function PerformAction(X,Y)
{
	switch(state)
	{
		case UltManNpcState.HoldPosition:
			if (instance_exists(obj_UltManBall.owner))
			{
				if (obj_UltManBall.owner.playerTeam)
				{
					state = UltManNpcState.PressPlayer
				}
			}
		break
		
		case UltManNpcState.PressPlayer:
			var strength = 200
			var tackleDist = 300
			var player = obj_UltManGameController.controlledPlayer
			var spd = topSpd
			if (point_distance(x,y,player.x,player.y) < topSpd)
			{
				spd = topSpd/2
			}
			var PosX = x + lengthdir_x(spd,point_direction(x,y,player.x,player.y))
			var PosY = y + lengthdir_y(spd,point_direction(x,y,player.x,player.y))
			
			// Superior tackle tracking
			if (instance_exists(obj_UltManBall.owner))
			{
				if (defence > obj_UltManBall.owner.dribbling &&
					point_distance(x,y,player.x, player.y) < topSpd*1.2)
				{
					if (spd > point_distance(x,y,player.targetX,player.targetY))
						spd = point_distance(x,y,player.targetX,player.targetY)
					
					PosX = x + lengthdir_x(spd,point_direction(x,y,player.targetX,player.targetY))*1.2
					PosY = y + lengthdir_y(spd,point_direction(x,y,player.targetX,player.targetY))*1.2
				}
			}
			
			// Tackle
			if ((point_distance(x,y,obj_UltManBall.x, obj_UltManBall.y) < tackleDist or 
				point_distance(x,y,player.x, player.y) < tackleDist/3) && tackleCooldown = false)
			{
				var angle = random_range(0,360)
				player.targetX += lengthdir_x(-strength,angle)
				player.targetY += lengthdir_y(-strength,angle)
				player.image_angle -= 30*player.facing
				player.tackleCooldown = true
				obj_UltManBall.owner = id
				state = UltManNpcState.HoldPosition
				obj_UltManBall.readyForPickup = false
				obj_UltManBall.alarm[0] = 30
				tackleCooldown = true
			}
			
			MoveToPos(PosX,PosY)
		break
	}
}