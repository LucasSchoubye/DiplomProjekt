/// @description Catch Social


if (async_load[? "status"] == 200)
{
	switch(async_load[? "type"])
	{
		case "FirebaseFirestore_Document_Read":	
			if (string_pos("students",async_load[? "path"]) > 0)
			{
				RepondStudent(async_load[? "value"])
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
				show_message("RespondAllowedGames: "+string(async_load[? "value"]))
				RespondAllowedGames(async_load[? "value"])
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
	
	var errorMessage = async_load[? "errorMessage"]
}

