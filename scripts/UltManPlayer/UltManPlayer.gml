// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function UltManPlayer(playerTier = UltManPackTier.Bronze) constructor {
	
	// Generel Information
	name = scr_UltManRandomName()
	number = irandom_range(1,99)
	age = irandom_range(15,30)
	nationality = Nationality.DK
	height = irandom_range(160,210)

	// Tactics
	position = FootballPositions.SUB
	preferredPosition = FootballPositions.ST
	playableColumns = ds_list_create()
	condition = 95
	scr_UltManRandomPosition(self)
	
	// Rating
	overallRating = 45
	topSpd = 300
	topShootSpd = 2000
	topPassSpd = 2000
	shooting = 200
	passing = 200
	strength = 300
	defence = 200
	dribbling = 200
	tier = playerTier
	scr_UltManGeneratePlayerStats(self, position, playerTier)
	
	// Drawing animation
	curX = room_width/2
	curY = room_height/2
	
	function DrawPlayer(X,Y, color = #43C44A)
	{
		var width = 90
		var height = 30
		
		curX += (X - curX)/5
		curY += (Y - curY)/5
		
		// Outline
		draw_set_color(color)
		draw_roundrect(curX-width/2, curY, curX+width/2, curY+height, false)
		draw_set_color(c_white)
		draw_roundrect(curX-width/2, curY, curX+width/2, curY+height, true)
		
		// Text
		draw_set_font(fn_textLato)
		draw_set_halign(fa_center)
		draw_set_valign(fa_middle)
		scr_drawOutlineText(curX,curY+height*1.5,c_black,c_white,name[1])
		//draw_text(curX,curY+height*1.5,name[1])
		draw_text(curX,curY+height*0.5,PosToString())
		draw_set_color(c_white)
		
		// Action
		if (mouse_check_button_pressed(mb_left) && mouse_x > X - width/2 && mouse_x < X + width/2 &&
			mouse_y > Y && mouse_y < Y + height &&
			position != FootballPositions.SUB)
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
	
	function CalculateRating(variableName)
	{
		switch(variableName)
		{
			case "topSpd":
				var highestPossible = 550*1.3
				return round(25 + (topSpd/highestPossible)*75)
			break;
			case "topShootSpd":
				var highestPossible = 4500*1.7
				return round(25 + (topShootSpd/highestPossible)*75)
			break;
			case "topPassSpd":
				var highestPossible = 4500*1.4
				return round(25 + (topPassSpd/highestPossible)*75)
			break;
			case "passing":
				var minScore = 100*0.8
			    var maxScore = 700 * 1.3;
			    return round(25 + ((maxScore - passing) / (maxScore - minScore)) * 75)
			break;
			case "shooting":
				var minScore = 100;
			    var maxScore = 700 * 1.3;
			    return round(25 + ((maxScore - shooting) / (maxScore - minScore)) * 75)
			break;
			case "strength":
				var highestPossible = 600*1.7
				return round(25 + (strength/highestPossible)*75)
			break;
			case "defence":
				var highestPossible = 1000*1.7
				return round(25 + (defence/highestPossible)*75)
			break;
			case "dribbling":
				var highestPossible = 1000*1.5
				return round(25 + (dribbling/highestPossible)*75)
			break;
		
			// Overall rating
			case "overallRating":
				show_message(CalculateRating("topSpd"))
				return round((CalculateRating("topSpd") + CalculateRating("topShootSpd") + CalculateRating("topPassSpd") + CalculateRating("passing") + CalculateRating("shooting") + CalculateRating("strength") + CalculateRating("defence") + CalculateRating("dribbling"))/8)
			break;			
		}
	}
	
	overallRating = CalculateRating("overallRating")
}