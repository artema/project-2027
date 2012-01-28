//=============================================================================
// MenuScreenSound
//=============================================================================

class GameMenuScreenSound expands MenuUIScreenWindow;

// ----------------------------------------------------------------------
// SaveSettings()
// ----------------------------------------------------------------------

function SaveSettings()
{
	Super.SaveSettings();
	player.SaveConfig();
}

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------

defaultproperties
{
     choices(0)=Class'DeusEx.MenuChoice_MusicVolume'
     choices(1)=Class'DeusEx.MenuChoice_SoundVolume'
     choices(2)=Class'DeusEx.MenuChoice_SpeechVolume'
     choices(7)=Class'DeusEx.MenuChoice_SurroundSound'
     choices(8)=Class'DeusEx.MenuChoice_Use3DHardware'
     actionButtons(0)=(Align=HALIGN_Right,Action=AB_OK)
     ClientWidth=537
     ClientHeight=268
     clientTextures(0)=Texture'GameMedia.UI.GameMenuSoundBackground_1'
     clientTextures(1)=Texture'GameMedia.UI.GameMenuSoundBackground_2'
     clientTextures(2)=Texture'GameMedia.UI.GameMenuSoundBackground_3'
     clientTextures(3)=Texture'GameMedia.UI.GameMenuSoundBackground_4'
     clientTextures(4)=Texture'GameMedia.UI.GameMenuSoundBackground_5'
     clientTextures(5)=Texture'GameMedia.UI.GameMenuSoundBackground_6'
     helpPosY=214
}
