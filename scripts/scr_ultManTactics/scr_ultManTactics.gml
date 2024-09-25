// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_ultManTactics(){
	
	// Draw Field Box
	var fieldBoxTop = room_height * 0.12;
	var fieldBoxBottom = room_height * 0.90;
	var fieldBoxLeft = room_width * 0.22;
	var fieldBoxRight = room_width * 0.68;
	var fieldBoxMid = (fieldBoxLeft + fieldBoxRight)/2
	
	var fieldBoxHeight = (fieldBoxBottom - fieldBoxTop)
	var SubBoxHeight = (room_height - fieldBoxBottom)
	var fieldBoxWidth = (fieldBoxRight - fieldBoxLeft)
	
	draw_sprite_ext(spr_UltManField, 0, fieldBoxLeft, fieldBoxTop, (fieldBoxRight-fieldBoxLeft)/sprite_get_width(spr_UltManField), (fieldBoxBottom-fieldBoxTop)/sprite_get_height(spr_UltManField), 0, c_white, 1)
	draw_rectangle(fieldBoxLeft, fieldBoxTop, fieldBoxRight, fieldBoxBottom, true)
	
	// Draw formation
	for (var column = 0; column < array_length(formationColumns); ++column) {
		for (var i = 0; i < ds_list_size(formationColumns[column]); ++i) {
		    // 
			ds_list_find_value(formationColumns[column], i).DrawPlayer(fieldBoxLeft + fieldBoxWidth/(ds_list_size(formationColumns[column])+1)*(i+1), fieldBoxTop+(fieldBoxHeight/7)*(column+1))
		}
	}
	
	// Draw Subs
	var row = 0.5
	var placement = 0
	for (var i = 11; i < 11+6; ++i) {
		if (ds_list_size(squad) > i)
		{
			ds_list_find_value(squad, i).DrawPlayer(fieldBoxLeft - 35 + ((fieldBoxWidth+35*2)/7)*(placement+1), fieldBoxBottom + (SubBoxHeight/3)*(row), GetColorFromPos(ds_list_find_value(squad, i).position))
			placement++
		}
	}
	
	// Draw Player Box
	scr_UltManTacticPlayerBox()
	
	
	
}

function GetColorFromPos(pos)
{
	switch(pos)
			{
			case FootballPositions.ST:
			case FootballPositions.RW:
			case FootballPositions.CAM:
			case FootballPositions.LW:
				return #7B00E7
				
			case FootballPositions.RM:
			case FootballPositions.LM:
			case FootballPositions.CM:
			case FootballPositions.CDM:
				return #FFBB00
				
			case FootballPositions.CB:
			case FootballPositions.LB:
			case FootballPositions.RB:
			case FootballPositions.RWB:
			case FootballPositions.LWB:
				return #0039E3
				
			case FootballPositions.GK:
				return #1ED001
				
			default:
				return c_ltgray
		}
}