// Setup variables

options = ds_list_create()
ds_list_add(options, "Mini Games")
ds_list_add(options, "Store")
ds_list_add(options, "Settings")
ds_list_add(options, "Quit")

selectedOption = 0;

// Animation
animTimer = 0
animColor = make_colour_rgb(204, sin(animTimer)*30 + 30, 255);
skylineArray = [[],[],[]]
for (var q = 0; q < 4; ++q) {
	for (var i = 0; i < q*15 + q*q;++i) {
		skylineArray[q][i] = random_range(50,150)+(300-100*q)
	}
}
instance_create_depth(x,room_height*0.6,0,obj_par_mainMenuLine)
instance_create_depth(x,room_height*0.7,0,obj_par_mainMenuLine)
instance_create_depth(x,room_height*0.8,0,obj_par_mainMenuLine)
instance_create_depth(x,room_height*0.9,0,obj_par_mainMenuLine)