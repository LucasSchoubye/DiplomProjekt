// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function getDamaged(dmgObj, _iframes = false) {
	
	// special exit for iframe timer
	if ( _iframes == true && iframeTimer > 0) {
		iframeTimer--
		
		// iframe sprite flicker
		if (iframeTimer mod 5 == 0) {
			if (image_alpha == 1) {
				image_alpha = 0
			} else {
				image_alpha = 1
			}
		}
		
		exit
	}
	
	//make sure sprite is visible after flicker
	if (_iframes == true) {
		image_alpha = 1
	}
	
	var _hitConfirm = false
	if (place_meeting(x,y, dmgObj)) {
		var _inst = instance_place(x,y,dmgObj)
		
		// take damage from specific instance
		hp -= _inst.dmg 
		_hitConfirm = true
		// tell the damage instance to destroy itself
		_inst.destroy = true
	}
	
	// set iframes if we were hit 
	if (_iframes == true &&_hitConfirm == true) {
		iframeTimer = iframeNumber
	}
	
}



function getDamagedCreate(_hp = 10, _iframes = false){
	hp = _hp
	hp_max = hp
	if (_iframes == true) {
		iframeTimer = 0
		iframeNumber = 90
	}
}
