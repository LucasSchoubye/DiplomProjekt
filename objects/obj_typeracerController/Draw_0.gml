/// Draw Event
if (keyboard_check_pressed(vk_space))
{
	question = questionGenerator.GetQuestion(Subject.Maths, DanishMathSubtopic.SmallMultiplication, QuestionType.MultipleChoice)
}

scr_drawMultipleChoice(optionsMenu)