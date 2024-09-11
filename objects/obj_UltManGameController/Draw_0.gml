
// 

scr_UltManDrawLine()

// Player control
controlledPlayer = scr_assignClosestControlledPlayer()
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

scr_UltManActiontypes()