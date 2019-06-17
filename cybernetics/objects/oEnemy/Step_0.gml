if(!pause)
{
#region collision
	grounded = (in_floor(tilemap,int64(x),bbox_bottom+1) >= 0);
	if(grounded || (in_floor(tilemap,bbox_left,bbox_bottom+1) >= 0) || (in_floor(tilemap,bbox_right,bbox_bottom+1) >= 0))
	{
		if(hp >= 1)
		{
			vsp = (-jsp - abs(hsp/4));
			particle(x,y+8,0.125,particleMode.smoke,make_color_rgb(200,200,200),2);
			grounded = false;
		}
	}
	vsp += grv;
	hsp *= 0.3;
	if(round(hsp) > 0)
	{
		bbox_side = bbox_right;
	}
	else
	{
		bbox_side = bbox_left;	
	}
	p1 = tilemap_get_at_pixel(tilemap,bbox_side+round(hsp),bbox_top);
	p2 = tilemap_get_at_pixel(tilemap,bbox_side+round(hsp),bbox_bottom);
	if(tilemap_get_at_pixel(tilemap,x,bbox_bottom) > 1)
	{
		p2 = 0;	
	}
	if(p1 = 1 or p2 = 1)
	{
		if(hsp > 0)
		{
			x = x - (x mod tileSize) + (tileSize-1) - (bbox_right - x);
		}
		else
		{
			x = x - (x mod tileSize) - (bbox_left - x);	
		}
		hsp = 0;
	}
	if(tilemap_get_at_pixel(tilemap,x,bbox_bottom+round(vsp)) <= 1)
	{
		if(round(vsp) >= 0 and tilemap_get_at_pixel(tilemap,x,bbox_bottom+1) = 1)
		{
			bbox_side = bbox_bottom;
		}
		else
		{
			bbox_side = bbox_top;	
		}
		p1 = tilemap_get_at_pixel(tilemap,bbox_left,bbox_side+round(vsp));
		p2 = tilemap_get_at_pixel(tilemap,bbox_right,bbox_side+round(vsp));
		if(p1 = 1 or p2 = 1)
		{
			if(round(vsp) >= 0)
			{
				y = y - (y mod tileSize) + (tileSize - 1) - (bbox_bottom-y);
			}
			else
			{
				y = y - (y mod tileSize) - (bbox_top - y);	
			}
			if(vsp > 4)
			{
				particle(x,y+8,0.25,particleMode.directionFade,make_color_rgb(150,150,150),vsp);
			}
			vsp = 0;
		}	
	}
	y += vsp;
	x += hsp;
#endregion collision
#region gameplay
	if(invun > 0)
	{
		invun--;	
	}
	if(place_meeting(x,y,oBullet) and invun = 0)
	{
		camera_shake(2);
		sound(hitenemy);
		//damage(oGame.atk);
		if(random(1) < oGame.critChance * (sqrt((oGame.chain+10)/10)))
		{
			dmgCached += oGame.atk;
			oGame.chainTotalDMG += dmgCached;
			dmgCached *= 2;
			dmgTime = 15;
			text(x,y,"LUCKY!",textType.floatUp,c_red);
			oGame.clip += 1;
			sound(choose(ehit_01,ehit_02,ehit_03,ehit_04,ehit_05,ehit_06,ehit_07,ehit_08,ehit_09,ehit_10));
		}
		else
		{
			dmgCached += oGame.atk;
			oGame.chainTotalDMG += oGame.atk;
			dmgTime += 15;
			sound(choose(ehit_01,ehit_02,ehit_03,ehit_04,ehit_05,ehit_06,ehit_07,ehit_08,ehit_09,ehit_10));
		}
		invun = 1;
		dtime = 30 + hp;
		oGame.chain += 1;
		oGame.chainTime = 120;
		if(x < instance_nearest(x,y,oBullet).x)
		{
			hsp += -0.5;
			vsp += -1;
		}
		else
		{
			hsp += 0.5;
			vsp += -1;
		}
		with(instance_nearest(x,y,oBullet))
		{
			particle(x,y,0.25,particleMode.fastDirectionFade,c_yellow,4);
			instance_destroy();
		}
	}
	if(hp < 1 and invun = 0 and dtime <= 0)
	{
		if(dmgCached > 0)
		{
			damage(dmgCached);
		}
		
		camera_shake(10);
		coin_generator(x,y,clamp(3+abs(hp),3,50),false);
		particle(x,y,0.6,particleMode.fastDirectionFade,make_color_rgb(255,0,0),20);	
		particle(x,y,1,particleMode.slowDecaySparkle,make_color_rgb(0,255,255),10);
		instance_destroy();
		sound(choose(edie1,edie2,edie3));
		for(i=0;i<ds_list_size(inventory);i++)
		{
			with(instance_create_layer(x,y,"game",oItem))
			{
				x += random_range(-4,4);
				y += random_range(-4,4);
				itemId = other.inventory[| other.i];
			}	
		}
		ds_list_destroy(inventory);
		pause = 10;
	}
	if(hp < 1)
	{
		dtime--;
		image_angle += 5*(abs(hsp)+abs(vsp));	
	}
	if(dmgCached > 0 and dmgTime = 0)
	{
		damage(dmgCached);
		dmgCached = 0;
	}
	if(dmgTime > 0)
	{
		dmgTime = clamp(dmgTime,0,60);
		dmgTime--;	
	}
	if(hp <= (1/3)*mhp and irandom(32767) > 32700 and hp > 0)
	{
		for(i=0;i<ds_list_size(inventory);i++)
		{
			if(inventory[| i] = item.healthKit)
			{
				heal(ceil(mhp/10));
				text(x,y,"MEDKIT USED",textType.floatUp,c_white);
				ds_list_delete(inventory, i);
			}
		}
	}
	if(place_meeting(x,y,oSpikes) and invun = 0)
	{
		dmgCached += 99;
		dmgTime += 15;
		y -= 1;
		vsp = -jsp;
		invun = 60;
	}
	#endregion gameplay
}