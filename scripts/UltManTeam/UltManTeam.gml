// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function UltManTeam() constructor{
	


    // Concatenate the city and suffix to form the club name
    clubName = scr_UltManGenerateTeamName()

    // Club statistics
	matchesWon = 0
	matchesDrawn = 0
	matchesLost = 0
	matchesPlayed = 0
    totalPoints = 0

    // Randomly assign a club rating between 1 and 100	
	attackerQuality = irandom_range(70, 100);
	midfielderQuality = irandom_range(70, 100);
	defenderQuality = irandom_range(70, 100);
	goalKeeperQuality = irandom_range(70, 100);
	ballPossesion = irandom_range(70, 100);
	counterAttacks = irandom_range(70, 100);
	
	clubRating = (attackerQuality + midfielderQuality + defenderQuality + goalKeeperQuality + ballPossesion + counterAttacks)/6
}

enum UltManClubRatingCategories 
{
	AttackerQuality,
	MidfielderQuality,
	DefenderQuality,
	GoalKeeperQuality,
}