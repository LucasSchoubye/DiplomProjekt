/// Setup variables for typeracer

questionGenerator = new QuestionGenerator(Curriculum.Danish)
question = undefined
typingString = ""
questionType = QuestionType.Typing
optionsMenu = new OptionsMenu()

question = obj_questionController.questionGenerator.GetQuestion(Subject.Maths, QuestionType.Typing)
