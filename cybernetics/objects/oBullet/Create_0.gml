
if(oPlayer.recentDirY = 0)
{
	mhsp = oPlayer.recentDirX * (random_range(14,16));
	hsp = 0;
	mvsp = oPlayer.recentDirY * (random_range(14,16));
	vsp = 0;
}
else
{
	mhsp = 0;
	hsp = 0;
	mvsp = oPlayer.recentDirY * (random_range(14,16));
	vsp = 0;
}
image_angle = point_direction(x,y,x+mhsp,y+mvsp);
tilemap = layer_tilemap_get_id("collision");
threshold = 200;
grv = 0.001;