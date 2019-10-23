// CURVES
// Example:
// Circle equation (center = (xc,yc) and radius = r)
// x = r*sin(t) + xc;
// y = r*cos(t) + xc;

// 0 - Generic
// This is a generic curve 
void generic(float x0, float y0)
{
  translate(x0,y0);
  x = a*pow(cos(p1*t), i) - b*pow(cos(p2*t), j);
  y = c*pow(sin(p3*t), m) - d*pow(sin(p4*t), n);
}

// 1 - Hypotrochoid
// This is a curve traced by a point attached to a circle of radius r
// rolling around the INSIDE of a fixed circle of radius R,
// where the point is at a distance h from the center of the INTERIOR circle.
void hypotrochoid(float x0, float y0)
{
  translate(x0,y0);
  x = (R - r)*cos(t) + h*cos(t*(R - r)/r);
  y = (R - r)*sin(t) - h*sin(t*(R - r)/r);
}

// 2 - Epitrochoid
// This is a curve traced by a point attached to a circle of radius r
// rolling around the OUTSIDE of a fixed circle of radius R,
// where the point is at a distance h from the center of the EXTERIOR circle
void epitrochoid(float x0, float y0)
{
  translate(x0,y0);
  x = (R + r)*cos(t) - h*cos(t*(R + r)/r);
  y = (R + r)*sin(t) - h*sin(t*(R + r)/r);
}