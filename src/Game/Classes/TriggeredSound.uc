//=============================================================================
// ���������� ����. �������� Ded'�� ��� ���� 2027
// Global sound. Copyright (C) 2003 Ded
//=============================================================================
class TriggeredSound expands Keypoint;

var() sound MessageSound;
var() Bool bOnceOnly;

function Trigger(Actor Other, Pawn Instigator)
{
	Super.Trigger(Other, Instigator);

	PlaySound(MessageSound, SLOT_None, 100, True, 12, 64);

	if(bOnceOnly)
		Tag='TriggeredSound';
}

defaultproperties
{
	 SoundVolume=128
     bOnceOnly=False
     bNoDelete=True
     bAlwaysRelevant=True
     Texture=Texture'Engine.S_Ambient'
     bMovable=False
     CollisionRadius=24.000000
     CollisionHeight=24.000000
}
