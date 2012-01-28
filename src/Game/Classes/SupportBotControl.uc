//=============================================================================
// ����� ���������� �����. �������� Ded'�� ��� ���� 2027
// Support bot control. Copyright (C) 2002 Hejhujka (Modified by Ded (C) 2005)
//=============================================================================
class SupportBotControl extends SupportBotControlImpl;

var() bool bNewSkin;
var() bool bPlayerViewSkinned;
var() texture PlayerViewSkins[8];
var() texture PickupViewSkins[8];

var texture NormalPlayerViewSkins[10];
var texture CamoPlayerViewSkins[10];
var bool bWeaponInvisible;

function BecomePickup()
{
	local int i;

	bPlayerViewSkinned = False;

	super.BecomePickup();

	if(bNewSkin)
		for(i=0;i<8;i++)
			MultiSkins[i]=PickupViewSkins[i];
}

function BecomeItem()
{
	local int i;

	bPlayerViewSkinned = True;

	super.BecomeItem();

	if(bNewSkin)
		for(i=0;i<8;i++)
			MultiSkins[i]=PlayerViewSkins[i];
}

function SetSkins()
{
	local int     i;
	local texture curSkin;

	for (i=0; i<8; i++)
	{
		if(bNewSkin && bPlayerViewSkinned && PlayerViewSkins[i] != None)
			NormalPlayerViewSkins[i] = PlayerViewSkins[i];
		else
			NormalPlayerViewSkins[i] = MultiSkins[i];
	}
		
	NormalPlayerViewSkins[8] = Skin;
	NormalPlayerViewSkins[9] = Texture;

	for (i=0; i<8; i++)
	{
		curSkin = GetMeshTexture(i);
		CamoPlayerViewSkins[i] = GetGridTexture(curSkin);
	}
	
	CamoPlayerViewSkins[8] = GetGridTexture(NormalPlayerViewSkins[8]);
	CamoPlayerViewSkins[9] = GetGridTexture(NormalPlayerViewSkins[9]);
	
	Style = STY_Translucent;
}

function ResetSkins()
{
	local int i;

	for (i=0; i<8; i++)
		MultiSkins[i] = NormalPlayerViewSkins[i];
		
	Skin = NormalPlayerViewSkins[8];
	Texture = NormalPlayerViewSkins[9];
	
	Style = Default.Style;
}

function Texture GetGridTexture(Texture tex)
{
	if (tex == None)
		return FireTexture'GameEffects.InvisibleTex';
		//return Texture'BlackMaskTex';
	else if (tex == Texture'BlackMaskTex')
		return Texture'BlackMaskTex';
	else if (tex == Texture'GrayMaskTex')
		return Texture'BlackMaskTex';
	else if (tex == Texture'PinkMaskTex')
		return Texture'BlackMaskTex';
	else
		return FireTexture'GameEffects.InvisibleTex';
}

simulated function Tick(float deltaTime)
{
	local vector loc;
	local rotator rot;
	local float beepspeed, recoil;
	local DeusExPlayer player;
    local Actor RealTarget;
	local Pawn pawn;
    local int i;
	local rotator recoilOffset;
	
	player = DeusExPlayer(Owner);
	pawn = Pawn(Owner);
	
	if(player != None)
	{
		if((player.AugmentationSystem != None && player.AugmentationSystem.GetClassLevel(class'AugCloak') >= 0) || player.UsingChargedPickup(class'AdaptiveArmor'))
		{
			if(!bWeaponInvisible)
			{
				SetSkins();				
				bWeaponInvisible = True;	
			}	
		}
		else
		{
			if(bWeaponInvisible)
			{
				ResetSkins();				
				bWeaponInvisible = False;	
			}	
		}
	}
	else if(pawn == None)
	{
		//No owner, so we are probably being dropped
		if(bWeaponInvisible)
		{
			ResetSkins();				
			bWeaponInvisible = False;
		}
	}
	
	if(bWeaponInvisible)
	{
		for (i=0; i<8; i++)
			MultiSkins[i] = CamoPlayerViewSkins[i];

		Skin = CamoPlayerViewSkins[8];
		Texture = CamoPlayerViewSkins[9];
		
		Style = STY_Translucent;
	}
	else
	{
		Style = Default.Style;
	}
	
	/*if(!bWeaponInvisible && bNewSkin)
	{
		if (bPlayerViewSkinned)
		{
			for (i=0; i<8; i++)
				MultiSkins[i]=PlayerViewSkins[i];
		}
		else
		{
			for (i=0; i<8; i++)
				MultiSkins[i]=PickupViewSkins[i];
		}
	}*/
	
	Super(Weapon).Tick(deltaTime);
	
}

defaultproperties
{
	 bNewSkin=True     
     PickupViewSkins(0)=Texture'GameMedia.Skins.BotControlTex0'
     PlayerViewSkins(0)=Texture'GameMedia.Skins.BotControlTex1'
     PlayerViewSkins(1)=Texture'GameMedia.Skins.WeaponNewHands'
     PlayerViewSkins(2)=Texture'GameMedia.Skins.BotControlTex1'
     PlayerViewSkins(3)=Texture'GameMedia.Skins.BotControlTex1'
     PlayerViewSkins(4)=Texture'GameMedia.Skins.BotControlTex1'
     PlayerViewSkins(5)=Texture'GameMedia.Skins.WeaponNewHands'
     Icon=Texture'GameMedia.Icons.BeltIconBotControl'
     largeIcon=Texture'GameMedia.Icons.LargeIconBotControl'
     largeIconWidth=28
     largeIconHeight=46
}