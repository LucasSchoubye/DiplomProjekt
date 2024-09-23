// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function InventoryElement() constructor {
	itemName = ""
	balance = ""
	itemID = ""
	isEquipped = false
	txtEquip = ""
	itemWidth = room_width*0.15
	itemHeight = room_height*0.3
	itemCenterX = itemWidth/2
	itemCenterY = itemHeight/2
	itemPriceY = itemHeight-20
	itemTitleY = itemHeight-40
	itemImgStartY = itemCenterY-10
	textHeight = 10
	categorySprite = spr_theOneAndOnlySmall
	categoryWidth = room_width*0.2
	categoryHeight = room_height*0.07
	categoryTextStartX =  room_width*0.01
	categoryCenterY = categoryHeight/2
	categoryImgStartX = categoryWidth-30

	
	function DrawItem(xValue,yValue) {
		if(yValue >= 100) {
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
		else if(yValue+itemHeight >= 100) {
			draw_rectangle(xValue,100,xValue+itemWidth,yValue+itemHeight,true)
		}
		if(yValue+itemPriceY >= 100) {
			if (isEquipped == true) {
				txtEquip = "EQUIPPED"
			} else {
				txtEquip = ""
			}
			draw_text(xValue+itemCenterX,yValue+itemTitleY,txtEquip)
		}
		if(yValue+itemPriceY-textHeight >= 100) {
			draw_text(xValue+itemCenterX,yValue+itemPriceY,itemName)
		}
		
		
		if(mouse_x > xValue && mouse_x < xValue+itemWidth) {
			if(mouse_y > yValue && mouse_y < yValue+itemHeight) {
				draw_set_alpha(0.3)
				if(yValue >= 100) {
					draw_rectangle(xValue,yValue,xValue+itemWidth,yValue+itemHeight,false)
				}
				else if(yValue+itemHeight >= 100) {
					draw_rectangle(xValue,100,xValue+itemWidth,yValue+itemHeight,false)
				}
				draw_set_alpha(1)
			}
		}
		if (mouse_check_button_pressed(mb_left) and mouse_x > xValue && mouse_x < xValue+itemWidth){
			if(mouse_y > yValue && mouse_y < yValue+itemHeight) {
			// Click event
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
				draw_set_alpha(0.3)
				draw_rectangle(xValue,yValue,xValue+categoryWidth,yValue+categoryHeight,false)
				draw_set_alpha(1)
			}
		}
	}
}
