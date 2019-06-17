init();
maxFps = 60;
minFps = 32767;
//pause
pauseTime = 0;
pauseMode = false;
whiteFlash = false;
//score
scr = 0;
gtScr = 0;
scrCached = 0;
scrCacheTime = 0;
nextLevel = 100;
level = 1;
//ammo
clip = 0;
mclip = 6;
reloadTime = 60;
reload = 0;
atk = 1;
baseAtk = 1;
critChance = 0.01;
hasPistol = false;
//health and energy
dhp = 0;
hp = 6;
mhp = 6;
deathCause = -1;
nrg = 300;
mnrg = 300;
//player inventory
inventory = ds_list_create();
for(i=0;i<256;i++)
{
	hasGottenItem[i] = false;
}
numGotten = 0;
invSelected = 0;
//game settings
surface_resize(application_surface,320,180);
musicGain = 0.8;
audioGain = 0.3;
trackList[0] = nothing;
trackList[1] = penbox69;
trackList[2] = penbox70_2;
trackList[3] = penbox73;
trackGain = array_create(array_length_1d(trackList),0);
areaTrack = 3;
musicQueue = ds_list_create();
time = 0;
//chain
chain = 0;
mChain = 0;
chainTotalDMG = 0;
chainTime = 0;
chainPosX = 320;
chainTopPosX = 520;
chainTopPosY = -4;
chainStartPosX = 320;
chainEndPosX = 520;
chainTopEndPosY = -4;
chainTopStartPosY = 16;
masterTime = 1;
modTime = 1;
//objectives
objective[0] = 0;
objectiveMax[0] = 0;
objectiveFinish[0] = -1;
deathTimer = 0;