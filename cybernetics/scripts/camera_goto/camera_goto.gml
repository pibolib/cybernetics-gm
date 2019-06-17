///@function camera_goto(x,y,scale,time);
///@arg x
///@arg y
///@arg scale
///@arg time
with(oCamera)
{
	state = cameraState.goToPoint;
	cGTX = argument0;
	cGTY = argument1;
	cScale = argument2;
	gtpTime = argument3;
}