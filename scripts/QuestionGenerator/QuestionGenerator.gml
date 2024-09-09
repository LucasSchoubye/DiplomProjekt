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

function Question(questionType, choiceAmount = 0) constructor {
	
	prompt = "";
	options = array_create(choiceAmount);
	answerIndex = undefined;
	
}

function QuestionGenerator(Curriculum) constructor {
		
	curriculum = Curriculum;
	subtopicMap = undefined;
		
	function GetQuestion(subject, subtopic, questionType)
	{
		switch (curriculum)
		{
			case Curriculum.Danish:
				switch(subject)
				{
					case Subject.Maths:
						return scr_getDanishMathQuestion(GetRandomSubtopicFromList(subject), questionType)
					
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
				// Clear original list
				var targetList = subtopicMap[?"Maths"]
				
				if (!ds_list_empty(targetList))
					ds_list_clear(subtopicMap[?"Maths"])
				obj_firestore_controller.RequestClassSubtopics("9RWenJGRJ0CTk6p0OlnO","Dog8bTzbTQ0jkX6qFNqj","Math")
				
			break;
			case Subject.Physics:
				show_debug_message("UpdateSubtopicsList(Physics) is not yet implemented")
			break;
			case Subject.Geography:
				show_debug_message("UpdateSubtopicsList(Geography) is not yet implemented")
			break;
			
			default:
				show_message(string(subject)+" is not recognized as a subject")
		}
	}
	
	function SetSubtopicListFromFirebase(subject, subtopicMapFromFirebase)
	{
		decodedMap = json_decode(subtopicMapFromFirebase)
		idArray = []
		ds_map_keys_to_array(decodedMap, idArray)
		
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