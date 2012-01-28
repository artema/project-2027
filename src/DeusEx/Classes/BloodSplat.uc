//=============================================================================
// BloodSplat.
//=============================================================================
class BloodSplat extends DeusExDecal;

function BeginPlay()
{
	local Rotator rot;
	local float rnd;

	// Gore check
	if (Level.Game.bLowGore || Level.Game.bVeryLowGore)
	{
		Destroy();
		return;
	}

	rnd = FRand();
	if (rnd < 0.25)
		Texture = Texture'FlatFXTex3';
	else if (rnd < 0.5)
		Texture = Texture'FlatFXTex5';
	else if (rnd < 0.75)
		Texture = Texture'FlatFXTex6';

	DrawScale += FRand() * 0.2;

	Super.BeginPlay();
}

simulated function Timer()
{
	// Check for nearby players, if none then destroy self

	if(!bKeepForever)
	{
		if(!bAttached)
		{
			Destroy();
			return;
		}
	
		if(!bStartedLife)
		{
			RemoteRole = ROLE_None;
			bStartedLife = true;
			if ( Level.bDropDetail )
				SetTimer(1.5 + 2 * FRand(), false);
			else
				SetTimer(4.0 + 2 * FRand(), false);
			return;
		}
		
		if(Level.bDropDetail && (MultiDecalLevel < 6))
		{
			if ((Level.TimeSeconds - LastRenderedTime > 0.35) || (!bImportant && (FRand() < 0.2)))
				Destroy();
			else
			{
				SetTimer(1.0, true);
				return;
			}
		}
		else if(Level.TimeSeconds - LastRenderedTime < 1)
		{
			SetTimer(2.5, true);
			return;
		}
		
		Destroy();
	}
}

defaultproperties
{
     Texture=Texture'DeusExItems.Skins.FlatFXTex2'
     DrawScale=0.200000
}
