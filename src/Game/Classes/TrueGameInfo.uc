//============================================================
// Параметры игры. Сделанно Ded'ом для мода 2027
// New Game Info. Copyright (C) 2003 Ded
//============================================================
class TrueGameInfo extends DeusExGameInfo
    config
    config(user);

// ---------------------------------------------------------------------- 
// Login() 
// ---------------------------------------------------------------------- 

event playerpawn Login 
( 
     string Portal, 
     string Options, 
     out string Error, 
     class<playerpawn> SpawnClass 
) 
{ 
     local DeusExPlayer player; 
     local NavigationPoint StartSpot; 
     local byte InTeam; 
     local DumpLocation dump; 

    
    

     SpawnClass=class'Game.TruePlayer';

     player = DeusExPlayer(Super.Login(Portal, Options, Error, SpawnClass)); 


     if ((player != None) && (!HasOption(Options, "Loadgame"))) 
     { 
          player.ResetPlayerToDefaults(); 

          dump = player.CreateDumpLocationObject(); 

          if ((dump != None) && (dump.HasLocationBeenSaved())) 
          { 
               dump.LoadLocation(); 

               player.Pause(); 
               player.SetLocation(dump.currentDumpLocation.Location); 
               player.SetRotation(dump.currentDumpLocation.ViewRotation); 
               player.ViewRotation = dump.currentDumpLocation.ViewRotation; 
               player.ClientSetRotation(dump.currentDumpLocation.ViewRotation); 

               CriticalDelete(dump); 
          } 
          else 
          { 
            InTeam    = GetIntOption( Options, "Team", 0 );
            StartSpot = FindPlayerStart( Player, InTeam, Portal ); 

               player.SetLocation(StartSpot.Location); 
               player.SetRotation(StartSpot.Rotation); 
               player.ViewRotation = StartSpot.Rotation; 
               player.ClientSetRotation(player.Rotation); 
          } 
     } 
     return player; 
} 


function bool ApproveClass( class<playerpawn> SpawnClass)
{
      return true;
}

defaultproperties
{
}
