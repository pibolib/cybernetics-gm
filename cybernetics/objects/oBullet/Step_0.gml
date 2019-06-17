if(!pause)
{
	vsp += grv;
	image_angle = point_direction(x,y,x+hsp,y+vsp);
	image_yscale = lerp(image_yscale,3,0.05);
	image_xscale = 1 + abs(hsp) + abs(vsp);
	var bbox_side;
	hsp = lerp(hsp,mhsp,0.05);
	vsp = lerp(vsp,mvsp,0.05);
	if(hsp > 0)
		{
			bbox_side = bbox_right;
		}
		else
		{
			bbox_side = bbox_left;	
		}
		p1 = tilemap_get_at_pixel(tilemap,bbox_side+hsp,bbox_top);
		p2 = tilemap_get_at_pixel(tilemap,bbox_side+hsp,bbox_bottom);
		if(tilemap_get_at_pixel(tilemap,x,bbox_bottom) > 1)
		{
			p2 = 0;	
		}
		if(p1 = 1 or p2 = 1)
		{
			particle(x,y,0.25,particleMode.fastDirectionFade,c_yellow,4);
			instance_destroy();
			sound(hitwall);
			camera_shake(1);	
		}
	if(tilemap_get_at_pixel(tilemap,x,bbox_bottom+vsp) <= 1)
	{
		if(vsp >= 0)
		{
			bbox_side = bbox_bottom;
		}
		else
		{
			bbox_side = bbox_top;	
		}
		if(tilemap_get_at_pixel(tilemap,int64(x),bbox_bottom+1+vsp) <= 1)
		{
			p1 = tilemap_get_at_pixel(tilemap,bbox_left,bbox_side+vsp);
			p2 = tilemap_get_at_pixel(tilemap,bbox_right,bbox_side+vsp);

			if(p1 = 1 or p2 = 1)
			{
				particle(x,y,0.25,particleMode.fastDirectionFade,c_yellow,4);
				instance_destroy();
				sound(hitwall);
				camera_shake(1);
			}	
		}	
		y += vsp;
		x += hsp;
		if(distance_to_object(oPlayer) > threshold)
		{
			particle(x,y,0.25,particleMode.fastDirectionFade,c_yellow,4);
			instance_destroy();	
		}
	}
}
