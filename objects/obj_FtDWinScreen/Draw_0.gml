var _camX = camera_get_view_x(view_camera[0])
var _camW = camera_get_view_width(view_camera[0])
var _camY = camera_get_view_y(view_camera[0])
var _camH = camera_get_view_height(view_camera[0])


// draw black rectancle over screen
draw_set_alpha(alpha*alphaMax)
draw_rectangle_color(_camX, _camY, _camX + _camW, _camY + _camH, c_black, c_black, c_black, c_black, false)


// draw the text
draw_set_halign(fa_center)
draw_set_valign(fa_middle)
draw_set_alpha(alpha)
var _gameOverOffset = -32
// "game over"
draw_text_transformed(_camX + _camW/2, _camY + _camH/2 + _gameOverOffset , "YOU WIN!!!", 4, 4, 0)

// "press R to restart or Q to Quit
var _messageOffset = 80
draw_text_transformed(_camX + _camW/2, _camY + _camH/2 + _messageOffset, "- You win " + string(prize) + " content coins! -", 1, 1, 0)

// "press R to restart or Q to Quit
var _optionMessageOffset = 110
draw_text_transformed(_camX + _camW/2, _camY + _camH/2 + _optionMessageOffset, "- Press 'R' to play again or 'Q' to quit -", 1, 1, 0)


// reset draw settings
draw_set_alpha(1)
