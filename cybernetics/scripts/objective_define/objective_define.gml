///@function objective_define(id,max,reset,onFinish)
///@arg id
///@arg max
///@arg reset
///@arg onFinish

if(argument2)
{
	oGame.objective[argument0] = 0;
	oGame.objectiveMax[argument0] = 0;
}
oGame.objectiveMax[argument0] = argument1;
oGame.objectiveFinish[argument0] = argument3;