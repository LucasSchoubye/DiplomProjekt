/// Setup variables for typeracer

global.typeracerPlacement = 1

cursor_sprite = spr_typeracerCursor
window_set_cursor(cr_none)
questionGenerator = new QuestionGenerator(Curriculum.Danish)
question = undefined
typingString = ""
questionType = QuestionType.Typing
optionsMenu = new OptionsMenu()
audio_play_sound(sou_TyperacerBgMusic,1,true)
question = obj_questionController.questionGenerator.GetQuestion(Subject.Maths, QuestionType.Typing)

function AnsweredCorrect()
{
	obj_typeracerCar.AnsweredCorrect()
}

function AnsweredIncorrect()
{
	obj_typeracerCar.AnsweredIncorrect()
}