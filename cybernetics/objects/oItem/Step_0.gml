if(!pause)
{
	if(!initiated)
	{
		switch(itemId)
		{
			case item.ammoBox:
				image_index = 0;
				value = irandom_range(12,24);
				instance_destroy();
			break;
			case item.deathAmmoBox:
				image_index = 1;
			break;
			
			case item.healthKit:
				image_index = 2;
			break;
			case item.heartPack:
				image_index = 3;
				y += 8;
				value = 4;
			break;
			case item.energyPack:
				image_index = 4;
				value = 10;
				y += 8;
			break;
			default:
				image_index = itemId;
			break;
		}
		initiated = true;
	}
	else
	{
		if(distance_to_object(instance_nth_nearest(x,y,oItem,2)) < 5)
		{
			obj = instance_nth_nearest(x,y,oItem,2);
			hsp = cos(point_direction(x,y,obj.x,obj.y)) * 0.1; 
			vsp = sin(point_direction(x,y,obj.x,obj.y)) * 0.1;
		}
		if(place_meeting(x,y,oBullet) and invun <= 0)
		{
			obj = instance_nearest(x,y,oBullet);
			hsp = cos(point_direction(x,y,obj.x,obj.y)) * 3; 
			vsp = sin(point_direction(x,y,obj.x,obj.y)) * 3;
			invun = 60;
		}
		invun--;
		x += hsp;
		y += vsp;
		hsp = lerp(hsp,0,0.2);
		vsp = lerp(vsp,0,0.2);
		if(time < 120 and time mod ceil((time+1)/15) = 0)
		{
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
		time++;
		if(itemId = item.ammoBox or itemId = item.deathAmmoBox or itemId = item.healthKit)
		{
			bgScale = 1 + 0.2*-sin(time/128);
			xscale = clamp(xscale,-0.1,0.1)+sin(time/32);
			yOff = cos(time/64)*8;
			angle = sin(time/32)*30;
			bgAngle += 2;
		}
		else if(itemId = item.heartPack or itemId = item.energyPack)
		{
			xscale = clamp(xscale,-0.1,0.1)+sin(time/32);
			yOff = -abs(sin(time/16)*8);
		}
		else
		{
			bgScale = 1 + 0.2*-sin(time/128);
			xscale = clamp(xscale,-0.1,0.1)+sin(time/32);
			yOff = cos(time/64)*8;
			angle = sin(time/32)*30;
			bgAngle += 2;
		}
		if(place_meeting(x,y,oPlayer) and time >= 120)
		{
			with(oGame)
			{
				ds_list_add(inventory,other.itemId); 
			}
			if(oGame.hasGottenItem[itemId])
			{
				if(itemId != item.healthKit)
				{
					text(x,y,"+"+oGame.itemName[itemId],textType.floatUp,c_lime);
				}
				sound(pickup);
			}
			else
			{
				oGame.scrCached += oGame.numGotten * 5;	
				oGame.scrCacheTime = 30;
			}
			instance_destroy();
			event(onDeath);
		}
	}
}