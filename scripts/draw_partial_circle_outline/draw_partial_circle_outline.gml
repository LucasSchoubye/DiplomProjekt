function draw_partial_circle_outline(X, Y, r, angle, thickness)
{
	var x_center = X;
	var y_center = Y;
	var max_angle = angle;

	// Convert the angle to radians since GML's trig functions use radians
	var max_angle_radians = degtorad(max_angle);

	// Draw the partial circle outline using multiple small lines
	for (var i = 0; i <= max_angle_radians; i += 0.05) {
	    var x1 = x_center + cos(i) * r;
	    var y1 = y_center - sin(i) * r;
	    var x2 = x_center + cos(i + 0.05) * r;
	    var y2 = y_center - sin(i + 0.05) * r;

	    draw_line_width(x1, y1, x2, y2, thickness);
	}
}