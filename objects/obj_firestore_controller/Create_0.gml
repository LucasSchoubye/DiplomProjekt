/// @description Setup Firestore

// Setup variables
randomize()
playerId = undefined
sessionId = undefined
sessionMap = undefined

// Login 
username = undefined
password = undefined

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
		}
		else
			show_debug_message("No Match found")
	}
	
	if (playerId = undefined)
		show_message("Wrong password or username")
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