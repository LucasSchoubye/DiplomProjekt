/// @description Insert description here
// You can write your code in this editor
if (stamZeroHit == true) {
	stamCD += 1
	if (stamCD == stamCDComplete){
		stamCD = 0
		stamZeroHit = false
	}
}
alarm_set(0,60)
	