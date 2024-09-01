/// @description Draw player

//draw_self()

draw_sprite_ext(sprite_index, 0, x, y+ sin(walk_cycle/2)*5, 1, 1, 0+sin(walk_cycle/2)*2, c_white, 1)


scr_anim_player_look();
scr_8d_movement();

