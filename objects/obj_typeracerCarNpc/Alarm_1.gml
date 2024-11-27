/// @description increase 

pos++ 

if (obj_typeracerController.averageAnswerTime == 0 || is_nan(obj_typeracerController.averageAnswerTime)) {
	alarm[1] = 11*60*difficulty
} else {
	alarm[1] = obj_typeracerController.averageAnswerTime*difficulty+1.5*60
}