/// @description Catch Social

if (async_load[? "type"] == "FirebaseFirestore_Document_Read")
{
    if (async_load[? "status"] == 200)
    {		
		show_message("Document data is: " + async_load[? "value"]);
    }
    else
    {
        var errorMessage = async_load[? "errorMessage"]
    }
}
