//=============================================================================
// �������. ������� Ded'�� ��� ���� 2027
// Crate. Copyright (C) 2003 Ded
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class PaperBox_Seat extends Seat;

defaultproperties
{
     bDirectional=True
     HitPoints=15
     sitPoint(0)=(X=0.000000,Y=-12.000000,Z=20.000000)
     FragType=Class'DeusEx.PaperFragment'
     bBlockSight=True
     Mesh=LodMesh'GameMedia.PaperBox'
     CollisionRadius=28.000000
     CollisionHeight=20.000000
     Mass=50.000000
     Buoyancy=60.000000
}
