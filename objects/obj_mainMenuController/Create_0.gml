// Setup variables

options = ds_list_create()
ds_list_add(options, "Store")
ds_list_add(options, "Settings")
ds_list_add(options, "Quit")

selectedOption = 0;

function AddAllowedGames(gameName)
{
	ds_list_add(options,"Play "+gameName)
	
	ds_list_sort(options, true)
}