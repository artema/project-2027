//=============================================================================
// DeusExScopeView.
//=============================================================================
class GameScopeView expands DeusExScopeView;

/*

var Bool  bGEP;

// ----------------------------------------------------------------------
// ActivateNewView()
// ----------------------------------------------------------------------
function ActivateNewView(int newFOV, bool bNewGEP, bool bInstant)
{
	desiredFOV = newFOV;

	bGEP = bNewGEP;

	if (player != None)
	{
		if (bInstant)
			player.SetFOVAngle(desiredFOV);
		else
			player.desiredFOV = desiredFOV;

		bViewVisible = True;
		Show();
	}
}

// ----------------------------------------------------------------------
// DrawWindow()
// ----------------------------------------------------------------------
event DrawWindow(GC gc)
{
	local float			fromX, toX;
	local float			fromY, toY;
	local float			scopeWidth, scopeHeight;

	Super.DrawWindow(gc);

	if (GetRootWindow().parentPawn != None)
	{
		if (player.IsInState('Dying'))
			return;
	}

	if (bBinocs)
		scopeWidth  = 512;
	else if (bGEP)
		scopeWidth  = 512;
	else
		scopeWidth  = 256;

	scopeHeight = 256;

	fromX = (width-scopeWidth)/2;
	fromY = (height-scopeHeight)/2;
	toX   = fromX + scopeWidth;
	toY   = fromY + scopeHeight;

	gc.SetTileColorRGB(0, 0, 0);
	gc.SetStyle(DSTY_Normal);
	if ( Player.Level.NetMode == NM_Standalone )
	{
		gc.DrawPattern(0, 0, width, fromY, 0, 0, Texture'Solid');
		gc.DrawPattern(0, toY, width, fromY, 0, 0, Texture'Solid');
		gc.DrawPattern(0, fromY, fromX, scopeHeight, 0, 0, Texture'Solid');
		gc.DrawPattern(toX, fromY, fromX, scopeHeight, 0, 0, Texture'Solid');
	}

	if (bBinocs)
	{
		gc.SetStyle(DSTY_Modulated);
		gc.DrawTexture(fromX,       fromY, 256, scopeHeight, 0, 0, Texture'HUDBinocularView_1');
		gc.DrawTexture(fromX + 256, fromY, 256, scopeHeight, 0, 0, Texture'HUDBinocularView_2');

		gc.SetTileColor(colLines);
		gc.SetStyle(DSTY_Masked);
		gc.DrawTexture(fromX,       fromY, 256, scopeHeight, 0, 0, Texture'HUDBinocularCrosshair_1');
		gc.DrawTexture(fromX + 256, fromY, 256, scopeHeight, 0, 0, Texture'HUDBinocularCrosshair_2');
	}
	else if (bGEP)
	{
		gc.SetStyle(DSTY_Modulated);
		gc.DrawTexture(fromX,       fromY, 256, scopeHeight, 0, 0, Texture'HUDBinocularView_1');
		gc.DrawTexture(fromX + 256, fromY, 256, scopeHeight, 0, 0, Texture'HUDBinocularView_2');

		gc.SetTileColor(colLines);
		gc.SetStyle(DSTY_Masked);
		gc.DrawTexture(fromX,       fromY, 256, scopeHeight, 0, 0, Texture'HUDBinocularCrosshair_1');
		gc.DrawTexture(fromX + 256, fromY, 256, scopeHeight, 0, 0, Texture'HUDBinocularCrosshair_2');
	}
	else
	{
		if ( Player.Level.NetMode == NM_Standalone )
		{
			gc.SetStyle(DSTY_Modulated);
			gc.DrawTexture(fromX, fromY, scopeWidth, scopeHeight, 0, 0, Texture'HUDScopeView');
			gc.SetTileColor(colLines);
			gc.SetStyle(DSTY_Masked);
			gc.DrawTexture(fromX, fromY, scopeWidth, scopeHeight, 0, 0, Texture'HUDScopeCrosshair');
		}
		else
		{
			if ( WeaponRifle(Player.inHand) != None )
			{
				gc.SetStyle(DSTY_Modulated);
				gc.DrawTexture(fromX, fromY, scopeWidth, scopeHeight, 0, 0, Texture'HUDScopeView3');
			}
			else
			{
				gc.SetStyle(DSTY_Modulated);
				gc.DrawTexture(fromX, fromY, scopeWidth, scopeHeight, 0, 0, Texture'HUDScopeView2');
			}
		}
	}
}

*/

defaultproperties
{
}
