//=============================================================================
// �������� ��������. �������� Ded'�� ��� ���� 2027
// Gun Fire Detector.  Copyright (C) 2003 Ded
//=============================================================================
class GunDetector extends HackableDevices;

function HackAction(Actor Hacker, bool bHacked)
{
	local Actor A;

	Super.HackAction(Hacker, bHacked);

	if (bHacked)
		AIClearEventCallback('WeaponFire');
}

function NoiseHeard(Name eventName, EAIEventState state, XAIParams params)
{
	local Actor A;

	if (Event != '')
		foreach AllActors(class 'Actor', A, Event)
			A.Trigger(Self, GetPlayerPawn());
}

function PostBeginPlay()
{
	Super.PostBeginPlay();

	AISetEventCallback('WeaponFire', 'NoiseHeard');
}

defaultproperties
{
     Mesh=LodMesh'GameMedia.GunDetector'
     CollisionRadius=17.000000
     CollisionHeight=2.000000
     Mass=10.000000
     Buoyancy=5.000000
}
