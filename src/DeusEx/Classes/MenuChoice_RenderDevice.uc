//=============================================================================
// MenuChoice_RenderDevice
//=============================================================================

class MenuChoice_RenderDevice extends MenuUIChoiceAction;

var localized String PromptTitle;
var localized String GamePromptMessage;
var localized String RestartPromptMessage;

// ----------------------------------------------------------------------
// ButtonActivated()
// ----------------------------------------------------------------------

function bool ButtonActivated( Window buttonPressed )
{
	local DeusExLevelInfo info;
	local DeusExRootWindow root;

	root = DeusExRootWindow(GetRootWindow());

	info = player.GetLevelInfo();

	// If the game is running, first *PROMPT* the user, becauase
	// this will cause the game to quit and restart!!

	if (((info != None) && (info.MissionNumber >= 0)) &&
	   !((player.IsInState('Dying')) || (player.IsInState('Paralyzed'))))
	{
		root.MessageBox(PromptTitle, GamePromptMessage, 0, False, Self);
	}
	else
	{
		root.MessageBox(PromptTitle, RestartPromptMessage, 0, False, Self);
	}

	return True;
}

// ----------------------------------------------------------------------
// BoxOptionSelected()
// ----------------------------------------------------------------------

event bool BoxOptionSelected(Window button, int buttonNumber)
{
	local DeusExRootWindow root;

	root = DeusExRootWindow(GetRootWindow());

	// Destroy the msgbox!  
	root.PopWindow();

	if (buttonNumber == 0) 
	{
		// First save any other changes the user made 
		// while in this menu before restarting the game!
		SaveMenuSettings();

		// Restart
		player.ConsoleCommand("RELAUNCH -changevideo");
	}
	return true;
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
PromptTitle="Перезапустить 2027?"
GamePromptMessage="Для выбора акселератора надо перезапустить 2027, при этом текущая игра потеряется, если вы не сохранились. Перезапустить?"
RestartPromptMessage="Для выбора акселератора надо перезапустить 2027. Желаете продолжить?"
helpText="Выберите устройство для 3D рендеринга.  Для этого нужно покинуть 2027 и выбрать 3D ускоритель."
actionText="|&Видеокарта для рендеринга..."
     Action=MA_Custom
}
