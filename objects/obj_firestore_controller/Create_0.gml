/// @description Setup Firestore

// Setup variables
randomize()
playerId = "test student"
sessionId = undefined
sessionMap = undefined

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
	if (sessionMap != undefined)
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

//DeleteAllSession()