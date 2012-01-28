//=============================================================================
// PickupDistributor.
//=============================================================================
class PickupDistributor extends Keypoint;

enum ESkinColor
{
	SC_Level1,
	SC_Level2,
	SC_Level3,
	SC_Level4
};

struct SNanoKeyInitStruct
{
	var() name			ScriptedPawnTag;
	var() name			KeyID;
	var() localized String		Description;
	var() ESkinColor			SkinColor;
};

struct SCreditsInitStruct
{
	var() name			ScriptedPawnTag;
	var() int			NumberToGive;
};

struct SWeaponInitStruct
{
	var() name			ScriptedPawnTag;
	var() class<DeusExWeapon>	        WeaponClass;
	var() bool			HasScope;
	var() bool			HasLaser;
	var() bool			HasSilencer;
};

struct SAugmentationInitStruct
{
	var() name			ScriptedPawnTag;
	var() name			Aug1;
	var() name			Aug2;
};

var() localized SNanoKeyInitStruct NanoKeyData[8];
var() SCreditsInitStruct CreditsData[8];
var() SWeaponInitStruct WeaponData[8];
var() SAugmentationInitStruct AugmentationData[8];

function PostPostBeginPlay()
{
	local int i;
	local ScriptedPawn P;
	local NanoKey key;
	local Credits cr;
	local DeusExWeapon wpn;
	local AugmentationCannister augcan;
	local class<DeusExWeapon> tempClass;

	Super.PostPostBeginPlay();

	for(i=0; i<ArrayCount(NanoKeyData); i++)
	{
		if (NanoKeyData[i].ScriptedPawnTag != '')
		{
			foreach AllActors(class'ScriptedPawn', P, NanoKeyData[i].ScriptedPawnTag)
			{
				key = spawn(class'NanoKey', P);
				if (key != None)
				{
					key.KeyID = NanoKeyData[i].KeyID;
					key.Description = NanoKeyData[i].Description;
					key.InitialState = 'Idle2';
					key.GiveTo(P);
					key.SetBase(P);
				}
			}
		}
	}

	for(i=0; i<ArrayCount(WeaponData); i++)
	{
		if (WeaponData[i].ScriptedPawnTag != '')
		{
			foreach AllActors(class'ScriptedPawn', P, WeaponData[i].ScriptedPawnTag)
			{
                                tempClass = WeaponData[i].WeaponClass;
				wpn = spawn(tempClass, P);

				if (wpn != None)
				{
					wpn.bHasScope = WeaponData[i].HasScope;
					wpn.bHasLaser = WeaponData[i].HasLaser;
					wpn.bHasSilencer = WeaponData[i].HasSilencer;
					wpn.InitialState = 'Idle2';
					wpn.GiveTo(P);
					wpn.SetBase(P);
				}
			}
		}
	}

	for(i=0; i<ArrayCount(CreditsData); i++)
	{
		if (CreditsData[i].ScriptedPawnTag != '')
		{
			foreach AllActors(class'ScriptedPawn', P, CreditsData[i].ScriptedPawnTag)
			{
				cr = spawn(class'Credits', P);
				if (cr != None)
				{
					cr.numCredits = CreditsData[i].NumberToGive;
					cr.InitialState = 'Idle2';
					cr.GiveTo(P);
					cr.SetBase(P);
				}
			}
		}
	}

	for(i=0; i<ArrayCount(AugmentationData); i++)
	{
		if (AugmentationData[i].ScriptedPawnTag != '')
		{
			foreach AllActors(class'ScriptedPawn', P, AugmentationData[i].ScriptedPawnTag)
			{
				augcan = spawn(class'AugmentationCannister', P);
				if (augcan != None)
				{
					augcan.AddAugs[0] = AugmentationData[i].Aug1;
					augcan.AddAugs[1] = AugmentationData[i].Aug2;
					augcan.InitialState = 'Idle2';
					augcan.GiveTo(P);
					augcan.SetBase(P);
				}
			}
		}
	}

	Destroy();
}

defaultproperties
{
     bStatic=False
}
