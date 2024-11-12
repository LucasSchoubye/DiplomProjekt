

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
	

if (questionMenuActive and questionMenuClickCooldown = false)
{
	// Draw multiple choice
	draw_set_font(fn_ArialBlack48)
	scr_drawMultipleChoice(optionsMenu, id)
	
	// Draw chances
	draw_text(camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0])/2, camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0])*0.69, string(skillCheckCorrectCounter)+"/"+string(skillCheckAttemptsCounter))
	draw_set_font(fn_RobotoBlack16)
	
	// Perform action
	if (skillCheckAttemptsCounter >= skillCheckAmount)
	{
		questionMenuActive = false
		scr_UltManDoActionType(frozenActionType, frozenTargetX, frozenTargetY, frozenGoalAttempt)
	}
}

if (keyboard_check_released(mb_left))
	questionMenuClickCooldown = false
	
	
if (celebrationActive)
{
	if (celebrationMusic == true && global.leftScored = false) {
		audio_sound_gain(sou_FtDApplause,8,0)
		audio_play_sound(sou_FtDApplause,1,false)
		celebrationMusic = false
	} else if (celebrationMusic == true && global.leftScored = true) {
		show_message("where music?")
		audio_play_sound(sou_UltManBoo,1,false)
		celebrationMusic = false
	}
	scr_UltManCelebrate()
	
}