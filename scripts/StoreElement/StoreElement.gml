// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function StoreElement() constructor {
	itemName = ""
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
	categorySprite = spr_theOneAndOnlySmall
	categoryWidth = room_width*0.2
	categoryHeight = room_height*0.07
	categoryTextStartX =  room_width*0.01
	categoryCenterY = categoryHeight/2
	categoryImgStartX = categoryWidth-30
	category = ""
	

	function DrawItem(xValue,yValue) {
		if(yValue >= categoryStartY) {
			switch(itemName){
				case "Cat":
					draw_sprite(spr_cat,0,xValue+itemCenterX,yValue+itemImgStartY)
				break
				case "Hat":
					draw_sprite(spr_hat,0,xValue+itemCenterX,yValue+itemImgStartY)
				break
				case "Scat":
					draw_sprite(spr_scat,0,xValue+itemCenterX,yValue+itemImgStartY)
				break
			}
			draw_rectangle(xValue,yValue,xValue+itemWidth,yValue+itemHeight,true)
		}
		else if(yValue+itemHeight >= categoryStartY) {
			draw_rectangle(xValue,categoryStartY,xValue+itemWidth,yValue+itemHeight,true)
		}
		if(yValue+itemPriceY-textHeight >= categoryStartY && isOwned == true) {
			draw_text(xValue+itemCenterX,yValue+itemPriceY,"Owned")
		}
		else if(yValue+itemPriceY-textHeight >= categoryStartY) {
			draw_text(xValue+itemCenterX,yValue+itemPriceY,price+"$")
		}
		if(yValue+itemTitleY-textHeight >= categoryStartY) {
			draw_text(xValue+itemCenterX,yValue+itemTitleY,itemName)
		}
		
		if(mouse_x > xValue && mouse_x < xValue+itemWidth) {
			if(mouse_y > yValue && mouse_y < yValue+itemHeight) {
				draw_set_alpha(0.3)
				if(yValue >= categoryStartY) {
					draw_rectangle(xValue,yValue,xValue+itemWidth,yValue+itemHeight,false)
				}
				else if(yValue+itemHeight >= categoryStartY) {
					draw_rectangle(xValue,categoryStartY,xValue+itemWidth,yValue+itemHeight,false)
				}
				obj_storeController.selectedPrice = price
				draw_set_alpha(1)
			}
		}
	}
	
}


