//=============================================================================
// Фотография. Сделано Ded'ом для мода 2027
// Photo card.  Copyright (C) 2003 Ded
// Автор модели/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class Photos extends DeusExDecoration
	abstract;

var() Texture ImageTexture;

defaultproperties
{
     bInvincible=True
     FragType=Class'DeusEx.PlasticFragment'
     bPushable=False
     Physics=PHYS_None
     bCollideWorld=True
     bBlockActors=True
}
