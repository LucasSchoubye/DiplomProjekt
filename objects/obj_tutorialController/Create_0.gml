/// @description Setup variables
function tutorialStruct() constructor
{
	title = "title"
	controlParagraf = "WASD: Bro"
	goalParagraf = "Try to win"
	roomRef = rm_typeracer
	gif = spr_TutorialFtDGif
}

// Load gamedata
gameAmount = 3
CombinedTutorialArray = []
tutorialScreens = 1
currentTutorialScreen = 1
tutorialArray = []
    
	switch(obj_firestore_controller.playedGameTitle)
	{
		case "Typeracer":
			tutorialArray[0] = new tutorialStruct();
		
			tutorialArray[0].title = "Typeracer"
			tutorialArray[0].controlParagraf = "Typing:\nNumpad: Type the correct answer \nEnter or Space: Submit your answer\n\nMultiple Choice:\nMouse: Left click on your answer"
			tutorialArray[0].goalParagraf = "Race to the finish line! Answer a question correct to get closer to the finish line! Try to avoid answering incorrect, otherwise you will move backwards!"
			tutorialArray[0].roomRef = rm_typeracer
			tutorialArray[0].gif = spr_tutorialTyperacer
		break;
		
		case "Ultimate Manager":
			tutorialScreens = 5
			tutorialArray = [new tutorialStruct(), new tutorialStruct(), new tutorialStruct(), new tutorialStruct(), new tutorialStruct()]
			
			// Main 
			tutorialArray[0].title = "Ultimate Manager"
			tutorialArray[0].controlParagraf = "Left Click: Move player towards mouse. \nHold Shift: Pass/Shoot the ball. \nDrag Right Click: Move teammates"
			tutorialArray[0].goalParagraf = "Manage your own football club in Ultimate Manager! Buy players, chose your own position, play in-game matches and win the league!"
			tutorialArray[0].roomRef = rm_UltManOverview
			tutorialArray[0].gif = spr_tutorialUltManMatchGif
			
			// Home 
			tutorialArray[1].title = "Ultimate Manager"
			tutorialArray[1].controlParagraf = "Mouse: Select menus"
			tutorialArray[1].goalParagraf = "In the home menu you can see how your team is doing in the league"
			tutorialArray[1].gif = spr_tutorialUltManHome
		
			// Tactics
			tutorialArray[2].title = "Ultimate Manager"
			tutorialArray[2].controlParagraf = "Mouse: Select menus"
			tutorialArray[2].goalParagraf = "In the Tactics menu you can set-up your squad and formation! Players can only play certain positions. You can drag-and-drop on the field to change position!"
			tutorialArray[2].gif = spr_tutorialUltManTacticsGif
		
			// Transfermarket
			tutorialArray[3].title = "Ultimate Manager"
			tutorialArray[3].controlParagraf = "Mouse: Select menus"
			tutorialArray[3].goalParagraf = "In the Transfermarket menu you can buy and sell players for Content Coins. Players rating are based on their tier. You can earn coins by doing well in matches!"
			tutorialArray[3].gif = spr_tutorialUltManTransfermarket
		
			// Matches 
			tutorialArray[4].title = "Ultimate Manager"
			tutorialArray[4].controlParagraf = "Left Click: Move player towards mouse. \nHold Shift: Pass/Shoot the ball. \nDrag Right Click: Move teammates"
			tutorialArray[4].goalParagraf = "When you play a match you always control the player closest to the ball. You move by clicking the mouse. You can also move team players by right-clicking them and dragging them."
			tutorialArray[4].gif = spr_tutorialUltManMatchGif
		
			tutorialArray[4].roomRef = rm_UltManOverview
		break;
		
		case "Fight the Dungeon":
			tutorialArray[0] = new tutorialStruct();
			tutorialArray[0].title = "Fight the Dungeon"
			tutorialArray[0].controlParagraf = "WASD: Movement \nShift: Sprint"
			tutorialArray[0].goalParagraf = "Avoid projectiles and wait for your attack to charge up! Answering questions correct makes your attacks deal more damage! Try getting more correct in a row for even MORE DAMAGE!"
			tutorialArray[0].roomRef = rm_FtDLoadoutMenu
		break;
	}


// Set gamedata to correct game
textStruct = tutorialArray[0]