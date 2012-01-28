//=============================================================================
// Карманный компьютер. Сделано Ded'ом для мода 2027
// Pocket PC.  Copyright (C) 2004 Ded
// Автор модели/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class Palm extends InformationDevices;

function PostBeginPlay()
{
	Super.PostBeginPlay();

	if ((FRand() > 0.0) && (FRand() < 0.2))
	   MultiSkins[2] = Texture'GameMedia.Skins.PalmTex0';
	else if ((FRand() > 0.2) && (FRand() < 0.4))
	   MultiSkins[2] = Texture'GameMedia.Skins.PalmTex0';
	else if ((FRand() > 0.4) && (FRand() < 0.6))
	   MultiSkins[2] = Texture'GameMedia.Skins.PalmTex0';
	else if ((FRand() > 0.6) && (FRand() < 0.8))
	   MultiSkins[2] = Texture'GameMedia.Skins.PalmTex0';
        else
	   MultiSkins[2] = Texture'GameMedia.Skins.PalmTex0';

}

defaultproperties
{
     bAddToVault=True
     bInvincible=True
     ItemName="Карманный компьютер"
     bPushable=False
     Physics=PHYS_None
     Mesh=LodMesh'GameMedia.PocketPC'
     CollisionRadius=3.200000
     CollisionHeight=0.500000
     bCollideWorld=True
     bBlockActors=True
     Mass=15.000000
     Buoyancy=2.000000
}
