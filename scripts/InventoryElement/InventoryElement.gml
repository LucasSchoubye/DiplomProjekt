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
	itemTitleY = itemHeight-20
	itemEquipY = itemHeight-40
	itemImgStartY = itemCenterY-10
	textHeight = 10

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
		if(yValue+itemEquipY-textHeight >= 100) {
			if (isEquipped == true) {
				txtEquip = "EQUIPPED"
			} else {
				txtEquip = ""
			}
			draw_text(xValue+itemCenterX,yValue+itemEquipY,txtEquip)
		}
		if(yValue+itemTitleY-textHeight >= 100) {
			draw_text(xValue+itemCenterX,yValue+itemTitleY,itemName)
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
	
	}
}
