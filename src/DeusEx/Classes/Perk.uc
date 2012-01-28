//=============================================================================
// ����. �������� Ded'�� ��� ���� 2027
// Perk. Copyright (C) 2007 Ded
//=============================================================================
class Perk extends Actor;

struct PerkStruct{
	var() int X;
	var() int Y;
};

var() travel bool 		bInstalled;
var() localized string		PerkName;
var() localized string		Description;
var() Texture               	PerkIcon;
var() class	 		NeedsPerk;
var() class	 		NeedsPerkAlt,NeedsPerkAlt2;

var DeusExPlayer Player;

var travel Perk next;	

var() PerkStruct PerkPosition;	

// ----------------------------------------------------------------------
// network replication
// ----------------------------------------------------------------------

replication
{
    //variables server to client
    reliable if ((Role == ROLE_Authority) && (bNetOwner))
        bInstalled, next;
}

// ----------------------------------------------------------------------
// CheckInstalled()
// ----------------------------------------------------------------------
simulated function bool CheckInstalled()
{
	return bInstalled;
}

// ----------------------------------------------------------------------
// InstallPerk()
// ----------------------------------------------------------------------
function bool InstallPerk(optional DeusExPlayer usePlayer)
{
	local DeusExPlayer localPlayer;

	// First make sure we're not maxed out
	if (!bInstalled)
	{
		if (usePlayer != None)
			localPlayer = usePlayer;
		else
			localPlayer = Player;

		if (localPlayer != None) 
		{
			if (localPlayer.UpgradePoints >= 1)
			{
				localPlayer.UpgradePoints--;
				bInstalled = True;
				return True;
			}
		}
		else
		{
			bInstalled = True;
			return True;
		}
	}

	return False;
}

// ----------------------------------------------------------------------
// CanAffordToInstall()
// ----------------------------------------------------------------------
simulated function bool CanAffordToInstall(int upgradePointsAvailable)
{
	if (bInstalled == True) 
		return False;
	else if(upgradePointsAvailable < 1)
		return False;
	else
		return True;
}

// ----------------------------------------------------------------------
// UpdateInfo()
// ----------------------------------------------------------------------

simulated function bool UpdateInfo(Object winObject)
{
	local PersonaInfoWindow winInfo;

	winInfo = PersonaInfoWindow(winObject);
	if (winInfo == None)
		return False;

	winInfo.Clear();
	winInfo.SetTitle(PerkName);
	winInfo.SetText(Description);

	return True;
}

simulated function bool CanBeInstalled()
{
	local Perk needs;
	local bool has1,has2,has3;

	return true;

	/*if(NeedsPerk != None || NeedsPerkAlt != None || NeedsPerkAlt2 != None){
		if(NeedsPerk != None){
			needs = player.PerkSystem.GetPerkFromClass(NeedsPerk);
			has1 = needs.CheckInstalled();
		}

		if(NeedsPerkAlt != None){
			needs = player.PerkSystem.GetPerkFromClass(NeedsPerkAlt);
			has2 = needs.CheckInstalled();
		}

		if(NeedsPerkAlt2 != None){
			needs = player.PerkSystem.GetPerkFromClass(NeedsPerkAlt2);
			has3 = needs.CheckInstalled();
		}

		if(has1 || has2 || has3)
			return True;
		else
			return False;
		
	}
	else
		return True;
	*/
}


defaultproperties
{
     bHidden=True
     bTravel=True
     NetUpdateFrequency=5.000000
     bInstalled=False
     PerkName=""
     Description=""
     PerkIcon=None
     NeedsPerk=None
     NeedsPerkAlt=None
     NeedsPerkAlt2=None
     PerkPosition=(X=0,Y=0)
}
