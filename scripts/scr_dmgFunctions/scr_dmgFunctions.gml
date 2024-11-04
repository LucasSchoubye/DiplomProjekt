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
		
		if (!object_is_ancestor(id.object_index, obj_enemyParent))
		{
			// Knockback Player
			var near = instance_nearest(x,y,obj_enemyParent)
			move_contact_solid(point_direction(x,y,near.x,near.y)-180,_inst.dmg*200)
			audio_play_sound(sou_FtDSmallDamage, 0, false)
		}
		else
		{
			// Knockback Player
			var near = instance_nearest(x,y,obj_FtDPlayer)
			move_contact_solid(point_direction(x,y,near.x,near.y)-180,_inst.dmg*30 + 10)
		}
	}
	
	// set iframes if we were hit 
	if (_iframes == true &&_hitConfirm == true) {
		iframeTimer = iframeNumber
	}
	
	// clamp HP
	hp = clamp(hp,0,hp_max)
}



function getDamagedCreate(_hp = 5, _iframes = false){
	hp = _hp
	hp_max = _hp
	if (_iframes == true) {
		iframeTimer = 0
		iframeNumber = 90
	}
}
