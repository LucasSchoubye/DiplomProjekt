// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_sort_struct_list(list, variable_name, ascending = true) {
    var n = ds_list_size(list);
    var swapped;

    // Perform the sorting
    repeat (n - 1) {
        swapped = false;
        for (var i = 0; i < n - 1; i++) {
            var item_a = list[| i];
            var item_b = list[| i + 1];

            var value_a = variable_struct_get(item_a, variable_name);
            var value_b = variable_struct_get(item_b, variable_name);

            // Determine if we need to swap based on ascending or descending order
            if ((ascending && value_a > value_b) || (!ascending && value_a < value_b)) {
                // Swap the two structs in the list
                list[| i] = item_b;
                list[| i + 1] = item_a;
                swapped = true;
            }
        }

        // If no swaps happened, the list is already sorted
        if (!swapped) {
            break;
        }
    }
}