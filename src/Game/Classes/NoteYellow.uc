//=============================================================================
// �������. �������� Ded'�� ��� ���� 2027
// Note. Copyright (C) 2003 Ded
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class NoteYellow extends InformationDevices;

enum ESkin
{
	ES_Note1,
        ES_Note2,
        ES_Note3
};

var() ESkin SkinType;

function BeginPlay()
{
	Super.BeginPlay();

	switch (SkinType)
	{
		case ES_Note1:
                  MultiSkins[1] = Texture'GameMedia.Skins.NoteYellowTex0';
                                                                    break;

		case ES_Note2:
                  MultiSkins[1] = Texture'GameMedia.Skins.NoteYellowTex1';
                                                                    break;

		case ES_Note3:
                  MultiSkins[1] = Texture'GameMedia.Skins.NoteYellowTex2';
                                                                    break;
	}
}

defaultproperties
{
     bMovable=False
     bBlockActors=False
     bBlockPlayers=False
     bCollideActors=True
     bCollideWorld=False
     FragType=Class'DeusEx.PaperFragment'
     bCanBeBase=True
     Physics=PHYS_None
     bInvincible=True
     HitPoints=5
     ScaleGlow=0.6
     Mesh=LodMesh'GameMedia.NoteYellow'
     CollisionRadius=2.0000000
     CollisionHeight=1.800000
     Mass=1.000000
     Buoyancy=11.000000
}
