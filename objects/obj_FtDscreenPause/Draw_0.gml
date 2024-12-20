var _camX = camera_get_view_x(view_camera[0])
var _camW = camera_get_view_width(view_camera[0])
var _camY = camera_get_view_y(view_camera[0])
var _camH = camera_get_view_height(view_camera[0])
var LC = obj_languageController


// draw black rectancle over screen
draw_set_alpha(alphaMax)
draw_rectangle_color(_camX, _camY, _camX + _camW, _camY + _camH, c_black, c_black, c_black, c_black, false)


// draw the text
draw_set_halign(fa_center)
draw_set_valign(fa_middle)
draw_set_alpha(1)
var _gameOverOffset = -32
// "game pause"
draw_text_transformed(_camX + _camW/2, _camY + _camH/2 + _gameOverOffset , LC.translate("GAME PAUSE"), 4, 4, 0)

// "press R to restart or Q to Quit
var _messageOffset = 80
draw_text_transformed(_camX + _camW/2, _camY + _camH/2 + _messageOffset, LC.translate("- Press 'R' to restart, 'Q' to quit or 'ESC' again to continue -"), 1, 1, 0)


