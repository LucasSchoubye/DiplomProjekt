/// Setup

enum ActionType{

	Run,
	Dribble,
	Pass,
	Shoot,
	Tackle
}

ballcarrier = undefined
commandedPlayer = undefined
controlledPlayer = undefined
selectedAction = ActionType.Run

// Gamelogic
commandTargetX = undefined
commandTargetY = undefined

// Goals
instance_create_depth(300, room_height/2, -100, obj_UltManGoal)
instance_create_depth(room_width-300, room_height/2, -100, obj_UltManGoal)

// Create teams
scr_UltManCreateTeam()