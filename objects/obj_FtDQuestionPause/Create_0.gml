/// @description Insert description here
// You can write your code in this editor

question = obj_questionController.questionGenerator.GetQuestion(Subject.Maths, QuestionType.MultipleChoice)
typingString = ""
optionsMenu = new OptionsMenu()
questionMenuActive = false
questionType = QuestionType.MultipleChoice
questionMenuClickCooldown = true
correctAnswers = 0
answeredQuestions = 0
dodgeTime = 10
depth = -7000
currentFont = draw_get_font()

layerID = layer_get_id("Backgrounds_2")
back = layer_background_get_id(layerID);	
layer_background_visible(back,false)

function AnsweredCorrect() {
	correctAnswers += 1
	answeredQuestions += 1
	
	audio_play_sound(sou_FtDCorrect, 2, false, 1, 0, 1 + correctAnswers*0.15)
	
}

function AnsweredIncorrect() {
	answeredQuestions += 1
	audio_play_sound(sou_FtDSmallDamage, 2, false, 1, 0, 1 + correctAnswers*0.15)
}