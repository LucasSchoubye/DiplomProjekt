/// @description Setup Menu and variables
enum ultManMenus{
	Home,
	Tactics,
	Fixtures,
	Transfermarket
}



// Variables
clubName = "Arsenal FC"
menuOptions = ds_list_create()
selectedMenuOption = 0
currentMenu = ultManMenus.Home

// Populate menu options

ds_list_add(menuOptions, "Home")
ds_list_add(menuOptions, "Tactics")
ds_list_add(menuOptions, "Fixtures")
ds_list_add(menuOptions, "Transfermarket")