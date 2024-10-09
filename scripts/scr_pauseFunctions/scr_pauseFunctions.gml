// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function screenPause(){
	if (instance_exists(obj_FtDscreenPause)) {
		image_speed = 0
		return true
	} else {
		image_speed = 1
		return false
	}
}