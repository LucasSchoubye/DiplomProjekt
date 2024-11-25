/// @description Set Variables

window_set_cursor(cr_none)
cursor_sprite = spr_UltManCursor
var LC = obj_languageController

// End looping sound
audio_stop_sound(sou_UltManCheer)

recapList = ds_list_create()
scoreline = obj_UltManManagerController.lastScoreline
totalReward = 0

// Rewards
winReward = 20
drawReward = 10
lostReward = 5
cleanSheetReward = 10
goalReward = 5

// Result text
if (scoreline[0] > scoreline[1])
{
	ds_list_add(recapList, LC.translate("Match won: +")+string(winReward)+" Content Coins")
	totalReward += winReward
}
else if (scoreline[0] < scoreline[1])
{
	ds_list_add(recapList, LC.translate("Match lost: +")+string(lostReward)+" Content Coins")
	totalReward += lostReward
}
else
{
	ds_list_add(recapList, LC.translate("Match drawn: +")+string(drawReward)+" Content Coins")
	totalReward += drawReward
}

if (scoreline[1] = 0)
{
	ds_list_add(recapList, LC.translate("Clean Sheet: +")+string(cleanSheetReward)+" Content Coins")
	totalReward += cleanSheetReward
}
if (scoreline[0] > 0)
{
	ds_list_add(recapList, LC.translate("Goal Bonus X")+string(scoreline[0])+": +"+string(scoreline[0]*goalReward)+" Content Coins")
	totalReward += scoreline[0]*goalReward
}


// Functions
function GetReward()
{
	var playerGoals = scoreline[0]
	var opponentGoals = scoreline[1]
	
	obj_storeController.balance += totalReward
	
	// Exit the room
	obj_UltManManagerController.halftimeCompleted = false
	obj_UltManManagerController.playerClub.goalsScored += playerGoals
	obj_UltManManagerController.playerClub.goalsConceded += opponentGoals
	obj_UltManManagerController.SimulateLeague(playerGoals, opponentGoals)
	obj_firestore_controller.UpdateBalance()
	room_goto(rm_UltManOverview)
}