/// Draw Event
if (keyboard_check_pressed(vk_space))
{
	question = questionGenerator.GetQuestion(Subject.Maths, DanishMathSubtopic.SmallMultiplication, QuestionType.MultipleChoice)
}

optionSelected = undefined

scr_drawMultipleChoice(optionsMenu)