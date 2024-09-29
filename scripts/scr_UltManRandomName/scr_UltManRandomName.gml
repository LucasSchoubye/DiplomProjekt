// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_UltManRandomName(nation){

	// Debug
	debugNumb = round(random_range(1,2))

	switch(debugNumb)
	{
		case 1:
		case Nationality.DK:
		case Nationality.SWE:
		case Nationality.NOR:
			return scr_UltManRandomScandinavianNames()
			
		case 2:
		case Nationality.DE:
		case Nationality.BEL:
		case Nationality.HOL:
			return scr_UltManRandomGermanNames()

		case Nationality.USA:
		case Nationality.ENG:
			return scr_UltManRandomEnglishNames()
			
		case Nationality.CRO:
			return scr_UltManRandomSlavicNames()
			
			
		case Nationality.ITA:
			return scr_UltManRandomItalianNames()
			
		case Nationality.FRA:
			return scr_UltManRandomFrenchNames()
			
		case Nationality.BRA:
		case Nationality.ESP:
		case Nationality.POR:
		case Nationality.ARG:
			return scr_UltManRandomLatinoNames()
			
		case Nationality.NIG:
		case Nationality.SEN:
		case Nationality.CAM:
			return scr_UltManRandomAfricanNames()

	}

}