/// Setup

enum ActionType{

	Run,
	Dribble,
	Pass,
	Shoot,
	ShotOnGoal,
	Tackle
}

ballcarrier = undefined
commandedPlayer = undefined
controlledPlayer = undefined
selectedAction = ActionType.Run

// Gamelogic
commandTargetX = undefined
commandTargetY = undefined

// Goals & timer
playerTeamIndex = 0
targetGoalIndex = 1
goals[0] = instance_create_depth(300, room_height/2, -100, obj_UltManGoal) // Left
goals[1] = instance_create_depth(room_width-300, room_height/2, -100, obj_UltManGoal) // Right
scoreline[0] = 0
scoreline[1] = 0
timer = 0

// Create teams
scr_UltManCreateTeam()
scr_UltManCreateEnemyTeam()
scr_UltManKickoffSetup(false)