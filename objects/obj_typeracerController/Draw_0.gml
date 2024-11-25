/// Draw Event

currentFont = draw_get_font()
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
draw_set_font(fn_ArialBlack12)
switch(question.questionType)
{
	case "MultipleChoice":
		scr_drawMultipleChoice(optionsMenu, id)
	break;
	
	case "Typing":
		scr_drawTyping(optionsMenu, id)
	break;
}
draw_set_font(currentFont)
