/// Setup variables for typeracer

questionGenerator = new QuestionGenerator(Curriculum.Danish)
question = undefined

function OptionsMenu() constructor
{
	top = 300
	screenMidX = room_width/2
	screenMidY = room_height/2

	answerBoxTop = room_height*0.7
	answerBoxBot = room_height*0.95
	answerBoxLeft = room_width*0.1
	answerBoxRight = room_width*0.9
	answerBoxMidY = (answerBoxTop+answerBoxBot)/2
	answerBoxMidThirdY = (answerBoxTop-answerBoxBot)/3
	answerBoxQuarterX = (answerBoxRight-answerBoxLeft)/4
	promptBoxHeight = room_height*0.15
	promptBoxMid = answerBoxTop-promptBoxHeight/2
	twoOptionsX = (answerBoxRight-answerBoxLeft)/4
	twoOptionsY = (answerBoxTop-answerBoxBot)/4
	fourOptionsX = (answerBoxRight-answerBoxLeft)/8
	threeOptionsY = (answerBoxTop-answerBoxBot)/6
}

optionsMenu = new OptionsMenu()

question = obj_questionController.questionGenerator.GetQuestion(Subject.Maths, QuestionType.MultipleChoice)
