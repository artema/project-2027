//=============================================================================
// FlagPole.
//=============================================================================
class FlagPole extends DeusExDecoration;

enum ESkinColor
{
	SC_China,
	SC_France,
	SC_President,
	SC_UNATCO,
	SC_USA,
	SC_Russia,
	SC_USSR
};

var() travel ESkinColor SkinColor;

// ----------------------------------------------------------------------
// BeginPlay()
// ----------------------------------------------------------------------

function BeginPlay()
{
	Super.BeginPlay();

	SetSkin();
}

// ----------------------------------------------------------------------
// TravelPostAccept()
// ----------------------------------------------------------------------

function TravelPostAccept()
{
	Super.TravelPostAccept();

	SetSkin();
}

// ----------------------------------------------------------------------
// SetSkin()
// ----------------------------------------------------------------------

function SetSkin()
{
	switch (SkinColor)
	{
		case SC_China:		Skin = Texture'FlagPoleTex1'; break;
		case SC_France:		Skin = Texture'FlagPoleTex2'; break;
		case SC_President:	Skin = Texture'FlagPoleTex3'; break;
		case SC_UNATCO:		Skin = Texture'FlagPoleTex4'; break;
		case SC_USA:		Skin = Texture'FlagPoleTex5'; break;
		case SC_Russia:		Skin = Texture'GameMedia.Skins.FlagPoleTex6'; break;
		case SC_USSR:		Skin = Texture'GameMedia.Skins.FlagPoleTex7'; break;
	}
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     FragType=Class'DeusEx.WoodFragment'
     ItemName="����"
     Mesh=LodMesh'DeusExDeco.FlagPole'
     CollisionRadius=17.000000
     CollisionHeight=56.389999
     Mass=40.000000
     Buoyancy=30.000000
}
