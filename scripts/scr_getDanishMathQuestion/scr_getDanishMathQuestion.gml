enum DanishMathSubtopic {
	SmallMultiplication,
	MediumMultiplication,
	LargeMultiplication,
}

function convertStringToEnum(subtopicMap)
{
	switch(subtopicMap)
	{
		case "smallMultiplication":
			return DanishMathSubtopic.SmallMultiplication
		break;
		case "mediumMultiplication":
			return DanishMathSubtopic.MediumMultiplication
		break;
		case "largeMultiplication":
			return DanishMathSubtopic.LargeMultiplication
		break;
	}
}


function scr_getDanishMathQuestion(subtopic, questionType)
{	
	var question = undefined
	switch(convertStringToEnum(subtopic))
	{
		case DanishMathSubtopic.SmallMultiplication:
			question = scr_danishSmallMultiplication(questionType);
			break;
		
		case DanishMathSubtopic.MediumMultiplication:
			question = scr_danishMediumMultiplication(questionType);
			break;
		
		case DanishMathSubtopic.LargeMultiplication:
			question = scr_danishLargeMultiplication(questionType);
			break;
		
		default:
			show_debug_message("This "+string(subtopic)+" subtopic is not currently supported")
	}
	
	question.subtopic = subtopic
	return question;
}