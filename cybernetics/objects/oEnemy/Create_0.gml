grv = 0.2;
hsp = 0;
vsp = 0;
hspFraction = 0;
vspFraction = 0;
floorDist = 0;
grounded = false;
jsp = 1.5;
msp = 3;
tilemap = layer_tilemap_get_id("collision");
mhp = irandom_range(1,3);
hp = mhp;

inventory = ds_list_create();
if(irandom(100) < 10)
{
	ds_list_add(inventory,item.healthKit)
}
invun = 0;
dtime = 0;
dmgTime = 0;
dmgCached = 0;
onDeath = 0;
atk = irandom(3) * irandom(3);