// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_ultManTactics(halftimeActive = false){
	
	var currentFont = draw_get_font()
	var currentHAlign = draw_get_halign()
	var currentVAlign = draw_get_valign()
	
	// Draw Field Box
	fieldBoxTop = room_height * 0.12;
	fieldBoxBottom = room_height * 0.90;
	fieldBoxLeft = room_width * 0.22;
	fieldBoxRight = room_width * 0.68;
	fieldBoxMid = (fieldBoxLeft + fieldBoxRight)/2
	
	fieldBoxHeight = (fieldBoxBottom - fieldBoxTop)
	SubBoxHeight = (room_height - fieldBoxBottom)
	fieldBoxWidth = (fieldBoxRight - fieldBoxLeft)
	
	draw_sprite_ext(spr_UltManField, 0, fieldBoxLeft, fieldBoxTop, (fieldBoxRight-fieldBoxLeft)/sprite_get_width(spr_UltManField), (fieldBoxBottom-fieldBoxTop)/sprite_get_height(spr_UltManField), 0, c_white, 1)
	draw_rectangle(fieldBoxLeft, fieldBoxTop, fieldBoxRight, fieldBoxBottom, true)
	
	// Draw formation
	#region Formation
	for (var column = 0; column < array_length(formationColumns); ++column) {
		for (var i = 0; i < ds_list_size(formationColumns[column]); ++i) {
		    // 
			ds_list_find_value(formationColumns[column], i).DrawPlayer(fieldBoxLeft + fieldBoxWidth/(ds_list_size(formationColumns[column])+1)*(i+1), fieldBoxTop+(fieldBoxHeight/7)*(column+1))
		}
	}
	
	// Drop selected player
	if (mouse_check_button_released(mb_left))
	{
		var fromColumn = undefined
		
		// Find player
		for (var column = 0; column < array_length(formationColumns); ++column) {
			for (var i = 0; i < ds_list_size(formationColumns[column]); ++i) {
			    
				if (ds_list_find_index(formationColumns[column], fieldViewFromPlayer) != -1)
				{
					fromColumn = column
				}
			}
		}
		
		MovePlayerColumn(fromColumn, toColumn)
	}
	
	if (fieldViewFromPlayer != undefined)
	{
		fieldViewFromPlayer.DrawDragAndDrop()
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
	#endregion 
	
	// Draw Player Box
	scr_UltManTacticPlayerBox(halftimeActive)
	
	draw_set_halign(currentHAlign)
	draw_set_valign(currentVAlign)
	draw_set_font(currentFont)
}

function GetColorFromPos(pos)
{
	switch(pos)
			{
			case FootballPositions.ST:
			case FootballPositions.RW:
			case FootballPositions.LW:
				return #7B00E7
				
			case FootballPositions.CAM:
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
				return c_dkgray
		}
}

function ResetStartingSquadOrder()
{
	// Remove the starting 11 from squad list
	for (var i = 0; i < 11; ++i) {
	    // code here
		ds_list_delete(squad, 0)
	}
	
	// insert 11 from column data structure
	for (var column = 0; column < 6; ++column) {
	    for (var i = 0; i < ds_list_size(formationColumns[column]); ++i) {
		    ds_list_insert(squad, 0, ds_list_find_value(formationColumns[column], i))
		}
	}
}