// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_HUD(){
	var healthbarStartX = view_wport[0]*0.9
	var healthbarStartY = 670
	var staminaBarStartX = healthbarStartX
	var staminaBarStartY = healthbarStartY+30
	
	
	if ( instance_exists(obj_FtDPlayer)) {
		// healthBar
		var hpbarLength = 150
		var hpbarThickness = 10
		var hpbarOffset = 30
		animTargetHp -= (animTargetHp - obj_FtDPlayer.hp)/3

		draw_rectangle(healthbarStartX - hpbarLength/2,healthbarStartY + hpbarOffset,healthbarStartX - hpbarLength/2 + animTargetHp/obj_FtDPlayer.hp_max*hpbarLength,healthbarStartY+hpbarOffset+hpbarThickness,false)
		draw_rectangle_color(healthbarStartX - hpbarLength/2,healthbarStartY + hpbarOffset,healthbarStartX - hpbarLength/2 + obj_FtDPlayer.hp/obj_FtDPlayer.hp_max*hpbarLength,healthbarStartY+hpbarOffset+hpbarThickness,c_maroon,c_maroon,c_maroon,c_maroon,false)
		draw_rectangle(healthbarStartX - hpbarLength/2,healthbarStartY + hpbarOffset,healthbarStartX + hpbarLength/2,healthbarStartY+hpbarOffset+hpbarThickness,true)
		
		// healthBar
		var stamBarLength = 150
		var stamBarThickness = 10
		var stamBarOffset = 30
		animTargetStamina -= (animTargetStamina - obj_FtDPlayer.stamina)/3

		draw_rectangle(staminaBarStartX - stamBarLength/2,staminaBarStartY + stamBarOffset,staminaBarStartX - stamBarLength/2 + animTargetStamina/obj_FtDPlayer.stamina_max*stamBarLength,staminaBarStartY+stamBarOffset+stamBarThickness,false)
		draw_rectangle_color(staminaBarStartX - stamBarLength/2,staminaBarStartY + stamBarOffset,staminaBarStartX - stamBarLength/2 + obj_FtDPlayer.stamina/obj_FtDPlayer.stamina_max*stamBarLength,staminaBarStartY+stamBarOffset+stamBarThickness,c_blue,c_blue,c_blue,c_blue,false)
		draw_rectangle(staminaBarStartX - stamBarLength/2,staminaBarStartY + stamBarOffset,staminaBarStartX + stamBarLength/2,staminaBarStartY+stamBarOffset+stamBarThickness,true)
		
	}

		
}