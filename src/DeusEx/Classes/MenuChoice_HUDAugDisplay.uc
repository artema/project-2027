//=============================================================================
// MenuChoice_HUDAugDisplay
//=============================================================================

class MenuChoice_HUDAugDisplay extends MenuUIChoiceEnum;

// ----------------------------------------------------------------------
// LoadSetting()
// ----------------------------------------------------------------------

function LoadSetting()
{
	SetValue(int(player.bHUDShowAllAugs));
}

// ----------------------------------------------------------------------
// SaveSetting()
// ----------------------------------------------------------------------

function SaveSetting()
{
	player.bHUDShowAllAugs = bool(GetValue());
	player.AugmentationSystem.RefreshAugDisplay();
}

// ----------------------------------------------------------------------
// ResetToDefault()
// ----------------------------------------------------------------------

function ResetToDefault()
{
	SetValue(defaultValue);
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     defaultValue=1
     defaultInfoWidth=88
helpText="Эта установка определяет какие приращения отображаются в HUD."
actionText="HUD экран приращений"
enumText(0)="Активные"
enumText(1)="Все"
}
