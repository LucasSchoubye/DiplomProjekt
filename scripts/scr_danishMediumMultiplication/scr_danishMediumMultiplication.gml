// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_danishMediumMultiplication(questionType){


	// Initialize question
	var question = new Question(questionType)
	
	switch(questionType)
	{
		case QuestionType.Typing:
		case QuestionType.MultipleChoice:
			
			// Random variables
			var a = round(random_range(-99,99))
			var b = round(random_range(-99,99))
			
			// Setup variables
			question.prompt = string(a)+" * "+string(b)
			var optionToList = ds_list_create()
			var answer = new AnswerOption(a*b, MathErrors.CorrectAnswer)
			
			// Populate mistakes
			ds_list_add(optionToList, new AnswerOption(a*(b+1), MathErrors.MultiplicationError))
			ds_list_add(optionToList, new AnswerOption((a+1)*b, MathErrors.MultiplicationError))
			ds_list_add(optionToList, new AnswerOption(a*(b-1), MathErrors.MultiplicationError))
			ds_list_add(optionToList, new AnswerOption((a-1)*b, MathErrors.MultiplicationError))
			ds_list_add(optionToList, new AnswerOption(a*b-1, MathErrors.CountingError))
			ds_list_add(optionToList, new AnswerOption(a*b+1, MathErrors.CountingError))
			
			var optionsArray = scr_clearDuplicateOptionsAndInsertAnswer(optionToList, answer, 3)
			
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

		
	// Generate question
	
	
	// Return
	return question;

}