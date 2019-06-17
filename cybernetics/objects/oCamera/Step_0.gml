if(!pMode)
{
	cShakeX = irandom_range(-shake,shake);
	cShakeY = irandom_range(-shake,shake);
	angle = random_range(-shake,shake)/2;
	switch(state)
	{
		case cameraState.followPlayer:
			if(instance_exists(oPlayer))
			{
				
				if(!cutscene and !instance_exists(oDialogue))
				{
					cGTXLookMod = lerp(cGTXLookMod,oPlayer.recentDirX*20,0.01);
					cGTYLookMod = lerp(cGTYLookMod,oPlayer.recentDirY*60,0.05);
				}
				else
				{
					cGTXLookMod = lerp(cGTXLookMod,0,0.05);
					cGTYLookMod = lerp(cGTYLookMod,0,0.05);
				}
			}
			if(instance_exists(oPlayer))
			{
				cGTX = oPlayer.x + cGTXLookMod;
				cGTY = oPlayer.y + cGTYLookMod;
			}
			cScale = 1;
		break;
		case cameraState.goToPoint:
			gtpTime--;
			if(gtpTime <= 0)
			{
				state = cameraState.followPlayer;	
			}
		break;
	}
	
	x = lerp(x,cGTX,0.1);
	y = lerp(y,cGTY,0.1);
	xView = lerp(xView,cSizeX*cScale,0.1);
	yView = lerp(yView,cSizeY*cScale,0.1);
	shake = lerp(shake,0,0.05);
	surface_resize(application_surface,320*surfaceScale,180*surfaceScale);
	if(surfaceScale < 1 and scaleTime = 0)
	{
		surfaceScale = 1;
	}
	else if(scaleTime > 0)
	{
		surfaceScale = clamp(surfaceScale/2,0.1,1);	
	}
	if(scaleTime > 0)
	{
		scaleTime--;	
	}

	cDispX = x + cShakeX;
	cDispY = y + cShakeY;
	vm = matrix_build_lookat(cDispX,cDispY,-10,cDispX,cDispY,0,angle/64,1,angle/64);
	pm = matrix_build_projection_ortho(xView,yView,cMaxDepthNeg,cMaxDepthPos);
	camera_set_view_mat(camera,vm);
	camera_set_proj_mat(camera,pm);
	x = clamp(x,(cSizeX*cScale)/2,room_width-(cSizeX*cScale)/2);
	y = clamp(y,(cSizeY*cScale)/2,room_height-(cSizeY*cScale)/2);
	view_camera[0] = camera;
}