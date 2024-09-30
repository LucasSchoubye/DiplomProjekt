// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function OptionsMenu() constructor
{
	top = 300
	screenMidX = view_wport[0]/2
	screenMidY = view_hport[0]/2

	answerBoxTop = view_hport[0]*0.7
	answerBoxBot = view_hport[0]*0.95
	answerBoxLeft = view_wport[0]*0.1
	answerBoxRight = view_wport[0]*0.9
	answerBoxMidY = (answerBoxTop+answerBoxBot)/2
	answerBoxMidThirdY = (answerBoxTop-answerBoxBot)/3
	answerBoxQuarterX = (answerBoxRight-answerBoxLeft)/4
	promptBoxHeight = view_hport[0]*0.15
	promptBoxMid = answerBoxTop-promptBoxHeight/2
	twoOptionsX = (answerBoxRight-answerBoxLeft)/4
	twoOptionsY = (answerBoxTop-answerBoxBot)/4
	fourOptionsX = (answerBoxRight-answerBoxLeft)/8
	threeOptionsY = (answerBoxTop-answerBoxBot)/6
}
