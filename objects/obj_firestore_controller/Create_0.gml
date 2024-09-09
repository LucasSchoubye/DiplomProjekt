/// @description Setup Firestore

// Setup variables
randomize()
playerId = undefined
sessionId = undefined
sessionMap = undefined

// Login 
username = undefined
password = undefined
schoolId = "9RWenJGRJ0CTk6p0OlnO"
classId = "Dog8bTzbTQ0jkX6qFNqj"

// Functions
function StartSession(game)
{		
	sessionMap = ds_map_create()
	sessionMap[?"starttime"] = date_date_string(date_current_datetime()) + "-" + string(current_hour) + "/" + string(current_minute) + "/" + string(current_second)
	sessionMap[?"endtime"] = ""
	sessionMap[?"gameref"] = string(game)
	sessionMap[?"student"] = "/students/test student"
	var json = json_encode(sessionMap)
	
	randomize()
	sessionId = playerId+"-"+string(random_get_seed())

	FirebaseFirestore("sessions/"+sessionId).Set(json)
}

function EndSession()
{		
	if (sessionId != undefined)
	{
		sessionMap[?"endtime"] = date_date_string(date_current_datetime()) + "-" + string(current_hour) + "/" + string(current_minute) + "/" + string(current_second)
		var json = json_encode(sessionMap)
		ds_map_destroy(sessionMap)

		FirebaseFirestore("sessions/"+sessionId).Set(json)
		sessionId = undefined
	}
}

function DeleteAllSession()
{
	FirebaseFirestore("/sessions/").Delete()
}

function RequestLogin(loginUsername, loginPassword)
{
	username = loginUsername
	password = loginPassword
	
	FirebaseFirestore("/users/").Read()
}

function ValidateLogin(map)
{
	decodedMap = json_decode(map)
	idArray = []
	ds_map_keys_to_array(decodedMap, idArray)
	
	// for each user
	for (var i = 0; i < array_length(idArray); i++) 
	{
		// Check their username
	    var ID = idArray[i];
	    var value = json_decode(decodedMap[? ID]);
		
		if (value[?"username"] = username && value[?"password"] = sha1_string_utf8(password))
		{
			playerId = value[?"ref"]
			
			// Find the position of the last dash ("/")
		    var last_dash_pos = string_last_pos("/", playerId);
    
		    // Check if there is a dash in the string
		    if (last_dash_pos != -1) {
		        // Extract the substring after the last dash
		        playerId = string_copy(playerId, last_dash_pos + 1, string_length(playerId) - last_dash_pos);
		    }
			
			username = value[?"username"]
			room_goto(rm_menu)
			
			RequestStudent()
		}
		else
			show_debug_message("No Match found")
	}
	
	if (playerId = undefined)
		show_message("Wrong password or username")
}

function RequestStudent()
{
	FirebaseFirestore("/students/"+playerId).Read()
}

function RepondStudent(map)
{
	map = json_decode(map)
	var fullPath = map[?"classRef"]
	
	// Find the positions
	var classDash = string_last_pos("/", fullPath);
	var schoolPath = fullPath//string_replace(fullPath,"/schools/", "");
	show_message("schoolPath: "+schoolPath)
	
	var schoolDash = string_pos("/schools/", schoolPath);
	var schoolDashEnd = string_last_pos("/classes/", schoolPath);
    
	// Check if there is a dash in the string
	if (classDash != -1) {
		// Extract the substring after the last dash
		classId = string_copy(fullPath, classDash + 1, string_length(fullPath) - classDash);
	}
		// Check if there is a dash in the string
	if (classDash != -1) {
		// Extract the substring after the last dash
		var schoolPrefixLength = 8
		var shortenedSchoolId = string_copy(schoolPath, schoolDash + 1 + schoolPrefixLength, string_length(schoolPath) - schoolDash);
		schoolId = string_copy(shortenedSchoolId, schoolDashEnd + 1, string_length(shortenedSchoolId) - schoolDashEnd);
	}
	
	show_message("ClassId: "+classId+". SchoolId: "+schoolId)
}

function RequestClassSubtopics(schoolId, classId, subject)
{
	show_debug_message("schools/"+schoolId+"/classes/"+classId+"/topics/"+subject+"/subtopics")
	show_debug_message("schools/9RWenJGRJ0CTk6p0OlnO/classes/Dog8bTzbTQ0jkX6qFNqj/topics/Math/subtopics")
	
	FirebaseFirestore("schools/"+schoolId+"/classes/"+classId+"/topics/"+subject+"/subtopics").Read()
}

function RespondClassSubtopics(subject, value)
{
	var subjectString = ""
	
	switch(subject)
	{
		case Subject.Maths:
			subjectString = "Maths"
		break;
		case Subject.Physics:
			subjectString = "Physics"
		break;
	}
	
	show_debug_message("RespondClassSubtopics: Value = "+value+", subjectString = "+subjectString)
	
	obj_questionController.questionGenerator.SetSubtopicListFromFirebase(subjectString, value)
 }

function SendAnswer(optionChosen, correctAnswer)
{
	answerMap = ds_map_create()
	answerMap[?"optionChosen"] = string(optionChosen)
	answerMap[?"sessionRef"] = string(sessionId)
	answerMap[?"correct"] = bool(optionChosen == correctAnswer)
	var json = json_encode(answerMap)
	ds_map_destroy(answerMap)

	FirebaseFirestore("answers/").Set(json)
}