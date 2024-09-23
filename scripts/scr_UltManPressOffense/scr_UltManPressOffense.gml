// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_UltManPressOffense(){

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
					point_distance(x,y,player.x, player.y) < topSpd*3)
				{
					if (spd > point_distance(x,y,player.targetX,player.targetY))
						spd = point_distance(x,y,player.targetX,player.targetY)
					
					PosX = targetX + lengthdir_x(spd,point_direction(x,y,player.targetX,player.targetY))*1.2
					PosY = targetY + lengthdir_y(spd,point_direction(x,y,player.targetX,player.targetY))*1.2
				}
			}
			
			// Tackle
			if ((point_distance(x,y,obj_UltManBall.x, obj_UltManBall.y) < tackleDist or 
				point_distance(x,y,player.x, player.y) < tackleDist/3) && tackleCooldown = false)
			{
				var angle = random_range(0,360)
				player.targetX += lengthdir_x(-strength,angle)
				player.targetY += lengthdir_y(-strength,angle)
				player.image_angle -= (strength/10)*player.facing
				player.tackleCooldown = true
				obj_UltManBall.owner = id
				state = UltManNpcState.HoldPosition
				obj_UltManBall.readyForPickup = false
				obj_UltManBall.alarm[0] = 30
				tackleCooldown = true
			}
			
			MoveToPos(PosX,PosY)
			
			var near = instance_nearest(obj_UltManBall.x, obj_UltManBall.y, obj_UltManOpponent)
			
			if (point_distance(near.x, near.y, x, y) < 50)
			{
				var push = 200
				var dir = random_range(0,360)
				targetX += lengthdir_x(push,dir)
				targetY += lengthdir_y(push,dir)
			}
			
			if (near != id &&
				point_distance(near.x, near.y, obj_UltManBall.x, obj_UltManBall.y) < point_distance(x, y, obj_UltManBall.x, obj_UltManBall.y) - topSpd*2)
			{
				state = UltManNpcState.HoldPosition
			}

}