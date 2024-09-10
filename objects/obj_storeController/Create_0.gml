/// @description Insert description here
// You can write your code in this editor
verticalScroll = 0
storeElements = ds_list_create()
categoryElements = ds_list_create()

for (var i = 0; i < 20; ++i) {
    ds_list_add(storeElements, new StoreElement())
}

for (var i = 0; i < 5; ++i) {
	ds_list_add(categoryElements, new StoreElement())
}

