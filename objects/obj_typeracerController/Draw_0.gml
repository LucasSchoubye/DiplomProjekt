/// Draw Event


switch(question.questionType)
{
	case "MultipleChoice":
		scr_drawMultipleChoice(optionsMenu)
	break;
	
	case "Typing":
		scr_drawTyping(optionsMenu, id)
	break;
}
