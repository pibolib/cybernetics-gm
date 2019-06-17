if(!pause)
{
	time++;
	y = startY + (sin(time/moveRateY)*moveY);
	x = startX + (cos(time/moveRateX)*moveX);
	image_angle += spd*2;
}