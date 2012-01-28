//=============================================================================
// ��������� ������. ������� Ded'�� ��� ���� 2027
// Toilet paper. Copyright (C) 2005 Ded
// Deus Ex: 2027
//=============================================================================
class ToiletPaper extends DeusExDecoration;

defaultproperties
{
     bCanBeBase=False
     bPushable=False
     Mesh=LodMesh'GameMedia.ToiletPaper'
     FragType=Class'DeusEx.PlasticFragment'
     Physics=PHYS_None
     HitPoints=10
     bInvincible=True
     ScaleGlow=0.750000
     bBlockActors=True
     bBlockPlayers=True
     bCollideActors=True
     bCollideWorld=False
     CollisionRadius=9.000000
     CollisionHeight=8.000000
     Mass=5.000000
     Buoyancy=15.000000
}
