if(place_meeting(x,y,oPlayer) and keyboard_check_pressed(kbUp))
{
	if(check_condition(condition) and !already)
	{
		event(onInteract);	
		already = true;
		if(oneTime)
		{
			instance_destroy();	
		}
	}
	else if(already)
	{
		event(onInteractAlreadyDone);
	}
	else
	{
		event(onInteractFail);
	}
}