// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function screenPause(){
	if (instance_exists(obj_FtDscreenPause)) {
		// turn down music and stop every moving thing when paused
		audio_sound_gain(sou_FtDFightMusicLoop,0.3,0)
		image_speed = 0
		return true
	} else {
		// reset when unpaused
		audio_sound_gain(sou_FtDFightMusicLoop,1,0)
		image_speed = 1
		return false
	}
}