//=============================================================================
// PersonaPerkButtonWindow
//=============================================================================
class PersonaPerkButtonWindow extends PersonaItemButton;

var Window                  winIcon;

var Perk perk;

var Color colIconActive;
var Color colIconNormal;
var Color colIconPassive;


// ----------------------------------------------------------------------
// InitWindow()
//
// Initialize the Window
// ----------------------------------------------------------------------

event DrawWindow(GC gc)
{	
	Super.DrawWindow(gc);
}

// ----------------------------------------------------------------------
// CreateControls()
// ----------------------------------------------------------------------
function CreateControls()
{
	SetIconSize(32, 32);
	SetBorderSize(32,32);

}


// ----------------------------------------------------------------------
// SetPerk()
// ----------------------------------------------------------------------
function SetPerk(Perk newPerk)
{
	perk = newPerk;
	RefreshPerkInfo();
}

// ----------------------------------------------------------------------
// GetSkill()
// ----------------------------------------------------------------------
function Perk GetPerk()
{
	return perk;
}

// ----------------------------------------------------------------------
// RefreshPerkInfo()
// ----------------------------------------------------------------------
function RefreshPerkInfo()
{
	local ColorTheme theme;

	if (perk != None)
	{
		theme = player.ThemeManager.GetCurrentHUDColorTheme();

		SetIcon(perk.PerkIcon);

		if(perk.bInstalled)
			colIcon = theme.GetColorFromName('HUDColor_ListHighlight');
		else if(perk.CanBeInstalled() && perk.CanAffordToInstall(player.UpgradePoints))
			colIcon = theme.GetColorFromName('HUDColor_ListText');
		else
			colIcon = theme.GetColorFromName('HUDColor_Background');
	}
}

// ----------------------------------------------------------------------
// SetActive()
// ----------------------------------------------------------------------
function SetActive(bool bNewActive)
{
	bSelected = bNewActive;
}


// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     colIconActive=(B=150)
     colIconNormal=(R=100,G=100,B=100)
     colIconPassive=(R=40,G=40,B=40)
}
