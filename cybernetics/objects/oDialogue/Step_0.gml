if(!pMode)
{
	if(!doneAction)
	{
		sprDrawX = lerp(sprDrawX,10,0.1);
		pause = 3;
	}
	else
	{
		sprDrawX = lerp(sprDrawX,-320,0.3);
		if(sprDrawX < -310){
			instance_destroy();
		}
	}
	if (characters < msgLength) { 
		
		hold = keyboard_check(kbPrimary);
		time += 1;
		characters += inc * (1 + hold); 
		msgDraw = string_copy(msg[msgCur], 0, characters); 
		if(string_char_at(msg[msgCur],characters) != " " and time mod 3 = 0)
		{
			sound(txt);	
		}
	} 
	else 
	{ 
		if(keyboard_check_pressed(kbPrimary))
		{ 
		    if (msgCur < msgEnd) 
			{ 
		        msgCur += 1; 
		        msgLength = string_length(msg[msgCur]);  
		        characters = 0; 
		        msgDraw = ""; 
		    }
		    else
			{ 
		        doneAction = true;
		    }
		}
	}
	if(string_length(msg[msgCur]) = 0)
	{
		doneAction = true;
	}
	if(keyboard_check_pressed(kbJump))
	{
		//doneAction = true;	
	}
}