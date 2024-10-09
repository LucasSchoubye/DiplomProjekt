// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_playerMovement(){

var hSpeed = 0
var vSpeed = 0
var walkSpeed = 6
var runSpeed = 1.3
var diagonalSpeed = 0.707107
var collisionSpeed = walkSpeed + 2

var keyLeft = keyboard_check(vk_left) or keyboard_check(ord("A"));
var keyRight = keyboard_check(vk_right) or keyboard_check(ord("D"));
var keyUp =  keyboard_check(vk_up) or keyboard_check(ord("W"));
var keyDown =  keyboard_check(vk_down) or keyboard_check(ord("S"));


hSpeed = (keyRight - keyLeft) * walkSpeed;
vSpeed = (keyDown - keyUp) * walkSpeed;

if (hSpeed != 0) and (vSpeed != 0) { hSpeed *= diagonalSpeed; vSpeed *= diagonalSpeed; }
if (keyboard_check(vk_shift)) { hSpeed *= runSpeed; vSpeed *= runSpeed; }


	
 // Horizontal movement with collision check
if (!place_meeting(x + hSpeed, y, [obj_wallBackDecor, obj_wallBack, obj_wallCorner, obj_wallDoor, obj_wallFront, obj_wallFrontDecor, obj_wallSide])) {
	x += hSpeed;
}

// Vertical movement with collision check
if (!place_meeting(x, y + vSpeed, [obj_wallBackDecor, obj_wallBack, obj_wallCorner, obj_wallDoor, obj_wallFront, obj_wallFrontDecor, obj_wallSide])) {
    y += vSpeed;
}


x = floor(x);
y = floor(y);
}