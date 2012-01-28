//=============================================================================
// MenuChoice_GoreLevel
//=============================================================================

class MenuChoice_GoreLevel extends MenuUIChoiceEnum;

// ----------------------------------------------------------------------
// LoadSetting()
// ----------------------------------------------------------------------

function LoadSetting()
{
	// Check for German system and disable this option
	if (player.Level.Game.bVeryLowGore)
		btnAction.EnableWindow(False);
	else
		SetValue(int(!player.Level.Game.bLowGore));
}

// ----------------------------------------------------------------------
// SaveSetting()
// ----------------------------------------------------------------------

function SaveSetting()
{
	player.Level.Game.bLowGore = !bool(GetValue());
	player.Level.Game.SaveConfig();
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
helpText="Установка на Низкий запретит показ крови в игре."
actionText="|&Уровень насилия"
enumText(0)="Низкий"
enumText(1)="Обычный"
     defaultValue=1
     defaultInfoWidth=88
}
