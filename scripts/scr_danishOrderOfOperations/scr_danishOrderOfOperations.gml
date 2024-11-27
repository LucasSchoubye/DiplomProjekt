// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_danishOrderOfOperations(questionType)
{
	// Initialize question
	var question = new Question(questionType)
	
	switch(questionType)
	{
		case QuestionType.Typing:
		case QuestionType.MultipleChoice:
			
			// Random variables
			var a = round(random_range(1,15))
			var b = round(random_range(1,15))
			var c = round(random_range(10,20))
			var d = round(random_range(0,9))
			question.prompt = string(a)+" * "+string(b)
			var optionToList = ds_list_create()
			var answer = undefined
			
			switch(round(random_range(1,2)))
			{
				// (A + D) - B * C
				case 1:
					question.prompt = "("+string(a)+" + "+string(d)+") - "+string(b)+" * "+string(c)
					answer = new AnswerOption(string((a+d)-(b*c)), MathErrors.CorrectAnswer)
					
					ds_list_add(optionToList, new AnswerOption(string((a+d-b)*c), MathErrors.OrderOfOperations))
					ds_list_add(optionToList, new AnswerOption(string(a+(d-b*c)), MathErrors.OrderOfOperations))
					ds_list_add(optionToList, new AnswerOption(string((a+d)-((b+1)*c)), MathErrors.CountingError))
					ds_list_add(optionToList, new AnswerOption(string((a+d)-((b-1)*c)), MathErrors.CountingError))
					ds_list_add(optionToList, new AnswerOption(string((a+d)-(b*(c+1))), MathErrors.CountingError))
					ds_list_add(optionToList, new AnswerOption(string((a+d)-(b*(c+1))), MathErrors.CountingError))
				break;
				
				// (A + B) / (C - D)
				case 2:
					question.prompt = "("+string(a)+" + "+string(b)+") / ("+string(c)+" - "+string(d)+")"
					answer = new AnswerOption(string((a+b)/(c-d)), MathErrors.CorrectAnswer)
					
					ds_list_add(optionToList, new AnswerOption(string((c*d)/(a+b)), MathErrors.OrderOfOperations))
					ds_list_add(optionToList, new AnswerOption(string((a+b)/c-d), MathErrors.OrderOfOperations))
					ds_list_add(optionToList, new AnswerOption(string(a+b/(c-d)), MathErrors.OrderOfOperations))
					ds_list_add(optionToList, new AnswerOption(string((a+b)/c-d), MathErrors.OrderOfOperations))

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