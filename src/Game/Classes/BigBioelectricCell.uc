//=============================================================================
// ������� ���-�������. �������� Ded'�� ��� ���� 2027
// Big biocell.  Copyright (C) 2005 Ded
//=============================================================================
class BigBioelectricCell expands BioelectricCell;

simulated function Tick(float deltaTime)
{
      Super.Tick(deltaTime);

     MultiSkins[1]=Texture'GameEffects.BigBioCell_SFX';
     DrawScale=1.200000;
}

function DestroyCell()
{
	NumCopies--;

	if(NumCopies<=0)
		Destroy();
}

defaultproperties
{
     ChargeSound=sound'GameMedia.BigBioHiss'
     rechargeAmount=50
     maxCopies=20
     DrawScale=1.200000
     bCanHaveMultipleCopies=True
     bActivatable=True
     PlayerViewOffset=(X=30.000000,Z=-12.000000)
     PlayerViewMesh=LodMesh'DeusExItems.BioCell'
     PickupViewMesh=LodMesh'DeusExItems.BioCell'
     ThirdPersonMesh=LodMesh'DeusExItems.BioCell'
     LandSound=Sound'DeusExSounds.Generic.PlasticHit2'
     Icon=Texture'Game.Icons.BeltIconBioAcc'
     largeIcon=Texture'Game.Icons.LargeIconBioAcc'
     largeIconWidth=44
     largeIconHeight=43
     Mesh=LodMesh'DeusExItems.BioCell'
     MultiSkins(1)=Texture'GameEffects.BigBioCell_SFX'
     CollisionRadius=5.640000
     CollisionHeight=1.116000
     Mass=10.000000
     Buoyancy=4.000000
}
