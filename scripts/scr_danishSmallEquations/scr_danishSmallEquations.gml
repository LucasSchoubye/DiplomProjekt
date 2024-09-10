// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_danishSmallEquations(questionType){

	// Initialize question
	var question = new Question(questionType)
	
	switch(questionType)
	{
		case QuestionType.MultipleChoice:
			
			// Random variables
			var a = round(random_range(0,9))
			var b = round(random_range(0,9))
			
			// Setup list
			var optionToList = ds_list_create()
			var answer = undefined
			
			// Setup variables
			switch(round(random_range(1,3)))
			{
				// Basic addition
				case 1:
					question.prompt = "X + "+string(abs(a))+" = "+string(b)
					answer = "X = "+ string(b - a)
					
					// Populate mistakes
					ds_list_add(optionToList, "X = "+ string(a-b))
					ds_list_add(optionToList, "X = "+ string(a+b))
					ds_list_add(optionToList, "X = "+ string(0))
					ds_list_add(optionToList, "X = "+ string(a-b+1))
					ds_list_add(optionToList, "X = "+ string(a-b-1))
					ds_list_add(optionToList, "X = "+ string(b-a+1))
					ds_list_add(optionToList, "X = "+ string(b-a-1))
				break;
				
				// Basic subtraction
				case 2:
					a = abs(a)*-1
					question.prompt = "X - "+string(abs(a))+" = "+string(b)
					a = abs(a)
					answer = "X = "+ string(b + a)
					
					// Populate mistakes
					ds_list_add(optionToList, "X = "+ string(a-b))
					ds_list_add(optionToList, "X = "+ string(0))
					ds_list_add(optionToList, "X = "+ string(b + a+1))
					ds_list_add(optionToList, "X = "+ string(b + a*2))
					ds_list_add(optionToList, "X = "+ string(b*2 + a))
					ds_list_add(optionToList, "X = "+ string(b + a-1))
				break;
				
				// Basic Multiplication
				case 3:
					question.prompt = "X / "+string(abs(a))+" = "+string(b)
					answer = "X = "+ string(b*a)
					
					// Populate mistakes
					ds_list_add(optionToList, "X = "+ string(a+b))
					ds_list_add(optionToList, "X = "+ string(a-b))
					ds_list_add(optionToList, "X = "+ string(a/b))
					ds_list_add(optionToList, "X = "+ string(a*(b+1)))
					ds_list_add(optionToList, "X = "+ string(a*(b-1)))
					ds_list_add(optionToList, "X = "+ string((a+1)*b))
					ds_list_add(optionToList, "X = "+ string((a-1)*b))
					ds_list_add(optionToList, "X = "+ string(b/a))
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

		
		case QuestionType.Typing:
			show_debug_message("Typing questions are not yet implemented for small multiplication")
		break;
		case QuestionType.Simple:
		break;
		case QuestionType.Sequence:
			show_debug_message("Sequence questions are not yet implemented for small multiplication")
		break;
	}

	// Return
	return question;
}