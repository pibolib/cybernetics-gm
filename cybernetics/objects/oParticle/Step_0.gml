if(!pause)
{
	if(!initiated)
	{
		if(mode = particleMode.directionFade)
		{
			dir = random(365);
			hsp = cos(dir) * random(0.5);
			vsp = sin(dir) * random(0.5);
			sspeed = 0.005;
			aspeed = 0;
		}
		if(mode = particleMode.smoke)
		{
			grv = -0.02;
			dir = random(365);
			hsp = cos(dir) * random(0.5);
			vsp = sin(dir) * random(0.5);
			sspeed = 0.005;
			aspeed = 0;
		}
		if(mode = particleMode.shrapnelGravity)
		{
			grv = 0.1;
			hsp = random_range(-0.5,0.5);
			vsp = random_range(-2,-4);
			sspeed = 0.005;
			aspeed = 5;
		}
		if(mode = particleMode.fastDirectionFade)
		{
			dir = random(365);
			hsp = cos(dir) * random(0.5);
			vsp = sin(dir) * random(0.5);
			sspeed = 0.01;
			aspeed = 0;
		}
		if(mode = particleMode.slowDecaySparkle)
		{
			sprite_index = sSlowDecaySparkleParticle
			hsp = random_range(-1,1);
			vsp = random_range(-2,-0.5);
			grv = 0.01;
			sspeed = 0.005;
			aspeed = 10;
		}
		if(mode = particleMode.stayStill)
		{
			sspeed = 0.005;
			aspeed = 0;
		}
		if(mode = particleMode.jetpackExhaust)
		{
			sspeed = 0.005;
			aspeed = 0;
			vsp = 0.3;
		}
		initiated = true;
	}
	vsp += grv;
	x += hsp;
	y += vsp;
	angle += aspeed;
	scale -= sspeed;
	if(scale <= 0)
	{
		instance_destroy();	
	}
}