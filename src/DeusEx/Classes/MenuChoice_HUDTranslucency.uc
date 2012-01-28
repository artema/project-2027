//=============================================================================
// MenuChoice_HUDTranslucency
//=============================================================================

class MenuChoice_HUDTranslucency extends MenuChoice_OnOff;

// ----------------------------------------------------------------------
// LoadSetting()
// ----------------------------------------------------------------------

function LoadSetting()
{
	SetValue(int(player.bHUDBackgroundTranslucent));
}

// ----------------------------------------------------------------------
// SaveSetting()
// ----------------------------------------------------------------------

function SaveSetting()
{
	player.bHUDBackgroundTranslucent = bool(GetValue());
}

// ----------------------------------------------------------------------
// ResetToDefault()
// ----------------------------------------------------------------------

function ResetToDefault()
{
	player.bHUDBackgroundTranslucent = bool(defaultValue);
	SetValue(defaultValue);
	ChangeStyle();
}

// ----------------------------------------------------------------------
// CycleNextValue()
// ----------------------------------------------------------------------

function CycleNextValue()
{
	Super.CycleNextValue();
	player.bHUDBackgroundTranslucent = bool(GetValue());
	ChangeStyle();
}

// ----------------------------------------------------------------------
// CyclePreviousValue()
// ----------------------------------------------------------------------

function CyclePreviousValue()
{
	Super.CyclePreviousValue();
	player.bHUDBackgroundTranslucent = bool(GetValue());
	ChangeStyle();
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     defaultValue=1
     defaultInfoWidth=97
helpText="Если прозрачность включена, то фон будет виден через игровые HUD или вспомогательные экраны."
actionText="Прозрачность HUD ф|&она"
}
