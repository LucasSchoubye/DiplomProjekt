function scr_clearDuplicateOptionsAndInsertAnswer(optionToList, answer, maxOptions)
	{
		// Clear duplicates
		var seen = ds_map_create();
    
		    // Iterate through the list backwards to avoid skipping indices after removal
		    for (var i = ds_list_size(optionToList) - 1; i >= 0; i--) {
		        var value = ds_list_find_value(optionToList, i);  // Get the value at index i

		        if (ds_map_exists(seen, string(value.text)) or string(value.text) == answer.text) {
		            // If value has been seen before or is the same as the answer, remove it from the list
		            ds_list_delete(optionToList, i);
		        } else {
		            // If value has not been seen, add it to the seen map
		            ds_map_set(seen, string(value.text), true);
		        }
		    }
			
			// Destroy the seen map to free up memory
			ds_map_destroy(seen);
			
			// Shorten to given length
			while(ds_list_size(optionToList) > maxOptions)
			{
				ds_list_delete(optionToList, 0)
			}
			
			// convert to Array
			ds_list_add(optionToList, answer)
			ds_list_shuffle(optionToList)
			var optionsArray = array_create(ds_list_size(optionToList));
			
			for (var i = 0; i < ds_list_size(optionToList); i++) {
			    optionsArray[i] = ds_list_find_value(optionToList, i);
			}
			
			return optionsArray
	}