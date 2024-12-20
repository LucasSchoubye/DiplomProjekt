/// @description 

enum Languages 
{
	Danish,
	English
}

enum Games 
{
	Menus,
	UltimateManager,
	FightTheDungeon,
	TypeRacer
}

languageChosen = Languages.Danish
gameChosen = Games.UltimateManager

function translate(text, game = gameChosen) 
{
	switch(game)
	{
		case Games.UltimateManager:
			return scr_UltimateManagerTranslatedTexts(text)
			
		case Games.FightTheDungeon:
			return scr_FightTheDungeonTranslatedTexts(text)
			
		case Games.Menus:
			return scr_MenusTranslatedTexts(text)
	}
}

function getLanguageString()
{
	switch(languageChosen)
	{
		case Languages.English:
			return "English";
		
		case Languages.Danish:
			return "Dansk";
	}
}