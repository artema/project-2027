//=============================================================================
// ����������. ������� Ded'�� ��� ���� 2027
// Ashtray. Copyright (C) 2003 Ded
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class Ashtray extends DeusExDecoration;

enum EType
{
	MT_Clean,
	MT_Dirty,
	MT_Smoking,
	MT_Random
};

enum ESkin
{
	ES_Black,
	ES_Gray,
	ES_Blue,
	ES_Red,
        ES_Random
};

var bool bDirty;
var bool bHasSmoke;
var bool bRandomType;
var bool bRandomSkin;
var() EType MeshType;
var() ESkin SkinType;
var ParticleGenerator smokeGen;

//#exec OBJ LOAD FILE=Effects

function BeginPlay()
{
	Super.BeginPlay();

	switch (MeshType)
	{
		case MT_Clean:                            bDirty=False;
                                                     bRandomType=False;
                                                                 break;

		case MT_Dirty:                             bDirty=True;
                                                       bHasSmoke=False;
                                                     bRandomType=False;
                                                                 break;

		case MT_Smoking:                           bDirty=True;
                                                        bHasSmoke=True;
                                                     bRandomType=False;
                                                                 break;

		case MT_Random:                       bRandomType=True;
	}

	switch (SkinType)
	{
		case ES_Black:	                       bRandomSkin=False;
                  MultiSkins[1] = Texture'GameMedia.Skins.AshtrayTex0';
                                                                 break;

		case ES_Gray:	                       bRandomSkin=False;
                  MultiSkins[1] = Texture'GameMedia.Skins.AshtrayTex1';
                                                                 break;

		case ES_Blue:	                       bRandomSkin=False;
                  MultiSkins[1] = Texture'GameMedia.Skins.AshtrayTex2';
                                                                 break;

		case ES_Red:	                       bRandomSkin=False;
                  MultiSkins[1] = Texture'GameMedia.Skins.AshtrayTex3';
                                                                 break;

		case ES_Random:	                        bRandomSkin=True;
                                                                 break;
	}
}

function PostBeginPlay()
{
	Super.PostBeginPlay();

if (bRandomSkin)
{
	if ((FRand() > 0.0) && (FRand() < 0.2))
	   MultiSkins[1] = Texture'GameMedia.Skins.AshtrayTex0';
	else if ((FRand() > 0.2) && (FRand() < 0.4))
	   MultiSkins[1] = Texture'GameMedia.Skins.AshtrayTex1';
	else if ((FRand() > 0.4) && (FRand() < 0.6))
	   MultiSkins[1] = Texture'GameMedia.Skins.AshtrayTex2';
	else if ((FRand() > 0.6) && (FRand() < 0.8))
	   MultiSkins[1] = Texture'GameMedia.Skins.AshtrayTex3';
        else
	   MultiSkins[1] = Texture'GameMedia.Skins.AshtrayTex0';
}

if (bRandomType)
{
	if (FRand() < 0.6)
               bDirty=False;
	else
               bDirty=True;

	if ((FRand() < 0.3) && (bDirty))
               bHasSmoke=True;
}

if (bDirty)
{
	if (FRand() < 0.4)
	   MultiSkins[2] = Texture'PinkMaskTex';

	if (FRand() < 0.1)
	   MultiSkins[3] = Texture'PinkMaskTex';

	if (FRand() < 0.3)
	   MultiSkins[4] = Texture'PinkMaskTex';

	if (FRand() < 0.2)
	   MultiSkins[5] = Texture'PinkMaskTex';

	if (FRand() < 0.1)
	   MultiSkins[6] = Texture'PinkMaskTex';

     if ((bHasSmoke) && (bDirty))
     {
	SetBase(Owner);
	smokeGen = Spawn(class'ParticleGenerator', Self,, Location + vect(0,0,1) * CollisionHeight * 0.1, rot(16384,0,0));
	if (smokeGen != None)
	{
		smokeGen.particleDrawScale = 0.015;
		smokeGen.checkTime = 0.1;
		smokeGen.frequency = 0.2;
		smokeGen.riseRate = 0.0;
		smokeGen.ejectSpeed = 3.0;
		smokeGen.particleLifeSpan = 3.5;
		smokeGen.bRandomEject = True;
		smokeGen.particleTexture = Texture'GameMedia.Effects.ef_ExpSmoke008';
		smokeGen.SetBase(Self);
	}
     }

}
else
{
	   MultiSkins[2] = Texture'PinkMaskTex';
	   MultiSkins[3] = Texture'PinkMaskTex';
	   MultiSkins[4] = Texture'PinkMaskTex';
	   MultiSkins[5] = Texture'PinkMaskTex';
	   MultiSkins[6] = Texture'PinkMaskTex';
	   MultiSkins[7] = Texture'PinkMaskTex';
}

}

function Destroyed()
{
	if ((smokeGen != None) && (bHasSmoke))
		smokeGen.DelayedDestroy();

	Super.Destroyed();
}

defaultproperties
{
     bHasSmoke=False
     bInvincible=False
     FragType=Class'DeusEx.GlassFragment'
     HitPoints=5
     Mesh=LodMesh'GameMedia.Ashtray'
     CollisionRadius=2.800000
     CollisionHeight=0.700000
     Mass=7.000000
     Buoyancy=40.000000
}
