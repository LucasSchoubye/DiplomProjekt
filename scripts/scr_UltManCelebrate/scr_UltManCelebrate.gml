// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_UltManCelebrate(){
	
	var player = global.celebratingPlayer
	
	// If the player has scored a goal
	if (instance_exists(player) and player.playerTeam)
	{
		if (sin(current_time/5) > 0)
		{
			var afterImage = instance_create_depth(player.x, player.y, -y, obj_FtDParticleDust)
			afterImage.sprite_index = player.sprite_index
			afterImage.image_index = 0
			afterImage.image_blend = #FFFFF0
			afterImage.shrink = 0.06
			afterImage.fade = 0.03			
		}
		
		player.targetX += lengthdir_x(28, point_direction(player.x,player.y,mouse_x,mouse_y))
		player.targetY += lengthdir_y(28, point_direction(player.x,player.y,mouse_x,mouse_y))
		
		
		if (mouse_x > player.x)
			player.facing = 1
		else
			player.facing = -1
			
		draw_set_alpha(sin(current_time/50)*0.25 + 0.8)
		draw_text_ext_transformed(
		camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0])*0.5 + sin(current_time/200)*60,
		camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0])*0.18 + sin(current_time/100)*50,
		player.playerStruct.name[0] + " " + player.playerStruct.name[1] ,0,1000,1,1,sin(current_time/150)*10)
		draw_set_alpha(1)
	
		repeat(3)
		{
			var randDir =  random(360)
			var randDist = 300 + random(30)
			var part = instance_create_depth(player.x + lengthdir_x(randDist,randDir), player.y + lengthdir_y(randDist,randDir), -10, obj_FtDParticleDust)
			part.speed = 20
			part.direction = randDir
			part.fade = 0.005
			part.shrink = 0.005
			part.image_angle = part.direction
			part.image_xscale = 4
			part.image_yscale = 0.25
			part.friction = 0.15
		}
	
		draw_set_font(fn_ArialBlack160)
		draw_set_alpha(sin(current_time/50)*0.25 + 0.8)
		draw_text_ext_transformed(
			camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0])*0.5 + sin(current_time/200)*50,
			camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0])*0.1 + sin(current_time/100)*50,
			"GOAL",0,1000,1,1,sin(current_time/150)*10)
		draw_set_alpha(1)
				
		var rumble = 40
		obj_UltManCamera.x += random_range(-rumble,rumble)
		obj_UltManCamera.y += random_range(-rumble,rumble)
	}
	else
	{
		// If the AI has scored
		draw_set_font(fn_ArialBlack160)
		draw_text_ext_transformed(
			camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0])*0.5 + sin(current_time/500)*10,
			camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0])*0.1 + sin(current_time/500)*5,
			"Goal Conceded",0,10000,1,1,sin(current_time/150))
			
		var rumble = 20
		obj_UltManCamera.x += random_range(-rumble,rumble)
		obj_UltManCamera.y += random_range(-rumble,rumble)
		
		with(obj_UltManOpponent)
		{
			var nearPlayer = instance_furthest(x,y,obj_UltManOpponent)
			targetX += lengthdir_x( clamp( point_distance(x,y,nearPlayer.x,nearPlayer.y)/10, 2, 20), point_direction(x,y,nearPlayer.x,nearPlayer.y))
			targetY += lengthdir_y( clamp( point_distance(x,y,nearPlayer.x,nearPlayer.y)/10, 2, 20), point_direction(x,y,nearPlayer.x,nearPlayer.y))
			y += random(60)
			image_angle += random_range(-2,2)
		}
	}
	
	
	// Fade to black
	if (alarm[1] < 60)
	{
		draw_set_color(c_black)
		draw_set_alpha(1.5 - alarm[1]/60 + 0.2)
		draw_rectangle(0,0,room_width,room_height,false)
		draw_set_color(c_white)
	}
}