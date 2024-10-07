// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function find_struct_in_list(list, variable_name, value_to_find) {
    // Iterate over each element in the list
    for (var i = 0; i < ds_list_size(list); i++) {
        var item = list[| i]; // Get the struct at index i
        var variable_value = variable_struct_get(item, variable_name);
        
        // Check if the value matches the input parameter
        if (variable_value == value_to_find) {
            return item; // Return the entire struct (self) if a match is found
        }
    }

    // If no match is found, return undefined
    return undefined;
}