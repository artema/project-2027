//=============================================================================
// �����. ������� Ded'�� ��� ���� 2027
// Lamp. Copyright (C) 2007 Ded
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class Fakel extends Furniture;

#exec obj load file="GameEffects.utx" package=GameEffects

defaultproperties
{
     MultiSkins(3)=Texture'GameEffects.CoolFire.CFire_A000'
     FragType=Class'DeusEx.WoodFragment'
     bInvincible=True
     bPushable=False
     Mesh=LodMesh'GameMedia.Fakel'
     CollisionRadius=7.000000
     CollisionHeight=8.500000
     bMovable=False
     Mass=40.000000
     Buoyancy=10.000000
}
