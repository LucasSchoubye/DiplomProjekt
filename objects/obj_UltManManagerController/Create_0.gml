/// @description Setup Menu and variables
enum ultManMenus{
	Home,
	Tactics,
	Fixtures,
	Transfermarket
}

UltManTeams()

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
// This variable is used in the transfermarket to determine if a user wants to sell a player
showSellPopup = false; 
// This variable is used in the transfermarket if the user is trying to sell a player in the active team
showCannotSellPopup = false
// This variable is used in the transfermarket if the user is trying to buy a pack but they meet insufficient requirements
showPopupCannotBuyPack = false

// Populate menu options
ds_list_add(menuOptions, "Home")
ds_list_add(menuOptions, "Tactics")
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

for (var i = 0; i < 4; ++i) {
    ds_list_add(squad, new UltManPlayer())
}

packs = ds_list_create();
ds_list_add(packs, new UltManPack(UltManPackTier.Bronze));
ds_list_add(packs, new UltManPack(UltManPackTier.Silver));
ds_list_add(packs, new UltManPack(UltManPackTier.Gold));
ds_list_add(packs, new UltManPack(UltManPackTier.Ruby));
ds_list_add(packs, new UltManPack(UltManPackTier.Obsidian));
ds_list_add(packs, new UltManPack(UltManPackTier.Legendary));