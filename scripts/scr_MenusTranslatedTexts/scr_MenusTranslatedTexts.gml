// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_MenusTranslatedTexts(text){

// Get language
var languageIndex = undefined
switch (obj_languageController.languageChosen)
{
	case Languages.Danish:
		languageIndex = 1
	break;
	case Languages.English:
		languageIndex = 0
	break;
}

	// Find translated text
	switch(text)
	{
		case "Mini Games":
			var array = [text, "Spil"]
		break;
		case "Inventory":
			var array = [text, "Inventar"]
		break;
		case "Store":
			var array = [text, "Butik"]
		break;
		case "Settings":
			var array = [text, "Indstillinger"]
		break;
		case "Quit":
			var array = [text, "Afslut"]
		break;
		case "Welcome back ":
			var array = [text, "Velkommen tilbage "]
		break;
		
		#region Shop and Items
		case "Owned":
			var array = [text, "Købt"]
		break;
		#endregion
		
		#region Login
		case "Don't have an account?   Contact your school":
			var array = [text, "Har du ikke en konto?   Kontakt din skole"]
		break;
		case "Information found here!":
			var array = [text, "Information finder du her!"]
		break;
		case "Username: ":
			var array = [text, "Brugernavn: "]
		break;
		case "Password: ":
			var array = [text, "Kodeord: "]
		break;
		case "News Title":
			var array = [text, "Titel på Nyhed"]
		break;
		case "Logging In...":
			var array = [text, "Logger på"]
		break;
		
		#endregion
		
		#region Control Hints
		case "Press 'enter'":
			var array = [text, "Tryk enter"]
		break
		case " or 'space'":
			var array = [text, " eller 'space'"]
		break
		case " to submit your answer":
			var array = [text, " for at indsende dit svar"]
		break
		case "Answer: ":
			var array = [text, "Svar: "]
		break
		#endregion
		
		#region Tutorials
		
			// General:
			case "Controls:":
				var array = [text, "Styring"]
			break;
			case "Goal:":
				var array = [text, "Formålet:"]
			break;
			case "Back":
				var array = [text, "Tilbage"]
			break;
			case "Next":
				var array = [text, "Næste"]
			break;
			case "Play":
				var array = [text, "Spil"]
			break;
			
			// Sub Menus
			case "Select Game":
				var array = [text, "Vælg Spil"]
			break;
			
			// Typeracer
			case "Typing:\nNumpad: Type the correct answer \nEnter: Submit your answer\n\nMultiple Choice:\nLeft click on your answer":
				var array = [text, "Keyboard: Skriv det rigtige svar \nEnter: Indsend dit svar"]
			break;
			
			case "Race to the finish line! Answer a question correct to get closer to the finish line! Try to avoid answering incorrect, otherwise you will move backwards!":
				var array = [text, "Ræs til målstregen! Besvar et spørgsmål rigtigt for at komme tættere på målstregen! Prøv at undgå at svare forkert, ellers går du baglæns!"]
			break;
		
			/*
			
			tutorialArray[0].controlParagraf = "Typing:\nNumpad: Type the correct answer \nEnter: Submit your answer\n\nMultiple Choice:\nLeft click on your answer"
			tutorialArray[0].goalParagraf = "Race to the finish line! Answer a question correct to get closer to the finish line! Try to avoid answering incorrect, otherwise you will move backwards!"
			
			
			*/
		
			// Fight the dungeon
			case "WASD: Movement \nShift: Sprint":
				var array = [text, "WASD: Bevægelse \nShift: Løbe"]
			break;
			case "Avoid projectiles and wait for your attack to charge up! Answering questions correct makes your attacks deal more damage! Try getting more correct in a row for even MORE DAMAGE!":
				var array = [text, "Undgå projektiler og vent på, at dit angreb oplades! At besvare spørgsmål korrekt får dine angreb til at give mere skade! Prøv at få mere korrekt i træk for endnu MERE SKADE!"]
			break;
			
			// Ultimate Manager
			case "Left Click: Move player towards mouse. \nHold Shift: Pass/Shoot the ball. \nDrag Right Click: Move teammates":
				var array = [text, "Venstre Click: Bevæg spilleren imod musen. \nHold Shift: Aflever/Skyd bolden. \nHøjre Click og Træk: Bevæg medspillere"]
			break;
			case "In the Transfermarket menu you can buy and sell players for Content Coins. Players rating are based on their tier. You can earn coins by doing well in matches!":
				var array = [text, "I Transfermarket-menuen kan du købe og sælge spillere til Content Coins. Spillernes vurdering er baseret på deres niveau. Du kan tjene mønter ved at gøre det godt i kampe!"]
			break;
			case "Mouse: Select menus":
				var array = [text, "Musen: Vælg Menu"]
			break;
			case "In the Tactics menu you can set-up your squad and formation! Players can only play certain positions. You can drag-and-drop on the field to change position!":
				var array = [text, "I taktikmenuen kan du opsætte dit hold og din formation! Spillere kan kun spille bestemte positioner. Du kan trække-og-slip på banen for at ændre position!"]
			break;
			case "In the home menu you can see how your team is doing in the league":
				var array = [text, "I oversigtsmenuen kan du se, hvordan dit hold klarer sig i ligaen"]
			break;
			case "Manage your own football club in Ultimate Manager! Buy players, chose your own position, play in-game matches and win the league!":
				var array = [text, "Administrer din egen fodboldklub i Ultimate Manager! Køb spillere, vælg din egen position, spil kampe i spillet og vind ligaen!"]
			break;
			case "When you play a match you always control the player closest to the ball. You move by clicking the mouse. You can also move team players by right-clicking them and dragging them.":
				var array = [text, "Når du spiller en kamp, kontrollerer du altid den spiller, der er tættest på bolden. Du flytter ved at klikke med musen. Du kan også flytte holdspillere ved at højreklikke på dem og trække dem."]
			break;
		#endregion
	}

	// Return
	try 
	{
		return array[languageIndex]
	}
	catch(err)
	{
		show_debug_message(err)
		return text
	}

}

/*

tutorialArray[0].controlParagraf = "WASD: Movement \nShift: Sprint"
			tutorialArray[0].goalParagraf = "Avoid projectiles and wait for your attack to charge up! Answering questions correct makes your attacks deal more damage! Try getting more correct in a row for even MORE DAMAGE!"
