//=============================================================================
// NanoKey.
//=============================================================================
class NanoKey extends DeusExPickup;

#exec obj load file="..\2027\Textures\ResEffects.utx" package=ResEffects

var() name			KeyID;

enum ESkinColor
{
	SC_Level1,
	SC_Level2,
	SC_Level3,
	SC_Level4
};

var() ESkinColor SkinColor;

// ----------------------------------------------------------------------
// BeginPlay()
// ----------------------------------------------------------------------

function BeginPlay()
{
	Super.BeginPlay();

	switch (SkinColor)
	{ 
		case SC_Level1:	   MultiSkins[0] = Texture'GameMedia.Skins.KeyTex0';
                            	     MultiSkins[1] = Texture'ResEffects.KeyTopTex0';
                                                                              break;
		case SC_Level2:	   MultiSkins[0] = Texture'GameMedia.Skins.KeyTex1';
                            	     MultiSkins[1] = Texture'ResEffects.KeyTopTex1';
                                                                              break;
		case SC_Level3:	   MultiSkins[0] = Texture'GameMedia.Skins.KeyTex2';
                            	     MultiSkins[1] = Texture'ResEffects.KeyTopTex2';
                                                                              break;
		case SC_Level4:	   MultiSkins[0] = Texture'GameMedia.Skins.KeyTex3';
                            	     MultiSkins[1] = Texture'ResEffects.KeyTopTex3';
                                                                              break;
	}
}

// ----------------------------------------------------------------------
// GiveTo()
// ----------------------------------------------------------------------

function GiveTo( pawn Other )
{
	local DeusExPlayer player;

	if (Other.IsA('DeusExPlayer'))
	{
		player = DeusExPlayer(Other);
		player.PickupNanoKey(Self);
		Destroy();
	}
	else
	{
		Super.GiveTo(Other);
	}
}

// ----------------------------------------------------------------------
// HandlePickupQuery()
// ----------------------------------------------------------------------

function bool HandlePickupQuery( inventory Item )
{
	local DeusExPlayer player;

	if ( Item.Class == Class )
	{
		player = DeusExPlayer(Owner);
		player.PickupNanoKey(NanoKey(item));
		item.Destroy();
			
		return True;
	}

	return Super.HandlePickupQuery(Item);
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     MultiSkins(0)=Texture'GameMedia.Skins.KeyTex0'
     MultiSkins(1)=Texture'ResEffects.KeyTopTex0'
     ItemName="����-����"
     PlayerViewOffset=(X=30.000000,Z=-12.000000)
     PlayerViewMesh=LodMesh'DeusExItems.NanoKey'
     PickupViewMesh=LodMesh'DeusExItems.NanoKey'
     ThirdPersonMesh=LodMesh'DeusExItems.NanoKey'
     Icon=Texture'DeusExUI.Icons.BeltIconNanoKey'
     Description="NO KEY DESCRIPTION - REPORT THIS AS A BUG!"
     beltDescription="����"
     Mesh=LodMesh'DeusExItems.NanoKey'
     CollisionRadius=2.050000
     CollisionHeight=3.110000
     Mass=1.000000
}
