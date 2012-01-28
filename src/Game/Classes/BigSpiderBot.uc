//=============================================================================
// �����-����. �������� Ded'�� ��� ���� 2027
// Spider-bot. Copyright (C) 2003 Ded
//=============================================================================
class BigSpiderBot extends Robot;

enum ESkinColor
{
	SC_Default,
	SC_MJ12
};

var() ESkinColor SkinColor;

function BeginPlay()
{
	Super.BeginPlay();

	switch (SkinColor)
	{
		case SC_Default:	Skin = Texture'DeusExCharacters.Skins.SpiderBotTex1'; break;
		case SC_MJ12:	        Skin = Texture'GameMedia.Characters.SpiderBotTex2';   break;
	}
}

defaultproperties
{
     SpawnAmmo=Class'DeusEx.RAmmoBattery'
     SpawnAmmoCount=40
     EMPHitPoints=100
     maxRange=1400.000000
     WalkingSpeed=1.000000
     bEmitDistress=True
     InitialInventory(0)=(Inventory=Class'Game.WeaponBigSpiderBot')
     InitialInventory(1)=(Inventory=Class'DeusEx.RAmmoBattery',Count=99)
     WalkSound=Sound'DeusExSounds.Robot.SpiderBotWalk'
     GroundSpeed=80.000000
     WaterSpeed=50.000000
     AirSpeed=144.000000
     AccelRate=500.000000
     Health=400
     UnderWaterTime=20.000000
     AttitudeToPlayer=ATTITUDE_Ignore
     DrawType=DT_Mesh
     Mesh=LodMesh'DeusExCharacters.SpiderBot'
     CollisionRadius=111.930000
     CollisionHeight=50.790001
     Mass=1000.000000
     Buoyancy=100.000000
     BindName="SpiderBot"
     FamiliarName="������� ����-���"
     UnfamiliarName="������� ����-���"
}
