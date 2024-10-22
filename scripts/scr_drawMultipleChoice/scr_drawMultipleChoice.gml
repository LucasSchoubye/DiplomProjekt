// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_drawMultipleChoice(optionsMenu, controllerId)
{

//draw_set_font(fn_konk18)

var resolutionSizeRatio = 1

var screenMidX = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0])/2
var screenMidY = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0])/2

var answerBoxTop = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0])*0.7
var answerBoxBot = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0])*0.95
var answerBoxLeft = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0])*0.1
var answerBoxRight = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0])*0.9
var answerBoxMidY = (answerBoxTop+answerBoxBot)/2
var answerBoxMidThirdY = (answerBoxTop-answerBoxBot)/3
var answerBoxQuarterX = camera_get_view_x(view_camera[0]) + (answerBoxRight-answerBoxLeft)/4

var promptBoxHeight = camera_get_view_height(view_camera[0])*0.15
var promptBoxMid = answerBoxTop-promptBoxHeight/2
var twoOptionsX = (answerBoxRight-answerBoxLeft)/4
var twoOptionsY = (answerBoxTop-answerBoxBot)/4
var fourOptionsX = (answerBoxRight-answerBoxLeft)/8
var threeOptionsY = (answerBoxTop-answerBoxBot)/6


var mouseWithinAnswerBox = false
if (mouse_x > answerBoxLeft && mouse_x < answerBoxRight &&
	mouse_y > answerBoxTop && mouse_y < answerBoxBot)
{
	mouseWithinAnswerBox = true
}


var optionSelected = undefined

	if (question != undefined)
	{
		draw_set_alpha(0.7)
		draw_roundrect(answerBoxLeft,answerBoxTop-promptBoxHeight,answerBoxRight,answerBoxBot,false)
		draw_set_alpha(1)
		
		draw_roundrect(answerBoxLeft,answerBoxTop-promptBoxHeight,answerBoxRight,answerBoxTop,true)
		//draw_rectangle(answerBoxLeft,answerBoxTop,answerBoxRight,answerBoxBot,true)
	
		// Vertical middle line for options
		draw_line(screenMidX,answerBoxTop,screenMidX,answerBoxBot)
	
		// Drawing prompt text
		draw_set_halign(fa_center)
		draw_set_color(c_black)
		draw_text(screenMidX,promptBoxMid,question.prompt)
		draw_set_color(c_white)
		
		
		// Draw option boxes
		switch(array_length(question.options))
		{
			case 2:
				draw_set_alpha(0.3)
				// Draw selection
				if (mouseWithinAnswerBox)
				{
					if (mouse_x < screenMidX)
					{
						draw_rectangle(answerBoxLeft,answerBoxTop,screenMidX,answerBoxBot,false)
						optionSelected = 0
					}
					else
					{
						draw_rectangle(answerBoxRight,answerBoxTop,screenMidX,answerBoxBot,false)
						optionSelected = 1
					}
				}
				draw_set_alpha(1)
			
				// Draw text
				for(var i = 0; i < array_length(question.options); i++) {
					draw_set_color(c_black)
					switch(i) {
						case 0:
							draw_text(answerBoxLeft+twoOptionsX,answerBoxBot+2*twoOptionsY,question.options[i])
						break;
						case 1:
							draw_text(answerBoxLeft+3*twoOptionsX,answerBoxBot+2*twoOptionsY,question.options[i])
						break;
					}
					draw_set_color(c_white)
				}
				//optionSelected
			break;
			case 3:
			case 4:
				// Draw option outlines
				draw_line(answerBoxLeft,answerBoxMidY,answerBoxRight,answerBoxMidY)
				
				// set transparency for hover
				draw_set_alpha(0.3)
				// Draw selection
				if (mouseWithinAnswerBox)
				{
					if (mouse_x < screenMidX)
					{
						if (mouse_y < answerBoxMidY)
						{
							draw_rectangle(answerBoxLeft,answerBoxTop,screenMidX,answerBoxMidY,false)
							optionSelected = 0
						}
						else 
						{
							draw_rectangle(answerBoxLeft,answerBoxBot,screenMidX,answerBoxMidY,false)
							optionSelected = 2
						}
					}
					else
					{
						if (mouse_y < answerBoxMidY)
						{
							draw_rectangle(screenMidX,answerBoxTop,answerBoxRight,answerBoxMidY,false)
							optionSelected = 1
						}
						else 
						{
							if(array_length(question.options) == 4) {
								draw_rectangle(screenMidX,answerBoxBot,answerBoxRight,answerBoxMidY,false)
								optionSelected = 3
							}
						}
					}
				}
				draw_set_alpha(1)
				draw_set_color(c_black)
				
				for(var i = 0; i < array_length(question.options); i++) {
					switch(i) {
						case 0:
							draw_text(answerBoxLeft+twoOptionsX,answerBoxBot+3*twoOptionsY,question.options[i])
						break;
						case 1:
							draw_text(answerBoxLeft+3*twoOptionsX,answerBoxBot+3*twoOptionsY,question.options[i])
						break;
						case 2:
							draw_text(answerBoxLeft+twoOptionsX,answerBoxBot+twoOptionsY,question.options[i])
						break;
						case 3:
							if(array_length(question.options) == 4) {
								draw_text(answerBoxLeft+3*twoOptionsX,answerBoxBot+twoOptionsY,question.options[i])
							}
						break;
					}
				}
				draw_set_color(c_white)
			break;
			case 5:
			case 6:
				draw_line(answerBoxLeft,answerBoxTop-answerBoxMidThirdY,answerBoxRight,answerBoxTop-answerBoxMidThirdY)
				draw_line(answerBoxLeft,answerBoxTop-answerBoxMidThirdY*2,answerBoxRight,answerBoxTop-answerBoxMidThirdY*2)
				
				// set transparency for hover
				draw_set_alpha(0.3)
				// Draw selection
				if (mouseWithinAnswerBox)
				{
					if (mouse_x < screenMidX)
					{
						if (mouse_y < answerBoxTop-answerBoxMidThirdY)
						{
							draw_rectangle(answerBoxLeft,answerBoxTop,screenMidX,answerBoxTop-answerBoxMidThirdY,false)
							optionSelected = 0
						}
						else if (mouse_y < answerBoxTop-2*answerBoxMidThirdY && mouse_y > answerBoxTop-answerBoxMidThirdY) 
						{
							draw_rectangle(answerBoxLeft,answerBoxTop-answerBoxMidThirdY,screenMidX,answerBoxTop-2*answerBoxMidThirdY,false)
							optionSelected = 2
						}
						else 
						{
							draw_rectangle(answerBoxLeft,answerBoxBot,screenMidX,answerBoxTop-2*answerBoxMidThirdY,false)
							optionSelected = 4
						}
					}
					else
					{
						if (mouse_y < answerBoxTop-answerBoxMidThirdY)
						{
							draw_rectangle(answerBoxRight,answerBoxTop,screenMidX,answerBoxTop-answerBoxMidThirdY,false)
							optionSelected = 1
						}
						else if (mouse_y < answerBoxTop-2*answerBoxMidThirdY && mouse_y > answerBoxTop-answerBoxMidThirdY) 
						{
							draw_rectangle(answerBoxRight,answerBoxTop-answerBoxMidThirdY,screenMidX,answerBoxTop-2*answerBoxMidThirdY,false)
							optionSelected = 3
						}
						else 
						{
							if(array_length(question.options) == 6) {
								draw_rectangle(answerBoxRight,answerBoxBot,screenMidX,answerBoxTop-2*answerBoxMidThirdY,false)
								optionSelected = 5
							}
						}
					}
				}
				draw_set_alpha(1)
				
				for(var i = 0; i < array_length(question.options); i++) {
					draw_set_color(c_black)
					switch(i) {
						case 0:
							draw_text(answerBoxLeft+twoOptionsX,answerBoxBot+5*threeOptionsY,question.options[i])
						break;
						case 1:
							draw_text(answerBoxLeft+3*twoOptionsX,answerBoxBot+5*threeOptionsY,question.options[i])
						break;
						case 2:
							draw_text(answerBoxLeft+twoOptionsX,answerBoxBot+3*threeOptionsY,question.options[i])
						break;
						case 3:
							draw_text(answerBoxLeft+3*twoOptionsX,answerBoxBot+3*threeOptionsY,question.options[i])
						break;
						case 4:
							draw_text(answerBoxLeft+twoOptionsX,answerBoxBot+threeOptionsY,question.options[i])
						break;
						case 5:
							if(array_length(question.options) == 6) {
								draw_text(answerBoxLeft+3*twoOptionsX,answerBoxBot+threeOptionsY,question.options[i])
							}
						break;
					}
					draw_set_color(c_white)
				}
			break;
			case 7:
			case 8:
				draw_line(answerBoxLeft+answerBoxQuarterX,answerBoxTop,answerBoxLeft+answerBoxQuarterX,answerBoxBot)
				draw_line(answerBoxLeft+answerBoxQuarterX*3,answerBoxTop,answerBoxLeft+answerBoxQuarterX*3,answerBoxBot)
				draw_line(answerBoxLeft,answerBoxMidY,answerBoxRight,answerBoxMidY)
	
				// set transparency for hover
				draw_set_alpha(0.3)
				// Draw selection
				if (mouseWithinAnswerBox)
				{
					if (mouse_y < answerBoxMidY)
					{
						if (mouse_x < answerBoxLeft+answerBoxQuarterX)
						{
							draw_rectangle(answerBoxLeft,answerBoxTop,answerBoxLeft+answerBoxQuarterX,answerBoxMidY,false)
							optionSelected = 0
						}
						else if (mouse_x < answerBoxLeft+2*answerBoxQuarterX && mouse_x > answerBoxLeft+answerBoxQuarterX) 
						{
							draw_rectangle(answerBoxLeft+answerBoxQuarterX,answerBoxTop,answerBoxLeft+2*answerBoxQuarterX,answerBoxMidY,false)
							optionSelected = 1
						}
						else if (mouse_x < answerBoxLeft+3*answerBoxQuarterX && mouse_x > answerBoxLeft+2*answerBoxQuarterX) 
						{
							draw_rectangle(answerBoxLeft+2*answerBoxQuarterX,answerBoxTop,answerBoxLeft+3*answerBoxQuarterX,answerBoxMidY,false)
							optionSelected = 2
						}
						else 
						{
							draw_rectangle(answerBoxLeft+3*answerBoxQuarterX,answerBoxTop,answerBoxRight,answerBoxMidY,false)
							optionSelected = 3
						}
					}
					else
					{
						if (mouse_x < answerBoxLeft+answerBoxQuarterX)
						{
							draw_rectangle(answerBoxLeft,answerBoxBot,answerBoxLeft+answerBoxQuarterX,answerBoxMidY,false)
							optionSelected = 4
						}
						else if (mouse_x < answerBoxLeft+2*answerBoxQuarterX && mouse_x > answerBoxLeft+answerBoxQuarterX) 
						{
							draw_rectangle(answerBoxLeft+answerBoxQuarterX,answerBoxBot,answerBoxLeft+2*answerBoxQuarterX,answerBoxMidY,false)
							optionSelected = 5
						}
						else if (mouse_x < answerBoxLeft+3*answerBoxQuarterX && mouse_x > answerBoxLeft+2*answerBoxQuarterX) 
						{
							draw_rectangle(answerBoxLeft+2*answerBoxQuarterX,answerBoxBot,answerBoxLeft+3*answerBoxQuarterX,answerBoxMidY,false)
							optionSelected = 6
						}
						else 
						{
							if(array_length(question.options) == 8) {
								draw_rectangle(answerBoxLeft+3*answerBoxQuarterX,answerBoxBot,answerBoxRight,answerBoxMidY,false)
								optionSelected = 7
							}
						}
					}
				}
				draw_set_alpha(1)
	
				for(var i = 0; i < array_length(question.options); i++) {
					draw_set_color(c_black)
					switch(i) {
						case 0:
							draw_text(answerBoxLeft+fourOptionsX,answerBoxBot+3*twoOptionsY,question.options[i])
						break;
						case 1:
							draw_text(answerBoxLeft+3*fourOptionsX,answerBoxBot+3*twoOptionsY,question.options[i])
						break;
						case 2:
							draw_text(answerBoxLeft+5*fourOptionsX,answerBoxBot+3*twoOptionsY,question.options[i])
						break;
						case 3:
							draw_text(answerBoxLeft+7*fourOptionsX,answerBoxBot+3*twoOptionsY,question.options[i])
						break;
						case 4:
							draw_text(answerBoxLeft+fourOptionsX,answerBoxBot+twoOptionsY,question.options[i])
						break;
						case 5:
							draw_text(answerBoxLeft+3*fourOptionsX,answerBoxBot+twoOptionsY,question.options[i])
						break;
						case 6:
							draw_text(answerBoxLeft+5*fourOptionsX,answerBoxBot+twoOptionsY,question.options[i])
						break;
						case 7:
							if(array_length(question.options) == 8) {
								draw_text(answerBoxLeft+7*fourOptionsX,answerBoxBot+twoOptionsY,question.options[i])
							}
						break;
					}
					draw_set_color(c_white)
				}
			break;
		}
	}


	// Answer and send to firebase
	obj_firestore_controller.answerTimer++
	if (mouse_check_button_pressed(mb_left) and mouseWithinAnswerBox == true)
	{
		if (optionSelected < array_length(question.options))
		{
			obj_firestore_controller.SendAnswer(question.prompt, question.options[optionSelected], question.options[question.answerIndex], question.subject, question.subtopic, question.questionType, obj_firestore_controller.answerTimer/60)
			obj_firestore_controller.answerTimer = 0

			if(optionSelected == question.answerIndex)
			{
				//obj_typeracerCar.AnsweredCorrect()
				controllerId.AnsweredCorrect()
				question = obj_questionController.questionGenerator.GetQuestion(Subject.Maths, controllerId.questionType)
			}
			else
			{
				//obj_typeracerCar.AnsweredIncorrect()
				controllerId.AnsweredIncorrect()
			}
		}
	}
}