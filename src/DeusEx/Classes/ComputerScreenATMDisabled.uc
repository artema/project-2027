//=============================================================================
// ComputerScreenATMDisabled
//=============================================================================
class ComputerScreenATMDisabled extends ComputerUIWindow;

var MenuUILabelWindow        winLoginInfo;
var MenuUIActionButtonWindow btnClose;

var localized String ButtonLabelClose;
var localized String LoginInfoText;
var localized String StatusText;

// ----------------------------------------------------------------------
// CreateControls()
// ----------------------------------------------------------------------

function CreateControls()
{
	Super.CreateControls();

	btnClose = winButtonBar.AddButton(ButtonLabelClose, HALIGN_Right);

	CreateLoginInfoWindow();

	winTitle.SetTitle(Title);
	winStatus.SetText(StatusText);
}

// ----------------------------------------------------------------------
// CreateLoginInfoWindow()
// ----------------------------------------------------------------------

function CreateLoginInfoWindow()
{
	winLoginInfo = MenuUILabelWindow(winClient.NewChild(Class'MenuUILabelWindow'));

	winLoginInfo.SetPos(10, 12);
	winLoginInfo.SetSize(377, 122);
	winLoginInfo.SetTextAlignments(HALIGN_Center, VALIGN_Center);
	winLoginInfo.SetTextMargins(0, 0);
	winLoginInfo.SetText(LoginInfoText);
}

// ----------------------------------------------------------------------
// SetNetworkTerminal()
// ----------------------------------------------------------------------

function SetNetworkTerminal(NetworkTerminal newTerm)
{
	Super.SetNetworkTerminal(newTerm);

	// Hide the Hack window
	if (winTerm != None)
		winTerm.CloseHackWindow();
}

// ----------------------------------------------------------------------
// ButtonActivated()
// ----------------------------------------------------------------------

function bool ButtonActivated( Window buttonPressed )
{
	local bool bHandled;

	bHandled = True;

	switch( buttonPressed )
	{
		case btnClose:
			CloseScreen("EXIT");
			break;

		default:
			bHandled = False;
			break;
	}

	if (bHandled)
		return True;
	else
		return Super.ButtonActivated(buttonPressed);
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     ButtonLabelClose="Закрыть"
     LoginInfoText="Извините, терминал временно недоступен.|n|nПриносим извинения за неудобства. Мы всегда будем рады обслужить вас в одном из 200.000 банковских терминалов по всему миру."
     StatusText="TMPLR//PUB:9811.1575[error]"
     Title="Глобальная Банковская Сеть"
     ClientWidth=403
     ClientHeight=211
     verticalOffset=30
     clientTextures(0)=Texture'DeusExUI.UserInterface.ComputerGBSDisabledBackground_1'
     clientTextures(1)=Texture'DeusExUI.UserInterface.ComputerGBSDisabledBackground_2'
     textureRows=1
     textureCols=2
     bAlwaysCenter=True
     statusPosY=186
}
