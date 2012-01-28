//=============================================================================
// ����. �������� Ded'�� ��� ���� 2027
// Perk. Copyright (C) 2007 Ded
//=============================================================================
class PerkManager extends Actor;

var DeusExPlayer Player;

var Class<Perk> perkClasses[12];

var travel Perk FirstPerk;

var localized string NoToolMessage;
var localized string NoSkillMessage;
var localized string SuccessMessage;
var localized string YourSkillLevelAt;

// ----------------------------------------------------------------------
// Network Replication
// ----------------------------------------------------------------------
replication
{
	reliable if ((Role == ROLE_Authority) && (bNetOwner))
	    perkClasses, FirstPerk, Player;

	reliable if (Role < ROLE_Authority)
	    AddAllPerks;

}

// ----------------------------------------------------------------------
// CreatePerks()
// ----------------------------------------------------------------------
function CreatePerks(DeusExPlayer newPlayer)
{
	local int perkIndex;
	local Perk aPerk;
	local Perk lastPerk;

	FirstPerk = None;
	LastPerk  = None;

	player = newPlayer;

	for(perkIndex=0; perkIndex<arrayCount(perkClasses); perkIndex++)
	{
		if (perkClasses[perkIndex] != None)
		{
			aPerk = Spawn(perkClasses[perkIndex], Self);
			aPerk.Player = player;

			if (aPerk != None)
			{
				if (FirstPerk == None)
				{
					FirstPerk = aPerk;
				}
				else
				{
					LastPerk.next = aPerk;
				}

				LastPerk  = aPerk;
			}
		}
	}
}

// ----------------------------------------------------------------------
// GetPerkFromClass()
// ----------------------------------------------------------------------
simulated function Perk GetPerkFromClass(class PerkClass)
{
	local Perk aPerk;

	aPerk = FirstPerk;
	while(aPerk != None)
	{
		if (aPerk.Class == PerkClass)
			break;

		aPerk = aPerk.next;
	}

	return aPerk;
}

// ----------------------------------------------------------------------
// CheckPerkState()
// ----------------------------------------------------------------------
simulated function bool CheckPerkState(class PerkClass)
{
	local Perk aPerk;
	local bool retval;

	retval = False;

	aPerk = GetPerkFromClass(PerkClass);

	if (aPerk != None)
		retval = aPerk.CheckInstalled();

	return retval;
}

// ----------------------------------------------------------------------
// GivePerk()
// ----------------------------------------------------------------------
function GivePerk(Perk aNewPerk)
{
	if (aNewPerk.InstallPerk())
		Player.ClientMessage(Sprintf(YourSkillLevelAt, aNewPerk.PerkName));
	else
		Player.ClientMessage(NoSkillMessage);
}

// ----------------------------------------------------------------------
// SetPlayer()
// ----------------------------------------------------------------------
function SetPlayer(DeusExPlayer newPlayer)
{
	local Perk aPerk;

	Player = newPlayer;

	aPerk = FirstPerk;
	while(aPerk != None)
	{
		aPerk.player = newPlayer;
		aPerk = aPerk.next;
	}
}

// ----------------------------------------------------------------------
// AddAllPerks()
// ----------------------------------------------------------------------
function AddAllPerks()
{
	local Perk aPerk;

	aPerk = FirstPerk;
	while(aPerk != None)
	{
		GivePerk(aPerk);
		aPerk = aPerk.next;
	}
}

// ----------------------------------------------------------------------
// ResetPerks()
// ----------------------------------------------------------------------
function ResetPerks()
{
	local Perk aPerk;

	aPerk = FirstPerk;
	while(aPerk != None)
	{
		aPerk.bInstalled = False;
		aPerk = aPerk.next;
	}
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------
//
defaultproperties
{
     perkClasses(0)=Class'DeusEx.PerkEnergy'
     perkClasses(1)=Class'DeusEx.PerkFire'
     perkClasses(2)=Class'DeusEx.PerkAugs'     
     perkClasses(3)=Class'DeusEx.PerkBotsammo'
     perkClasses(4)=Class'DeusEx.PerkMarksman'
     perkClasses(5)=Class'DeusEx.PerkDoubleMods'
     perkClasses(6)=Class'DeusEx.PerkStealth'
     perkClasses(7)=Class'DeusEx.PerkBotexplode'
     NoToolMessage=""
     bHidden=True
     bTravel=True
}