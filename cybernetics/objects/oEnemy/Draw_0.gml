if(invun > 0)
{
	if(image_alpha = 1)
	{
		image_alpha = 0;	
	}
	else
	{
		image_alpha = 1;	
	}
}
else
{
	image_alpha = 1;	
}
draw_sprite_ext(sprite_index,image_index,ceil(x),ceil(y),image_xscale,image_yscale,image_angle,c_white,image_alpha);
for(i=0;i<ds_list_size(inventory);i++)
{
	draw_sprite_ext(sItem,inventory[| i],ceil(x)-4+(i*8),ceil(y)-14,0.5,0.5,0,c_white,1);	
}
draw_set_font(fGameSmall);
draw_set_halign(fa_center);
if(ds_list_size(inventory) > 0)
{
	draw_text(ceil(x),ceil(y)-23,string(hp)+"/"+string(mhp));
}
else
{
	draw_text(ceil(x),ceil(y)-17,string(hp)+"/"+string(mhp));
}
draw_set_halign(fa_left);