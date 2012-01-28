//=============================================================================
// �����. ������� Ded'�� ��� ���� 2027
// Barrel. Copyright (C) 2003 Ded
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class WoodBarrel extends Seat;

#exec obj load file="Tavern.utx" package=Tavern

defaultproperties
{
     sitPoint(0)=(X=0.000000,Y=-6.500000,Z=19.000000)
     Mesh=LodMesh'GameMedia.WoodBarrel'
     bDirectional=True
     HitPoints=50
     CollisionRadius=17.000000
     CollisionHeight=19.200000
     Mass=80.000000
     Buoyancy=5.000000
     MultiSkins(0)=Texture'Tavern.Wood.WoodBarrel2'
     MultiSkins(1)=Texture'Tavern.Wood.WoodBarrel1'
}
