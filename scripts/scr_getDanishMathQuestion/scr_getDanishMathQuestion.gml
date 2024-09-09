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
	switch(convertStringToEnum(subtopic))
	{
		case DanishMathSubtopic.SmallMultiplication:
			return scr_danishSmallMultiplication(questionType);
		
		case DanishMathSubtopic.MediumMultiplication:
			return scr_danishMediumMultiplication(questionType);
		
		case DanishMathSubtopic.LargeMultiplication:
			return scr_danishLargeMultiplication(questionType);
		
		default:
			show_debug_message("This "+string(subtopic)+" subtopic is not currently supported")
	}
}