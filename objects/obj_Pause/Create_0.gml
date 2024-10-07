/// @description Insert description here
// You can write your code in this editor

question = obj_questionController.questionGenerator.GetQuestion(Subject.Maths, QuestionType.Typing)
typingString = ""
optionsMenu = new OptionsMenu()
questionMenuActive = false
questionType = QuestionType.MultipleChoice
questionMenuClickCooldown = true
depth = -room_height

layerID = layer_get_id("Backgrounds_2")
back = layer_background_get_id(layerID);	
layer_background_visible(back,false)

function AnsweredCorrect() {
	show_message("NICE COCK")
}

function AnsweredIncorrect() {
	show_message("Nah man")
}