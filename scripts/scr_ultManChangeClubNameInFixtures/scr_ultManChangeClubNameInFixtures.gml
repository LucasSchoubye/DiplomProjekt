// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_ultManChangeClubNameInFixtures(oldName, newName)
{
	for (var gameweeks = 0; gameweeks < array_length(seasonGameweeks); ++gameweeks) {
	    
		// For each gameweek
		for (var match = 0; match < array_length(seasonGameweeks[gameweeks]); ++match) {
		    
			// Find each matchup and change their name
			if (seasonGameweeks[gameweeks][match][0] = oldName)
				seasonGameweeks[gameweeks][match][0] = newName
				
			if (seasonGameweeks[gameweeks][match][1] = oldName)
				seasonGameweeks[gameweeks][match][1] = newName
		}
	}
}