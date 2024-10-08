// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function MenuGridElement() constructor {
	itemName = ""
	price = 0
	itemSprite = ""
	itemWidth = room_width*0.15
	itemHeight = room_height*0.3
	itemCenterX = itemWidth/2
	itemCenterY = itemHeight/2
	itemPriceY = itemHeight-20
	itemTitleY = itemHeight-40
	itemImgStartY = itemCenterY-10
	textHeight = 10
	itemStartX = room_height*0.125
	categorySprite = spr_theOneAndOnlySmall
	categoryWidth = room_width*0.2
	categoryHeight = room_height*0.07
	categoryTextStartX =  room_width*0.01
	categoryCenterY = categoryHeight/2
	categoryImgStartX = categoryWidth-30

	
	function DrawItem(xValue,yValue) {

			draw_set_alpha(0.1)
			draw_set_color(c_white)
			draw_roundrect_color(xValue,yValue,xValue+itemWidth,yValue+itemHeight,c_black,c_white,false)
			draw_set_alpha(0.3 + sin(current_time/500)*0.1)
			
			draw_roundrect(xValue,yValue,xValue+itemWidth,yValue+itemHeight,true)
			draw_set_alpha(1)
			
			switch(itemName){
				case "Typeracer":
					draw_sprite(spr_typeracerIcon,0,xValue+itemCenterX,yValue+itemImgStartY)
				break
				case "Ultimate Manager":
					draw_sprite(spr_managerIcon,0,xValue+itemCenterX,yValue+itemImgStartY)
				break
				case "Fight The Dungeon":
					draw_sprite(spr_FtDIcon,0,xValue+itemCenterX,yValue+itemImgStartY)
				break
			}
			draw_text(xValue+itemCenterX,yValue+itemPriceY,itemName)

		/*
		else if(yValue+itemHeight >= itemStartX) {
			draw_set_alpha(0.5)
			draw_roundrect(xValue,itemStartX,xValue+itemWidth,yValue+itemHeight,true)
		}
		if(yValue+itemPriceY-textHeight >= itemStartX) {
			draw_set_alpha(0.5)
			draw_text(xValue+itemCenterX,yValue+itemPriceY,itemName)
		}*/
		
		
		if(mouse_x > xValue && mouse_x < xValue+itemWidth) {
			if(mouse_y > yValue && mouse_y < yValue+itemHeight) {
				draw_set_alpha(0.15)
				if(yValue >= itemStartX) {
					draw_rectangle(xValue,yValue,xValue+itemWidth,yValue+itemHeight,false)
				}
				else if(yValue+itemHeight >= itemStartX) {
					draw_rectangle(xValue,itemStartX,xValue+itemWidth,yValue+itemHeight,false)
				}
				draw_set_alpha(1)
			}
		}
		if (mouse_check_button_pressed(mb_left) and mouse_x > xValue && mouse_x < xValue+itemWidth){
			if(mouse_y > yValue && mouse_y < yValue+itemHeight) {
			switch(itemName){
				case "Typeracer":
					obj_firestore_controller.StartSession("/games/typeracer")
					room_goto(rm_typeracer)
				break
				case "Ultimate Manager":
					room_goto(rm_UltManOverview)
				break
				case "Fight The Dungeon":
					room_goto(rm_FtD)
			}
			}
		}
	
	}
	
	function DrawCategory(xValue,yValue) {
		
		draw_set_alpha(0.1)
		draw_set_color(c_white)
		draw_roundrect(xValue,yValue,xValue+categoryWidth,yValue+categoryHeight,false)
		draw_set_alpha(0.4 + sin(current_time/500)*0.1)
		draw_roundrect(xValue,yValue,xValue+categoryWidth,yValue+categoryHeight,true)
		draw_set_alpha(1)
		
		//draw_rectangle(xValue,yValue,xValue+categoryWidth,yValue+categoryHeight,true)
		//draw_sprite(spr_theOneAndOnlySmall,0,xValue+categoryImgStartX,yValue+categoryCenterY)
		draw_set_halign(fa_center)
		draw_text(xValue+categoryWidth/2,yValue+categoryCenterY,itemName)
		draw_set_halign(fa_center)
		if(mouse_x > xValue && mouse_x < xValue+categoryWidth) {
			if(mouse_y > yValue && mouse_y < yValue+categoryHeight) {
				draw_set_alpha(0.3)
				draw_rectangle(xValue,yValue,xValue+categoryWidth,yValue+categoryHeight,false)
				draw_set_alpha(1)
			}
		}
	}
}
