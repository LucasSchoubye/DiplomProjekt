// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function array_to_ds_list(arr) {
    var list_id = ds_list_create();
    
    for (var i = 0; i < array_length(arr); i++) {
        ds_list_add(list_id, arr[i]);
    }
    
    return list_id;
}
