//=============================================================================
// MenuChoice_Crosshairs
//=============================================================================
class MenuChoice_Crosshairs extends MenuChoice_VisibleHidden;



// ----------------------------------------------------------------------
// LoadSetting()
// ----------------------------------------------------------------------
function LoadSetting()
{
	SetValue(int(!player.bCrosshairVisible));
}

// ----------------------------------------------------------------------
// SaveSetting()
// ----------------------------------------------------------------------
function SaveSetting()
{
	player.bCrosshairVisible = !bool(GetValue());
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------
function ResetToDefault()
{
	SetValue(int(!player.bCrosshairVisible));
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     defaultInfoWidth=88
helpText="��������� ��������� �������."
actionText="���|&���"
}
