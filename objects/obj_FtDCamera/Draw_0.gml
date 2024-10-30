/// @description Insert description here
// You can write your code in this editor

depth = -10000

if (instance_exists(obj_FtDPlayer)) {
	
	var targetZoom = 0
	
	if (global.game_state == GAME_STATE.PAUSED)
	{
		var targetX = obj_FtDPlayer.x
		var targetY = obj_FtDPlayer.y
		
		targetZoom = -10*obj_FtDQuestionPause.correctAnswers
	}
	else
	{
		var targetX = (obj_FtDPlayer.x + room_width/2)/2
		var targetY = (obj_FtDPlayer.y + room_height/2)/2
	}
	
	x += (targetX-x)/5
	y += (targetY-y)/5
	zoom += (targetZoom - zoom)/15
	
	// Get the camera
	var cam = view_camera[0];
	
	// Calculate the new width and height based on the zoom value
	var base_width = 1920;  // Set the base width of the camera (default view size)
	var base_height = 1080; // Set the base height of the camera (default view size)
	var new_width = base_width + zoom*16;
	var new_height = base_height + zoom*9;

	// Apply the new width and height to the camera
	camera_set_view_size(cam, new_width, new_height);

	// Set the camera's position based on the smoothly transitioned values
	camera_set_view_pos(cam, x - new_width / 2, y - new_height / 2);
}

draw_distance_shadow(x,y,800,400 + sin(current_time/800)*50,c_black,c_black,0.05,1)



/*x   = argument[0], // X Position
    _y   = argument[1], // Y Position
    _r   = argument[2], // Radius
    _d   = argument[3], // Glow Distance (Outwards)
    _c1  = argument[4], // Inner Color
    _c2  = argument[5], // Outer Color
    _a1  = argument[6], // Inner Alpha
    _a2  = argument[7], // Outer Alpha
)