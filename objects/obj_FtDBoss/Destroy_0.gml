// get rid of bullet if not shot yet
if (instance_exists(bulletInst) && bulletInst.state == 0) {
	bulletInst.destroy = true
}