/// Variables

enum SkinClothingCategories
{
	Hat,
	Glasses,
	FaceAccesories,
	Neckwear,
	Shirt,
	Jacket,
	Belt,
	Pants,
	Shoes,
	Pet
}
enum SkinPhysicalCategories
{
	Bodytype,
	SkinColor,
	HairColor,
	HairStyle,
	Face,
	Beard
}

// Equipped
physical = [undefined,undefined,undefined,undefined,undefined,undefined]
clothing = [undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined,undefined]

// Test data
physical[SkinPhysicalCategories.SkinColor] = #fce1bd
physical[SkinPhysicalCategories.Face] = spr_characterFace


// Functions
function DrawCharacterMenu(X,Y,size = 1) 
{
	#region Body
	// Time-based value for breathing animation
	var time = current_time / 500; // Dividing current_time for slower animation

	// Sinusoidal breathing effect (range between -0.05 and 0.05 for subtle movement)
	var breathing = sin(time);

	// Humanoid dimensions
	var head_width = 20*size;
	var head_height = 20*size;
	var torso_width = 30*size;
	var torso_height = 50*size - size*sin(breathing);
	var shoulder_height = 2*size;
	var arm_width = 10*size;
	var arm_height = 60*size;
	var leg_width = 10*size;
	var leg_height = 40*size;

	// Humanoid position (centered on x, y coordinates)
	var x_center = X;
	var y_center = Y;

	// Calculate breathing effect on torso width
	var breathing_torso_width = torso_width;

	// Draw head
	draw_sprite_ext(spr_characterBox,0,
		x_center - head_width / 2, 
		y_center - torso_height - head_height + 2*size*sin(breathing),
		head_height,head_width,0,physical[SkinPhysicalCategories.SkinColor],1)
	
	// Draw face
	draw_sprite_ext(physical[SkinPhysicalCategories.Face], 0,
		x_center - head_width / 2, 
		y_center - torso_height - head_height + 2*size*sin(breathing),
		head_width/sprite_get_width(physical[SkinPhysicalCategories.Face]),
		head_height/sprite_get_height(physical[SkinPhysicalCategories.Face]),
		0,physical[SkinPhysicalCategories.SkinColor],0.5)

	// Draw torso with breathing effect
	draw_sprite_ext(spr_characterBox,0,
		x_center - breathing_torso_width / 2, 
	    y_center - torso_height + size*sin(breathing),
		torso_width,torso_height,0,physical[SkinPhysicalCategories.SkinColor],1)

	// Draw arms
	draw_sprite_ext(spr_characterBox,0,
	x_center - breathing_torso_width / 2 - arm_width,
	y_center - torso_height + shoulder_height,
	arm_width,arm_height,-5+sin(breathing)*5,physical[SkinPhysicalCategories.SkinColor],1)
	
	draw_sprite_ext(spr_characterBox,0,
	x_center + breathing_torso_width / 2,
	y_center - torso_height + shoulder_height,
	arm_width,arm_height,5-sin(breathing)*5,physical[SkinPhysicalCategories.SkinColor],1)

	// Draw legs
	draw_sprite_ext(spr_characterBox,0,
		x_center - leg_width / 2 - 10*size, 
	    y_center,
		leg_width,leg_height,0,physical[SkinPhysicalCategories.SkinColor],1)
		
	draw_sprite_ext(spr_characterBox,0,
		x_center - leg_width / 2 + 10*size, 
	    y_center,
		leg_width,leg_height,0,physical[SkinPhysicalCategories.SkinColor],1)
	#endregion
}