//=============================================================================
// �����. �������� Ded'�� ��� ���� 2027
// Fire Ball. Copyright (C) 2004 Ded
//=============================================================================
class p_Fireball extends DeusExProjectile;

#exec OBJ LOAD FILE=GameEffects

var() float mpDamage;
var float animSpeed;
var float GlowFactor;
var float ScaleFactor;
var int numFrames;
var int nextFrame;
var texture frames[45];
var float time, totalTime, duration;

simulated function Tick(float deltaTime)
{
	time += deltaTime;
	totalTime += deltaTime;

	DrawScale = 0.25 + (ScaleFactor * totalTime / duration);
	ScaleGlow = GlowFactor*((duration - totalTime) / duration);

	if (time >= animSpeed)
	{
		Texture = frames[nextFrame++];
		if (nextFrame >= numFrames)
			Destroy();

		time -= animSpeed;
	}
}

function PostBeginPlay()
{
	Super.PostBeginPlay();

	duration = animSpeed * numFrames;

	if (FRand() < 0.25)
        {
             LightType=LT_None;
             LightEffect=LE_None;
             LightBrightness=0;
        }
}

function ZoneChange(ZoneInfo NewZone)
{
	Super.ZoneChange(NewZone);

	if (NewZone.bWaterZone)
		Destroy();
}

defaultproperties
{
     ScaleFactor=3.0
     GlowFactor=0.75
     animSpeed=0.015
     numFrames=45
     nextFrame=1
     blastRadius=1.0
     DamageType=Flamed
     AccurateRange=550
     maxRange=550
     bIgnoresNanoDefense=True
     speed=800.000000
     MaxSpeed=800.000000
     Damage=3
     MomentumTransfer=500
     ExplosionDecal=Class'DeusEx.BurnMark'
     LifeSpan=0.75
     DrawType=DT_Sprite
     Style=STY_Translucent
     DrawScale=0.50000
     bUnlit=True
     LightType=LT_Steady
     LightEffect=LE_NonIncidence
     LightBrightness=200
     LightHue=16
     LightSaturation=32
     LightRadius=8
frames(0)=Texture'GameMedia.Effects.spr000'
frames(1)=Texture'GameMedia.Effects.spr001'
frames(2)=Texture'GameMedia.Effects.spr002'
frames(3)=Texture'GameMedia.Effects.spr003'
frames(4)=Texture'GameMedia.Effects.spr004'
frames(5)=Texture'GameMedia.Effects.spr005'
frames(6)=Texture'GameMedia.Effects.spr006'
frames(7)=Texture'GameMedia.Effects.spr007'
frames(8)=Texture'GameMedia.Effects.spr008'
frames(9)=Texture'GameMedia.Effects.spr009'
frames(10)=Texture'GameMedia.Effects.spr010'
frames(11)=Texture'GameMedia.Effects.spr011'
frames(12)=Texture'GameMedia.Effects.spr012'
frames(13)=Texture'GameMedia.Effects.spr013'
frames(14)=Texture'GameMedia.Effects.spr014'
frames(15)=Texture'GameMedia.Effects.spr015'
frames(16)=Texture'GameMedia.Effects.spr016'
frames(17)=Texture'GameMedia.Effects.spr017'
frames(18)=Texture'GameMedia.Effects.spr018'
frames(19)=Texture'GameMedia.Effects.spr019'
frames(20)=Texture'GameMedia.Effects.spr020'
frames(21)=Texture'GameMedia.Effects.spr021'
frames(22)=Texture'GameMedia.Effects.spr022'
frames(23)=Texture'GameMedia.Effects.spr023'
frames(24)=Texture'GameMedia.Effects.spr024'
frames(25)=Texture'GameMedia.Effects.spr025'
frames(26)=Texture'GameMedia.Effects.spr026'
frames(27)=Texture'GameMedia.Effects.spr027'
frames(28)=Texture'GameMedia.Effects.spr028'
frames(29)=Texture'GameMedia.Effects.spr029'
frames(30)=Texture'GameMedia.Effects.spr030'
frames(31)=Texture'GameMedia.Effects.spr031'
frames(32)=Texture'GameMedia.Effects.spr032'
frames(33)=Texture'GameMedia.Effects.spr033'
frames(34)=Texture'GameMedia.Effects.spr034'
frames(35)=Texture'GameMedia.Effects.spr035'
frames(36)=Texture'GameMedia.Effects.spr036'
frames(37)=Texture'GameMedia.Effects.spr037'
frames(38)=Texture'GameMedia.Effects.spr038'
frames(39)=Texture'GameMedia.Effects.spr039'
frames(40)=Texture'GameMedia.Effects.spr040'
frames(41)=Texture'GameMedia.Effects.spr041'
frames(42)=Texture'GameMedia.Effects.spr042'
frames(43)=Texture'GameMedia.Effects.spr043'
frames(44)=Texture'GameMedia.Effects.spr044'
     Texture=Texture'GameMedia.Effects.spr000'
}
