// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_doLinesCross(x1, y1, x2, y2, x3, y3, x4, y4){

/// @function lines_intersect(x1, y1, x2, y2, x3, y3, x4, y4)
/// @description Checks if two lines intersect
/// @param x1 The x-coordinate of the first endpoint of line 1
/// @param y1 The y-coordinate of the first endpoint of line 1
/// @param x2 The x-coordinate of the second endpoint of line 1
/// @param y2 The y-coordinate of the second endpoint of line 1
/// @param x3 The x-coordinate of the first endpoint of line 2
/// @param y3 The y-coordinate of the first endpoint of line 2
/// @param x4 The x-coordinate of the second endpoint of line 2
/// @param y4 The y-coordinate of the second endpoint of line 2
/// @return Returns true if the lines intersect, false otherwise


    var denom = (y4 - y3) * (x2 - x1) - (x4 - x3) * (y2 - y1);
    if (denom == 0) {
        return false; // Lines are parallel or coincident
    }

    var ua = ((x4 - x3) * (y1 - y3) - (y4 - y3) * (x1 - x3)) / denom;
    var ub = ((x2 - x1) * (y1 - y3) - (y2 - y1) * (x1 - x3)) / denom;

    return (ua >= 0 && ua <= 1 && ub >= 0 && ub <= 1);
}
