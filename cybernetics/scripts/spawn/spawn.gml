///@function spawn(x,y,object,type,onDeath)
///@arg x
///@arg y
///@arg object
///@arg type
///@arg onDeath
with(instance_create_layer(argument0,argument1,"game",argument2))
{
	onDeath = argument4;	
}
switch(argument3)
{
	case spawnType.good:
		particle(argument0,argument1,0.3,particleMode.directionFade,c_green,6);
	break;
	case spawnType.evil:
		particle(argument0,argument1,0.3,particleMode.smoke,c_purple,6);
	break;
}