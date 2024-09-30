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
		draw_rectangle(xValue,yValue,xValue+categoryWidth,yValue+categoryHeight,true)
		draw_sprite(spr_theOneAndOnlySmall,0,xValue+categoryImgStartX,yValue+categoryCenterY)
		draw_set_halign(fa_left)
		draw_text(xValue+categoryTextStartX,yValue+categoryCenterY,"YOYOYO CATEGORY BRO")
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