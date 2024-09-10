// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_danishLargeMultiplication(questionType){

	// Initialize question
	var question = new Question(questionType)
	
	switch(questionType)
	{
		case QuestionType.MultipleChoice:
			
			// Random variables
			var a = round(random_range(-9999,9999))
			var b = round(random_range(-9999,9999))
			
			// Setup variables
			question.prompt = string(a)+" * "+string(b)
			var optionToList = ds_list_create()
			var answer = a*b
			
			// Populate mistakes
			ds_list_add(optionToList, a*(b+1))
			ds_list_add(optionToList, (a+1)*b)
			ds_list_add(optionToList, a*(b-1))
			ds_list_add(optionToList, (a-1)*b)
			ds_list_add(optionToList, a*b-1)
			ds_list_add(optionToList, a*b+1)
			
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