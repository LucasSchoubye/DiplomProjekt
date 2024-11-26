// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function CategoryElement() constructor {
	itemName = ""
	balance = ""
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
	categorySprite = spr_theOneAndOnlySmall
	categoryWidth = room_width*0.2
	categoryHeight = room_height*0.07
	categoryTextStartX =  room_width*0.01
	categoryCenterY = categoryHeight/2
	categoryImgStartX = categoryWidth-30
	
	
	function DrawCategory(xValue,yValue) {
		var LC = obj_languageController
		
		draw_set_alpha(0.1)
		draw_set_color(c_white)
		draw_roundrect(xValue,yValue,xValue+categoryWidth,yValue+categoryHeight,false)
		draw_set_alpha(0.4 + sin(current_time/500)*0.1)
		draw_roundrect(xValue,yValue,xValue+categoryWidth,yValue+categoryHeight,true)
		draw_set_alpha(1)
		
		draw_set_halign(fa_center)
		draw_text(xValue+categoryWidth/2,yValue+categoryCenterY,LC.translate(itemName, Games.Menus))
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