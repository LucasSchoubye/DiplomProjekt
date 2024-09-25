// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function UltManPlayer() constructor {

	// Generel Information
	name = ["Cristiano", "Ronaldo"]
	number = "7"
	age = 29
	nationality = Nationality.POR

	// Tactics
	position = FootballPositions.ST
	condition = 95
	
	// Rating
	overallRating = 84
	
	function DrawPlayer(X,Y, color = #43C44A)
	{
		var width = 90
		var height = 30
		
		// Outline
		draw_set_color(color)
		draw_roundrect(X-width/2, Y, X+width/2, Y+height, false)
		draw_set_color(c_white)
		draw_roundrect(X-width/2, Y, X+width/2, Y+height, true)
		
		// Text
		draw_set_font(fn_textLato)
		draw_set_halign(fa_center)
		draw_set_valign(fa_middle)
		draw_text(X,Y+height*1.5,name[1])
		draw_text(X,Y+height*0.5,PosToString())
	}
	
	function PosToString()
	{
		switch(position)
		{
			case FootballPositions.ST:
				return "ST"
			case FootballPositions.RW:
				return "RW"
			case FootballPositions.LW:
				return "LW"
			case FootballPositions.RM:
				return "RM"
			case FootballPositions.LM:
				return "LM"
			case FootballPositions.CM:
				return "CM"
			case FootballPositions.CAM:
				return "CAM"
			case FootballPositions.CDM:
				return "CDM"
			case FootballPositions.CB:
				return "CB"
			case FootballPositions.LB:
				return "LB"
			case FootballPositions.RB:
				return "RB"
			case FootballPositions.RWB:
				return "RWB"
			case FootballPositions.LWB:
				return "LWB"
			case FootballPositions.GK:
				return "GK"
			case FootballPositions.SUB:
				return "SUB"
				
		}
	}
	
	function UpdatePosition(column, index, length)
	{
		switch(column)
		{
			case FormationColumns.Attackers:
				if (length > 2)
				{
					show_message(name[1] + "Column: "+string(column)+" Index: "+string(index)+" Length: "+string(length))
					if (index = length-1)
					{
						position = FootballPositions.RW
					}
					else if (index = 0)
					{
						position = FootballPositions.LW
					}
					else
					{
						position = FootballPositions.ST
					}
				}
				else
				{
					position = FootballPositions.ST
				}
			break;
			case FormationColumns.OffensiveMidfield:
				position = FootballPositions.CAM
			break;
			case FormationColumns.Midfield:
				if (length > 3)
					{
						if (index = length-1)
						{
							position = FootballPositions.RM
						}
						else if (index = 0)
						{
							position = FootballPositions.LM
						}
						else
						{
							position = FootballPositions.CM
						}
					}
					else
					{
						position = FootballPositions.CM
					}
			break;
			case FormationColumns.DefensiveMidfielder:
				position = FootballPositions.CDM
			break;
			case FormationColumns.Defense:
				if (length > 3)
					{
						if (index = length-1)
						{
							position = FootballPositions.RB
						}
						else if (index = 0)
						{
							position = FootballPositions.LB
						}
						else
						{
							position = FootballPositions.CB
						}
					}
					else
					{
						position = FootballPositions.CB
					}
			break;
			case FormationColumns.Goalkeeper:
				position = FootballPositions.GK
			break;
		}
	}
}