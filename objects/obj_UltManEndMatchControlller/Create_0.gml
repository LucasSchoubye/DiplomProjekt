/// @description Set Variables

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
	ds_list_add(recapList, "Match won: +"+string(winReward)+" Content Coins")
	totalReward += winReward
}
else if (scoreline[0] < scoreline[1])
{
	ds_list_add(recapList, "Match lost: +"+string(lostReward)+" Content Coins")
	totalReward += lostReward
}
else
{
	ds_list_add(recapList, "Match drawn: +"+string(drawReward)+" Content Coins")
	totalReward += drawReward
}

if (scoreline[1] = 0)
{
	ds_list_add(recapList, "Clean Sheet: +"+string(cleanSheetReward)+" Content Coins")
	totalReward += cleanSheetReward
}
if (scoreline[0] > 0)
{
	ds_list_add(recapList, "Goal Bonus X"+string(scoreline[0])+": +"+string(scoreline[0]*goalReward)+" Content Coins")
	totalReward += scoreline[0]*goalReward
}


// Functions
function GetReward()
{
	var playerGoals = scoreline[0]
	var opponentGoals = scoreline[1]
	
	if (playerGoals > opponentGoals)
		// Win
		obj_storeController.balance += winReward
	else if (playerGoals < opponentGoals)
		// Lose
		obj_storeController.balance += lostReward
	else
		// Draw
		obj_storeController.balance += drawReward
	
	// Goal and clean sheet rewards
	obj_storeController.balance += (goalReward * playerGoals)
	if(opponentGoals = 0)
	{
		obj_storeController.balance += cleanSheetReward
	}
	
	// Exit the room
	obj_UltManManagerController.halftimeCompleted = false
	obj_UltManManagerController.SimulateLeague(playerGoals, opponentGoals)
	obj_firestore_controller.UpdateBalance()
	room_goto(rm_UltManOverview)
}