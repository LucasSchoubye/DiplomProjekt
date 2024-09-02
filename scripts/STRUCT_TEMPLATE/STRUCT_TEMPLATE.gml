// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
enum Course 
{
	Math,
	English,
	Physics,
	Geography
}

enum AnswerType 
{
	Choice,
	Typing,
	Sequence,
	Slider
}

function Question() constructor
{
	ID = undefined;
	course = undefined;
	answerType = undefined;
	options = undefined;
	answer = undefined;
}