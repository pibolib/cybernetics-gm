///@function event(ev)
///@arg ev
ev = argument[0];
if(argument_count > 1)
{
	arg0 = argument[1];
}
if(argument_count > 2)
{
	arg1 = argument[2];
}
switch(ev)
{
	case 5:
		cutscene_execute(0);
	break;
	case 6:
		cutscene_execute(1);
	break;
	case "chestOpenTest0":
		coin_generator(oPlayer.x,oPlayer.y,75,true);
		dialogue("You put the bronze key\nin the keyhole.                       ","You got 75 XP!");
		ds_list_delete(oGame.inventory,ds_list_find_index(oGame.inventory,item.keyBronze));
		image_index = 1;
	break;
	case "noBronzeKey":
		dialogue("You need a bronze key\nto open this chest.");
	break;
	case "noSilverKey":
		dialogue("You need a silver key\nto open this chest.");
	break;
	case "noGoldKey":
		dialogue("You need a gold key\nto open this chest.");
	break;
	case "noCoreKeycard":
		dialogue("You need a core keycard\nto open this capsule.");
	break;
	case "chestAlreadyOpen":
		dialogue("There is nothing in the chest.");
	break;
	case "capsuleAlreadyOpen":
		dialogue("There is nothing in the capsule.");
	break;
	case "chestOpenGiveMobilityCore":
		dialogue("You hold the core keycard up to\nthe capsule.");
		with(instance_create_layer(x+8,y-32,"game",oItem))
		{
			time = 120;
			itemId = item.mobilityCore;	
		}
		image_index = 3;
	break;
	case "platformChallengeStart":
		event("setAreaTrack",1);
	break;
	case "skipTrack":
		//add_notif("Skipped current track");
		for(i=0;i<array_length_1d(oGame.trackList);i++)
		{
			audio_stop_sound(oGame.trackList[i]);
		}
	break;
	case "addTrack":
		ds_list_add(oGame.musicQueue,arg0);
		//add_notif("Added Track "+oGame.trackName[arg0]);
	break;
	case "insertTrack":
		ds_list_insert(oGame.musicQueue,arg0,arg1);
		//add_notif("Inserted Track "+oGame.trackName[arg0]+" at pos "+string(arg1));
	break;
	case "playTrack":
		ds_list_insert(oGame.musicQueue,arg0,0);
		//add_notif("Playing Track "+oGame.trackName[arg0]);
		for(i=0;i<array_length_1d(oGame.trackList);i++)
		{
			audio_stop_sound(oGame.trackList[i]);
		}
	break;
	case "setAreaTrack":
		oGame.areaTrack = arg0;
		//add_notif("Inserted Track "+oGame.trackName[arg0]+" at pos "+string(arg1));
		for(i=0;i<array_length_1d(oGame.trackList);i++)
		{
			audio_stop_sound(oGame.trackList[i]);
		}
		if(ds_list_size(oGame.musicQueue) > 0)
		{
			ds_list_clear(oGame.musicQueue);
		}	
	break;
}