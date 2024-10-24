/// @description Catch Social


if (async_load[? "status"] == 200)
{
	switch(async_load[? "type"])
	{
		case "FirebaseFirestore_Document_Read":	
			if (string_pos("students",async_load[? "path"]) > 0 && 
				string_count("bank",async_load[? "path"]) = 0 && 
				string_count("gamestates",async_load[? "path"]) = 0)
			{
				RepondStudent(async_load[? "value"])
			}
			else if (string_pos("bank",async_load[? "path"]) > 0)
			{
				RespondBalance(async_load[? "value"])	
			}
			else if (string_pos("gamestates",async_load[? "path"]) > 0)
			{
				var last_slash_pos = string_last_pos("/",async_load[? "path"]);
				var result = string_copy(async_load[? "path"], last_slash_pos + 1, string_length(async_load[? "path"]) - last_slash_pos);
				RespondGamestate(async_load[? "value"], result)
			}
			else{
				show_message(async_load[? "value"])
			}
		break;
		
		case "FirebaseFirestore_Collection_Read":
			if (async_load[? "path"] == "/users/")
			{
				show_debug_message("ValidateLogin()")
				ValidateLogin(async_load[? "value"])
			}
			else if (string_pos("subtopics",async_load[? "path"]) > 0)
			{
				show_debug_message("RespondClassSubtopics()")
				RespondClassSubtopics(Subject.Maths, async_load[? "value"])
			}
			else if (string_pos("allowedGames",async_load[? "path"]) > 0)
			{
				RespondAllowedGames(async_load[? "value"])
			}
			else if (string_pos("shop items",async_load[? "path"]) > 0)
			{
				RespondStoreItems(async_load[? "value"],async_load[? "path"])
			}
			else if (string_pos("inventory",async_load[? "path"]) > 0 && 
				string_count("bank",async_load[? "path"]) = 0)
			{
				RespondStudentInventory(async_load[? "value"])	
			}
			else
			{
				show_message("Path was "+string(async_load[? "path"]))	
			}
		break;
	
		case "FirebaseFirestore_Collection_Add":	
			show_debug_message(variable_instance_get(async_load[? "listener"], "url"))
		break;
	
		default:
			show_debug_message("Type was "+string(async_load[? "type"]))	
	}
}
else
{
	if (async_load[? "status"] == 404)
	{
		switch(async_load[? "type"])
		{
			// If gamestate is missing
			case "FirebaseFirestore_Document_Read":	
				if (string_count("gamestates",async_load[? "path"]) > 0)
				{
					// Find the position of the last "/"
					var last_slash_pos = string_last_pos("/",async_load[? "path"]);

					// Get the substring after the last "/"
					var result = string_copy(async_load[? "path"], last_slash_pos + 1, string_length(async_load[? "path"]) - last_slash_pos);

					RespondEmptyGamestate(result)
				}
			break;
		}
	}
	
	
	var errorMessage = async_load[? "errorMessage"]
}

