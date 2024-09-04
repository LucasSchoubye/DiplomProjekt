/// Draw Event

// GUI variables
var top = 300
var screenMidX = room_width/2
var screenMidY = room_height/2

var answerBoxTop = room_height*0.7
var answerBoxBot = room_height*0.95
var answerBoxLeft = room_width*0.1
var answerBoxRight = room_width*0.9
var answerBoxMidY = (answerBoxTop+answerBoxBot)/2
var answerBoxMidThirdY = (answerBoxTop-answerBoxBot)/3
var answerBoxQuarterX = (answerBoxRight-answerBoxLeft)/4
var promptBoxHeight = room_height*0.15
var promptBoxMid = answerBoxTop-promptBoxHeight/2
var twoOptionsX = (answerBoxRight-answerBoxLeft)/4
var twoOptionsY = (answerBoxTop-answerBoxBot)/4
var fourOptionsX = (answerBoxRight-answerBoxLeft)/8
var threeOptionsY = (answerBoxTop-answerBoxBot)/6



if (keyboard_check_pressed(vk_space))
{
	question = questionGenerator.GetQuestion(Subject.Maths, DanishMathSubtopic.SmallMultiplication, QuestionType.MultipleChoice)
}

// Draw question
if (question != undefined)
{
	draw_rectangle(answerBoxLeft,answerBoxTop-promptBoxHeight,answerBoxRight,answerBoxTop,true)
	draw_rectangle(answerBoxLeft,answerBoxTop,answerBoxRight,answerBoxBot,true)
	
	// Vertical middle line for options
	draw_line(screenMidX,answerBoxTop,screenMidX,answerBoxBot)
	
	
	// Drawing prompt text
	draw_set_halign(fa_center)
	draw_text(screenMidX,promptBoxMid,question.prompt)
	
	
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
	
	
	/*draw_rectangle(x,y,x,y,true)
	
	
	draw_text(screenMidX, top, question.prompt)
	draw_text(screenMidX, top+300, question.options)
	draw_text(screenMidX, top+400, question.answerIndex)*/
}