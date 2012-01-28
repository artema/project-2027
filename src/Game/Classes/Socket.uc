//=============================================================================
// �������. ������� Ded'�� ��� ���� 2027
// Socket. Copyright (C) 2003 Ded
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class Socket extends DeusExDecoration;

enum ESkin
{
	ES_Socket1,
	ES_Socket2
};

var() ESkin SkinType;

function BeginPlay()
{
	Super.BeginPlay();

	switch (SkinType)
	{
		case ES_Socket1:
                    MultiSkins[1] = Texture'GameMedia.Skins.SocketTex0';
                                                                 break;

		case ES_Socket2:
                    MultiSkins[1] = Texture'GameMedia.Skins.SocketTex1';
                                                                 break;
	}
}

defaultproperties
{
     bCanBeBase=True
     bPushable=False
     Mesh=LodMesh'GameMedia.Socket'
     FragType=Class'DeusEx.PlasticFragment'
     Physics=PHYS_None
     HitPoints=10
     bInvincible=True
     ScaleGlow=0.2
     bBlockActors=False
     bBlockPlayers=False
     bCollideActors=True
     bCollideWorld=False
     CollisionRadius=3.500000
     CollisionHeight=4.000000
     Mass=5.000000
     Buoyancy=15.000000
}
