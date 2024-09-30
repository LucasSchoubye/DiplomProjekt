/// @description Setup Menu and variables
enum ultManMenus{
	Home,
	Tactics,
	Players,
	Fixtures,
	Transfermarket
}

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
	ST,
	SUB
}

enum FormationColumns
{
	Attackers, 
	OffensiveMidfield,
	Midfield,
	DefensiveMidfielder,
	Defense,
	Goalkeeper
}

// Variables
clubName = "Arsenal FC"
menuOptions = ds_list_create()
selectedMenuOption = 0
currentMenu = ultManMenus.Home

// Populate menu options
ds_list_add(menuOptions, "Home")
ds_list_add(menuOptions, "Tactics")
ds_list_add(menuOptions, "Players")
ds_list_add(menuOptions, "Fixtures")
ds_list_add(menuOptions, "Transfermarket")

// TacticsLogic
fromPlayer = undefined
fieldViewFromPlayer = undefined
toColumn = undefined

// Gameplay
teamformation = TeamFormations.FourFourTwo
formationColumns = [ds_list_create(), ds_list_create(), ds_list_create(), ds_list_create(), ds_list_create(), ds_list_create()]
squad = ds_list_create()

// Test Players
scr_UltManTestTeamArsenal()

for (var i = 0; i < 15; ++i) {
    ds_list_add(squad, new UltManPlayer())
}
