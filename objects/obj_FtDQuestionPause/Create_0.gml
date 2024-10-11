/// @description Insert description here
// You can write your code in this editor

question = obj_questionController.questionGenerator.GetQuestion(Subject.Maths, QuestionType.Typing)
typingString = ""
optionsMenu = new OptionsMenu()
questionMenuActive = false
questionType = QuestionType.MultipleChoice
questionMenuClickCooldown = true
correctAnswers = 0
answeredQuestions = 0
dodgeTime = 15
depth = -7000

layerID = layer_get_id("Backgrounds_2")
back = layer_background_get_id(layerID);	
layer_background_visible(back,false)

function AnsweredCorrect() {
	correctAnswers += 1
	answeredQuestions += 1
	
}

function AnsweredIncorrect() {
	answeredQuestions += 1
}