//=============================================================================
// MenuChoice_MenuTranslucency
//=============================================================================

class MenuChoice_MenuTranslucency extends MenuChoice_OnOff;

// ----------------------------------------------------------------------
// LoadSetting()
// ----------------------------------------------------------------------

function LoadSetting()
{
	SetValue(int(player.bMenusTranslucent));
}

// ----------------------------------------------------------------------
// SaveSetting()
// ----------------------------------------------------------------------

function SaveSetting()
{
	player.bMenusTranslucent = bool(GetValue());
}

// ----------------------------------------------------------------------
// ResetToDefault()
// ----------------------------------------------------------------------

function ResetToDefault()
{
	player.bMenusTranslucent = bool(defaultValue);
	SetValue(defaultValue);
	ChangeStyle();
}

// ----------------------------------------------------------------------
// CycleNextValue()
// ----------------------------------------------------------------------

function CycleNextValue()
{
	Super.CycleNextValue();
	player.bMenusTranslucent = bool(GetValue());
	ChangeStyle();
}

// ----------------------------------------------------------------------
// CyclePreviousValue()
// ----------------------------------------------------------------------

function CyclePreviousValue()
{
	Super.CyclePreviousValue();
	player.bMenusTranslucent = bool(GetValue());
	ChangeStyle();
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     defaultValue=1
     defaultInfoWidth=97
helpText="Если прозрачность включена, то фон будет виден через игровые меню."
actionText="|&Прозрачность меню"
}
