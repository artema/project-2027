//=============================================================================
// Система погоды. Сделанно Ded'ом для мода 2027
// Weather system. Copyright (C) 2005 Smoke39 - bomberman49@hotmail.com
// (Modified by Ded (C) 2005)
//=============================================================================
class TracerHitsWater extends Effects;

simulated function Tick(float deltaTime)
{
	DrawScale += 4.0 * deltaTime;
	ScaleGlow = LifeSpan / Default.LifeSpan;
}

function PostBeginPlay()
{
	local Rotator rot;

	Super.PostBeginPlay();


	DrawScale *= 0.5 + FRand()/2;
	
	LifeSpan -= FRand()*0.2;

	rot.Pitch = 16384;
	rot.Roll = 0;
	rot.Yaw = Rand(65535);
	SetRotation(rot);
}
//0.01
defaultproperties
{
    LifeSpan=0.30
    DrawType=2
    Style=3
    Skin=Texture'DeusExItems.Skins.FlatFXTex46'
    Mesh=LodMesh'DeusExItems.FlatFX'
    DrawScale=0.1
    bUnlit=True
}
