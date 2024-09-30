function UltManTeams() {
    // Arrays for cities and suffixes
    var cities = ["London", "Manchester", "Liverpool", "Birmingham", 
	"Leeds", "Glasgow", "Edinburgh", "Cardiff", "Bristol", "Sheffield", "Southampton",
	"Newcastle", "Nottingham", "Bristol"];
    var suffixes = ["United", "FC", "CF", "Athletic", "City", "Rovers", "Wanderers", "Wednesday"];
	
	teamList = ds_list_create()
	
	for (var i = 0; i < 19; ++i) {
		
	// Randomly select a city and a suffix
    var city = cities[irandom(array_length(cities) - 1)];
    var suffix = suffixes[irandom(array_length(suffixes) - 1)];

    // Concatenate the city and suffix to form the club name
    var clubName = city + " " + suffix;

    // Club statistics
    var matchesWon = 0;
    var matchesDrawn = 0;
    var matchesLost = 0;
    var matchesPlayed = matchesWon + matchesDrawn + matchesLost;
    var totalPoints = (matchesWon * 3) + (matchesDrawn * 1) + (matchesLost * 0);

    // Randomly assign a club rating between 1 and 100
    var clubRating = irandom_range(1, 100);
	
	ds_list_add(teamList,)
		
	}

   

    // Output (you can display or log these values in your game)
    show_debug_message("Club Name: " + clubName);
    show_debug_message("Club Rating: " + string(clubRating));
    show_debug_message("Matches Played: " + string(matchesPlayed));
    show_debug_message("Total Points: " + string(totalPoints));
}
