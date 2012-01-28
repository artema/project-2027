//====================================================
// ������� ��������. �������� Ded'�� ��� ���� 2027
// Military Helicopter. Copyright (C) 2003 Ded
//====================================================
class MilitaryHelicopter extends Vehicles;

#exec obj load file="..\2027\Textures\GameEffects.utx" package=GameEffects

var bool bCloacked;
var bool bUnCloacked;
var() bool bCamoIsOn;

auto state Flying
{
	function BeginState()
	{
		Super.BeginState();
		LoopAnim('Fly');
	}
}

singular function SupportActor(Actor standingActor)
{
	if (standingActor != None)
		standingActor.TakeDamage(9000, None, standingActor.Location, vect(0,0,0), 'Exploded');
}

//
// ������ ���������������� ���������
//
state ActivateCamo
{
Begin:
   
    if (!bCloacked)
    {
    PlaySound(Sound'CloakUp', SLOT_None, 96, True, 20240, 1.0);
	CloackUp();
	Sleep(0.25*FRand());
	CloackDown();
	Sleep(0.20*FRand());
	CloackUp();
	Sleep(0.15*FRand());
	CloackDown();
	Sleep(0.1*FRand());
	CloackUp();
	Sleep(0.1*FRand());
	CloackDown();
	Sleep(0.1*FRand());
	CloackUp();
	Sleep(0.1*FRand());
	CloackDown();
	Sleep(0.1*FRand());
	CloackUp();
	Sleep(0.1*FRand());
	CloackDown();
	Sleep(0.1*FRand());
	CloackUp();
        bCloacked=True;
    }
}

state DeactivateCamo
{
Begin:
   
    if (!bUnCloacked)
    {
	CloackDown();
	Sleep(0.15*FRand());
	CloackUp();
	Sleep(0.05*FRand());
	CloackDown();
	Sleep(0.1*FRand());
	CloackUp();
	Sleep(0.1*FRand());
	CloackDown();
	Sleep(0.05*FRand());
	CloackUp();
	Sleep(0.1*FRand());
	CloackDown();
	Sleep(0.05*FRand());
	CloackUp();
	Sleep(0.1*FRand());
	CloackDown();
        bUnCloacked=True;
    }
}

function CloackUp()
{
	local SFXCamoOnLight light;
	local SFXCamoOnFlash flash;
	local float size;
	
     MultiSkins[0] = Texture'GameEffects.CamoEffect';
     MultiSkins[1] = Texture'GameEffects.CamoEffect';
     MultiSkins[2] = Texture'GameEffects.CamoEffect';
     Style=STY_Translucent;
     ScaleGlow=2.5;
     
     //if(FRand() < 0.5)
     //{
     	 size =  - (FRand() * 10);
     	
	     light = Spawn(class'SFXCamoOnLight',,, Location);
	     if(light != None) { light.SetBase(Self); light.size = 30 - size; }
	     
		 flash = Spawn(class'SFXCamoOnFlash',,, Location);
		 if(flash != None) { flash.SetBase(Self); flash.size = 30 - size; }
     //}
}

function CloackDown()
{
	local SFXCamoOnLight light;
	local SFXCamoOnFlash flash;
	local float size;
	
     Style=STY_Normal;
     MultiSkins[0] = Texture'BlackHelicopterTex1';
     MultiSkins[1] = Texture'BlackHelicopterTex2';
     MultiSkins[2] = Texture'ReflectionMapTex3';
     ScaleGlow=1.0;
     
     /*if(FRand() < 0.5)
     {
	     size =  - (FRand() * 10);
	     	
	     light = Spawn(class'SFXCamoOnLight',,, Location);
	     if(light != None) { light.SetBase(Self); light.size = 100 - size; }
	     
		 flash = Spawn(class'SFXCamoOnFlash',,, Location);
		 if(flash != None) { flash.SetBase(Self); flash.size = 100 - size; }
     }*/
}

function PostBeginPlay()
{
	Super.PostBeginPlay();

    if (bCamoIsOn)
          CloackUp();
}

defaultproperties
{
     Mesh=LodMesh'DeusExDeco.BlackHelicopter'
     SoundRadius=160
     SoundVolume=255
     AmbientSound=Sound'Ambient.Ambient.Helicopter2'
     CollisionRadius=461.230011
     CollisionHeight=87.839996
     Mass=10000.000000
     Buoyancy=1000.000000
     BindName="MilitaryHelicopter"
}
