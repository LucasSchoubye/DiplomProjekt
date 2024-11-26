
var LC = obj_languageController
scr_UltManDrawLine()

// Player control
controlledPlayer = scr_assignClosestControlledPlayer(obj_UltManBall.x, obj_UltManBall.y)
ballcarrier = obj_UltManBall.owner

dir = point_direction(controlledPlayer.x,controlledPlayer.y,mouse_x,mouse_y)
len = controlledPlayer.targetSpd + lengthdir_x(controlledPlayer.accX, dir) + lengthdir_y(controlledPlayer.accY, dir)
lenX = lengthdir_x(len, dir)
lenY = lengthdir_y(len, dir)
targetX = controlledPlayer.x+lenX//+controlledPlayer.accX
targetY = controlledPlayer.y+lenY//+controlledPlayer.accY
playAllowed = true
	
// Draw Curser
if (instance_exists(controlledPlayer))
{
	draw_set_alpha(1 - point_distance(controlledPlayer.x,controlledPlayer.y,mouse_x,mouse_y)/6500)
	draw_circle(mouse_x,mouse_y,20 + point_distance(controlledPlayer.x,controlledPlayer.y,mouse_x,mouse_y)/70,true)
	draw_set_alpha(1)
	
	// Tooltip for dragging
	var collidingPlayer = collision_point(mouse_x, mouse_y, obj_UltManPlayer, false,true)
	if (collidingPlayer != controlledPlayer && collidingPlayer != noone)
	{
		if (collidingPlayer.playerTeam = true)
		{
			draw_set_halign(fa_left)
			draw_set_alpha(0.8 + sin(current_time/80)*0.2)
			draw_text_ext(mouse_x + 150, mouse_y, LC.translate("Drag with right mouse button"), string_height("I"),400)
			draw_set_alpha(1)
		}
	}
}
else
	draw_circle(mouse_x,mouse_y,20,true)
	
// Action type selected
if (keyboard_check(vk_shift))
{
	selectedAction = ActionType.Shoot
}
else
{
	selectedAction = ActionType.Run
}
	
// Command other player
var commandClickedPlayer = collision_point(mouse_x, mouse_y, obj_UltManPlayer, true, true)
if (mouse_check_button_pressed(mb_right))
{
	if (instance_exists(commandClickedPlayer))
	{
		if (commandClickedPlayer.playerTeam = true)
		commandedPlayer = commandClickedPlayer
	}
}
if (instance_exists(commandedPlayer) && mouse_check_button(mb_right))
{
	commandTargetX = commandedPlayer.x + lengthdir_x(commandedPlayer.targetSpd, point_direction(commandedPlayer.x,commandedPlayer.y,mouse_x,mouse_y))
	commandTargetY = commandedPlayer.y + lengthdir_y(commandedPlayer.targetSpd, point_direction(commandedPlayer.x,commandedPlayer.y,mouse_x,mouse_y))
}

// Check goal 
for (var i = 0; i < 2; ++i) {
	if (goals[i].CheckBallHasScored())
	{
		if (i = 0)
		{
			scoreline[1]++
			scr_UltManKickoffSetup(true, true)
		}
		else
		{
			scoreline[0]++
			playerControllerHistory[0].goalsScored++
 
			if(playerControllerHistory[0] !=playerControllerHistory[1] && playerControllerHistory[1] != undefined){
				playerControllerHistory[1].assists++
			}
			scr_UltManKickoffSetup(false, true)
		}
	}
}

// End Match
if (timer > 45 && obj_UltManManagerController.halftimeCompleted = false)
{
	audio_play_sound(sou_UltManWhistle,1,false)
	room_goto(rm_UltManHalftime)
	obj_UltManManagerController.lastScoreline = scoreline
	obj_UltManManagerController.halftimeCompleted = true
}
if (timer > 90)
{
	room_goto(rm_UltManEndMatch)
	audio_play_sound(sou_UltManWhistle,1,false)
	obj_UltManManagerController.lastScoreline = scoreline
	obj_UltManManagerController.halftimeCompleted = false
}

if (!celebrationActive){
	scr_UltManActiontypes()
	audio_sound_gain(sou_FtDApplause,0,300)
	audio_stop_sound(sou_UltManBoo)
}
	
// Multiple choice active
if (questionMenuActive and questionMenuClickCooldown = false)
{
	cursor_sprite = spr_UltManCursor
	
	// Draw multiple choice
	draw_set_font(fn_ArialBlack48)
	scr_drawMultipleChoice(optionsMenu, id)
	
	// Draw chances
	draw_set_color(c_black)
	draw_set_font(fn_LatoBold40)
	draw_text(camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0])/2, camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0])*0.68,LC.translate("Shot difficulty: ")+string(skillCheckAmount)+LC.translate(" questions!") + " ("+string(skillCheckAmount-skillCheckAttemptsCounter)+LC.translate(" left)"))
	draw_set_color(c_white)
	draw_set_font(fn_RobotoBlack16)
	
	// Perform action
	if (skillCheckAttemptsCounter >= skillCheckAmount)
	{
		questionMenuActive = false
		scr_UltManDoActionType(frozenActionType, frozenTargetX, frozenTargetY, frozenGoalAttempt)
	}
}
else
{
	cursor_sprite = noone
	window_set_cursor(cr_none)
}

if (keyboard_check_released(mb_left))
	questionMenuClickCooldown = false
	
	
if (celebrationActive)
{
	if (celebrationMusic == true && global.leftScored = false) {
		audio_sound_gain(sou_FtDApplause,0.8,0)
		audio_play_sound(sou_FtDApplause,1,false, 1, 0.5)
		celebrationMusic = false
	} else if (celebrationMusic == true && global.leftScored = true) {
		//audio_play_sound(sou_UltManBoo,1,false, 0.7)
		audio_sound_gain(sou_FtDApplause,0.8,0)
		audio_play_sound(sou_FtDApplause,1,false, 1, 0.5)
		celebrationMusic = false
	}
	scr_UltManCelebrate()
}