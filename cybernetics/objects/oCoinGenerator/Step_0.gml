if(!pause)
{
	time++;
	if(!fast)
	{
		if(value > 0)
		{
			with(instance_create_layer(x,y,"game",oCoin))
			{
				value = 1;
				hsp = sin(other.time/4) * (2+other.time/16);
				vsp = cos(other.time/4) * (2+other.time/16);
			}
			value -= 1;
			if(value > 0)
			{
				with(instance_create_layer(x,y,"game",oCoin))
				{
					value = 1;
					hsp = -sin(other.time/4) * (2+other.time/16);
					vsp = -cos(other.time/4) * (2+other.time/16);
				}
			value -= 1;	
			}
			if(value > 0)
			{
				with(instance_create_layer(x,y,"game",oCoin))
				{
					value = 1;
					hsp = -sin(other.time/4) * (2+other.time/16);
					vsp = -cos(other.time/4) * (2+other.time/16);
				}
			value -= 1;	
			}
			if(value > 0)
			{
				with(instance_create_layer(x,y,"game",oCoin))
				{
					value = 1;
					hsp = -sin(other.time/4) * (2+other.time/16);
					vsp = -cos(other.time/4) * (2+other.time/16);
				}
			value -= 1;	
			}
		}
		else if(value = 0)
		{
			particle(x,y,0.4,particleMode.fastDirectionFade,c_white,4);
			instance_destroy();
		}
	}
	else
	{
		if(value >= 50)
		{
			with(instance_create_layer(x,y,"game",oCoin))
			{
				value = 50;
				hsp = sin(other.time/4) * (2+other.time/16);
				vsp = cos(other.time/4) * (2+other.time/16);
			}
		value -= 50;
		}
		else if(value > 0)
		{
			with(instance_create_layer(x,y,"game",oCoin))
			{
				value = other.value;
				hsp = sin(other.time/4) * (2+other.time/16);
				vsp = cos(other.time/4) * (2+other.time/16);
			}
			value = 0;
		}
		else
		{
			instance_destroy();	
		}
	}
}