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
question = obj_questionController.questionGenerator.GetQuestion(Subject.Maths, QuestionType.MultipleChoice)
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
celebrationMusic = false
applauseVolume = 1
applauseDecrease = -0.1

// 
ballcarrier = undefined
playerControllerHistory = [undefined,undefined]
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
scoreline[0] = obj_UltManManagerController.lastScoreline[0]
scoreline[1] = obj_UltManManagerController.lastScoreline[1]
timer = 0
celebrationActive = false
global.celebratingPlayer = undefined
instance_create_depth(room_width/2, room_height/2, 0, obj_UltManBall)

// Create teams
scr_UltManCreateEnemyTeam(UltManPackTier.Bronze)
scr_UltManCreateManagerTeam()

scr_UltManKickoffSetup(false)

audio_play_sound(sou_UltManCheer, 1, true, 0.2)

// Functions
function AnsweredCorrect() 
{
	audio_play_sound(sou_FtDCorrect, 1, false, 1)
	skillCheckAttemptsCounter++
	skillCheckCorrectCounter++
}

function AnsweredIncorrect() 
{
	audio_play_sound(sou_FtDSmallDamage, 1, false, 1)
	var punishmentLength = 200
	skillCheckAttemptsCounter++
	
	if (frozenGoalAttempt = true)
	{
		punishmentLength = obj_UltManBall.owner.shooting
	}
	else
	{
		punishmentLength = obj_UltManBall.owner.passing
	}
	
	var nearPlayer = scr_assignClosestControlledPlayer(frozenTargetX, frozenTargetY)
	var nearDir = point_direction(frozenTargetX, frozenTargetY, nearPlayer.x, nearPlayer.y)
	
	frozenTargetX = frozenTargetX + lengthdir_x(punishmentLength, nearDir - random_range(150,210))
	frozenTargetY = frozenTargetY + lengthdir_y(punishmentLength, nearDir - random_range(150,210))
	
	if (frozenTargetX > room_width or frozenShotMissed)
	{
		frozenTargetX = instance_nearest(frozenTargetX,frozenTargetY,obj_UltManOpponent).x
		frozenTargetY = instance_nearest(frozenTargetX,frozenTargetY,obj_UltManOpponent).y
		frozenShotMissed = true
	}
}