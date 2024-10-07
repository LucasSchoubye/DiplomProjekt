// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_UltManGeneratePlayerStats(player, pos, tier){
	show_debug_message(tier)
	switch(tier)
	{
		case UltManPackTier.Bronze:
			player.topSpd = irandom_range(150, 250)
			player.topShootSpd = irandom_range(1000, 1300)
			player.topPassSpd = irandom_range(1000, 1300)
			player.passing = irandom_range(500, 700)
			player.shooting = irandom_range(500, 700)
			player.strength = irandom_range(100, 150)
			player.defence = irandom_range(100, 150)
			player.dribbling = irandom_range(100, 150)
		break;
		
		case UltManPackTier.Silver:
			player.topSpd = irandom_range(200, 300)
			player.topShootSpd = irandom_range(1200, 1500)
			player.topPassSpd = irandom_range(1200, 1500)
			player.passing = irandom_range(400, 600)
			player.shooting = irandom_range(400, 600)
			player.strength = irandom_range(125, 175)
			player.defence = irandom_range(125, 175)
			player.dribbling = irandom_range(125, 175)
		break;
		
		case UltManPackTier.Gold:
			player.topSpd = irandom_range(250, 350)
			player.topShootSpd = irandom_range(1400, 1700)
			player.topPassSpd = irandom_range(1400, 1700)
			player.passing = irandom_range(300, 500)
			player.shooting = irandom_range(300, 500)
			player.strength = irandom_range(150, 200)
			player.defence = irandom_range(150, 200)
			player.dribbling = irandom_range(150, 200)
		break;
		
		case UltManPackTier.Ruby:
			player.topSpd = irandom_range(250, 350)
			player.topShootSpd = irandom_range(1400, 1700)
			player.topPassSpd = irandom_range(1400, 1700)
			player.passing = irandom_range(300, 500)
			player.shooting = irandom_range(300, 500)
			player.strength = irandom_range(150, 200)
			player.defence = irandom_range(150, 200)
			player.dribbling = irandom_range(150, 200)
		break;
		
		case UltManPackTier.Obsidian:
			player.topSpd = irandom_range(250, 350)
			player.topShootSpd = irandom_range(1400, 1700)
			player.topPassSpd = irandom_range(1400, 1700)
			player.passing = irandom_range(300, 500)
			player.shooting = irandom_range(300, 500)
			player.strength = irandom_range(150, 200)
			player.defence = irandom_range(150, 200)
			player.dribbling = irandom_range(150, 200)
		break;
		
		case UltManPackTier.Legendary:
			player.topSpd = irandom_range(450, 550)
			player.topShootSpd = irandom_range(4000, 4500)
			player.topPassSpd = irandom_range(4000, 4500)
			player.passing = irandom_range(150, 100)
			player.shooting = irandom_range(150, 100)
			player.strength = irandom_range(500, 600)
			player.defence = irandom_range(800, 1000)
			player.dribbling = irandom_range(100, 150)
		break;
	}

	ModifyStatsWithPos(pos, player)
}

function ModifyStatsWithPos(pos, player)
{
	switch(pos)
	{
		case FootballPositions.CB:
			// Nerfs
			player.topSpd = player.topSpd*0.8
			player.dribbling = player.dribbling*0.8
			player.passing = player.passing*1.3
			player.shooting = player.shooting*1.3
			
			// Buffs
			player.topPassSpd = player.topPassSpd*1.3
			player.strength = player.strength*1.7
			player.defence = player.defence*1.7
			
			// Situational
			if (random_range(1,100) > 90)
				player.topShootSpd = player.topShootSpd*1.4
			else
				player.topShootSpd = player.topShootSpd*0.6
		break;
	}
}