enum MathErrors {
	
	CorrectAnswer,
	Undescribed,
	
	// Basic
	CountingError,
	MultiplicationError,
	NegationError,
	
	// Equations
	EquationsAddition
	
}


function AnswerOption(optionText, errorType = MathErrors.Undescribed) constructor {

	text = optionText
	errorEnum = errorType
}

function scr_mathErrorEnumToString(mathErrorEnum)
{
	switch(mathErrorEnum)
	{
		case MathErrors.CorrectAnswer:
			return "CorrectAnswer";
		case MathErrors.Undescribed:
			return "Undescribed";
			
		case MathErrors.CountingError:
			return "CountingError";
		case MathErrors.MultiplicationError:
			return "MultiplicationError";
		case MathErrors.NegationError:
			return "MultiplicationError";
			
		default:
			return "Unknown"
	}
}