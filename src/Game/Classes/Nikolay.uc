//=============================================================================
// �������. ������� Ded'�� ��� ���� 2027
// Nikolay. Copyright (C) 2007 Ded
//=============================================================================
class Nikolay extends HumanThug;

var() bool bPermanentBleeding;

simulated function Timer()
{
	bleedRate = 0.0;
	PlaySound(sound'MedicalHiss', SLOT_None,,, 256);
}

simulated function StopMyBleed()
{
	bPermanentBleeding = False;
	SetTimer(1,False);
}

function Tick(float deltaTime)
{
	Super.Tick(deltaTime);

	if(bPermanentBleeding)
		bleedRate = 1.0;
}

function PostBeginPlay()
{
	Super.PostBeginPlay();

	if(!bPermanentBleeding)
		UnfamiliarName = FamiliarName;
}

defaultproperties
{
     bPermanentBleeding=True
     Health=5
     HealthHead=50
     HealthTorso=70
     HealthLegLeft=60
     HealthLegRight=40
     HealthArmLeft=40
     HealthArmRight=50
     BaseAccuracy=0.100000
     CarcassType=Class'Game.NikolayCarcass'
     walkAnimMult=1.050000
     GroundSpeed=200.000000
     WalkingSpeed=0.296000
     Mesh=LodMesh'DeusExCharacters.GM_Trench'
     MultiSkins(0)=Texture'GameMedia.Characters.NikolayTex0'
     MultiSkins(1)=Texture'DeusExCharacters.Skins.SmugglerTex2'
     MultiSkins(2)=Texture'DeusExCharacters.Skins.PantsTex8'
     MultiSkins(3)=Texture'DeusExItems.Skins.PinkMaskTex'
     MultiSkins(4)=Texture'DeusExCharacters.Skins.PaulDentonTex1'
     MultiSkins(5)=Texture'DeusExCharacters.Skins.FordSchickTex2'
     MultiSkins(6)=Texture'DeusExItems.Skins.GrayMaskTex'
     MultiSkins(7)=Texture'DeusExItems.Skins.BlackMaskTex'
     CollisionRadius=20.000000
     CollisionHeight=47.500000
     BindName="Nikolay"
}
