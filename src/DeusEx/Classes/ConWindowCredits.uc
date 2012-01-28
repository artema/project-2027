//=============================================================================
// ConWindowSpeech
//=============================================================================
class ConWindowCredits extends AlignWindow;

var TextWindow txtLabel;
var TextWindow txtCount;

var localized Color colConTextLabel;
var localized Color colConTextCount;

var localized String Credits;

// ----------------------------------------------------------------------
// InitWindow()
//
// Initialize the Window
// ----------------------------------------------------------------------

event InitWindow()
{
	Super.InitWindow();

	SetChildVAlignment(VALIGN_Top);

	CreateControls();
}

// ----------------------------------------------------------------------
// CreateControls()
// ----------------------------------------------------------------------

function CreateControls()
{
	txtLabel = TextWindow(NewChild(Class'TextWindow', False));
	txtLabel.SetTextColor(colConTextLabel);
	txtLabel.SetFont(Font'DeusExUI.FontConversationLarge');
	txtLabel.SetTextAlignments(HALIGN_Left, VALIGN_Top);
	txtLabel.SetText(Credits $ ": ");
	txtLabel.Hide();

	txtCount = TextWindow(NewChild(Class'TextWindow', False));
	txtCount.SetTextColor(colConTextCount);
	txtCount.SetFont(Font'DeusExUI.FontConversationLargeBold');
	txtCount.SetTextAlignments(HALIGN_Left, VALIGN_Top);
	txtCount.Hide();
}

// ----------------------------------------------------------------------
// SetName()
// ----------------------------------------------------------------------

function SetCreditsCount(int count)
{
	txtLabel.Show(True);
	
	txtCount.SetText(count $ "");
	txtCount.Show(True);
}

defaultproperties
{
     colConTextLabel=(R=200,G=200,B=210)
     colConTextCount=(R=255,G=255,B=255)
}
