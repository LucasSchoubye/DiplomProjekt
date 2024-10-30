/// @description Insert description here
// You can write your code in this editor
image_alpha = 1
shrink = 0.05
fade = 0.05

function get_fire_color(alpha) {
    // Clamp the alpha to be between 0 and 1
    alpha = clamp(alpha, 0, 1);

    // Define color transitions based on alpha value
    if (alpha > 0.5) {
        // First half of the fade: from white to orange/red
        var t = (alpha - 0.5) * 2; // Scale for 0.5 to 1 range
        return merge_color(c_orange,c_white, t); // Interpolates between white and orange/red
    } else {
        // Second half of the fade: from orange/red to gray
        var t = alpha * 2; // Scale for 0 to 0.5 range
        return merge_color(c_gray, c_orange, t); // Interpolates between orange/red and gray
    }
}