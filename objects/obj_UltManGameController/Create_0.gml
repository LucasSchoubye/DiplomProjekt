/// Setup

enum ActionType{

	Run,
	Dribble,
	Pass,
	Shoot,
	ShotOnGoal,
	Tackle
}

// Question specfic
question = obj_questionController.questionGenerator.GetQuestion(Subject.Maths, QuestionType.Typing)
typingString = ""
optionsMenu = new OptionsMenu()
questionMenuActive = false
questionType = QuestionType.MultipleChoice
questionMenuClickCooldown = true
frozenTargetX = x
frozenTargetY = y
depth = -room_height
skillCheckAmount = 0
skillCheckCorrectCounter = 0
skillCheckAttemptsCounter = 0
frozenShotMissed = false

// 
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
instance_create_depth(room_width/2, room_height/2, 0, obj_UltManBall)

// Create teams
scr_UltManCreateTeam()
scr_UltManCreateEnemyTeam()
scr_UltManKickoffSetup(false)


// Functions
function AnsweredCorrect() 
{
	skillCheckAttemptsCounter++
	skillCheckCorrectCounter++
}

function AnsweredIncorrect() 
{
	var punishmentLength = 200
	skillCheckAttemptsCounter++
	
	var nearPlayer = scr_assignClosestControlledPlayer(frozenTargetX, frozenTargetY)
	var nearDir = point_direction(frozenTargetX, frozenTargetY, nearPlayer.x, nearPlayer.y)
	
	frozenTargetX = frozenTargetX + lengthdir_x(punishmentLength, nearDir - random_range(150,210))
	frozenTargetY = frozenTargetY + lengthdir_y(punishmentLength, nearDir - random_range(150,210))
	
	if (frozenTargetX > room_width or frozenShotMissed)
	{
		frozenTargetX = instance_nearest(x,y,obj_UltManOpponent).x
		frozenTargetY = instance_nearest(x,y,obj_UltManOpponent).y
		frozenShotMissed = true
	}
}