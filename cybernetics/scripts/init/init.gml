//pibolib version 1.0
///@function init()
//developed by The Tin Whistle Consortium
//(C) 2019 All Rights Reserved.
#macro tileSize 16
#macro pause oGame.pauseTime
#macro pMode oGame.pauseMode
#macro cutscene instance_exists(oCutscene)
//config keys, never should have more than 8
configKBLEFT = "a";
configKBRIGHT = "d";
configKBUP = "w";
configKBDOWN = "s";

configKBJUMP = "o";
configKBPRIMARY = "p";
configKBSECONDARY = "l";
configKBSTART = vk_enter;

#macro kbLeft ord(string_upper(oGame.configKBLEFT))
#macro kbRight ord(string_upper(oGame.configKBRIGHT))
#macro kbUp ord(string_upper(oGame.configKBUP))
#macro kbDown ord(string_upper(oGame.configKBDOWN))

#macro kbJump ord(string_upper(oGame.configKBJUMP))
#macro kbPrimary ord(string_upper(oGame.configKBPRIMARY))
#macro kbSecondary ord(string_upper(oGame.configKBSECONDARY))
#macro kbStart configKBSTART
enum item
{
	generic = -1,
	ammoBox = 0,
	deathAmmoBox = 1,
	healthKit = 2,
	heartPack = 3,
	energyPack = 4,
	pistol = 5,
	revivalCore = 6,
	revivalCoreDepleted = 7,
	mobilityCore = 8,
	vitalityCore = 9,
	autofireCore = 10,
	firepowerCore = 11,
	keyBronze = 12,
	keySilver = 13,
	keyGold = 14,
	keycardCore = 15
}
//1
itemName[item.deathAmmoBox] = "Retrieval";
itemDesc[item.deathAmmoBox] = "This item contains your previous \nlife's savings.";
itemColor[item.deathAmmoBox] = c_white;
//2
itemName[item.healthKit] = "Health Kit";
itemDesc[item.healthKit] = "This item heals you for 10% of your \nmax hp.";
itemColor[item.healthKit] = c_white;
//5
itemName[item.pistol] = "Gun";
itemDesc[item.pistol] = "It's a gun! It has a clip of 6 rounds.\nPress "+string_upper(configKBPRIMARY)+" to use it.";
itemColor[item.pistol]  = c_white;
//6
itemName[item.revivalCore] = "Revival Core";
itemDesc[item.revivalCore] = "This item, when equipped, revives \nyou at 50% of your max hp.";
itemColor[item.revivalCore] = make_color_rgb(255,107,176);
//7
itemName[item.revivalCoreDepleted] = "Depleted Revival Core";
itemDesc[item.revivalCoreDepleted] = "This item will recharge in \n5 minutes.";
itemColor[item.revivalCoreDepleted] = make_color_rgb(117,0,54);
//8
itemName[item.mobilityCore] = "Mobility Core";
itemDesc[item.mobilityCore] = "This item uses energy to allow \nflight for a short period.";
itemColor[item.mobilityCore] = make_color_rgb(102,255,165);
//9
itemName[item.vitalityCore] = "Vitality Core";
itemDesc[item.vitalityCore] = "This item allows for regeneration \nwith a 5 point cost.";
itemColor[item.vitalityCore] = make_color_rgb(255,0,0);
//10
itemName[item.autofireCore] = "Autofire Core";
itemDesc[item.autofireCore] = "This item allows for autofire.";
itemColor[item.autofireCore] = make_color_rgb(255,255,0);
//11
itemName[item.firepowerCore] = "Firepower Core";
itemDesc[item.firepowerCore] = "This item uses energy to \ndouble attack power.";
itemColor[item.firepowerCore] = make_color_rgb(255,0,0);
//12
itemName[item.keyBronze] = "Bronze Key";
itemDesc[item.keyBronze] = "This key is used to unlock \ncertain objects.";
itemColor[item.keyBronze] = make_color_rgb(135,78,0);
//13
itemName[item.keySilver] = "Silver Key";
itemDesc[item.keySilver] = "This key is used to unlock \ncertain objects.";
itemColor[item.keySilver] = make_color_rgb(186,186,186);
//14
itemName[item.keyGold] = "Gold Key";
itemDesc[item.keyGold] = "This key is used to unlock \ncertain objects.";
itemColor[item.keyGold] = make_color_rgb(251,255,137);
//15
itemName[item.keycardCore] = "Core Keycard";
itemDesc[item.keycardCore] = "This keycard is used to unlock \ncapsules containing cores.";
itemColor[item.keycardCore] = make_color_rgb(0,255,255);
enum cameraState
{
	followPlayer = 0,
	goToPoint = 1
}

enum playerState
{
	idle = 0,
	moveLeft = 1,
	moveRight = 2
}
enum particleMode
{
	directionFade = 0,
	smoke = 1,
	shrapnelGravity = 2,
	fastDirectionFade = 3,
	slowDecaySparkle = 4,
	stayStill = 5,
	jetpackExhaust = 6
}
enum spawnType
{
	good = 1,
	evil = 2
}
enum textType
{
	floatUp = 0,
	notifSmall = 1,
	notifLarge = 2,
	floatDown = 3,
	static = 4,
	flashRedYellow = 5,
	flashGreenBlue = 6,
	randomUp = 7,
	randomDown = 8
}
enum dc
{
	generic = 0,
	enemyBlunt = 1,
	spikes = 2,
	sawblade = 3
}


heightsToGet = sprite_get_width(sCollisionSet);
tiles = heightsToGet / tileSize;

//create tiles
var layerid = layer_create(0,"collision");
tilemapid = layer_tilemap_create(layerid,0,0,tsetCollision,tiles,1);
for(i=0;i<=tiles;i++)
{
	tilemap_set(tilemapid,i,i,0);	
}
