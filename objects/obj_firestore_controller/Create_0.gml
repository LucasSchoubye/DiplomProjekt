/// @description Setup Firestore

// Setup variables
randomize()
playerId = undefined
sessionId = undefined
sessionMap = undefined
answerTimer = 0
categories = undefined
inventoryID = undefined
playedGameTitle = ""

// Login 
username = undefined
password = undefined
schoolId = undefined
classId = undefined
itemID = undefined

// Functions
function RequestAllowedGames()
{
	FirebaseFirestore("/schools/"+schoolId+"/classes/"+classId+"/allowedGames/").Read()
}

function RespondAllowedGames(gamesList)
{
	var gamesMap = json_decode(gamesList)
	var idArray = []
	ds_map_keys_to_array(gamesMap, idArray)
	
	for (var i = 0; i < array_length(idArray); i++) 
	{
		// Check their username
	    var ID = idArray[i];
	    var value = json_decode(gamesMap[? ID]);
		obj_menuGridController.GetGameData(value)
	}
}

function RequestGamestate(gameId)
{
	FirebaseFirestore("/students/"+playerId+"/gamestates/"+gameId).Read()
}

function SaveGamestate(game, gamestateJson)
{
	var gamestateMap = ds_map_create()
	gamestateMap[?"state"] = gamestateJson
	FirebaseFirestore("/students/"+playerId+"/gamestates/"+game).Set(gamestateJson)
	ds_map_destroy(gamestateMap)
}

function RespondEmptyGamestate(gamename)
{	
	// Handle empty gamestate based on game
	switch(gamename)
	{
		case "ultimateManager":
			obj_UltManManagerController.StartNewGamestate()
		break
	}
}

function RespondGamestate(gameStateJson, gamename)
{
	// Handle gamestate based on game
	switch(gamename)
	{
		case "ultimateManager":
			obj_UltManManagerController.LoadGamestate(gameStateJson)
		break;
	}
}

function RequestCategories() {
	FirebaseFirestore("shop items/categories/")
}

function RespondCategories(categoryList) {
	var storeMap = json_decode(storeList)
	var idArray = []
	ds_map_keys_to_array(storeMap, idArray)
	
	for (var i = 0; i < array_length(idArray); i++) 
	{
		// Check their username
	    var ID = idArray[i];
	    var value = json_decode(storeMap[? ID]);
		obj_storeController.GetStoreData(value,ID)
		obj_inventoryController.GetInventoryData(value)
	}
}

function RequestStoreItems(categoryString) {
	FirebaseFirestore("/shop items/categories/"+categoryString).Read()
}

function RespondStoreItems(storeList,path) {
	var storeMap = json_decode(storeList)
	var idArray = []
	ds_map_keys_to_array(storeMap, idArray)
	
	for (var i = 0; i < array_length(idArray); i++) 
	{
	    var ID = idArray[i];
	    var value = json_decode(storeMap[? ID]);
		value[? "category"] = path
		obj_storeController.GetStoreData(value,ID)
	}
}

function RequestBalance() {
	FirebaseFirestore("/students/"+playerId+"/inventory/bank/").Read()
}

function RespondBalance(bankJSON) {
	var balanceMap = json_decode(bankJSON)
	
	obj_storeController.GetBalanceData(balanceMap)
	obj_inventoryController.GetBalanceData(balanceMap)
}

function UpdateBalance() {
	var balanceMap = ds_map_create()
	balanceMap[?"balance"] = obj_storeController.balance
	var json = json_encode(balanceMap)
	FirebaseFirestore("/students/"+playerId+"/inventory/bank/").Set(json)
}

function RequestStudentInventory() {
		FirebaseFirestore("/students/"+playerId+"/inventory/").Read()
}

function RespondStudentInventory(inventoryList) {
	var inventoryMap = json_decode(inventoryList)
	var idArray = []
	ds_map_keys_to_array(inventoryMap, idArray)
	
	for (var i = 0; i < array_length(idArray); i++) 
	{
		// Check their username
	    var ID = idArray[i];
	    var value = json_decode(inventoryMap[? ID]);
	
		obj_inventoryController.GetInventoryData(value)
	}	
}

function BuyShopItem() {
	var inventoryMap = ds_map_create()
	var item = ds_list_find_value(obj_inventoryController.inventoryElements,ds_list_size(obj_inventoryController.inventoryElements)-1)
	
	inventoryMap[?"shopItemRef"] = "/shop items/categories/"+item.itemID
	inventoryMap[?"equipped"] = false
	var json = json_encode(inventoryMap)
	
	FirebaseFirestore("/students/"+playerId+"/inventory/"+item.itemID).Set(json)
	ds_map_destroy(inventoryMap)
}

function UpdateInventory(itemStruct)
{
	var itemMap = ds_map_create()
	itemMap[?"shopItemRef"] = "/shop items/categories/"+itemStruct.itemID
	itemMap[?"equipped"] = itemStruct.isEquipped
	
	var json = json_encode(itemMap)
	FirebaseFirestore("/students/"+playerId+"/inventory/"+itemStruct.itemID).Set(json)

	ds_map_destroy(itemMap)
}

function StartSession(game)
{		
	sessionMap = ds_map_create()
	sessionMap[?"starttime"] = date_date_string(date_current_datetime()) + "-" + string(current_hour) + "/" + string(current_minute) + "/" + string(current_second)
	sessionMap[?"endtime"] = ""
	sessionMap[?"gameref"] = string(game)
	sessionMap[?"student"] = "/students/"+string(playerId)
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
	try
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
		
		if (value[?"username"] = username && value[?"password"] = scr_stringSha512(password))
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
		{
			//show_message("Wrong password or username")
			room_goto(rm_login)
			var part = instance_create_depth(room_width/2, 200, -1, obj_par_text) 
			part.text = "Wrong password or username"
		}
	}
	catch(error)
	{
		room_goto(rm_login)
	}
}

function RequestStudent()
{
	FirebaseFirestore("/students/"+playerId).Read()
}

function RepondStudent(map)
{
	map = json_decode(map)
	
	#region SchoolID & ClassId
	var fullPath = map[?"classRef"]
	
	var classDash = string_last_pos("/", fullPath);
	var schoolPath = fullPath//string_replace(fullPath,"/schools/", "");
	
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
		
		var slash_pos = string_pos("/", shortenedSchoolId); // Find position of the first slash
		schoolId = string_copy(shortenedSchoolId, 1, slash_pos - 1); // Copy substring until first slash
	}
	
	#endregion SchoolID & ClassId
	
	// After student data is fetched, create question generator
	instance_create_depth(0,0,0,obj_questionController)
	RequestAllowedGames()
	
}

function RequestClassSubtopics(schoolId, classId, subject)
{
	if (schoolId != undefined && schoolId != undefined)
	{
		FirebaseFirestore("schools/"+schoolId+"/classes/"+classId+"/topics/"+subject+"/subtopics").Read()
	}
	else
	{
		show_message("SchoolId or classId are undefined")
	}
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

function SendAnswer(prompt, optionChosen, correctAnswer, subject, subtopic, answerType, answerTime)
{
	answerMap = ds_map_create()
	answerMap[?"sessionRef"] = string(sessionId)
	answerMap[?"answerTime"] = answerTime
	answerMap[?"prompt"] = prompt
	answerMap[?"optionChosen"] = optionChosen
	answerMap[?"answer"] = correctAnswer
	answerMap[?"correct"] = optionChosen == correctAnswer
	answerMap[?"subject"] = subject
	answerMap[?"subtopic"] = subtopic
	answerMap[?"answerType"] = answerType
	var json = json_encode(answerMap)
	ds_map_destroy(answerMap)

	FirebaseFirestore("answers/").Set(json)
}