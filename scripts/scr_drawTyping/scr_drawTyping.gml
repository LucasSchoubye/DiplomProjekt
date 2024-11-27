// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_drawTyping(optionsMenu, controllerId)
{

draw_set_font(fn_konk12)
var typingDefaultFont = draw_get_font()
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
var LC = obj_languageController

var controlTextL = LC.translate("Press 'enter'",Games.Menus)
var controlTextM = LC.translate(" or 'space'",Games.Menus)
var controlTextR = LC.translate(" to submit your answer",Games.Menus)

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
		draw_set_alpha(0.85)
		draw_roundrect(answerBoxLeft,answerBoxTop-promptBoxHeight,answerBoxRight,answerBoxBot,false)
		draw_set_alpha(1)
		
		draw_set_color(c_black)
		draw_roundrect(answerBoxLeft,answerBoxTop-promptBoxHeight,answerBoxRight,answerBoxBot,true)
		draw_roundrect(answerBoxLeft,answerBoxTop-promptBoxHeight,answerBoxRight,answerBoxTop,true)
	
		// Drawing prompt text
		draw_set_color(c_black)
		draw_set_halign(fa_center)
		draw_text(screenMidX,promptBoxMid,question.prompt)
		
		// Control text
		draw_set_font(fn_konk10)
		draw_set_halign(fa_left)
		draw_text(answerBoxLeft+room_width*0.01,answerBoxBot-room_height*0.02, controlTextL)
		draw_sprite(spr_enter,0,answerBoxLeft+room_width*0.01+string_width(controlTextL),answerBoxBot-room_height*0.02)
		draw_text(answerBoxLeft+room_width*0.01+string_width(controlTextL)+20,answerBoxBot-room_height*0.02,controlTextM)
		draw_sprite(spr_space,0,answerBoxLeft+room_width*0.01+string_width(controlTextL)+20+string_width(controlTextM),answerBoxBot-room_height*0.02)
		draw_text(answerBoxLeft+room_width*0.01+string_width(controlTextL)+20+string_width(controlTextM)+60,answerBoxBot-room_height*0.02,controlTextR)
		draw_set_font(typingDefaultFont)
		draw_set_halign(fa_center)
		
	}
	
	// Draw typing string
	draw_set_halign(fa_center)
	
	draw_text(screenMidX,answerBoxMidY,LC.translate("Answer: ",Games.Menus)+typingString)
	if (keyboard_check_pressed(vk_anykey))
	{
		if (charIsValid() and !keyboard_check_pressed(vk_shift))
			typingString = typingString + keyboard_lastchar
		if (keyboard_check_pressed(vk_backspace))
			typingString = string_delete(typingString, string_length(typingString), 1)
	}
	controllerId.typingString = typingString
	draw_set_alpha(sin(current_time/100))
	draw_text(screenMidX + string_width(LC.translate("Answer: ",Games.Menus) + typingString)/2 + 3, answerBoxMidY, "|");
	draw_set_alpha(1)
	
	draw_set_color(c_white)

	// Answer and send to firebase
	obj_firestore_controller.answerTimer++
	if (keyboard_check_pressed(vk_space) or keyboard_check_pressed(vk_enter))
	{
		if (typingString = round(real(question.options[question.answerIndex].text)))
		{
			// Correct
			obj_firestore_controller.SendAnswer(question.prompt, new AnswerOption(typingString), question.options[question.answerIndex].text, question.subject, question.subtopic, question.questionType, obj_firestore_controller.answerTimer/60)
			obj_firestore_controller.answerTimer = 0
			controllerId.AnsweredCorrect()
		}
		else
		{
			controllerId.AnsweredIncorrect()
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
	    if ((key_pressed >= "0" && key_pressed <= "9") or key_pressed = "-"  or (key_pressed = "." and string_pos(".",typingString) = 0)) 
		{
	        return true;
	    } else {
	        return false;
	    }
	}
}