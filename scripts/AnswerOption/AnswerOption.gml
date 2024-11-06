enum MathErrors {
	
	CorrectAnswer,
	Undescribed,
	
	// Basic
	CountingError,
	MultiplicationError,
	NegationError,
	
	// Equations
	EquationSubtractionWrongNegative,
	EquationAdditionWrongNegative,
	EquationWrongDivision,
	
	OrderOfOperations
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
			
		// Common Errors
		case MathErrors.CountingError:
			return "CountingError";
		case MathErrors.MultiplicationError:
			return "MultiplicationError";
		case MathErrors.NegationError:
			return "NegationError";
			
		// Equations
		case MathErrors.EquationSubtractionWrongNegative:
			return "EquationSubtractionWrongNegative"
		case MathErrors.EquationAdditionWrongNegative:
			return "EquationAdditionWrongNegative"
		case MathErrors.EquationWrongDivision:
			return "EquationWrongDivision"
			
		// Order of operations
		case MathErrors.OrderOfOperations:
			return "OrderOfOperations"
			
		default:
			return "Unknown"
	}
}

function scr_mathErroEnumToDescription(mathErrorEnum)
{
	switch(mathErrorEnum)
	{
		// 
		case MathErrors.CorrectAnswer:
			return "Vildt flot!";
			
		// General errors
		case MathErrors.CountingError:
			return "Du er så tæt på, prøv at tælle igen";
		case MathErrors.MultiplicationError:
			return "Du er så tæt på, det ligner du har ganget en gang for meget eller for lidt";
		case MathErrors.NegationError:
			return "Husk at negative tal kan drille. Man skal sikre sig både rækkefølge og dobbelt minus";
			
		// Equations
		case MathErrors.EquationSubtractionWrongNegative:
			return "Husk at hvis du vil fjerne et plus skal man subtrahere hver side af lighedstegnet: \n X + 1 = 5     →     X + 1 - 1 = 5 - 1     →     X = 4";
		case MathErrors.EquationAdditionWrongNegative:
			return "Husk at hvis du vil fjerne et minus skal man addere hver side af lighedstegnet: \n X - 1 = 5     →     X - 1 + 1 = 5 + 1     →     X = 6";
		case MathErrors.EquationWrongDivision:
			return "Husk at hvis du vil fjerne en dividering skal man gange på hver side af lighedstegnet: \n X / 2 = 5     →     X / 2 * 2 = 5 * 2     →     X = 10";
		
		case MathErrors.OrderOfOperations:
			return "Husk rækkefølgen af regneheirakiet: \n ()     →     * og /     →     + og -"
		
			
		case MathErrors.Undescribed:
		default:
			return "Så tæt på, prøv igen"
	}
}