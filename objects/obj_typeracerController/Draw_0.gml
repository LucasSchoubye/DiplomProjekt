/// Draw Event
if (keyboard_check_pressed(vk_space))
{
	question = obj_questionController.questionGenerator.GetQuestion(Subject.Maths, DanishMathSubtopic.SmallMultiplication, QuestionType.MultipleChoice)
}

scr_drawMultipleChoice(optionsMenu)