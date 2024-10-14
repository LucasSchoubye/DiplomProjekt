/// @description Insert description here
// You can write your code in this editor
draw_sprite_ext( sprite_index, image_index, x,y, face, image_yscale, image_angle, image_blend, image_alpha)

var afterImage = instance_create_depth(x,y,depth + 10,obj_FtDParticleDust)
			afterImage.sprite_index = sprite_index
			afterImage.image_index = image_index
			afterImage.image_blend = #FFFFF0
			afterImage.shrink = 0.06
			afterImage.fade = 0.03
			