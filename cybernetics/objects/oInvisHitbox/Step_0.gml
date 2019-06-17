if(place_meeting(x,y,oPlayer) and !pause)
{
	event(ev);
	if(oneTime)
	{
		instance_destroy();	
	}
}