// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_HUD(){
	var screenMidX = view_wport[0]/2
	var timerStartx = view_wport[0]*0.95
	var currentHealthSprite = spr_healthFull
	var healthbarStartX = view_wport[0]*0.9
	var healthbarStartY = 700
	
	
	if (instance_exists(obj_FtDPlayer)){
		switch(obj_FtDPlayer.hp) {
			case 5:
				currentHealthSprite = spr_healthFull
			break
			case 4:
				currentHealthSprite = spr_healthAlmostFull
			break
			case 3:
				currentHealthSprite = spr_healthMid
			break
			case 2:
				currentHealthSprite = spr_healthAlmostDead
			break
			case 1:
				currentHealthSprite = spr_healthLastLife
			break
		}
	
	draw_sprite(currentHealthSprite,0,healthbarStartX,healthbarStartY)
	}

		
}