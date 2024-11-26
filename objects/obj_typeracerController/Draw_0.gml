/// Draw Event
var LC = obj_languageController
currentFont = draw_get_font()
if (keyboard_check_pressed(vk_tab))
{
	if (questionType = QuestionType.MultipleChoice)
	{
		questionType = QuestionType.Typing
	}
	else
	{
		questionType = QuestionType.MultipleChoice
	}
}
draw_set_font(fn_ArialBlack12)
switch(question.questionType)
{
	case "MultipleChoice":
		scr_drawMultipleChoice(optionsMenu, id)
	break;
	
	case "Typing":
		scr_drawTyping(optionsMenu, id)
	break;
}
draw_set_font(currentFont)

//Back
// Back button
var buttonMiddleX = room_width*0.95
var buttonMiddleY = room_height*0.05
var buttonWidth = 100
var buttonHeight = 25

draw_set_halign(fa_center)
draw_set_valign(fa_middle)
draw_roundrect(buttonMiddleX - buttonWidth/2, buttonMiddleY + buttonHeight/2,buttonMiddleX + buttonWidth/2, buttonMiddleY - buttonHeight/2,true)
draw_set_alpha(1)

draw_text(buttonMiddleX, buttonMiddleY, LC.translate("Back", Games.Menus))

if (mouse_x > buttonMiddleX - buttonWidth/2 &&
	mouse_y < buttonMiddleX + buttonWidth/2 &&
	mouse_y > buttonMiddleY - buttonHeight/2 &&
	mouse_y < buttonMiddleY + buttonHeight/2)
{
	draw_set_alpha(0.3)
	draw_roundrect(buttonMiddleX - buttonWidth/2, buttonMiddleY + buttonHeight/2,buttonMiddleX + buttonWidth/2, buttonMiddleY - buttonHeight/2,false)
	draw_set_alpha(1)

	if (mouse_check_button_pressed(mb_left))
	{
		room_goto(rm_minigameMenu)
		obj_firestore_controller.EndSession()
	}
}