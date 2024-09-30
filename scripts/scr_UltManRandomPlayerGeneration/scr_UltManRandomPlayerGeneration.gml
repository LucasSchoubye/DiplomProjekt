// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
enum UltManPackTier
{
	Bronze,
	Silver,
	Gold,
	Platinum,
	Obsidian,
	Legendary
}

function scr_UltManRandomPlayerGeneration(tier){

	var player = new UltManPlayer() 
	

	switch(tier)
	{
		case UltManPackTier.Bronze:
			return scr_UltManBronzePack()
	}

	return player;
}