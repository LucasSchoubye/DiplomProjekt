// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_UltManRandomNationality(){

	switch (round(random_range(1,18)))
	{
		case 1:
			return Nationality.DK
			
		case 2:
			return Nationality.SWE
			
		case 3:
			return Nationality.NOR
			
		case 4:
			return Nationality.DE
			
		case 5:
			return Nationality.BEL
			
		case 6:
			return Nationality.ENG
			
		case 7:
			return Nationality.CRO
			
		case 8:
			return Nationality.HOL
			
		case 9:
			return Nationality.ITA
			
		case 10:
			return Nationality.FRA
			
		case 11:
			return Nationality.ESP
			
		case 12:
			return Nationality.POR
			
		case 13:
			return Nationality.ARG
			
		case 14:
			return Nationality.BRA
			
		case 15:
			return Nationality.USA
			
		case 16:
			return Nationality.NIG
			
		case 17:
			return Nationality.SEN
			
		case 18:
			return Nationality.CAM
	}
}
