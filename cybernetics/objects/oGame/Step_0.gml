#region pause
if(fps_real > maxFps)
{
	maxFps = round(fps_real);	
}
if(fps_real < minFps and time > 30)
{
	minFps = round(fps_real);	
}
time++;
if(pauseTime > 0)
{
	pauseTime--;
}

if(pauseMode)
{
	pauseTime = 3;	
	if(keyboard_check_pressed(kbLeft))
	{
		invSelected--;	
	}
	if(keyboard_check_pressed(kbRight))
	{
		invSelected++;
	}
	if(keyboard_check_pressed(kbUp))
	{
		invSelected -= 8;	
	}
	if(keyboard_check_pressed(kbDown))
	{
		invSelected += 8;	
	}
	invSelected = clamp(invSelected,0,ds_list_size(inventory)-1);
}
if(keyboard_check_pressed(kbStart) and !instance_exists(oDialogue))
{
	if(!pauseMode)
	{
		pauseMode = true;	
	}
	else
	{
		pauseMode = false;	
	}
}
#endregion pause
#region other
if(invSelected >= ds_list_size(inventory))
{
	invSelected = 0;	
}
if(instance_exists(oPlayer))
{
	x = oPlayer.x;
	y = oPlayer.y;
}
canPlayTrackNum = 0;
for(i=0;i<array_length_1d(trackList);i++){
	if(!audio_is_playing(trackList[i]))
	{
		canPlayTrackNum++;
	}
	if(canPlayTrackNum >= array_length_1d(trackList))
	{
		canPlayTrack = true;	
	}
}
if(canPlayTrack and ds_list_size(musicQueue) > 0)
{
	audio_play_sound(trackList[ds_list_find_value(musicQueue,0)],1,0);	
	ds_list_delete(musicQueue,0);
	canPlayTrack = false;
}
for(i=0;i<array_length_1d(trackGain);i++)
{
	audio_sound_gain(trackList[i],musicGain,0.1);
}
if(ds_list_size(musicQueue) = 0)
{
	event("addTrack",areaTrack);	
}
time++;
#endregion other
#region gameFunctions
if(pauseTime = 0)
{
	if(whiteFlash)
	{
		whiteFlash = false;	
	}
	#region objective
	for(i=0;i<array_length_1d(objective);i++)
	{
		if(objective[i] >= objectiveMax[i])
		{
			event(objectiveFinish[i]);
			if(objective[i] != 0)
			{
				sound_nopitch(jingle);	
			}
			objective[i] = 0;
			objectiveMax[i] = 0;
			objectiveFinish[i] = -1;
		}
	}
	#endregion objective
	#region chain
	if(chainTime > 0)
	{
		chainTime--;
		if(chain > 1)
		{
			chainPosX = lerp(chainPosX,chainStartPosX,0.1);
			chainTopPosX = lerp(chainTopPosX,chainStartPosX,0.1);
			chainTopPosY = lerp(chainTopPosY,chainTopStartPosY,0.3);
		}
	}
	else
	{
		chainPosX = lerp(chainPosX,chainEndPosX,0.01);
		chainTopPosY = lerp(chainTopPosY,chainTopEndPosY,0.05);
		if(chainTopPosY = chainTopEndPosY)
		{
			chainTopPosX = lerp(chainTopPosX,chainEndPosX,0.01);
		}
	}
	if(chainTime = 0)
	{
		chain = 0;	
		chainTotalDMG = 0;
	}
	if(chain > mChain)
	{
		mChain = chain;	
	}
	#endregion chain
	#region score
	if(scrCacheTime > 0)
	{
		scrCacheTime--;	
	}
	if(scrCached > 0 and scrCacheTime = 0)
	{
		text(x,y,"+"+string(scrCached)+" XP",textType.floatUp,c_white);
		gtScr += floor(scrCached);
		scrCached = 0;
	}
	scr = lerp(scr,gtScr,0.075);
	if(gtScr >= nextLevel)
	{
		level += 1;
		gtScr -= nextLevel;
		nextLevel = ceil(nextLevel * 1.5);
		dialogue("You reached level "+string(level)+"!\n+3 HP");
		mhp += 3;
		hp += 3;
	}
	#endregion score
	#region gunReloading
	if(hasPistol)
	{
		if(clip = 0)
		{
			reload++;
			if(instance_exists(oPlayer))
			{
				oPlayer.gunAngle = lerp(oPlayer.gunAngle,90*-oPlayer.recentDirX,0.1);	
			}
			if(reload >= reloadTime)
			{
				clip = mclip;
				sound(rload);
				reload = 0;
			}
		}
	}
	#endregion gunReloading
	#region playerStatBuffs


	if(chain >= atk*5 and instance_exists(oPlayer))
	{
		atk = baseAtk + floor(chain/5);
	}
	else if(chain < 5 and atk > 1 and instance_exists(oPlayer))
	{
		atk = baseAtk;	
	}
	#endregion playerStatBuffs
	#region hpLimit
	dhp = lerp(dhp,hp,0.1);
	hp = clamp(hp,0,mhp);
	#endregion hpLimit
	#region inventoryIteration
	numGotten = 0;
	for(i=0;i<array_length_1d(hasGottenItem);i++)
	{
		if(hasGottenItem[i])
		{
			numGotten++;
		}
	}
	if(keyboard_check_pressed(kbSecondary) and hp > 0)
	{
		invSelected++;
	}
	for(i=0;i<ds_list_size(inventory);i++)
	{
		if(ds_list_size(inventory) > 0)
		{
			if(!hasGottenItem[ds_list_find_value(inventory,i)])
			{
				sound(purchase);
				dialogue("You got the \n"+string(itemName[ds_list_find_value(inventory,i)])+"!",string(itemDesc[ds_list_find_value(inventory,i)]));
				hasGottenItem[ds_list_find_value(inventory,i)] = true;
			}
		}
		switch(inventory[| i])
		{
			case item.deathAmmoBox:
				coin_generator(x,y,lostScr,true);
				ds_list_delete(inventory,i);
				lostScr = 0;
				hasGottenItem[i] = true;
			break;
			case item.healthKit:
				ds_list_delete(inventory,i);
				heal(ceil(mhp/10));
				particle(x,y,1,particleMode.slowDecaySparkle,c_red,6);
			break;
			case item.heartPack:
				with(oGame)
				{
					mhp += 4;
					heal(other.value);	
				}
				dialogue("You found a heart pack. \n+4 Max HP");
				particle(x,y,1,particleMode.slowDecaySparkle,c_red,12);
				ds_list_delete(inventory,i);
			break;
			case item.energyPack:
				with(oGame)
				{
					mnrg += other.value;
				}
				dialogue("You found an energy pack. \n+10 Max Energy");
				particle(x,y,1,particleMode.slowDecaySparkle,c_lime,12);
				ds_list_delete(inventory,i);
			break;
			case item.revivalCoreDepleted:
				hasGottenItem[i] = true;
				if(gtScr >= 100)
				{
					//sound(purchase);
					//ds_list_replace(inventory,ds_list_find_index(inventory,7),6);
					//gtScr -= 100;
				}
			break;
			case item.vitalityCore:
				if(time mod 300 = 0 and ds_list_find_value(inventory,invSelected) = 9 and gtScr >= 5 and hp < mhp)
				{
					gtScr -= 5;
					heal(1);
				}
			break;
			case item.pistol:
				hasPistol = true;
				ds_list_delete(inventory,i);
			break;
		}
	}
	#endregion inventoryIteration
}
#region death
if(!instance_exists(oPlayer) and room != rInit and hp > 0)
{
	instance_create_layer(x,y,"game",oPlayer);
}
if(hp = 0)
{
	if(ds_list_find_value(inventory,invSelected) != 6)
	{
		deathTimer++;
		camera_shake(0.1);
		if(deathTimer = 5)
		{
			camera_shake(15);
			sound(explosion1);
			particle(x,y,1,particleMode.slowDecaySparkle,c_red,15);
			particle(x,y,0.5,particleMode.fastDirectionFade,c_gray,15);
		}
		if(deathTimer = 90)
		{
			deathDialogue = "";
			switch(deathCause)
			{
				case dc.generic:
					deathDialogue = "You have died!";
				break;
				case dc.enemyBlunt:
					deathDialogue = "You were bashed to death!";
				break;
				case dc.spikes:
					deathDialogue = "You were impaled by a bed of spikes!";
				break;
				case dc.sawblade:
					deathDialogue = "Your torso was torn by a sawblade!";
				break;
			}
			deathCause = 0;
			dialogue(deathDialogue);
		}
		if(deathTimer >= 240 and !instance_exists(oDialogue))
		{		
			clip = 0;
			if(ceil(gtScr) > 0)
			{
				with(instance_create_layer(x,y,"game",oItem))
				{
					itemId = item.deathAmmoBox;
				}
			}
			lostScr = ceil(gtScr);
			gtScr = 0;
			instance_create_layer(160,128,"player",oPlayer);
			hp = mhp;
			deathTimer = 0;
		}
	}
	else
	{
	heal(ceil(mhp/2));
	dialogue("You've been revived with 50% \nof your maximum health.");
	ds_list_replace(inventory,ds_list_find_index(inventory,6),7);
	}
}
#endregion death
#endregion gameFunctions