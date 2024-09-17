// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function StoreElement() constructor {
	itemName = ""
	balance = ""
	price = undefined
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
	mouseWithinAnswerBox = false
	
	function DrawBalance(xValue,yValue) {
		draw_text(xValue,yValue,balance)
	}
	
	function DrawItem(xValue,yValue) {
		if(yValue >= 100) {
			draw_sprite(itemSprite,0,xValue+itemCenterX,yValue+itemImgStartY)
			draw_rectangle(xValue,yValue,xValue+itemWidth,yValue+itemHeight,true)
		}
		else if(yValue+itemHeight >= 100) {
			draw_rectangle(xValue,100,xValue+itemWidth,yValue+itemHeight,true)
		}
		if(yValue+itemPriceY-textHeight >= 100) {
			draw_text(xValue+itemCenterX,yValue+itemPriceY,price+"$")
		}
		if(yValue+itemTitleY-textHeight >= 100) {
			draw_text(xValue+itemCenterX,yValue+itemTitleY,itemName)
		}
		
		if(mouse_x > xValue && mouse_x < xValue+itemWidth) {
			if(mouse_y > yValue && mouse_y < yValue+itemHeight) {
				mouseWithinAnswerBox = true
				draw_set_alpha(0.3)
				if(yValue >= 100) {
					draw_rectangle(xValue,yValue,xValue+itemWidth,yValue+itemHeight,false)
				}
				else if(yValue+itemHeight >= 100) {
					draw_rectangle(xValue,100,xValue+itemWidth,yValue+itemHeight,false)
				}
				obj_storeController.selectedPrice = price
				draw_set_alpha(1)
			}
		}
	}
	
	function DrawCategory(xValue,yValue) {
		draw_rectangle(xValue,yValue,xValue+categoryWidth,yValue+categoryHeight,true)
		draw_sprite(spr_theOneAndOnlySmall,0,xValue+categoryImgStartX,yValue+categoryCenterY)
		draw_set_halign(fa_left)
		draw_text(xValue+categoryTextStartX,yValue+categoryCenterY,"YOYOYO CATEGORY BRO")
		draw_set_halign(fa_center)
		if(mouse_x > xValue && mouse_x < xValue+categoryWidth) {
			if(mouse_y > yValue && mouse_y < yValue+categoryHeight) {
				mouseWithinAnswerBox = true
				draw_set_alpha(0.3)
				draw_rectangle(xValue,yValue,xValue+categoryWidth,yValue+categoryHeight,false)
				draw_set_alpha(1)
			}
		}
	}
}


