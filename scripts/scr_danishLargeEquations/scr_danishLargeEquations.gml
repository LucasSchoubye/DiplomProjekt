// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_danishLargeEquations(questionType){

	// Initialize question
	var question = new Question(questionType)
	
	switch(questionType)
	{
		case QuestionType.Typing:
		case QuestionType.MultipleChoice:
			
			// Random variables
			var a = round(random_range(1,99))
			var b = round(random_range(1,99))
			
			// Setup list
			var optionToList = ds_list_create()
			var answer = undefined
			
			// Setup variables
			switch(round(random_range(1,3)))
			{
				// Basic addition
				case 1:						
					question.prompt = "X + "+string(abs(a))+" = "+string(b)
					answer = new AnswerOption("X = "+ string(b - a), MathErrors.CorrectAnswer)
					
					// Populate mistakes
					ds_list_add(optionToList, new AnswerOption("X = "+ string(a-b), MathErrors.Undescribed))
					ds_list_add(optionToList, new AnswerOption("X = "+ string(a+b), MathErrors.Undescribed))
					ds_list_add(optionToList, new AnswerOption("X = "+ string(0), MathErrors.Undescribed))
					ds_list_add(optionToList, new AnswerOption("X = "+ string(a-b+1), MathErrors.Undescribed))
					ds_list_add(optionToList, new AnswerOption("X = "+ string(a-b-1), MathErrors.Undescribed))
					ds_list_add(optionToList, new AnswerOption("X = "+ string(b-a+1), MathErrors.CountingError))
					ds_list_add(optionToList, new AnswerOption("X = "+ string(b-a-1), MathErrors.CountingError))
					
					if (questionType = QuestionType.Typing)
						answer = new AnswerOption(string(b - a), MathErrors.CorrectAnswer)
				break;
				
				// Basic subtraction
				case 2:
					a = abs(a)*-1
					question.prompt = "X - "+string(abs(a))+" = "+string(b)
					a = abs(a)
					answer = new AnswerOption("X = "+ string(b + a), MathErrors.CorrectAnswer)
					
					// Populate mistakes
					ds_list_add(optionToList, new AnswerOption("X = "+ string(a-b), MathErrors.Undescribed))
					ds_list_add(optionToList, new AnswerOption("X = "+ string(0), MathErrors.CountingError))
					ds_list_add(optionToList, new AnswerOption("X = "+ string(b + a+1), MathErrors.CountingError))
					ds_list_add(optionToList, new AnswerOption("X = "+ string(b + a*2), MathErrors.MultiplicationError))
					ds_list_add(optionToList, new AnswerOption("X = "+ string(b*2 + a), MathErrors.MultiplicationError))
					ds_list_add(optionToList, new AnswerOption("X = "+ string(b + a-1), MathErrors.CountingError))
					
					if (questionType = QuestionType.Typing)
						answer = new AnswerOption(string(b + a), MathErrors.CorrectAnswer)
				break;
				
				// Basic Multiplication
				case 3:
					question.prompt = "X / "+string(abs(a))+" = "+string(b)
					answer = new AnswerOption("X = "+ string(b*a), MathErrors.CorrectAnswer)
					
					// Populate mistakes
					ds_list_add(optionToList, new AnswerOption("X = "+ string(a+b), MathErrors.Undescribed))
					ds_list_add(optionToList, new AnswerOption("X = "+ string(a-b), MathErrors.Undescribed))
					ds_list_add(optionToList, new AnswerOption("X = "+ string(a/b), MathErrors.Undescribed))
					ds_list_add(optionToList, new AnswerOption("X = "+ string(a*(b+1)), MathErrors.Undescribed))
					ds_list_add(optionToList, new AnswerOption("X = "+ string(a*(b-1)), MathErrors.Undescribed))
					ds_list_add(optionToList, new AnswerOption("X = "+ string((a+1)*b), MathErrors.Undescribed))
					ds_list_add(optionToList, new AnswerOption("X = "+ string((a-1)*b), MathErrors.Undescribed))
					ds_list_add(optionToList, new AnswerOption("X = "+ string(b/a), MathErrors.Undescribed))
					
					if (questionType = QuestionType.Typing)
						answer = new AnswerOption(string(b*a), MathErrors.CorrectAnswer)
				break;
			}
			
			var optionsArray = scr_clearDuplicateOptionsAndInsertAnswer(optionToList, answer, round(random_range(1,5)))
			
			for (var i = 0; i < array_length(optionsArray); ++i) {
			    if (optionsArray[i] == answer)
				{
					question.answerIndex = i
					break
				}
			}
			question.options = optionsArray
			
		return question;

		case QuestionType.Simple:
		break;
		case QuestionType.Sequence:
			show_debug_message("Sequence questions are not yet implemented for small multiplication")
		break;
	}

	// Return
	return question;
}