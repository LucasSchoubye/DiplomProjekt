/// @description Insert description here
// You can write your code in this editor

var menuX = room_width * 0.0225
var menuY = room_height * 0.15
var menuClubNameX = room_width * 0.0225
var menuClubNameY = room_height * 0.0225
var menuTitlePaddingY = 40
var menuPaddingY = 50
var menuDividerPadding = (menuPaddingY - string_height("I")) / 2
var menuDividerLeft = room_width * 0.0125
var menuDividerRight = room_width * 0.1875
var menuWidthMax = 50
var clickAbleMenuPaddingY = 50

// Button position and size
var buttonX = room_width * 0.85
var buttonY = room_height * 0.035
var buttonWidth = room_width * 0.9925
var buttonHeight = room_height * 0.0965
var buttonText = "Play Match"
var titleHeight = (string_height(clubName) / 2)

draw_set_font(fn_titleLato);

// Draw clubname
draw_set_valign(fa_top)
draw_set_halign(fa_left)
draw_text(menuClubNameX, menuClubNameY, clubName)

draw_set_font(fn_sideBarOptionsRoboto);
draw_set_valign(fa_bottom)

// Draw menu elements
for (var i = 0; i < ds_list_size(menuOptions); ++i) {
    
	draw_text(menuX, menuY + i*menuPaddingY, ds_list_find_value(menuOptions, i))
	var stringWidth = string_width(ds_list_find_value(menuOptions, i))
	if (menuWidthMax < stringWidth){menuWidthMax = stringWidth}
	
	if( ds_list_find_value(menuOptions, i) = "Fixtures" ){
		draw_set_alpha(0.3)
		draw_line(menuDividerLeft, menuY + ((i-1)*menuPaddingY)+menuDividerPadding,
		menuDividerRight,menuY + ((i-1)*menuPaddingY)+menuDividerPadding)
		draw_line(menuDividerLeft, menuY + ((i)*menuPaddingY)+menuDividerPadding,
		menuDividerRight,menuY + ((i)*menuPaddingY)+menuDividerPadding)
		draw_set_alpha(1)
	}
	
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


// Sets button colour and draws button
draw_set_color(#3B95FF)
if (scr_drawButton(buttonX, buttonY - titleHeight,buttonWidth, buttonHeight - titleHeight, buttonText ))
{
	room_goto(rm_UltManMatch)
}

draw_set_color(#ffffff)

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
