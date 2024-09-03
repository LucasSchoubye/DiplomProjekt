enum DanishMathSubtopic {
	SmallMultiplication,
	MediumMultiplication,
	LargeMultiplication,
}


function scr_getDanishMathQuestion(subtopic, questionType)
{
	switch(subtopic)
	{
		case DanishMathSubtopic.SmallMultiplication:
			return scr_danishSmallMultiplication(questionType);
		
		case DanishMathSubtopic.MediumMultiplication:
		break;
		
		case DanishMathSubtopic.LargeMultiplication:
		break;
		
		default:
			show_debug_message("This "+string(subtopic)+" subtopic is not currently supported")
	}
}