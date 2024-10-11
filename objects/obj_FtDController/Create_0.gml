/// @description Insert description here
// You can write your code in this editor
questionTimer = 10
showTime = questionTimer
animTargetHp = 0

alarm[0] = 60

global.game_state = GAME_STATE.RUNNING

// Music
audio_play_sound(sou_FtDFightMusicLoop, 1, true)