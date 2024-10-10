/// @description Insert description here
// You can write your code in this editor
if (instance_exists(obj_FtDPlayer)) {
	
	var targetX = (obj_FtDPlayer.x + room_width/2)/2
	var targetY = (obj_FtDPlayer.y + room_height/2)/2
	
	x += (targetX-x)/5
	y += (targetY-y)/5
}

