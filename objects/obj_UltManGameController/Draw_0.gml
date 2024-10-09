
// 

scr_UltManDrawLine()
scr_UltManDrawField()

// Player control
controlledPlayer = scr_assignClosestControlledPlayer(obj_UltManBall.x, obj_UltManBall.y)
ballcarrier = obj_UltManBall.owner

len = controlledPlayer.targetSpd
dir = point_direction(controlledPlayer.x,controlledPlayer.y,mouse_x,mouse_y)
lenX = lengthdir_x(len, dir)
lenY = lengthdir_y(len, dir)
targetX = controlledPlayer.x+lenX
targetY = controlledPlayer.y+lenY
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
	commandedPlayer = commandClickedPlayer
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
			scr_UltManKickoffSetup(true)
		}
		else
		{
			scoreline[0]++
			show_message("SCORED GOAL")
			scr_UltManKickoffSetup(false)
		}
	}
}

// End Match
if (timer > 90)
{
	room_goto(rm_UltManOverview)
	obj_UltManManagerController.SimulateLeague(scoreline[0], scoreline[1])
}

scr_UltManActiontypes()

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