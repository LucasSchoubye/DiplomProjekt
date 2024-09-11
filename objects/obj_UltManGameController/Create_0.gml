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