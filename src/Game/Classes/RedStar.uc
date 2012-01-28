//=============================================================================
// ������. ������� Ded'�� ��� ���� 2027
// Red star. Copyright (C) 2005 Ded
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class RedStar extends DeusExDecoration;

defaultproperties
{
     bCanBeBase=False
     bPushable=False
     bHighlight=False
     Mesh=LodMesh'GameMedia.OldRedStar'
     FragType=Class'DeusEx.PlasticFragment'
     Physics=PHYS_None
     bInvincible=True
     bUnlit=True
     bBlockActors=True
     bBlockPlayers=True
     bCollideActors=True
     bCollideWorld=False
     CollisionRadius=11.000000
     CollisionHeight=11.000000
     Mass=5.000000
     Buoyancy=15.000000
}
