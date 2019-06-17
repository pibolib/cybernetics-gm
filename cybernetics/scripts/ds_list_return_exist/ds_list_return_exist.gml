returnVal = false;
for(i=0;i<ds_list_size(argument0);i++)
{
	if(argument0[| i] = argument1)
	{
		returnVal = true;
	}
}
if(returnVal)
{
	return true;	
}
else
{
	return false;	
}