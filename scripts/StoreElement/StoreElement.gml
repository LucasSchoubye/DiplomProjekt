// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function StoreElement() constructor {
	itemName = ""
	itemType = ""
	balance = undefined
	price = undefined
	itemID = ""
	isOwned = false
	itemSprite = spr_theOneAndOnly
	itemWidth = room_width*0.15
	itemHeight = room_height*0.3
	itemCenterX = itemWidth/2
	itemCenterY = itemHeight/2
	itemPriceY = itemHeight-20
	itemTitleY = itemHeight-40
	itemImgStartY = itemCenterY-20
	textHeight = 10
	categoryStartY = room_height*0.125
	

	function DrawItem(xValue,yValue) {
		
		var LC = obj_languageController
		
		draw_set_font(fn_textLato)
		draw_set_alpha(0.1)
		draw_set_color(c_white)
		draw_roundrect_color(xValue,yValue,xValue+itemWidth,yValue+itemHeight,c_black,c_white,false)
		draw_set_alpha(0.3 + sin(current_time/500)*0.1)
			
		draw_roundrect(xValue,yValue,xValue+itemWidth,yValue+itemHeight,true)
		draw_set_alpha(1)
		draw_sprite_ext(itemNameToSprite(itemName),0,xValue+itemCenterX,yValue+itemImgStartY,(itemWidth*0.8)/sprite_get_width(itemNameToSprite(itemName)), (itemHeight*0.6)/sprite_get_height(itemNameToSprite(itemName)),0,c_white,1)
		
		// Price/owned text & Name
		if(isOwned == true) {
			draw_text(xValue+itemCenterX,yValue+itemPriceY, LC.translate("Owned", Games.Menus))
			draw_set_alpha(0.6)
			draw_set_color(c_black)
			draw_roundrect(xValue + 5,yValue +5,xValue+itemWidth-5,yValue+itemHeight-5,false)
			draw_set_color(c_white)
			draw_set_alpha(1)
		}
		else 
		{
			draw_text(xValue+itemCenterX,yValue+itemPriceY,price+"$")
		}
		draw_text(xValue+itemCenterX,yValue+itemTitleY,itemName)

		
		// Mouseover hover highlighter
		if(mouse_x > xValue && mouse_x < xValue+itemWidth) {
			if(mouse_y > yValue && mouse_y < yValue+itemHeight) {
				draw_set_alpha(0.3)
				// make sure they are not above max height
				if(yValue >= categoryStartY) {
					draw_rectangle(xValue,yValue,xValue+itemWidth,yValue+itemHeight,false)
				}
				else if(yValue+itemHeight >= categoryStartY) {
					draw_rectangle(xValue,categoryStartY,xValue+itemWidth,yValue+itemHeight,false)
				}
				// set current item price
				obj_storeController.selectedPrice = price
				draw_set_alpha(1)
			}
		}
	}
}


