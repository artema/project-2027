//=============================================================================
// Dart.
//=============================================================================
class P_BotDart extends P_DartPoison;

function PostBeginPlay()
{
	Super.PostBeginPlay();

	Damage = Default.Damage + (Default.Damage * DeusExPlayer(GetPlayerPawn()).SkillSystem.GetSkillLevelValue(class'SkillTechnics'));	
}

defaultproperties
{
     Damage=10.0
}