// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function UltManTeam() constructor{
	
	 name = ["","",""];
	 nameLast = ["","",""];

	 // Arrays for cities and suffixes
	 switch(round(random_range(1,60)))
{
      case 1:
             name[0] = "Ash"
      break;
      case 2:
             name[0] = "Ayles"
      break;
      case 3:
             name[0] = "Ban"
      break;
      case 4:
             name[0] = "Bath"
      break;
      case 5:
             name[0] = "Bed"
      break;
      case 6:
             name[0] = "Bir"
      break;
      case 7:
             name[0] = "Bol"
      break;
      case 8:
             name[0] = "Bos"
      break;
      case 9:
             name[0] = "Brigh"
      break;
      case 10:
             name[0] = "Bur"
      break;
      case 11:
             name[0] = "Cam"
      break;
      case 12:
             name[0] = "Canter"
      break;
      case 13:
             name[0] = "Carl"
      break;
      case 14:
             name[0] = "Chelt"
      break;
      case 15:
             name[0] = "Ches"
      break;
      case 16:
             name[0] = "Chipp"
      break;
      case 17:
             name[0] = "Colch"
      break;
      case 18:
             name[0] = "Cov"
      break;
      case 19:
             name[0] = "Craw"
      break;
      case 20:
             name[0] = "Der"
      break;
      case 21:
             name[0] = "Dor"
      break;
      case 22:
             name[0] = "Dum"
      break;
      case 23:
             name[0] = "Dur"
      break;
      case 24:
             name[0] = "Eas"
      break;
      case 25:
             name[0] = "Edin"
      break;
      case 26:
             name[0] = "Ex"
      break;
      case 27:
             name[0] = "Glas"
      break;
      case 28:
             name[0] = "Glouce"
      break;
      case 29:
             name[0] = "Grim"
      break;
      case 30:
             name[0] = "Hal"
      break;
      case 31:
             name[0] = "Here"
      break;
      case 32:
             name[0] = "Hudd"
      break;
      case 33:
             name[0] = "Ips"
      break;
      case 34:
             name[0] = "Ken"
      break;
      case 35:
             name[0] = "Lan"
      break;
      case 36:
             name[0] = "Leeds"
      break;
      case 37:
             name[0] = "Lei"
      break;
      case 38:
             name[0] = "Lin"
      break;
      case 39:
             name[0] = "Liv"
      break;
      case 40:
             name[0] = "Lon"
      break;
      case 41:
             name[0] = "Lut"
      break;
      case 42:
             name[0] = "Man"
      break;
      case 43:
             name[0] = "New"
      break;
      case 44:
             name[0] = "Northamp"
      break;
      case 45:
             name[0] = "Nor"
      break;
      case 46:
             name[0] = "Not"
      break;
      case 47:
             name[0] = "Ox"
      break;
      case 48:
             name[0] = "Pen"
      break;
      case 49:
             name[0] = "Plym"
      break;
      case 50:
             name[0] = "Por"
      break;
      case 51:
             name[0] = "Pre"
      break;
      case 52:
             name[0] = "Read"
      break;
      case 53:
             name[0] = "Shef"
      break;
      case 54:
             name[0] = "Shrew"
      break;
      case 55:
             name[0] = "Swan"
      break;
      case 56:
             name[0] = "Telf"
      break;
      case 57:
             name[0] = "War"
      break;
      case 58:
             name[0] = "Wat"
      break;
      case 59:
             name[0] = "Win"
      break;
      case 60:
             name[0] = "Wolver"
      break;
}
	 
	switch(round(random_range(1, 60)))
{
    case 1:
        name[1] = "don"
    break;
    case 2:
        name[1] = "ton"
    break;
    case 3:
        name[1] = "brough"
    break;
    case 4:
        name[1] = "ham"
    break;
    case 5:
        name[1] = "ford"
    break;
    case 6:
        name[1] = "mouth"
    break;
    case 7:
        name[1] = "chester"
    break;
    case 8:
        name[1] = "wich"
    break;
    case 9:
        name[1] = "by"
    break;
    case 10:
        name[1] = "bury"
    break;
    case 11:
        name[1] = "pool"
    break;
    case 12:
        name[1] = "field"
    break;
    case 13:
        name[1] = "bridge"
    break;
    case 14:
        name[1] = "land"
    break;
    case 15:
        name[1] = "port"
    break;
    case 16:
        name[1] = "ley"
    break;
    case 17:
        name[1] = "hill"
    break;
    case 18:
        name[1] = "worth"
    break;
    case 19:
        name[1] = "head"
    break;
    case 20:
        name[1] = "stone"
    break;
    case 21:
        name[1] = "cester"
    break;
    case 22:
        name[1] = "borough"
    break;
    case 23:
        name[1] = "gate"
    break;
    case 24:
        name[1] = "combe"
    break;
    case 25:
        name[1] = "well"
    break;
    case 26:
        name[1] = "minster"
    break;
    case 27:
        name[1] = "court"
    break;
    case 28:
        name[1] = "wood"
    break;
    case 29:
        name[1] = "den"
    break;
    case 30:
        name[1] = "bourne"
    break;
    case 31:
        name[1] = "haven"
    break;
    case 32:
        name[1] = "hall"
    break;
    case 33:
        name[1] = "thorpe"
    break;
    case 34:
        name[1] = "side"
    break;
    case 35:
        name[1] = "beck"
    break;
    case 36:
        name[1] = "worth"
    break;
    case 37:
        name[1] = "dean"
    break;
    case 38:
        name[1] = "brook"
    break;
    case 39:
        name[1] = "leigh"
    break;
    case 40:
        name[1] = "burn"
    break;
    case 41:
        name[1] = "cross"
    break;
    case 42:
        name[1] = "moor"
    break;
    case 43:
        name[1] = "holt"
    break;
    case 44:
        name[1] = "bridge"
    break;
    case 45:
        name[1] = "dale"
    break;
    case 46:
        name[1] = "town"
    break;
    case 47:
        name[1] = "park"
    break;
    case 48:
        name[1] = "castle"
    break;
    case 49:
        name[1] = "green"
    break;
    case 50:
        name[1] = "end"
    break;
    case 51:
        name[1] = "wood"
    break;
    case 52:
        name[1] = "ridge"
    break;
    case 53:
        name[1] = "bury"
    break;
    case 54:
        name[1] = "fleet"
    break;
    case 55:
        name[1] = "marsh"
    break;
    case 56:
        name[1] = "creek"
    break;
    case 57:
        name[1] = "hurst"
    break;
    case 58:
        name[1] = "grove"
    break;
    case 59:
        name[1] = "ford"
    break;
    case 60:
        name[1] = "mount"
    break;
}

	city = name[0] + name[1];
     var suffixes = ["United", "FC", "CF", "Athletic", "City", "Rovers", "Wanderers", "Wednesday"];
	
     var suffix = suffixes[irandom(array_length(suffixes) - 1)];

    // Concatenate the city and suffix to form the club name
    clubName = city + " " + suffix;

    // Club statistics
    matchesWon = 0;
    matchesDrawn = 0;
    matchesLost = 0;
    matchesPlayed = matchesWon + matchesDrawn + matchesLost;
    totalPoints = (matchesWon * 3) + (matchesDrawn * 1) + (matchesLost * 0);

    // Randomly assign a club rating between 1 and 100
    clubRating = irandom_range(1, 100);

}