///@function in_floor(tilemap,x,y)
///@arg tilemap
///@arg x
///@arg y

pos = tilemap_get_at_pixel(argument0,argument1,argument2);

if(pos > 0)
{
	if(pos == 1)
	{
		return (argument2 mod tileSize);	
	}
	theFloor = global.heights[(argument1 mod tileSize) + (pos * tileSize)];
	return ((argument2 mod tileSize) - theFloor);
}
else
{
	return -(tileSize - (argument2 mod tileSize));	
}