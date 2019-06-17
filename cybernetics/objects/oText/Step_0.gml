if(!pause)
{
	if(!initiated)
	{
		switch(mode)
		{
			case 0:
				gtx = x;
				gty = y - 16;
			break;
			case 1:
			
			break;
			case 2:
		
			break;
			case 3:
				gtx = x;
				gty = y + 16;
			break;
			case 4:
		
			break;
			case 5:
		
			break;
			case 6:
		
			break;
			case 7:
				gtx = x + random_range(-8,8);
				gty = y - random_range(24,32);
				flickerTime = 60;
			break;
			case 8:
				gtx = x + random_range(-8,8);
				gty = y + random_range(24,32);	
				flickerTime = 60;
			break;
		}
		startFlicker = flickerTime;
		initiated = true;
	}
	if(flickerTime <= 0)
	{
		instance_destroy();	
	}
	if(flickerTime < startFlicker/2 and flickerTime mod ceil(amt/30) = 0)
	{
		amt = lerp(amt,startFlicker,0.1);
		if(image_alpha = 1)
		{
			image_alpha = 0;	
		}
		else
		{
			image_alpha = 1;	
		}
	}
	if(flickerTime > 0)
	{
		flickerTime--;	
	}
	x = lerp(x,gtx,0.1);
	y = lerp(y,gty,0.1);
}