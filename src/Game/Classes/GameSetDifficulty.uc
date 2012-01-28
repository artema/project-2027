//=============================================================================
// ���� "����� ���������". �������� Ded'�� ��� ���� 2027
// "Set Difficulty" menu. Copyright (C) 2003 Ded
//=============================================================================
class GameSetDifficulty expands MenuSelectDifficulty;

// ----------------------------------------------------------------------
// ProcessCustomMenuButton()
// ----------------------------------------------------------------------

function ProcessCustomMenuButton(string key)
{
	switch(key)
	{
		case "EASY":
			InvokeNewGameScreen(DeusExPlayer(GetPlayerPawn()).Default.DifficultyAmount1);
			break;

		case "MEDIUM":
			InvokeNewGameScreen(DeusExPlayer(GetPlayerPawn()).Default.DifficultyAmount2);
			break;

		case "HARD":
			InvokeNewGameScreen(DeusExPlayer(GetPlayerPawn()).Default.DifficultyAmount3);
			break;

		case "REALISTIC":
			InvokeNewGameScreen(DeusExPlayer(GetPlayerPawn()).Default.DifficultyAmount4);
			break;
	}
}

// ----------------------------------------------------------------------
// InvokeNewGameScreen()
// ----------------------------------------------------------------------
function InvokeNewGameScreen(float difficulty)
{
	local GameMenuScreenNewGame newGame;

	newGame = GameMenuScreenNewGame(root.InvokeMenuScreen(Class'Game.GameMenuScreenNewGame'));

	if (newGame != None)
		newGame.SetDifficulty(difficulty);
}

defaultproperties
{
     buttonXPos=7
     buttonWidth=245
     buttonDefaults(0)=(Y=13,Action=MA_Custom,Key="EASY")
     buttonDefaults(1)=(Y=49,Action=MA_Custom,Key="MEDIUM")
     buttonDefaults(2)=(Y=85,Action=MA_Custom,Key="HARD")
     buttonDefaults(3)=(Y=121,Action=MA_Custom,Key="REALISTIC")
     buttonDefaults(4)=(Y=179,Action=MA_Previous)
     ClientWidth=258
     ClientHeight=221
     clientTextures(0)=Texture'DeusExUI.UserInterface.MenuDifficultyBackground_1'
     clientTextures(1)=Texture'DeusExUI.UserInterface.MenuDifficultyBackground_2'
     textureRows=1
     textureCols=2
}
