//=============================================================================
// Глобальный звук. Сделанно Ded'ом для мода 2027
// Global sound. Copyright (C) 2003 Ded
//=============================================================================
class GlobalSound expands Keypoint;

var() sound MessageSound;
var() Bool bOnceOnly;
function Trigger(Actor Other, Pawn Instigator)
{

	Super.Trigger(Other, Instigator);

	PlaySound(MessageSound,,255,True,1000000,);

	if(bOnceOnly)
		Tag='GlobalSound';
}

defaultproperties
{
     Style=STY_Modulated
     bOnceOnly=False
     bNoDelete=True
     bAlwaysRelevant=True
     Texture=Texture'Engine.S_Ambient'
     bMovable=False
     CollisionRadius=24.000000
     CollisionHeight=24.000000
}
