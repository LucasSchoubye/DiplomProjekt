// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function LoadoutElement() constructor {
	category = ""
	itemName = ""
	itemID = ""
	isEquipped = false
	txtEquip = ""
	itemWidth = room_width*0.075
	itemHeight = room_height*0.15
	itemCenterX = itemWidth/2
	itemCenterY = itemHeight/2
	itemEquipY = itemHeight-10
	itemTitleY = itemHeight-22
	itemImgStartY = itemCenterY-10
	textHeight = 10
	itemStartY = room_height*0.125
	defaultFont = draw_get_font()
	itemType = ""
	LC = obj_languageController
	

	function DrawFtDItem(xValue,yValue) {

			draw_set_font(fn_textLato)
			draw_set_alpha(0.1)
			draw_set_color(c_white)
			draw_roundrect_color(xValue,yValue,xValue+itemWidth,yValue+itemHeight,c_black,c_white,false)
			draw_set_alpha(0.3 + sin(current_time/500)*0.1)
			
			draw_roundrect(xValue,yValue,xValue+itemWidth,yValue+itemHeight,true)
			draw_set_alpha(1)
			draw_sprite_ext(itemNameToSprite(itemName),0,xValue+itemCenterX,yValue+itemImgStartY,(itemWidth*0.8)/sprite_get_width(itemNameToSprite(itemName)), (itemHeight*0.6)/sprite_get_height(itemNameToSprite(itemName)),0,c_white,1)
			
			if (isEquipped == true) {
				txtEquip = "EQUIPPED"
			} else {
				txtEquip = ""
			}
			draw_set_font(fn_RobotoBlack8)
			draw_text(xValue+itemCenterX,yValue+itemEquipY,LC.translate(txtEquip))
			draw_text(xValue+itemCenterX,yValue+itemTitleY,itemName)
			draw_set_font(defaultFont)
			

		
		// Logic
		if(mouse_x > xValue && mouse_x < xValue+itemWidth) {
			if(mouse_y > yValue && mouse_y < yValue+itemHeight) {
				draw_set_alpha(0.3)
				if(yValue >= itemStartY) {
					draw_rectangle(xValue,yValue,xValue+itemWidth,yValue+itemHeight,false)
				}
				else if(yValue+itemHeight >= itemStartY) {
					draw_rectangle(xValue,itemStartY,xValue+itemWidth,yValue+itemHeight,false)
				}
				draw_set_alpha(1)
			}
		}
	}
	
	function DrawFtDEquipped(xValue, yValue) {
		draw_sprite_ext(itemNameToSprite(itemName),0,xValue+itemCenterX,yValue+itemImgStartY,(itemWidth*0.8)/sprite_get_width(itemNameToSprite(itemName)), (itemHeight*0.6)/sprite_get_height(itemNameToSprite(itemName)),0,c_white,1)
		
		draw_set_font(fn_RobotoBlack8)
		draw_text(xValue+itemCenterX,yValue+itemTitleY,itemName)
		draw_set_font(defaultFont)
		
	}
	
}
