
var bbox_side;
if(!pause)
{
	#region gunPos
	gunPosX = lerp(gunPosX,x+2*recentDirX,0.8);
	gunPosY = lerp(gunPosY,y,0.8);
	gunHsp = lerp(gunHsp,0,0.1);
	gunVsp = lerp(gunVsp,0,0.1);
	gunAngle = lerp(gunAngle,recentDirY*-90*gunXscale,0.1);
	gunPosX += gunHsp;
	gunPosY += gunVsp;
	gunXscale = lerp(gunXscale,recentDirX,0.3);
	#endregion gunPos
	time++;
	#region control
		if(!cutscene){
		#region move
		move = -1*keyboard_check(kbLeft) + keyboard_check(kbRight);
		recentDirY = -keyboard_check(kbUp)+keyboard_check(kbDown);
		if(move != 0)
		{
			recentDirX = move;	
		}
		if(abs(hsp) >= 3 and oGame.nrg > 0)
		{
			oGame.nrg -= 0.2;
			msp = lerp(msp,4.5,0.1);
		}
		else
		{
			msp = 3;
			if(oGame.nrg < oGame.mnrg and hsp = 0 and vsp = 0)
			{
				oGame.nrg = lerp(oGame.nrg,oGame.mnrg,0.01);	
			}
		}
		#endregion move
		#region shoot
		if(keyboard_check_pressed(kbPrimary) or (keyboard_check(kbPrimary) and ds_list_find_value(oGame.inventory,oGame.invSelected) = 10 and time mod 10 = 0))
		{
			if(oGame.clip > 0 and oGame.hasPistol)
			{
				oGame.clip--;
				instance_create_layer(x,(bbox_bottom+bbox_top)/2,"game",oBullet);	
				if(ds_list_find_value(oGame.inventory,oGame.invSelected) = 11 and oGame.nrg >= oGame.mnrg/10)
				{
					oGame.nrg -= oGame.mnrg/10;
					instance_create_layer(x,(bbox_bottom+bbox_top)/2,"game",oBullet);
				}
				sound_custompitch(shoot,(11/12)+(oGame.atk/12));
				particle(x,(bbox_bottom+bbox_top)/2,0.25,particleMode.shrapnelGravity,c_yellow,1);
				xscale = 0.8 * recentDirX;
				yscale = 0.8;
				hsp -= recentDirX;
				vsp -= recentDirY;
				if(recentDirY = 0)
				{
					gunHsp = -1 * recentDirX;
					gunAngle = 30 * recentDirX;
					gunVsp = -0.3;
				}
				else
				{
					gunHsp = 0.3 * recentDirX;
					gunAngle = 30 * recentDirY;
					gunVsp = -1 * recentDirY;	
				}
			}
		}
		#endregion shoot
	}
	if(move != 0)
	{
		hsp = lerp(hsp,move*msp,0.1);
	}
	else
	{
		if(oGame.hp != 0)
		{
			hsp = lerp(hsp,0,0.2);
		}
	}

	if(keyboard_check(kbJump) and vsp < 0)
	{
		vsp += grv/1.5;	
	}
	else
	{
		vsp += grv;	
	}
	#region jump
	grounded = (in_floor(tilemap,int64(x),bbox_bottom+1) >= 0);
	if(!cutscene)
	{
		if(grounded || (in_floor(tilemap,bbox_left,bbox_bottom+1) >= 0) || (in_floor(tilemap,bbox_right,bbox_bottom+1) >= 0))
		{
			 vsp = keyboard_check_pressed(kbJump) * (-jsp - abs(hsp/4));
			 if(keyboard_check_pressed(kbJump))
			 {
				particle(x,bbox_bottom,0.5,particleMode.smoke,make_color_rgb(200,200,200),3);
				sound(jump);
				xscale = 0.5*recentDirX;
				yscale = 2;
			 }
		 
			 grounded = false;
		}
		else if(ds_list_return_exist(oGame.inventory,8) and ds_list_find_value(oGame.inventory,oGame.invSelected) = 8)
		{
			if(keyboard_check_pressed(kbJump))
			{
				hasPressedJump = true;	
			}
			if(oGame.nrg >= 5 and hasPressedJump and keyboard_check(kbJump) and !canWallJump)
			{
				if(time mod 3 = 0)
				{
					particle(x+4,bbox_bottom,0.2,particleMode.jetpackExhaust,c_white,1);
					particle(x-4,bbox_bottom,0.2,particleMode.jetpackExhaust,c_white,1);	
					sound(jetpack);
				}
				timePack++;
				vsp = clamp(vsp-0.4,-6,10000);
				oGame.nrg -= 5;
			}
			else
			{
				hasPressedJump = false;	
			}
		}
	}
	#endregion jump
	#region takeDamage
	#region enemy
	if(place_meeting(x,y,oEnemy) and invun = 0 and instance_nearest(x,y,oEnemy).hp > 0)
	{
		oGame.deathCause = dc.enemyBlunt;
		with(oGame)
		{
			sound(ouch);
			damage(instance_nearest(x,y,oEnemy).atk);
			camera_shake(5);
		}
		oCamera.scaleTime = 10;
		invun = 60;
		if(x < instance_nearest(x,y,oEnemy).x)
		{
			hsp = -5;
			vsp = -4;
		}
		else if(x > instance_nearest(x,y,oEnemy).x)
		{
			hsp = 5;
			vsp = -4;
		}
		else
		{
			vsp = -4;
		}
	}
	#endregion enemy
	#region spikes
	if(place_meeting(x,y,oSpikes) and invun = 0)
	{
		with(oGame)
		{
			damage(instance_nearest(x,y,oSpikes).spd);
			sound(ouch);
		}
		oGame.deathCause = dc.spikes;
		oCamera.scaleTime = 10;
		y -= 1;
		vsp = -jsp;
		invun = 60;
	}
	#endregion spikes
	#region sawblade
	if(place_meeting(x,y,oSawblade) and invun = 0)
	{
		with(oGame)
		{
			damage(8);
			sound(ouch);
		}
		oCamera.scaleTime = 10;
		y -= 1;
		vsp = -jsp;
		invun = 60;
		oGame.deathCause = dc.sawblade;
	}
	#endregion sawblade
	#region invunerability
	if(invun > 0)
	{
		invun--;
		if(alpha = 1)
		{
			alpha = 0;	
		}
		else
		{
			alpha = 1;	
		}
	}
	else
	{
		alpha = 1;	
	}
	#endregion invunerability
	#endregion takeDamage
	#region physicsPreCollisionCheck
	hsp += hspFraction;
	vsp += vspFraction;
	
	hspFraction = hsp mod 1;
	hsp -= hspFraction;
	vspFraction = vsp mod 1;
	vsp -= vspFraction;
	#endregion physicsPreCollisionCheck
	
	#endregion control
	#region collision

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
	#region wallJump
	if((tilemap_get_at_pixel(tilemap,bbox_right+1,bbox_bottom) or tilemap_get_at_pixel(tilemap,bbox_left-1,bbox_bottom)) and !cutscene and oGame.nrg >= 30 and tilemap_get_at_pixel(tilemap,x,bbox_bottom+1) = 0)
	{
		canWallJump = true;
		if(keyboard_check_pressed(kbJump))
			{
			oGame.nrg -= 30;
			sound(jump);
			xscale = 0.5;
			yscale = 2;
			vsp = -jsp - abs(hsp/2);
			if(tilemap_get_at_pixel(tilemap,bbox_right+1,bbox_bottom))
			{
				hsp = -6;
				x -= 1;
				particle(x,y,0.5,particleMode.smoke,make_color_rgb(200,200,200),3);
			}
			if(tilemap_get_at_pixel(tilemap,bbox_left-1,bbox_bottom))
			{
				hsp = 6;
				x += 1;
				particle(x,y,0.5,particleMode.smoke,make_color_rgb(200,200,200),3);
			}
		}
		else if(tilemap_get_at_pixel(tilemap,x,bbox_bottom+1) = 0)
		{
			oGame.nrg -= 0.5;
			vsp = clamp(vsp,-32767,1);	
		}
	}
	else
	{
		canWallJump = false;	
	}
	#endregion wallJump
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
				if(vsp >= 0)
				{
					y = y - (y mod tileSize) + (tileSize - 1) - (bbox_bottom-y);
				}
				else
				{
					y = y - (y mod tileSize) - (bbox_top - y);	
				}
				if(vsp > 0)
				{
					xscale = 1.7 * recentDirX;
					yscale = 0.3;
				}
				if(vsp > 4)
				{
					particle(x,y+8,0.5,particleMode.directionFade,make_color_rgb(150,150,150),vsp);
				}
				vsp = 0;
			}	
		}
	}
	y += vsp;
	x += hsp;
	#endregion collision
	#region particles
	if(abs(hsp)+abs(vsp) > 6)
	{
		particle(x,y,0.4,particleMode.smoke,make_color_rgb(irandom_range(200,255),irandom_range(60,120),0),1);	
	}
	if(oGame.chain >= 50)
	{
		particle(x,y,1,particleMode.slowDecaySparkle,make_color_rgb(random_range(0,255),random_range(0,255),random_range(0,255)),1);
	}
	else if(oGame.chain >= 30)
	{
		particle(x,y,0.3,particleMode.smoke,make_color_rgb(0,random_range(150,255),random_range(150,255)),1);	
	}
	else if(oGame.chain >= 20)
	{
		particle(x,y,0.3,particleMode.smoke,make_color_rgb(random_range(150,255),0,0),1);
	}
	else if(oGame.chain >= 10)
	{
		particle(x,y,0.3,particleMode.smoke,make_color_rgb(random_range(200,255),random_range(200,255),0),1);
	}
	#endregion particles
	x = clamp(x,0,room_width);
	y = clamp(y,0,room_height);
	if(cutscene)
	{
		xscale = 1 * recentDirX;
		yscale = 1;
	}
	if(oGame.deathTimer > 0)
	{
		instance_destroy();
	}
	xscale = lerp(xscale,1*recentDirX,0.3);
	yscale = lerp(yscale,1,0.3);
	#region animation
		if(abs(hsp) > 0)
		{
			image_speed = abs(hsp) * 4;	
		}
		else
		{
			image_index = 0;	
		}
	#endregion animation
}