/// @description 

enum Languages 
{
	Danish,
	English
}

enum Games 
{
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
	}
}