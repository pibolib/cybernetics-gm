#region init
display_set_gui_size(320,180);
draw_set_font(fGameSmall);
#endregion init
#region health
draw_set_font(fUI);
if(hp <= 2 or hp < 0.15 * mhp)
{
	draw_set_color(c_red);	
}
else
{
	draw_set_color(make_color_rgb(255,137,0));
}
if(hp < 10)
{
	dhp = "0"+string(hp);	
}
else
{
	dhp = string(hp);	
}
if(mhp < 10)
{
	dmhp = "0"+string(mhp);	
}
else
{
	dmhp = string(mhp);	
}
draw_text(11,8,string(dhp));
hpSize = string_width(dhp);
draw_set_font(fGameSmall);
hpSize2 = string_width(dmhp);
draw_sprite(sBarXP,0,11,6);
draw_sprite_part(sBarXP,1,0,0,round(sprite_get_width(sBarXP)*(scr/nextLevel)),1,11,6);
draw_text(11+hpSize,7,string(dmhp));
draw_set_color(c_white);
#endregion health
#region ammo
uiY = 24;
uiModY1 = uiY - 2;
if(clip > 0 and hasPistol)
{
	draw_sprite(sUIIcon,3,11,uiModY1);
	draw_sprite_part(sUIIcon,4,0,0,ceil(8*(clip/mclip)),8,11,uiModY1);
}
else if(hasPistol)
{
	draw_sprite(sUIIcon,3,11,uiModY1);
	draw_sprite_part(sUIIcon,5,0,0,ceil(8*reload/reloadTime),8,11,uiModY1);
}

draw_set_color(c_white);
#endregion ammo
#region energy
if(hasPistol)
{
	draw_sprite(sUIIcon,0,20,uiModY1);
	draw_sprite_part(sUIIcon,1,0,0,round(8*(nrg/mnrg)),8,20,uiModY1);
	if(nrg >= mnrg * 0.875)
	{
		draw_sprite(sUIIcon,2,20,uiModY1);	
	}
	draw_sprite(sItemBG,0,19+hpSize+hpSize2,16);
}
#endregion energy
if(ds_list_size(inventory) > 0 and invSelected < ds_list_size(inventory) and inventory[| invSelected] != undefined)
{
	draw_sprite(sItem,inventory[| invSelected],19+hpSize+hpSize2,16);
}
#region chain
draw_set_halign(fa_right);
draw_text(floor(chainPosX),2,"CHAIN:");
draw_text(floor(chainPosX),floor(chainTopPosY)+12,"TOTAL DMG: "+string(chainTotalDMG));
draw_text(floor(chainTopPosX),floor(chainTopPosY)+6,"TOP: "+string(mChain));
draw_set_font(fGame);
draw_text(floor(chainPosX),8,string(chain));
draw_set_halign(fa_left);
#endregion chain
if(whiteFlash)
{
	draw_set_color(c_white);
	draw_rectangle(0,0,320,180,true);
}
#region pause
if(pauseMode)
{
	draw_set_alpha(0.3);
	draw_set_color(c_black);
	draw_rectangle(0,0,320,180,false);
	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_text(160,20,"GAME PAUSED");
	draw_set_halign(fa_left);
	if(ds_list_size(inventory) > 0 and inventory[| invSelected] != undefined)
	{
		draw_text_color(17,135,itemName[inventory[| invSelected]],c_black,c_black,c_black,c_black,1);
		draw_text_color(16,134,itemName[inventory[| invSelected]],itemColor[inventory[| invSelected]],itemColor[inventory[| invSelected]],itemColor[inventory[| invSelected]],itemColor[inventory[| invSelected]],1);
		draw_set_font(fGameSmall);
		draw_text_color(17,149,itemDesc[inventory[| invSelected]],c_black,c_black,c_black,c_black,1);
		draw_text_color(17,148,itemDesc[inventory[| invSelected]],c_white,c_white,c_white,c_white,1);
		draw_set_font(fGame);
	}
	for(i=0;i<8;i++)
	{
		for(j=0;j<6;j++)
		{
		dx = i * 16 + 32;
		dy = j * 16 + 54;
		draw_sprite(sItemBG,1,dx-8,dy-8);	
		}
	}
	for(i=0;i<ds_list_size(inventory);i++)
	{
		dPosX = i mod 8;
		dPosY = floor(i/8);
		dx = dPosX * 16 + 32;
		dy = dPosY * 16 + 54;
		draw_sprite(sItem,inventory[| i],dx-8,dy-8);
		if(i = invSelected)
		{
			draw_sprite(sSelector,0,dx-16,dy-20);
		}
	}
	draw_text_outline(160,40,"LEVEL: ",c_white,fGameSmall);
	draw_text_outline(190,40,string(level),c_yellow,fGameSmall);
	draw_text_outline(160,48,"XP: ",c_white,fGameSmall);
	draw_text_outline(190,48,string(gtScr)+"/"+string(nextLevel),c_yellow,fGameSmall);
	
	draw_text_outline(160,58,"HP: ",c_white,fGameSmall);
	draw_text_outline(190,58,string(hp)+"/"+string(mhp),c_yellow,fGameSmall);
	
	draw_text_outline(160,68,"AMMO: ",c_white,fGameSmall);
	draw_text_outline(190,68,string(clip)+"/"+string(mclip),c_yellow,fGameSmall);
	
	draw_text_outline(160,78,"ITEMS COLLECTED: ",c_white,fGameSmall);
	draw_text_outline(228,78,string(numGotten)+"/"+string(array_length_1d(itemName)),c_yellow,fGameSmall);
	
	
}
#endregion pause
draw_text_outline(1,173,"Version Alpha 5"+", FPS: "+string(round(fps)),c_yellow,fGameSmall);