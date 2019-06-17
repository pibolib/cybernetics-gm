switch(argument0)
{
	case "hasBronzeKey":
		return oGame.inventory[| oGame.invSelected] = item.keyBronze;
	break;
	case "hasSilverKey":
		return oGame.inventory[| oGame.invSelected] = item.keySilver;
	break;
	case "hasGoldKey":
		return oGame.inventory[| oGame.invSelected] = item.keyGold;
	break;
	case "hasCoreKeycard":
		return oGame.inventory[| oGame.invSelected] = item.keycardCore;
	break;
	default:
		return true;
	break;
}