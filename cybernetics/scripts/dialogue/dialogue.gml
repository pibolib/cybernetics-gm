//DO NOT USE!
///@function dialogue(text)
///@arg text
if(!instance_exists(oDialogue))
{
	with(instance_create_layer(0,0,"game",oDialogue))
	{
		msgEnd = argument_count;
		for (i = 0; i < argument_count; i++)
		{
			msg[i] = argument[i];
		}
		msgCur = 0;
		msgLength = string_length(msg[msgCur]);
	}
}