//=============================================================================
// MenuChoice_SurroundSound
//=============================================================================

class MenuChoice_SurroundSound extends MenuChoice_OnOff;

// ----------------------------------------------------------------------
// LoadSetting()
// ----------------------------------------------------------------------

function LoadSetting()
{
	LoadSettingBool();
}

// ----------------------------------------------------------------------
// SaveSetting()
// ----------------------------------------------------------------------

function SaveSetting()
{
	SaveSettingBool();
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     defaultValue=1
     defaultInfoWidth=83
helpText="Включение поддержки звука Dolby Surround.  Требуется Dolby Pro-Logic Surround звуковой процессор."
actionText="|&Звук Dolby Surround"
     configSetting="ini:Engine.Engine.AudioDevice UseSurround"
}
