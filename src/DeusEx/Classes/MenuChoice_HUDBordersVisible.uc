//=============================================================================
// MenuChoice_HUDBordersVisible
//=============================================================================

class MenuChoice_HUDBordersVisible extends MenuChoice_OnOff;

// ----------------------------------------------------------------------
// LoadSetting()
// ----------------------------------------------------------------------

function LoadSetting()
{
	SetValue(int(player.bHUDBordersVisible));
}

// ----------------------------------------------------------------------
// SaveSetting()
// ----------------------------------------------------------------------

function SaveSetting()
{
	player.bHUDBordersVisible = bool(GetValue());
}

// ----------------------------------------------------------------------
// ResetToDefault()
// ----------------------------------------------------------------------

function ResetToDefault()
{
	player.bHUDBordersVisible = bool(defaultValue);
	SetValue(defaultValue);
	ChangeStyle();
}

// ----------------------------------------------------------------------
// CycleNextValue()
// ----------------------------------------------------------------------

function CycleNextValue()
{
	Super.CycleNextValue();
	player.bHUDBordersVisible = bool(GetValue());
	ChangeStyle();
}

// ----------------------------------------------------------------------
// CyclePreviousValue()
// ----------------------------------------------------------------------

function CyclePreviousValue()
{
	Super.CyclePreviousValue();
	player.bHUDBordersVisible = bool(GetValue());
	ChangeStyle();
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     defaultValue=1
     defaultInfoWidth=97
helpText="Определяет показываются или нет границы HUD."
actionText="|&Видимость границ HUD"
}
