if(!pause)
{
	image_blend = make_color_rgb(255,255,255-value*5);
	time++;
	timeSinceSpawn++;
	x += hsp;
	y += vsp;
	hsp = lerp(hsp,0,0.1);
	vsp = lerp(vsp,0,0.1);
	if(timeSinceSpawn > 120 and instance_exists(oPlayer))
	{
		if(time mod 2 = 0)
		{
			particle(x,y,0.2*image_xscale,particleMode.stayStill,image_blend,1);
		}
		hsp = 0;
		vsp = 0;
		x = lerp(x,oPlayer.x,0.1);
		y = lerp(y,oPlayer.y,0.1);
		if(place_meeting(x,y,oPlayer))
		{
			if(value = 1)
			{
				oGame.scrCached += floor(value * (sqrt((oGame.mChain+10)/10)));
			}
			else
			{
				oGame.scrCached += value;
			}
			oGame.scrCacheTime = 30;
			oGame.nrg += 0.01 * oGame.mnrg;
			particle(x,y,0.2,particleMode.fastDirectionFade,c_white,4);
			instance_destroy();
		}
	}
}