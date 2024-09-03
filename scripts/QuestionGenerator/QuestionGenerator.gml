enum Curriculum {
	Danish,
	English,
}

enum Subject {
	Maths,
	Physics,
	Geography
}

enum QuestionType {
	MultipleChoice,
	Typing,
	Sequence,
	Simple
}

function Question(questionType, choiceAmount = 0) constructor {
	
	prompt = "";
	options = array_create(choiceAmount);
	answerIndex = undefined;
	
}

function QuestionGenerator(Curriculum) constructor {

	curriculum = Curriculum
	
	function GetQuestion(subject, subtopic, questionType)
	{
		switch (curriculum)
		{
			case Curriculum.Danish:
				switch(subject)
				{
					case Subject.Maths:
						return scr_getDanishMathQuestion(subtopic, questionType)
					
					default:
						show_debug_message("This subject is not currently supported")
				}
			break;
			
			case Curriculum.English:
				show_debug_message("The English curriculum is not currently supported")
			break;
			
			default:
				show_debug_message("This curriculum is not currently supported")
			break;
		}
	}
}