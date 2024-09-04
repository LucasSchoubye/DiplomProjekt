/// @description Particle effects

for (var i = 0; i < 2; ++i) {
    var part = instance_create_depth(x,y,0,obj_typeracerParticle)
	part.direction = image_angle-180
	
	if (i = 0)
		part.y += 10
	else
		part.y -= 10
}

alarm[0] = 2
