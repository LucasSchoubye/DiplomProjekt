// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_reverseDsList(list){

    var list_size = ds_list_size(list);
    
    // Loop through the first half of the list
    for (var i = 0; i < list_size / 2; i++) {
        var temp = ds_list_find_value(list, i);
        var opposite_index = list_size - 1 - i;

        // Swap the elements at i and opposite_index
        ds_list_replace(list, i, ds_list_find_value(list, opposite_index));
        ds_list_replace(list, opposite_index, temp);
    }
}