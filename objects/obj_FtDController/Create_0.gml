/// @description Insert description here
// You can write your code in this editor
questionTimer = 10
showTime = questionTimer
animTargetHp = 0
animTargetStamina = 0
draw_set_font(fn_lato16)

alarm[0] = 60

global.game_state = GAME_STATE.RUNNING

// Music
audio_stop_all()
audio_play_sound(sou_FtDFightMusicLoop, 1, true)
