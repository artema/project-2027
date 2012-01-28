//=============================================================================
// �����-����. �������� Ded'�� ��� ���� 2027
// Spider-bot. Copyright (C) 2003 Ded
//=============================================================================
class MiniSpiderBot extends Robot;

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
     EMPHitPoints=25
     maxRange=640.000000
     MinRange=200.000000
     WalkingSpeed=1.000000
     bEmitDistress=True
     InitialInventory(0)=(Inventory=Class'Game.WeaponMiniSpiderBot')
     InitialInventory(1)=(Inventory=Class'DeusEx.RAmmoBattery',Count=99)
     WalkSound=Sound'DeusExSounds.Robot.SpiderBot2Walk'
     GroundSpeed=300.000000
     WaterSpeed=50.000000
     AirSpeed=144.000000
     AccelRate=500.000000
     Health=80
     UnderWaterTime=20.000000
     AttitudeToPlayer=ATTITUDE_Ignore
     DrawType=DT_Mesh
     Mesh=LodMesh'DeusExCharacters.SpiderBot2'
     CollisionRadius=33.580002
     CollisionHeight=15.240000
     Mass=200.000000
     Buoyancy=50.000000
     BindName="MiniSpiderBot"
}
