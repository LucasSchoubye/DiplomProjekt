repeat(60)
{
	instance_create_depth(random_range(1200,3280),random_range(816,2120),0,obj_FtDPuddle)
}

// Bricks
var amount = 25
for (var i = 0; i < amount; ++i) {
	
	var startLeft = 1200
	var endRight = 3280
	var dist = 3280 - 1200
	
    var part = instance_create_depth(startLeft + (dist/amount)*i, random_range(836,850),0,obj_FtDPuddle)
	part.sprite_index = spr_FtDBrick
	part.depth = -1
	part.image_xscale = 0.4
	part.image_yscale = 0.4
	part.image_yscale = 0.4
	part.x += random_range(-20,20)
	
	var part = instance_create_depth(startLeft + (dist/amount)*i, random_range(886,941),0,obj_FtDPuddle)
	part.sprite_index = spr_FtDBrick
	part.depth = -1
	part.image_xscale = 0.4
	part.image_yscale = 0.4
	part.image_yscale = 0.4
	part.x += random_range(-20,20)
}

// torch
var amount = 6
for (var i = 0; i < amount; ++i) {

	var startLeft = 1200
	var endRight = 3280
	var dist = 3280 - 1200

	var part = instance_create_depth(startLeft + (dist/amount)*(i+0.5), 850,0,obj_FtDTorch)
}