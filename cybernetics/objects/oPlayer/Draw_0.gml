draw_sprite_ext(sprite_index,image_index,ceil(x),ceil(y),xscale,yscale,angle,c_white,alpha);
if(oGame.hasPistol)
{
	draw_sprite_ext(sPistol,0,gunPosX,gunPosY,gunXscale,1,gunAngle,c_white,1);
}