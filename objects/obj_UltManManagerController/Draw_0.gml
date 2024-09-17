/// @description Insert description here
// You can write your code in this editor

var menuX = 100
var menuY = 200
var menuTitlePaddingY = 70
var menuPaddingY = 30
var menuWidthMax = 10



// Draw title
draw_set_valign(fa_bottom)
draw_set_halign(fa_left)
draw_text_ext_transformed(menuX, menuY - menuTitlePaddingY, clubName, 0, 1000, 1.5, 1.5, 0)

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