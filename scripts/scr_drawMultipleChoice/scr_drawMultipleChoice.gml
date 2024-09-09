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
			break;
			case 3:
			case 4:
				draw_line(answerBoxLeft,answerBoxMidY,answerBoxRight,answerBoxMidY)
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
}