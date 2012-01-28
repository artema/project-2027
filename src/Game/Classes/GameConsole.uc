//=============================================================================
// �������. ������� Ded'�� ��� ���� 2027
// Console. Copyright (C) 2003 Ded
//=============================================================================
class GameConsole expands Console;

#exec obj load file="..\2027\Textures\GameSigns.utx" package=GameSigns
//#exec OBJ LOAD FILE=LoadingScreens

var Font PauseFont;
var Texture SavingTexture;
var Texture LoadingTexture;

event bool KeyEvent(EInputKey Key, EInputAction Action, FLOAT Delta)
{
	if( Action != IST_Press )
	{
		return false;
	}
	// DEUS_EX CNN - Shift-Tilde is console now
/*	else if( Key==IK_Tilde )
	{
		if( ConsoleDest==0.0 )
		{
			ConsoleDest=0.6;
			GotoState('Typing');
		}
		else GotoState('');
		return true;
	}
*/
	else return false;
}

function DrawLevelAction(canvas C)
{
	local texture LoadTex;
	local string BigMessage;
	local DeusExPlayer Player;
	local Actor a;
	local String screenStringName;
	local Texture screenTexture;

	if (Viewport.Actor.bShowMenu)
	{
		BigMessage = "";
		return;
	}
	if ((Viewport.Actor.Level.Pauser != "") && (Viewport.Actor.Level.LevelAction == LEVACT_None))
	{

		C.Font = PauseFont;
		C.Style = 1;
		C.DrawColor.R = 255;
		C.DrawColor.G = 255;
		C.DrawColor.B = 255;

		C.SetPos(C.ClipX / 2, C.ClipY / 2 - 32);
		BigMessage = PausedMessage;
		PrintActionMessage(C, BigMessage);

		return;
	}
	else if ((Viewport.Actor.Level.LevelAction == LEVACT_Loading || Viewport.Actor.Level.LevelAction == LEVACT_Saving) && LoadingMessage != "")
    {
		screenTexture = Texture(DynamicLoadObject("GameSigns.Screens.LS_" $ LoadingMessage, class'Texture'));

		LoadTex = Texture'BlackMaskTex';		
		C.SetPos(0, 0);
		C.DrawTile(LoadTex, C.ClipX, C.ClipY, 0, 0, LoadTex.USize, LoadTex.VSize);
		
		if(screenTexture == None)
			screenTexture = LoadingTexture;
		
		if(screenTexture != None)
		{
			C.SetPos((C.ClipX / 2) - (screenTexture.USize / 2), (C.ClipY / 2) - (screenTexture.VSize / 2));
			C.DrawTile(screenTexture, screenTexture.USize, screenTexture.VSize, 0, 0, screenTexture.USize, screenTexture.VSize);
		}
		
		/*
		LoadTex = Texture'BlackMaskTex';
		C.SetPos(0, 0);
		C.DrawTile(LoadTex, C.ClipX, C.ClipY, 0, 0, LoadTex.USize, LoadTex.VSize);
		C.SetPos((C.ClipX / 2) - (tex[0].USize), (C.ClipY / 2) - (tex[0].VSize));
		C.DrawTile(tex[0], tex[0].USize, tex[0].VSize, 0, 0, tex[0].USize, tex[0].VSize);
		C.SetPos(C.ClipX / 2, (C.ClipY / 2) - (tex[1].VSize));
		C.DrawTile(tex[1], tex[1].USize, tex[1].VSize, 0, 0, tex[1].USize, tex[1].VSize);
		C.SetPos(C.ClipX / 2 - tex[2].USize, C.ClipY / 2);
		C.DrawTile(tex[2], tex[2].USize, 256, 0, 0, tex[2].USize, tex[2].VSize);
		C.SetPos(C.ClipX / 2, C.ClipY / 2);
		C.DrawTile(tex[3], tex[3].USize, 256, 0, 0, tex[3].USize, tex[3].VSize);*/

		if (Viewport.Actor.Level.LevelAction == LEVACT_Saving)
			BigMessage = "";
		else
			BigMessage = "";
    }
	else if ((Viewport.Actor.Level.LevelAction == LEVACT_Loading) && LoadingMessage == "")
    {
		LoadTex = Texture'BlackMaskTex';
		C.SetPos(0, 0);
		C.DrawTile(LoadTex, C.ClipX, C.ClipY, 0, 0, LoadTex.USize, LoadTex.VSize);
		LoadTex = LoadingTexture;
		C.SetPos(C.ClipX / 2 - LoadTex.USize / 2, C.ClipY / 2 - LoadTex.VSize / 2);
		C.DrawTile(LoadTex, LoadTex.USize, LoadTex.VSize, 0, 0, LoadTex.USize, LoadTex.VSize);
		BigMessage = "";
	}
	else if ((Viewport.Actor.Level.LevelAction == LEVACT_Saving) && LoadingMessage == "")
    {
		LoadTex = Texture'BlackMaskTex';
		C.SetPos(0, 0);
		C.DrawTile(LoadTex, C.ClipX, C.ClipY, 0, 0, LoadTex.USize, LoadTex.VSize);
		LoadTex = SavingTexture;
		C.SetPos(C.ClipX / 2 - LoadTex.USize / 2, C.ClipY / 2 - LoadTex.VSize / 2);
		C.DrawTile(LoadTex, LoadTex.USize, LoadTex.VSize, 0, 0, LoadTex.USize, LoadTex.VSize);
		BigMessage = "";
    }
	else if (Viewport.Actor.Level.LevelAction == LEVACT_Connecting)
    {
		LoadTex = Texture'BlackMaskTex';
		C.SetPos(0, 0);
		C.DrawTile(LoadTex, C.ClipX, C.ClipY, 0, 0, LoadTex.USize, LoadTex.VSize);
		LoadTex = LoadingTexture;
		C.SetPos(C.ClipX / 2 - LoadTex.USize / 2, C.ClipY / 2 - LoadTex.VSize / 2);
		C.DrawTile(LoadTex, LoadTex.USize, LoadTex.VSize, 0, 0, LoadTex.USize, LoadTex.VSize);
		BigMessage = "";
    }
	else if (Viewport.Actor.Level.LevelAction == LEVACT_Precaching)
    {
		LoadTex = Texture'BlackMaskTex';
		C.SetPos(0, 0);
		C.DrawTile(LoadTex, C.ClipX, C.ClipY, 0, 0, LoadTex.USize, LoadTex.VSize);
		LoadTex = LoadingTexture;
		C.SetPos(C.ClipX / 2 - LoadTex.USize / 2, C.ClipY / 2 - LoadTex.VSize / 2);
		C.DrawTile(LoadTex, LoadTex.USize, LoadTex.VSize, 0, 0, LoadTex.USize, LoadTex.VSize);
		BigMessage = "";
    }
	
	if (BigMessage != "")
	{
		C.Style = 3;
		C.DrawColor.R = 225;
		C.DrawColor.G = 225;
		C.DrawColor.B = 240;
		C.Font = C.LargeFont;	
		PrintActionMessage(C, BigMessage);
	}
}

exec function Talk()
{
	TypedStr="";
	bNoStuff = true;
	GotoState('Typing');
}

exec function TeamTalk()
{
}

defaultproperties
{
     PauseFont=Font'DeusExUI.FontPause'
     LoadingTexture=Texture'GameSigns.Screens.LoadingScr'
     SavingTexture=Texture'GameSigns.Screens.SavingScr'
     ConBackground=Texture'Engine.ConsoleBack'
     Border=Texture'Engine.Border'
     TimeDemoFont=Font'DeusExUI.FontAtom'
     ConnectingMessage="CONNECTING"
     PrecachingMessage="PRECACHING"
     FrameRateText="Frame Rate"
     AvgText="Avg"
     LastSecText="Last Sec"
     MinText="Min"
     MaxText="Max"
     fpsText="FPS"
     SecondsText="seconds."
     FramesText="frames rendered in"
}
