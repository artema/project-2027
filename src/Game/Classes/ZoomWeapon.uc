//=======================================================
// ������ - ������ �����. �������� Ded'�� ��� ���� 2027
// Weapon - Advanced class. Copyright (C) 2003 Ded
//=======================================================
class ZoomWeapon extends GameWeapon
     abstract;

var() int ScopeMax; 
var() int ScopeMin; 
var travel int ScopeCurrent;
var(Sounds) sound ZoomSound;

simulated function bool ClientAltFire( float Value )
{
}

function AltFire( float Value )
{
	ClientAltFire(Value);     
}

function ScopeOn() 
{ 
     InScope(); 
} 


function InScope() 
{
     if (bHasScope && (Owner != None) && Owner.IsA('TruePlayer') && (!IsInState('Reload'))) 
     { 
           
          if(!bZoomed) 
          { 
               bZoomed = True; 
               ScopeCurrent=ScopeMin;
               Owner.PlaySound(ZoomSound, SLOT_None, 8.0,,,); 
               RefreshScopeDisplay(TruePlayer(Owner), False, bZoomed);
          } 
      
          else 
           
          { 
               if (ScopeCurrent!=ScopeMax) 
               { 
                    --ScopeCurrent;
                    Owner.PlaySound(ZoomSound, SLOT_None, 8.0,,, 120.0);
                    RefreshScopeDisplay(TruePlayer(Owner), False, bZoomed); 
               } 
          }      
     } 

} 

function OutScope() 
{ 
     if(bHasScope && bZoomed && (Owner != None) && Owner.IsA('TruePlayer') && (ScopeCurrent!=ScopeMin) ) 
     {      
          ++ScopeCurrent;
          Owner.PlaySound(ZoomSound, SLOT_None, 8.0,,, 120.0); 
          RefreshScopeDisplay(TruePlayer(Owner),False, bZoomed); 
     }
     else if(bHasScope && bZoomed && (Owner != None) && Owner.IsA('TruePlayer') && (ScopeCurrent<=ScopeMin))
     {
     	bZoomed = False;
     	RefreshScopeDisplay(TruePlayer(Owner), False, bZoomed);
     }
} 

simulated function RefreshScopeDisplay(DeusExPlayer player, bool bInstant, bool bScopeOn) 
{ 
     if (bScopeOn && (player != None)) 
     { 
          DeusExRootWindow(player.rootWindow).scopeView.ActivateView(ScopeCurrent, False, bInstant); 
     } 
     else if (!bScopeOn) 
     { 
          DeusExrootWindow(player.rootWindow).scopeView.DeactivateView(); 
     } 
} 

simulated function Tick(float deltaTime)
{
	local Pawn pawn;
	local TruePlayer tpl;

	tpl = TruePlayer(Owner);

      Super(GameWeapon).Tick(deltaTime);

        if(tpl!= none)
        {
           if (TruePlayer(Owner).bScopeIn==1 && bZoomed)
           {
                InScope();
           }
           else if (TruePlayer(Owner).bScopeOut==1 && bZoomed)
           {
                OutScope();
           }
        }
        else
        {
        }
}

defaultproperties
{
     ZoomSound=Sound'Game.Weapons.SniperZoom'
     ScopeMax=1
     ScopeMin=50
}
