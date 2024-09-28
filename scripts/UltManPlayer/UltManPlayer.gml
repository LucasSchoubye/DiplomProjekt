// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function UltManPlayer() constructor {

	// Generel Information
	name = ["Cristiano", "Ronaldo"]
	number = "7"
	age = 29
	nationality = Nationality.POR

	// Tactics
	position = FootballPositions.SUB
	preferredPosition = FootballPositions.ST
	playableColumns = ds_list_create()
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
		draw_set_color(c_white)
		
		// Action
		if (mouse_check_button_pressed(mb_left) && mouse_x > X - width/2 && mouse_x < X + width/2 &&
			mouse_y > Y && mouse_y < Y + height)
		{
			obj_UltManManagerController.fieldViewFromPlayer = self
		}
	}
	
	function DrawDragAndDrop()
	{
		for (var i = 0; i < 6; ++i) {
		    if (ds_list_find_index(playableColumns, i) = -1)
			{
				draw_set_alpha(0.25)
				draw_rectangle(obj_UltManManagerController.fieldBoxLeft, obj_UltManManagerController.fieldBoxTop + obj_UltManManagerController.fieldBoxHeight/7*(0.7+i),obj_UltManManagerController.fieldBoxRight, obj_UltManManagerController.fieldBoxTop + obj_UltManManagerController.fieldBoxHeight/7*(i+1.7), false)
				draw_set_alpha(1)
			}
		
			// Draw outline
			if (mouse_y > obj_UltManManagerController.fieldBoxTop + obj_UltManManagerController.fieldBoxHeight/7*(0.7+i) &&
				mouse_y < obj_UltManManagerController.fieldBoxTop + obj_UltManManagerController.fieldBoxHeight/7*(1.7+i))
			{
				draw_rectangle(obj_UltManManagerController.fieldBoxLeft + 2, obj_UltManManagerController.fieldBoxTop + obj_UltManManagerController.fieldBoxHeight/7*(0.7+i),obj_UltManManagerController.fieldBoxRight - 2, obj_UltManManagerController.fieldBoxTop + obj_UltManManagerController.fieldBoxHeight/7*(i+1.7), true)
				obj_UltManManagerController.toColumn = i
			}
		}
		
		
	}
	
	function PosToString()
	{
		var drawnPosition = position
		if (position = FootballPositions.SUB)
			drawnPosition = preferredPosition
		
		switch(drawnPosition)
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
						if (length > 4)
						{
							if (index = length-1)
							{
								position = FootballPositions.RWB
							}
							else if (index = 0)
							{
								position = FootballPositions.LWB
							}
							else
							{
								position = FootballPositions.CB
							}
						}
						else
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