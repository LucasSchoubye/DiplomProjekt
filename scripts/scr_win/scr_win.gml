// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function win(){
	var prize = 2000
	show_message("You win " + string(prize) + " content coins")
	obj_storeController.balance = real(obj_storeController.balance)+prize
	obj_firestore_controller.UpdateBalance()
}