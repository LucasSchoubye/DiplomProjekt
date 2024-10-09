// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function itemNameToSprite(name)
	{
		switch(name)
		{
			case "Cat":
				return spr_cat
			case "Hat":
				return spr_hat
			case "Scat":
				return spr_scat
			default:
				return Spr_YoYo_button
		}
	}