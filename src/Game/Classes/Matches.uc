//=============================================================================
// ������. �������� Ded'�� ��� ���� 2027
// Matches. Copyright (C) 2003 Ded
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class Matches extends DeusExDecoration;

enum ESkin
{
	ES_PSR,
	ES_Russian
};

var ParticleGenerator gen;
var() ESkin SkinType;

function BeginPlay()
{
	Super.BeginPlay();

	switch (SkinType)
	{
		case ES_PSR:         MultiSkins[1] = Texture'GameMedia.Skins.MatchesTex0';
                                                                                    break;

		case ES_Russian:     MultiSkins[1] = Texture'GameMedia.Skins.MatchesTex1';
                                                                                    break;
	}
}

defaultproperties
{
     bCanBeBase=True
     bBlockPlayers=False
     FragType=Class'DeusEx.PaperFragment'
     HitPoints=7
     Mesh=LodMesh'GameMedia.Matches'
     CollisionRadius=2.400000
     CollisionHeight=0.400000
     Mass=2.000000
     Buoyancy=1.000000
}
