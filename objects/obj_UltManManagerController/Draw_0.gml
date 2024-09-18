/// @description Insert description here
// You can write your code in this editor

var menuX = room_width * 0.025
var menuY = room_height * 0.125
var menuTitlePaddingY = 40
var menuPaddingY = 30
var menuWidthMax = 10

draw_set_font(fn_titleLato);


// Draw title
draw_set_valign(fa_bottom)
draw_set_halign(fa_left)
draw_text(menuX, menuY - menuTitlePaddingY, clubName)
// draw_text_ext_transformed(menuX, menuY - menuTitlePaddingY, clubName, 0, 1000, 1.5, 1.5, 0)

draw_set_font(fn_textLato);

// Draw menu elements
for (var i = 0; i < ds_list_size(menuOptions); ++i) {
    
	draw_text(menuX, menuY + i*menuPaddingY, ds_list_find_value(menuOptions, i))
	var stringWidth = string_width(ds_list_find_value(menuOptions, i))
	if (menuWidthMax < stringWidth){menuWidthMax = stringWidth}
	
	// Take actions based on selected menu item
	if (mouse_y > menuY - menuPaddingY && mouse_y < menuY + menuPaddingY*(ds_list_size(menuOptions)-1)
		&& mouse_x > menuX && mouse_x < menuX+menuWidthMax*1.3)
	{
		if (i == selectedMenuOption)
		{
			draw_line(menuX, menuY + i*menuPaddingY, menuX + stringWidth, menuY + i*menuPaddingY)
		}
		if (mouse_y > menuY + (i-1)*menuPaddingY && mouse_y < menuY + (i)*menuPaddingY)
		{
			selectedMenuOption = i
		}
	}
	else
	{
		selectedMenuOption = undefined
	}
}


if (mouse_check_button_pressed(mb_left) && selectedMenuOption != undefined)
{
	switch(ds_list_find_value(menuOptions, selectedMenuOption))
	{
		case "Play Match":
			room_goto(rm_UltManMatch)
		break;
	}	
}

// draw submenu
switch(currentMenu){
	case ultManMenus.Home:
		scr_ultManHome()
		break;
	case ultManMenus.Tactics:
		scr_ultManTactics()
		break;
	case ultManMenus.Players:
		scr_ultManPlayers()
		break;
	case ultManMenus.Fixtures:
		scr_ultManFixtures()
		break;
	case ultManMenus.Transfermarket:
		scr_ultManTransferMarket()
		break;
}
