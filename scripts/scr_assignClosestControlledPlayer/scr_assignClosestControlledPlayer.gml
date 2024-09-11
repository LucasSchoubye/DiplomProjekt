// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_assignClosestControlledPlayer(){

var closestPlayer = noone; // Variable to store the closest valid player
var closestDist = -1;      // Variable to store the distance of the closest valid player

// Loop through all instances of obj_UltManPlayer
with (obj_UltManPlayer) {
    // Check if the player is on the player's team
    if (playerTeam == true) {
        // Calculate distance to obj_UltManBall
        var dist = point_distance(x, y, obj_UltManBall.x, obj_UltManBall.y);
        
        // If this is the first valid player or the closest one so far, update the closest player
        if (closestDist == -1 || dist < closestDist) {
            closestDist = dist;
            closestPlayer = id; // 'id' refers to the current instance in 'with'
        }
    }
}

// Assign the closest valid player to controlledPlayer, if one was found
if (closestPlayer != noone) {
    return closestPlayer;
}

}