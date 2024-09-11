/// Draw Event


if (keyboard_check_pressed(vk_tab))
{
	if (questionType = QuestionType.MultipleChoice)
	{
		questionType = QuestionType.Typing
	}
	else
	{
		questionType = QuestionType.MultipleChoice
	}
}

switch(question.questionType)
{
	case "MultipleChoice":
		scr_drawMultipleChoice(optionsMenu, id)
	break;
	
	case "Typing":
		scr_drawTyping(optionsMenu, id)
	break;
}
