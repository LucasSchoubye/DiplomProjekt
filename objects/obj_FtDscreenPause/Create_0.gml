// fade in
alpha = 0
alphaSpd = 1/90
alphaMax = .6
prize = 2000

depth = -10000


// get prize 
function ftdGetPrize(){
	obj_storeController.balance = real(obj_storeController.balance)+prize
	obj_firestore_controller.UpdateBalance()
}
