/// Draw Event

// GUI variables
var top = 300
var screenMidX = room_width/2
var screenMidY = room_height/2

var answerBoxTop = room_height*0.7
var answerBoxBot = room_height*0.95
var answerBoxLeft = room_width*0.1
var answerBoxRight = room_width*0.9

if (keyboard_check_pressed(vk_space))
{
	question = questionGenerator.GetQuestion(Subject.Maths, DanishMathSubtopic.SmallMultiplication, QuestionType.MultipleChoice)
}

// Draw question
if (question != undefined)
{
	draw_rectangle(answerBoxLeft,answerBoxTop-100,answerBoxRight,answerBoxTop,true)
	draw_rectangle(answerBoxLeft,answerBoxTop,answerBoxRight,answerBoxBot,true)
	
	draw_line(screenMidX,answerBoxTop,screenMidX,answerBoxBot)
	
	switch(array_length(question.options))
	{
		
		case 2:
			//draw_line(screenMidX,answerBoxTop,screenMidX,answerBoxBot)
		break;
		case 3:
		break;
		case 4:
		break;
		case 5:
		break;
		case 6:
		break;
		case 7:
		break;
		case 8:
		break;
	}
	
	
	/*draw_rectangle(x,y,x,y,true)
	
	
	draw_text(screenMidX, top, question.prompt)
	draw_text(screenMidX, top+300, question.options)
	draw_text(screenMidX, top+400, question.answerIndex)*/
}