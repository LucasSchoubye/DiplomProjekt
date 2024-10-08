// get rid of bullet if not shot yet
if (instance_exists(bulletInst) && bulletInst.attack_state == ATTACK_STATE.CHARGING) {
	bulletInst.destroy = true
}