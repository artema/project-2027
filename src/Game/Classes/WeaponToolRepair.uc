//=============================================================================
// ��������� ����������. �������� Ded'�� ��� ���� 2027
// Weapon tool. Copyright (C) 2005 Ded
//=============================================================================
class WeaponToolRepair extends WeaponTool;

function ApplyTool(Inventory Item)
{
	local SupportBotContainer SBC;
	if (Item.IsA('SupportBotContainer'))
	{
		SupportBotContainer(Item).BotHealth += Int(Float(SupportBotContainer(Item).Default.BotHealth) * DeusExPlayer(GetPlayerPawn()).SkillSystem.GetSkillLevelValue(class'SkillTechnics') * 2);
		
		if(SupportBotContainer(Item).BotHealth > SupportBotContainer(Item).Default.BotHealth)
			SupportBotContainer(Item).BotHealth = SupportBotContainer(Item).Default.BotHealth;
	}
}

simulated function bool CanFixItem(Inventory Item)
{
	if (Item.IsA('DeusExWeapon'))
	{
		return False;
	}
	else if (Item.IsA('SupportBotContainer'))
	{
		if(SupportBotContainer(Item).BotHealth < SupportBotContainer(Item).Default.BotHealth)
			return True;
		else
			return False;
	}
}

function string GetApplyMessage()
{
	return ItemFixedLabel;
}

defaultproperties
{
     Skin=Texture'GameMedia.Skins.ToolRepairTex0'
     ItemModifier=0.250000
     Icon=Texture'GameMedia.Icons.BeltIconToolRepair'
     largeIcon=Texture'GameMedia.Icons.LargeIconToolRepair'
}