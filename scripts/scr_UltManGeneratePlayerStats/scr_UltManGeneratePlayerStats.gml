// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_UltManGeneratePlayerStats(player, pos, tier){
	switch(tier)
	{
		case UltManPackTier.Bronze:
			player.topSpd = irandom_range(102, 164)
			player.topShootSpd = irandom_range(1000, 1550)
			player.topPassSpd = irandom_range(1000, 1550)
			player.passing = irandom_range(600, 700)
			player.shooting = irandom_range(600, 700)
			player.strength = irandom_range(0, 100)
			player.defence = irandom_range(100, 250)
			player.dribbling = irandom_range(100, 250)
			player.overallRating = irandom_range(45, 54)
		break;
		
		case UltManPackTier.Silver:
			player.topSpd = irandom_range(164, 226)
			player.topShootSpd = irandom_range(1550, 2100)
			player.topPassSpd = irandom_range(1550, 2100)
			player.passing = irandom_range(500, 600)
			player.shooting = irandom_range(500, 600)
			player.strength = irandom_range(100, 200)
			player.defence = irandom_range(250, 400)
			player.dribbling = irandom_range(250, 400)
			player.overallRating = irandom_range(55, 64)
		break;
		
		case UltManPackTier.Gold:
			player.topSpd = irandom_range(226, 288)
			player.topShootSpd = irandom_range(2100, 2650)
			player.topPassSpd = irandom_range(2100, 2650)
			player.passing = irandom_range(400, 500)
			player.shooting = irandom_range(400, 500)
			player.strength = irandom_range(200, 300)
			player.defence = irandom_range(400, 550)
			player.dribbling = irandom_range(400, 550)
			player.overallRating = irandom_range(65, 74)
		break;
		
		case UltManPackTier.Ruby:
			player.topSpd = irandom_range(288, 350)
			player.topShootSpd = irandom_range(2650, 3200)
			player.topPassSpd = irandom_range(2650, 3200)
			player.passing = irandom_range(300, 400)
			player.shooting = irandom_range(300, 400)
			player.strength = irandom_range(300, 400)
			player.defence = irandom_range(550, 700)
			player.dribbling = irandom_range(550, 700)
			player.overallRating = irandom_range(75, 84)
		break;
		
		case UltManPackTier.Obsidian:
			player.topSpd = irandom_range(350, 412)
			player.topShootSpd = irandom_range(3200, 3750)
			player.topPassSpd = irandom_range(3200, 3750)
			player.passing = irandom_range(200, 300)
			player.shooting = irandom_range(200, 300)
			player.strength = irandom_range(400, 500)
			player.defence = irandom_range(700, 850)
			player.dribbling = irandom_range(700, 850)
			player.overallRating = irandom_range(85, 94)
		break;
		
		case UltManPackTier.Legendary:
			player.topSpd = irandom_range(412, 550)
			player.topShootSpd = irandom_range(3750, 4500)
			player.topPassSpd = irandom_range(3750, 4500)
			player.passing = irandom_range(100, 200)
			player.shooting = irandom_range(100, 200)
			player.strength = irandom_range(500, 600)
			player.defence = irandom_range(850, 1000)
			player.dribbling = irandom_range(850, 1000)
			player.overallRating = irandom_range(95, 100)
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
			if (random_range(1,100) > 95)
				player.topShootSpd = player.topShootSpd*1.4
			else
				player.topShootSpd = player.topShootSpd*0.6
		break;
		case FootballPositions.LB:
			// Nerfs
			player.passing = player.passing*1.2
			player.shooting = player.shooting*1.3
			
			// Buffs
			player.topSpd = player.topSpd*1.1
			player.strength = player.strength*1.1
			player.defence = player.defence*1.3
			
			// Situational
		break;
		case FootballPositions.RB:
			// Nerfs
			player.passing = player.passing*1.2
			player.shooting = player.shooting*1.3
			
			// Buffs
			player.topSpd = player.topSpd*1.1
			player.strength = player.strength*1.1
			player.defence = player.defence*1.3
			
			// Situational
		break;
		case FootballPositions.LWB:
			// Nerfs
			player.passing = player.passing*1.1
			player.shooting = player.shooting*1.1
			player.strength = player.strength*0.9
			
			// Buffs
			player.topSpd = player.topSpd*1.2
			player.defence = player.defence*1.1
			
			// Situational
		break;
		case FootballPositions.RWB:
			// Nerfs
			player.passing = player.passing*1.1
			player.shooting = player.shooting*1.1
			player.strength = player.strength*0.9
			
			// Buffs
			player.topSpd = player.topSpd*1.2
			player.defence = player.defence*1.1
			
			// Situational
		break;
		case FootballPositions.CDM:
			// Nerfs
			player.topSpd = player.topSpd*0.8
			player.dribbling = player.dribbling*0.9
			player.shooting = player.shooting*1.3
			
			// Buffs
			player.topPassSpd = player.topPassSpd*1.3
			player.strength = player.strength*1.3
			player.defence = player.defence*1.1
			player.passing = player.passing*0.9
			
			// Situational
			if (random_range(1,100) > 95)
				player.topShootSpd = player.topShootSpd*1.4
			else
				player.topShootSpd = player.topShootSpd*0.8
		break;
		case FootballPositions.CM:
			// Nerfs
			player.shooting = player.shooting*1.1
			player.defence = player.defence*0.9
			
			// Buffs
			player.topPassSpd = player.topPassSpd*1.3
			player.passing = player.passing*0.8
			player.dribbling = player.dribbling*1.1
			
			
			// Situational
			if (random_range(1,100) > 95)
				player.topShootSpd = player.topShootSpd*1.4
			else
				player.topShootSpd = player.topShootSpd*0.9
		break;
		case FootballPositions.CAM:
			// Nerfs
			player.defence = player.defence*0.7
			player.strength = player.strength*0.7
			
			// Buffs
			player.topPassSpd = player.topPassSpd*1.4
			player.passing = player.passing*0.7
			player.dribbling = player.dribbling*1.2
			player.shooting = player.shooting*0.9
			
			// Situational
			if (random_range(1,100) > 90)
				player.topShootSpd = player.topShootSpd*1.4
			else
				player.topShootSpd = player.topShootSpd*1.1
		break;
		case FootballPositions.LM:
			// Nerfs
			player.defence = player.defence*0.8
			player.strength = player.strength*0.7
			
			// Buffs
			player.topPassSpd = player.topPassSpd*1.1
			player.passing = player.passing*0.9
			player.dribbling = player.dribbling*1.3
			
			// Situational
			if (random_range(1,100) > 90)
				player.topShootSpd = player.topShootSpd*1.2
			else
				player.topShootSpd = player.topShootSpd*1
		break;
		case FootballPositions.RM:
			// Nerfs
			player.defence = player.defence*0.8
			player.strength = player.strength*0.7
			
			// Buffs
			player.topPassSpd = player.topPassSpd*1.1
			player.passing = player.passing*0.9
			player.dribbling = player.dribbling*1.3
			
			// Situational
			if (random_range(1,100) > 90)
				player.topShootSpd = player.topShootSpd*1.2
			else
				player.topShootSpd = player.topShootSpd*1
		break;
		case FootballPositions.LW:
			// Nerfs
			player.defence = player.defence*0.5
			player.strength = player.strength*0.6
			
			// Buffs
			player.topPassSpd = player.topPassSpd*1.3
			player.topSpd = player.topPassSpd*1.3
			player.passing = player.passing*0.9
			player.dribbling = player.dribbling*1.5
			player.shooting = player.shooting*1.2
			
			// Situational
			if (random_range(1,100) > 80)
				player.topShootSpd = player.topShootSpd*1.5
			else
				player.topShootSpd = player.topShootSpd*1.1
		break;
		case FootballPositions.RW:
			// Nerfs
			player.defence = player.defence*0.5
			player.strength = player.strength*0.6
			
			// Buffs
			player.topPassSpd = player.topPassSpd*1.3
			player.topSpd = player.topPassSpd*1.3
			player.passing = player.passing*0.9
			player.dribbling = player.dribbling*1.5
			player.shooting = player.shooting*1.2
			
			// Situational
			if (random_range(1,100) > 80)
				player.topShootSpd = player.topShootSpd*1.5
			else
				player.topShootSpd = player.topShootSpd*1.1
		break;
		case FootballPositions.ST:
			// Nerfs
			player.defence = player.defence*0.3
			player.passing = player.passing*1.1
			player.topPassSpd = player.topPassSpd*0.9
			
			// Buffs
			player.topSpd = player.topPassSpd*1.2
			player.dribbling = player.dribbling*1.2
			player.shooting = player.shooting*1.5
			
			// Situational
			if (random_range(1,100) > 80)
				player.topShootSpd = player.topShootSpd*1.7
			else
				player.topShootSpd = player.topShootSpd*1.3
		break;
	}
}