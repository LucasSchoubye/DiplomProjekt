/// Setup variables for typeracer

global.typeracerPlacement = 1

answerTime = 0;
answerTimeList = ds_list_create();
totalAnswerTime = 0;
averageAnswerTime = 0;
cursor_sprite = spr_typeracerCursor
window_set_cursor(cr_none)
blink_time = 0;
blink_length = 30;
blink_alpha = 0.25;
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
	ds_list_add(answerTimeList,answerTime)
	answerTime = 0;
}

function AnsweredIncorrect()
{
	obj_typeracerCar.AnsweredIncorrect()
	if (obj_typeracerCar.pos != 0) {
		answerTime += 60
	}
}