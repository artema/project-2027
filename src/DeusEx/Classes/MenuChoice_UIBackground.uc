//=============================================================================
// MenuChoice_UIBackground
//=============================================================================

class MenuChoice_UIBackground extends MenuUIChoiceEnum;

// ----------------------------------------------------------------------
// LoadSetting()
// ----------------------------------------------------------------------

function LoadSetting()
{
	SetValue(player.UIBackground);
}

// ----------------------------------------------------------------------
// SaveSetting()
// ----------------------------------------------------------------------

function SaveSetting()
{
	player.UIBackground = GetValue();

	if (player.UIBackground == 1)
		DeusExRootWindow(player.rootWindow).Hide();

	DeusExRootWindow(player.rootWindow).ShowSnapshot();

	if (player.UIBackground == 1)
		DeusExRootWindow(player.rootWindow).Show();
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
     helpText="Определяет, что будет показываться под меню и 2D экранами: 3D-рендеринг, статичная картинка или же черный экран."
     actionText="|&Фон UI/Меню"
     enumText(0)="3D-рендер"
     enumText(1)="Статик"
     enumText(2)="Черный"
     defaultInfoWidth=97
}
