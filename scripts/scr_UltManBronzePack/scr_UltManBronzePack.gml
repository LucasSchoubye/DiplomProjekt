// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_UltManBronzePack(){
	
	var player = new UltManPlayer()
	
	// Non-Gameplay
	player.nationality = scr_UltManRandomNationality()
	player.name = scr_UltManRandomName(player.nationality)
	
	// Gameplay
	player.preferredPosition = scr_UltManRandomPosition
	scr_UltManGenerateStats()
	

}