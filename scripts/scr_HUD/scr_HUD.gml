// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_HUD(){
	var screenMidX = view_wport[0]/2
	var healthbarStartX = view_wport[0]*0.9
	var healthbarStartY = 650
	
	
	if ( instance_exists(obj_FtDPlayer)) {
		// healthBar
		var hpbarLength = 150
		var hpbarThickness = 10
		var hpbarOffset = 30
		animTargetHp -= (animTargetHp - obj_FtDPlayer.hp)/3

		draw_rectangle(healthbarStartX - hpbarLength/2,healthbarStartY + hpbarOffset,healthbarStartX - hpbarLength/2 + animTargetHp/obj_FtDPlayer.hp_max*hpbarLength,healthbarStartY+hpbarOffset+hpbarThickness,false)
		draw_rectangle_color(healthbarStartX - hpbarLength/2,healthbarStartY + hpbarOffset,healthbarStartX - hpbarLength/2 + obj_FtDPlayer.hp/obj_FtDPlayer.hp_max*hpbarLength,healthbarStartY+hpbarOffset+hpbarThickness,c_maroon,c_maroon,c_maroon,c_maroon,false)
		draw_rectangle(healthbarStartX - hpbarLength/2,healthbarStartY + hpbarOffset,healthbarStartX + hpbarLength/2,healthbarStartY+hpbarOffset+hpbarThickness,true)
		
	}

		
}