// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_drawTyping(optionsMenu, controllerId)
{

var top = optionsMenu.top
var screenMidX = optionsMenu.screenMidX
var screenMidY = optionsMenu.screenMidY

var answerBoxTop = optionsMenu.answerBoxTop
var answerBoxBot = optionsMenu.answerBoxBot
var answerBoxLeft = optionsMenu.answerBoxLeft
var answerBoxRight = optionsMenu.answerBoxRight
var answerBoxMidY = optionsMenu.answerBoxMidY
var answerBoxMidThirdY = optionsMenu.answerBoxMidThirdY
var answerBoxQuarterX = optionsMenu.answerBoxQuarterX
var promptBoxHeight = optionsMenu.promptBoxHeight
var promptBoxMid = optionsMenu.promptBoxMid
var twoOptionsX = optionsMenu.twoOptionsX
var twoOptionsY = optionsMenu.twoOptionsY
var fourOptionsX = optionsMenu.fourOptionsX
var threeOptionsY = optionsMenu.threeOptionsY

	var optionSelected = undefined

	// Mouse Collisions
	var mouseWithinAnswerBox = false
	if (mouse_x > answerBoxLeft && mouse_x < answerBoxRight &&
		mouse_y > answerBoxTop && mouse_y < answerBoxBot)
	{
		mouseWithinAnswerBox = true
	}


	if (question != undefined)
	{
		draw_set_color(c_white)
		draw_set_alpha(0.5)
		draw_roundrect(answerBoxLeft,answerBoxTop-promptBoxHeight,answerBoxRight,answerBoxBot,false)
		draw_set_alpha(1)
		
		draw_set_color(c_black)
		draw_roundrect(answerBoxLeft,answerBoxTop-promptBoxHeight,answerBoxRight,answerBoxBot,true)
		draw_roundrect(answerBoxLeft,answerBoxTop-promptBoxHeight,answerBoxRight,answerBoxTop,true)
	
		// Drawing prompt text
		draw_set_color(c_black)
		draw_set_halign(fa_center)
		draw_text(screenMidX,promptBoxMid,question.prompt)
		
	}
	
	// Draw typing string
	draw_set_halign(fa_center)
	
	draw_text(screenMidX,answerBoxMidY,"Answer: "+typingString)
	if (keyboard_check_pressed(vk_anykey))
	{
		if (charIsValid() and !keyboard_check_pressed(vk_shift))
			typingString = typingString + keyboard_lastchar
		if (keyboard_check_pressed(vk_backspace))
			typingString = string_delete(typingString, string_length(typingString), 1)
	}
	controllerId.typingString = typingString

	draw_set_color(c_white)

	// Answer and send to firebase
	obj_firestore_controller.answerTimer++
	if (keyboard_check_pressed(vk_space) or keyboard_check_pressed(vk_enter))
	{
		if (typingString = round(real(question.options[question.answerIndex])))
		{
			// Correct
			obj_firestore_controller.SendAnswer(question.prompt, typingString, question.options[question.answerIndex], question.subject, question.subtopic, question.questionType, obj_firestore_controller.answerTimer/60)
			obj_firestore_controller.answerTimer = 0
			obj_typeracerCar.AnsweredCorrect()
		}
		else
		{
			obj_typeracerCar.AnsweredIncorrect()
		}
		question = obj_questionController.questionGenerator.GetQuestion(Subject.Maths, controllerId.questionType)
		typingString = ""
	}
	
	function charIsValid() {
	    var key_pressed = keyboard_lastchar;

		if(keyboard_check_pressed(vk_shift) or 
			keyboard_check_pressed(vk_up) or
			keyboard_check_pressed(vk_down) or
			keyboard_check_pressed(vk_tab))
			return false

	    // Check if the key pressed is a letter or a number
	    if ((key_pressed >= "0" && key_pressed <= "9")) {
	        return true;
	    } else {
	        return false;
	    }
	}
}