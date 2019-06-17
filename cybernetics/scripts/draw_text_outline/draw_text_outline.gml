///@function draw_text_outlined
///@arg x
///@arg y
///@arg text
///@arg color
///@arg font

draw_set_font(argument4);
draw_set_color(c_black);
for(i=-1;i<=1;i++)
{
	for(j=-1;j<=1;j++)
	{
		draw_text(argument0+i,argument1+j,argument2);	
	}
} 
draw_set_color(argument3);
draw_text(argument0,argument1,argument2);
draw_set_color(c_white);
draw_set_font(fGame);