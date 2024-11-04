// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function itemNameToSprite(name)
	{
		switch(name)
		{
			case "Black Hole":
				return spr_blackHole
			case "Thunderbolt":
				return spr_thunderBall
			case "Fireball":
				return spr_fireBallR
			case "Heavy Armor":
				return spr_heavyArmor
			case "Medium Armor":
				return spr_mediumArmor
			case "Light Armor":
				return spr_lightArmor
			default:
				return Spr_YoYo_button
		}
	}