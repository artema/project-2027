//=============================================================================
// �����. ������� Ded'�� ��� ���� 2027
// Grass. Copyright (C) 2004 Ded
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class Grass extends OutdoorThings;


function PostBeginPlay()
{
     local DeusExPlayer player;

	Super.PostBeginPlay();

     player = DeusExPlayer(GetPlayerPawn());

     if (player.bNoResurrection)
            bHidden=True;
     else
            bHidden=False;

	if (FRand() < 0.2)
	   MultiSkins[1] = Texture'GameMedia.Skins.GrassTex0';
	else if ((FRand() > 0.2) && (FRand() < 0.6))
	   MultiSkins[1] = Texture'GameMedia.Skins.GrassTex1';
        else
	   MultiSkins[1] = Texture'PinkMaskTex';

	if (FRand() < 0.2)
	   MultiSkins[2] = Texture'GameMedia.Skins.GrassTex1';
	else if ((FRand() > 0.2) && (FRand() < 0.6))
	   MultiSkins[2] = Texture'GameMedia.Skins.GrassTex0';
        else
	   MultiSkins[2] = Texture'PinkMaskTex';

	if ((FRand() > 0.4) && (FRand() < 0.6))
	   MultiSkins[3] = Texture'GameMedia.Skins.GrassTex0';
	else if ((FRand() > 0.1) && (FRand() < 0.4))
	   MultiSkins[3] = Texture'GameMedia.Skins.GrassTex1';
        else
	   MultiSkins[3] = Texture'PinkMaskTex';

	if (FRand() > 0.8)
	   MultiSkins[3] = Texture'GameMedia.Skins.GrassTex0';
	else if ((FRand() < 0.6) && (FRand() > 0.3))
	   MultiSkins[3] = Texture'GameMedia.Skins.GrassTex1';
        else
	   MultiSkins[3] = Texture'PinkMaskTex';
}

defaultproperties
{
     bStatic=False
     bAnimLoop=True
     AnimSequence=Wind
     AnimRate=0.5
     FragType=Class'DeusEx.PaperFragment'
     bHighlight=False
     bInvincible=True
     Mesh=LodMesh'GameMedia.Grass'
     bPushable=False
     Physics=PHYS_None
     ScaleGlow=0.400000
     CollisionRadius=25.000000
     CollisionHeight=9.500000
     bBlockActors=False
     bBlockPlayers=False
     bCollideActors=False
     Mass=1.000000
     Buoyancy=1.000000
}
