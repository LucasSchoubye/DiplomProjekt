
// 

scr_UltManDrawLine()

// Player control
controlledPlayer = instance_nearest(obj_UltManBall.x, obj_UltManBall.y, obj_UltManPlayer)
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
	
scr_UltManActiontypes()

// Command other player
var commandClickedPlayer = collision_point(mouse_x, mouse_y, obj_UltManPlayer, true, true)
if (mouse_check_button_pressed(mb_right))
{
	commandedPlayer = commandClickedPlayer
}

