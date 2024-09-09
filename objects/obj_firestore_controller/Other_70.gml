/// @description Catch Social


if (async_load[? "status"] == 200)
{
	switch(async_load[? "type"])
	{
		case "FirebaseFirestore_Document_Read":	
			show_debug_message("Document data is: " + async_load[? "value"]);
		break;
		
		case "FirebaseFirestore_Collection_Read":
			if (async_load[? "path"] == "/users/")
			{
				ValidateLogin(async_load[? "value"])
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

