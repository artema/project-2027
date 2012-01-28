//=============================================================================
// MenuScreenDisplay
//=============================================================================

class GameMenuScreenDisplay expands MenuUIScreenWindow;

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------
/*
     choices(0)=Class'DeusEx.MenuChoice_Brightness'
     choices(1)=Class'DeusEx.MenuChoice_FullScreen'
     choices(2)=Class'DeusEx.MenuChoice_RenderDevice'
     choices(3)=Class'DeusEx.MenuChoice_Resolution'
     choices(4)=Class'DeusEx.MenuChoice_TextureColorBits'
     choices(5)=Class'DeusEx.MenuChoice_WorldTextureDetail'
     choices(6)=Class'DeusEx.MenuChoice_ObjectTextureDetail'
     choices(7)=Class'Game.GameMenuChoice_DetailTextures'
     choices(8)=Class'Game.GameMenuChoice_VSync'
*/


defaultproperties
{
     choices(0)=Class'GameMenuChoice_Brightness'
     choices(1)=Class'GameMenuChoice_HUD'
     //choices(2)=Class'DeusEx.MenuChoice_Resolution'
     //choices(3)=Class'Game.GameMenuChoice_HiResTextures'
     //choices(4)=Class'Game.MenuChoice_Resurrection'
     choices(2)=Class'Game.MenuChoice_Weather'
     actionButtons(0)=(Align=HALIGN_Right,Action=AB_OK)
     ClientWidth=391
     ClientHeight=196
     clientTextures(0)=Texture'GameMedia.UI.GameMenuDisplayBackground_1'
     clientTextures(1)=Texture'GameMedia.UI.GameMenuDisplayBackground_2'
     clientTextures(2)=Texture'GameMedia.UI.GameMenuDisplayBackground_3'
     clientTextures(3)=Texture'GameMedia.UI.GameMenuDisplayBackground_4'
     textureCols=2
     helpPosY=142
}
