// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_drawMultipleChoice(optionsMenu)
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


var mouseWithinAnswerBox = false
if (mouse_x > answerBoxLeft && mouse_x < answerBoxRight &&
	mouse_y > answerBoxTop && mouse_y < answerBoxBot)
{
	mouseWithinAnswerBox = true
}

var optionSelected = undefined

	if (question != undefined)
	{
		
		
		draw_rectangle(answerBoxLeft,answerBoxTop-promptBoxHeight,answerBoxRight,answerBoxTop,true)
		draw_rectangle(answerBoxLeft,answerBoxTop,answerBoxRight,answerBoxBot,true)
	
		// Vertical middle line for options
		draw_line(screenMidX,answerBoxTop,screenMidX,answerBoxBot)
	
		// Drawing prompt text
		draw_set_halign(fa_center)
		draw_text(screenMidX,promptBoxMid,question.prompt)
		
		
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
					switch(i) {
						case 0:
							draw_text(answerBoxLeft+twoOptionsX,answerBoxBot+2*twoOptionsY,question.options[i])
						break;
						case 1:
							draw_text(answerBoxLeft+3*twoOptionsX,answerBoxBot+2*twoOptionsY,question.options[i])
						break;
					}
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
				}
			break;
		}
	}

if (mouse_check_button_pressed(mb_left) and mouseWithinAnswerBox == true)
{
	show_message("Mousebutton: "+string(optionSelected))
}
}
