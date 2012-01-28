//=============================================================================
// �����. ������� Ded'�� ��� ���� 2027
// Broom. Copyright (C) 2005 Ded
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class Broom extends DeusExDecoration;

defaultproperties
{
     bCanBeBase=False
     bPushable=False
     Mesh=LodMesh'GameMedia.Broom'
     FragType=Class'DeusEx.WoodFragment'
     Physics=PHYS_None
     HitPoints=10
     bInvincible=False
     ScaleGlow=0.750000
     bBlockActors=True
     bBlockPlayers=True
     bCollideActors=True
     bCollideWorld=False
     CollisionRadius=3.000000
     CollisionHeight=44.200000
     Mass=7.000000
     Buoyancy=15.000000
}
