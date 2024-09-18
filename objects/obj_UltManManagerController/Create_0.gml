/// @description Setup Menu and variables

enum FootballPositions 
{
	GK,
	CB,
	LB,
	RB,
	LWB,
	RWB,
	CM,
	CDM,
	CAM,
	LM,
	RM,
	LW,
	RW,
	ST
}

// Variables
clubName = "Arseanal FC"
menuOptions = ds_list_create()
selectedMenuOption = 0

// Populate menu options
ds_list_add(menuOptions, "Play Match")
ds_list_add(menuOptions, "Home")
ds_list_add(menuOptions, "Tactics")
ds_list_add(menuOptions, "Players")
ds_list_add(menuOptions, "Fixtures")
ds_list_add(menuOptions, "Transfermarket")