enum DanishMathSubtopic {
	
	// Multiplication
	SmallMultiplication,
	MediumMultiplication,
	LargeMultiplication,
	
	// Equations
	SmallEquations,
	LargeEquations,
}

function convertStringToEnum(subtopicMap)
{
	switch(subtopicMap)
	{
		// Multiplication
		case "smallMultiplication":
			return DanishMathSubtopic.SmallMultiplication
		break;
		case "mediumMultiplication":
			return DanishMathSubtopic.MediumMultiplication
		break;
		case "largeMultiplication":
			return DanishMathSubtopic.LargeMultiplication
		break;
		
		// Equations
		case "smallEquations":	
			return DanishMathSubtopic.SmallEquations
		break;
		case "largeEquations":	
			return DanishMathSubtopic.LargeEquations
		break;
	}
}


function scr_getDanishMathQuestion(subtopic, questionType)
{	
	var question = undefined
	switch(convertStringToEnum(subtopic))
	{
		#region Multiplications
		case DanishMathSubtopic.SmallMultiplication:
			question = scr_danishSmallMultiplication(questionType);
			break;
		case DanishMathSubtopic.MediumMultiplication:
			question = scr_danishMediumMultiplication(questionType);
			break;
		case DanishMathSubtopic.LargeMultiplication:
			question = scr_danishLargeMultiplication(questionType);
			break;
		#endregion Multiplications
		
		#region Equations
		case DanishMathSubtopic.SmallEquations:
			question = scr_danishSmallEquations(questionType);
			break;
		case DanishMathSubtopic.LargeEquations:
			question = scr_danishLargeEquations(questionType);
			break;
		#endregion Equations
		
		default:
			show_debug_message("This "+string(subtopic)+" subtopic is not currently supported")
	}
	
	question.subtopic = subtopic
	return question;
}