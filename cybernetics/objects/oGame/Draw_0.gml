if(room = rInit)
{
	draw_tilemap(tilemapid,0,0);
	for(i=heightsToGet-1;i>=0;i--)
	{
		var check = 0;
		while(check <= tileSize)
		{
			global.heights[i] = check;
			if(check = tileSize)
			{
				break;	
			}
			if(surface_getpixel(application_surface,i,check) != c_black)
			{
				break;
			}
			check++;
		}
	}
	room_goto_next();	
}
