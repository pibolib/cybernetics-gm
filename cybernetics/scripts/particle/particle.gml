///@function particle(x,y,start,mode,color,count)
///@arg x
///@arg y
///@arg start
///@arg mode
///@arg color
///@arg count
for(i=0;i<argument5;i++)
{
	with(instance_create_layer(argument0,argument1,"game",oParticle))
	{
		scale = argument2;
		mode = argument3;
		image_blend = argument4;
	}
}