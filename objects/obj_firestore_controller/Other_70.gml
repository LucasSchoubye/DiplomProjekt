/// @description Catch Social


if (async_load[? "status"] == 200)
{
	switch(async_load[? "type"])
	{
		case "FirebaseFirestore_Document_Read":	
			show_debug_message("Document data is: " + async_load[? "value"]);
		break;
	
		case "FirebaseFirestore_Collection_Add":	
			//show_message("JSON: \n\n"+ string(variable_instance_get_names(async_load[? "listener"]))) ;  //listener
			show_message(variable_instance_get(async_load[? "listener"], "url"))
			//var listener = async_load[? "listener"]
			//show_message(json_stringify(async_load[? "listener"]));
			//show_message(json_encode(async_load));
			
			//show_message("JSON: \n\n"+ string(async_load[? "listener"])) ;
		break;
	
		default:
			show_debug_message("Type was "+string(async_load[? "type"]))	
	}
}
else
{
	
	var errorMessage = async_load[? "errorMessage"]
}

