if(!pause and !pMode)
{
	#region eventChangeHandler
	nextev--;
	if(nextev = 0)
	{
		ev++;
	}
	#endregion eventChangeHandler
	if(nextev = 0)
	{
		switch(scene)
		{
			#region 0
			case 0:
				switch(ev)
				{
					case 0:
						camera_goto(841,79,1,32767);
						oGame.currentTrack = 0;
						tilemap_set(layer_tilemap_get_id(layer_get_id("collision")),1,49,7);
						nextev = 64;
						camera_shake(5);
						sound(choose(explosion1,explosion2));
					break;
					case 1:
						tilemap_set(layer_tilemap_get_id(layer_get_id("collision")),1,50,7);
						tilemap_set(layer_tilemap_get_id(layer_get_id("collision")),1,49,8);
						nextev = 49;
						camera_shake(5);
						sound(choose(explosion1,explosion2));
					break;
					case 2:
						tilemap_set(layer_tilemap_get_id(layer_get_id("collision")),1,51,7);
						tilemap_set(layer_tilemap_get_id(layer_get_id("collision")),1,49,9);
						tilemap_set(layer_tilemap_get_id(layer_get_id("collision")),1,50,8);
						nextev = 36;
						camera_shake(5);
						sound(choose(explosion1,explosion2));
					break;
					case 3:
						tilemap_set(layer_tilemap_get_id(layer_get_id("collision")),1,52,7);
						nextev = 25;
						camera_shake(5);
						sound(choose(explosion1,explosion2));
					break;
					case 4:
						tilemap_set(layer_tilemap_get_id(layer_get_id("collision")),1,53,7);
						nextev = 16;
						camera_shake(5);
						sound(choose(explosion1,explosion2));
					break;
					case 5:
						tilemap_set(layer_tilemap_get_id(layer_get_id("collision")),1,54,7);
						nextev = 9;
						camera_shake(5);
						sound(choose(explosion1,explosion2));
					break;
					case 6:
						tilemap_set(layer_tilemap_get_id(layer_get_id("collision")),1,55,7);
						nextev = 4;
						camera_shake(5);
						sound(choose(explosion1,explosion2));
					break;
					case 7:
						tilemap_set(layer_tilemap_get_id(layer_get_id("collision")),0,56,4);
						tilemap_set(layer_tilemap_get_id(layer_get_id("collision")),0,56,5);
						tilemap_set(layer_tilemap_get_id(layer_get_id("collision")),0,56,6);
						nextev = 1;
						camera_shake(15);
						sound_nopitch(jingle);
						sound(choose(explosion1,explosion2));
						sound(choose(explosion1,explosion2));
						sound(choose(explosion1,explosion2));
						dialogue("An opening has formed.");
					break;
					case 8:
						event("setAreaTrack",2);
						camera_reset();
						instance_destroy();
					break;
				}
			break;

			#endregion 0
			#region 1
			case 1:
				switch(ev)
				{
					case 0:
						oGame.currentTrack = 0;
						camera_goto(65,152,1,32767);
						camera_shake(15);
						nextev = 60;
					break;
					case 1:
						tilemap_set(layer_tilemap_get_id(layer_get_id("collision")),0,4,9);
						sound(choose(explosion1,explosion2));
						camera_shake(5);
						nextev = 30;
						with(oSpikes)
						{
							if(ref = "testChallengeSpikes0")
							{
								x -= 32;	
							}
						}
					break;
					case 2:
						tilemap_set(layer_tilemap_get_id(layer_get_id("collision")),0,5,9);
						sound(choose(explosion1,explosion2));
						camera_shake(5);
						nextev = 30;
						with(oSpikes)
						{
							if(ref = "testChallengeSpikes0")
							{
								x -= 32;	
							}
						}
	
					break;
					case 3:
						tilemap_set(layer_tilemap_get_id(layer_get_id("collision")),0,6,9);
						sound(choose(explosion1,explosion2));
						camera_shake(5);
						nextev = 30;
						with(oSpikes)
						{
							if(ref = "testChallengeSpikes0")
							{
								x -= 32;	
							}
						}
					break;
					case 4:
						camera_goto(61,231,1,32767);
						nextev = 60;
					break;
					case 5:
						tilemap_set(layer_tilemap_get_id(layer_get_id("collision")),0,1,14);
						sound(choose(explosion1,explosion2));
						camera_shake(5);
						nextev = 30;
						with(oSpikes)
						{
							if(ref = "testChallengeSpikes1")
							{
								x -= 16;	
							}
						}
					break;
					case 6:
						tilemap_set(layer_tilemap_get_id(layer_get_id("collision")),0,2,14);
						sound(choose(explosion1,explosion2));
						camera_shake(5);
						nextev = 30;
						with(oSpikes)
						{
							if(ref = "testChallengeSpikes1")
							{
								x -= 16;	
							}
						}
					break;
					case 7:
						tilemap_set(layer_tilemap_get_id(layer_get_id("collision")),0,3,14);
						sound(choose(explosion1,explosion2));
						camera_shake(5);
						nextev = 30;
						with(oSpikes)
						{
							if(ref = "testChallengeSpikes1")
							{
								x -= 16;	
							}
						}
					break;
					case 8:
						camera_goto(64,305,1,60);
						nextev = 60;
					break;
					case 9:
						oGame.currentTrack = 1;
						sound_nopitch(jingle);
						dialogue("Congratulations!");
						instance_destroy();
					break;
				}
			break;
			#endregion 1
		}
	}
}