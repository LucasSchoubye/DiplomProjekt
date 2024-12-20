enum Curriculum {
	Danish,
	English,
}

enum Subject {
	Maths,
	Physics,
	Geography
}

enum QuestionType {
	MultipleChoice,
	Typing,
	Sequence,
	Simple
}

function QuestionTypeToString(questionType)
{
	switch(questionType)
	{
		case QuestionType.MultipleChoice:
			return "MultipleChoice" 
		case QuestionType.Typing:
			return "Typing" 
		case QuestionType.Sequence:
			return "Sequence" 
		default:
			return "Not Recognized" 
	}
}

function Question(questionType, choiceAmount = 0) constructor {
	
	prompt = "";
	options = array_create(choiceAmount);
	answerIndex = undefined;
	subject = undefined
	subtopic = undefined
	questionType = undefined
}

function QuestionGenerator(Curriculum) constructor {
		
	curriculum = Curriculum;
	subtopicMap = undefined;
		
	function GetQuestion(subject, questionType)
	{
		var question = undefined
		switch (curriculum)
		{
			case Curriculum.Danish:
				switch(subject)
				{
					case Subject.Maths:
						question = scr_getDanishMathQuestion(GetRandomSubtopicFromList(subject), questionType)
						question.subject = "Maths"
						question.questionType = QuestionTypeToString(questionType)
						return question
					
					default:
						show_debug_message("This subject is not currently supported")
				}
			break;
			
			case Curriculum.English:
				show_debug_message("The English curriculum is not currently supported")
			break;
			
			default:
				show_debug_message("This curriculum is not currently supported")
			break;
		}
	}
	
	function SetupSubtopicMap(curriculum)
	{
		if (subtopicMap == undefined)
			subtopicMap = ds_map_create()
		
		subtopicMap[?"Maths"] = ds_list_create()
		subtopicMap[?"Physics"] = ds_list_create()
		subtopicMap[?"Geography"] = ds_list_create()
	}
	
	function UpdateSubtopicsList(subject)
	{
		switch(subject)
		{
			case Subject.Maths:
				var targetList = subtopicMap[?"Maths"]
				
				if (!ds_list_empty(targetList))
					ds_list_clear(subtopicMap[?"Maths"])
				obj_firestore_controller.RequestClassSubtopics(obj_firestore_controller.schoolId,obj_firestore_controller.classId,"Maths")
				
			break;
			case Subject.Physics:
				show_debug_message("UpdateSubtopicsList(Physics) is not yet implemented")
			break;
			case Subject.Geography:
				show_debug_message("UpdateSubtopicsList(Geography) is not yet implemented")
			break;
			
			default:
				show_debug_message(string(subject)+" is not recognized as a subject")
		}
	}
	
	function SetSubtopicListFromFirebase(subject, subtopicMapFromFirebase)
	{
		decodedMap = json_decode(subtopicMapFromFirebase)
		idArray = []
		ds_map_keys_to_array(decodedMap, idArray)
		
		show_debug_message("SetSubtopicListFromFirebase: "+subtopicMapFromFirebase)
		
		for (var i = 0; i < array_length(idArray); i++) 
		{
			var ID = idArray[i];
			var value = json_decode(decodedMap[? ID]);
			
			if (value[?"active"] == true)
			{
				ds_list_add(subtopicMap[?"Maths"], ID)
			}
		}
	}
	
	function GetRandomSubtopicFromList(subject)
	{		
		var subtopicListSize = ds_list_size(subtopicMap[?"Maths"])
		var randomIndex = round(random_range(0, subtopicListSize-1))
		var subtopicFound = ds_list_find_value(subtopicMap[?"Maths"], randomIndex)
		show_debug_message("found this subtopic: "+string(subtopicFound))
		
		return subtopicFound
	}

	SetupSubtopicMap(Curriculum)
	UpdateSubtopicsList(Subject.Maths)
}