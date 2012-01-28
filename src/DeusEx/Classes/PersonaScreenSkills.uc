//=============================================================================
// PersonaScreenSkills
//=============================================================================

class PersonaScreenSkills extends PersonaScreenBaseWindow;

var PersonaActionButtonWindow btnUpgrade,btnUpgrade2;
var TileWindow                winTile;
var PersonaPerkWindow winTile2;
var PersonaListWindow         lstPerks;
var PersonaScrollAreaWindow   winScroll;

var Skill			selectedSkill;
var Perk			selectedPerk;

var PersonaSkillButtonWindow  selectedSkillButton;
var PersonaPerkButtonWindow  selectedPerkButton;

var PersonaAgentButtonWindow  selectedAgentButton;

var PersonaHeaderTextWindow   winSkillPoints, winUpgradePoints, winTotalExperience;
var PersonaHeaderTextWindow winUpgradePointsTitle;

var PersonaInfoWindow         winInfo,winInfo2;


var PersonaSkillButtonWindow  skillButtons[15];
var PersonaPerkButtonWindow  perkButtons[15];

var ProgressBarWindow winProgress;

var int focusPerkRowId;

var color BarColor;
var color BarBackgroundColor;

var localized String SkillsTitleText, PerksTitleText;
var localized String UpgradeButtonLabel;
var localized String InstallButtonLabel;
var localized String PointsNeededHeaderText;
var localized String SkillLevelHeaderText;
var localized String SkillPointsHeaderText;
var localized String SkillUpgradedLevelLabel,PerkInstalledLabel;
var localized String UpgradePointsHeaderText;
var localized String ExperienceHeaderText;

var localized String AgentCombatTitle, AgentTechTitle, AgentMedicTitle;
var localized String AgentCombatDesc, AgentTechDesc, AgentMedicDesc;

var() int StartX,StartY;
var() int SpaceX,SpaceY;

// ----------------------------------------------------------------------
// InitWindow()
//
// Initialize the Window
// ----------------------------------------------------------------------
event InitWindow()
{
	Super.InitWindow();

	PersonaNavBarWindow(winNavBar).btnSkills.SetSensitivity(False);

	EnableButtons();
}

// ----------------------------------------------------------------------
// CreateControls()
// ----------------------------------------------------------------------
function CreateControls()
{
	Super.CreateControls();

	CreateTitleWindow(9, 4, SkillsTitleText);
	CreateInfoWindow();
	CreateButtons();
	CreateSkillsHeaders();
	CreateSkillsTileWindow();
	CreateSkillsList();
	CreateSkillPointsWindow();
	CreateStatusWindow();

	CreateProgressBar();

	CreateTitleWindow(9, 273, PerksTitleText);
	CreateInfoWindow2();
	CreateButtons2();
	CreatePerksTileWindow();
	CreatePerksList();
	
	CreateUpgradePointsWindow();
	
	CreateStatusWindow2();
}

function CreateProgressBar()
{
	local ColorTheme theme;

	theme = player.ThemeManager.GetCurrentHUDColorTheme();
	BarColor = theme.GetColorFromName('HUDColor_ButtonTextNormal');
	
	winProgress = ProgressBarWindow(NewChild(Class'ProgressBarWindow'));
	winProgress.SetSize(200, 7);
	winProgress.SetPos(134, 477);
	winProgress.SetValues(0, 100);
	winProgress.SetCurrentValue(0);
	winProgress.SetVertical(False);
	winProgress.UseScaledColor(False);
	winProgress.SetDrawBackground(False);
	winProgress.SetColors(BarBackgroundColor, BarColor);
	
	RefreshProgressBar();
}

function RefreshProgressBar()
{
	local int i, TotalPoints, Points;
	local float ExpPercent;
	
	if(player.HeroLevel<player.MaxHeroLevel)
	{
		TotalPoints=0;
		
		for(i=0;i<player.HeroLevel;i++)
		{
			TotalPoints += player.ExperienceLevel[i];
		}

		Points = player.ExperiencePoints - TotalPoints;
		ExpPercent = 100.0 * (float(Points) / float(player.ExperienceLevel[player.HeroLevel]));
	}
	else
	{
		ExpPercent = 100;
	}

	winProgress.SetCurrentValue(ExpPercent);
	winProgress.SetColors(BarBackgroundColor, BarColor);
}

// ----------------------------------------------------------------------
// CreateStatusWindow2()
// ----------------------------------------------------------------------
function CreateStatusWindow2()
{
	winStatus2 = PersonaStatusLineWindow(winClient.NewChild(Class'PersonaStatusLineWindow'));
	winStatus2.SetPos(356, 428);
}

// ----------------------------------------------------------------------
// CreateStatusWindow()
// ----------------------------------------------------------------------
function CreateStatusWindow()
{
	winStatus = PersonaStatusLineWindow(winClient.NewChild(Class'PersonaStatusLineWindow'));
	winStatus.SetPos(356, 230);//356-328
}

// ----------------------------------------------------------------------
// CreatePerksTileWindow()
// ----------------------------------------------------------------------
function CreatePerksTileWindow()
{
	local PersonaPerkWindow w1,w2;

	winTile2 = PersonaPerkWindow(winClient.NewChild(Class'PersonaPerkWindow'));
	winTile2.SetPos(11, 289);
	winTile2.SetSize(354, 118);

	w1 = PersonaPerkWindow(winTile2.NewChild(Class'PersonaPerkWindow'));
	w1.SetPos(0, 0);
	w1.SetSize(256, 138);
	w1.setwinsize(256, 118);
	w1.setbg(Texture'GameMedia.UI.PerksBG_1');

	w2 = PersonaPerkWindow(winTile2.NewChild(Class'PersonaPerkWindow'));
	w2.SetPos(256, 0);
	w2.SetSize(48, 138);
	w2.setwinsize(48, 118);
	w2.setbg(Texture'GameMedia.UI.PerksBG_2');

	winScroll = CreateScrollAreaWindow(winClient);
	winScroll.SetPos(11, 289);
	winScroll.SetSize(304, 120);//304, 118

	lstPerks = PersonaListWindow(winScroll.clipWindow.NewChild(Class'PersonaListWindow'));
	lstPerks.EnableMultiSelect(False);
	lstPerks.EnableAutoExpandColumns(True);
	lstPerks.SetNumColumns(2);
	lstPerks.SetSortColumn(0, True);
	lstPerks.EnableAutoSort(False);
	lstPerks.SetColumnWidth(0, 269);
	lstPerks.SetColumnWidth(1, 20);
	lstPerks.SetColumnFont(1, Font'FontHUDWingDings');
}

// ----------------------------------------------------------------------
// CreateSkillsTileWindow()
// ----------------------------------------------------------------------
function CreateSkillsTileWindow()
{
	winTile = TileWindow(winClient.NewChild(Class'TileWindow'));

	winTile.SetPos(12, 39);
	winTile.SetSize(302, 189);//302-351
	winTile.SetMinorSpacing(0);
	winTile.SetMargins(0, 0);
	winTile.SetOrder(ORDER_Down);
}

// ----------------------------------------------------------------------
// CreateInfoWindow2()
// ----------------------------------------------------------------------
function CreateInfoWindow2()
{
	winInfo2 = PersonaInfoWindow(winClient.NewChild(Class'PersonaInfoWindow'));
	winInfo2.SetPos(356, 277);
	winInfo2.SetSize(238, 146);
}

// ----------------------------------------------------------------------
// CreateInfoWindow()
// ----------------------------------------------------------------------
function CreateInfoWindow()
{
	winInfo = PersonaInfoWindow(winClient.NewChild(Class'PersonaInfoWindow'));
	winInfo.SetPos(356, 22);
	winInfo.SetSize(238, 201);//238-299
}

// ----------------------------------------------------------------------
// CreateButtons2()
// ----------------------------------------------------------------------
function CreateButtons2()
{
	local PersonaButtonBarWindow winActionButtons;

	winActionButtons = PersonaButtonBarWindow(winClient.NewChild(Class'PersonaButtonBarWindow'));
	winActionButtons.SetPos(10, 409);
	winActionButtons.SetWidth(149);
	winActionButtons.FillAllSpace(False);

	btnUpgrade2 = PersonaActionButtonWindow(winActionButtons.NewChild(Class'PersonaActionButtonWindow'));
	btnUpgrade2.SetButtonText(InstallButtonLabel);
}

// ----------------------------------------------------------------------
// CreateButtons()
// ----------------------------------------------------------------------
function CreateButtons()
{
	local PersonaButtonBarWindow winActionButtons;

	winActionButtons = PersonaButtonBarWindow(winClient.NewChild(Class'PersonaButtonBarWindow'));
	winActionButtons.SetPos(10, 230);
	winActionButtons.SetWidth(149);
	winActionButtons.FillAllSpace(False);

	btnUpgrade = PersonaActionButtonWindow(winActionButtons.NewChild(Class'PersonaActionButtonWindow'));
	btnUpgrade.SetButtonText(UpgradeButtonLabel);
}



// ----------------------------------------------------------------------
// CreateSkillsHeaders()
// ----------------------------------------------------------------------
function CreateSkillsHeaders()
{
	local PersonaNormalTextWindow winText;

	winText = PersonaNormalTextWindow(winClient.NewChild(Class'PersonaNormalTextWindow'));
	winText.SetPos(177, 24);
	winText.SetText(SkillLevelHeaderText);

	winText = PersonaNormalTextWindow(winClient.NewChild(Class'PersonaNormalTextWindow'));
	winText.SetPos(275, 24);
	winText.SetTextAlignments(HALIGN_Right, VALIGN_Center);
	winText.SetText(PointsNeededHeaderText);
}

// ----------------------------------------------------------------------
// CreatePerksList()
// ----------------------------------------------------------------------
function CreatePerksList()
{
	local Perk aPerk;
	local int   buttonIndex, i;
	local PersonaPerkButtonWindow perkButton;
	local PersonaPerkButtonWindow firstButton;
	local int rowId;

	lstPerks.DeleteAllRows();

	aPerk = player.PerkSystem.FirstPerk;
	
	while(aPerk != None)
	{
		if (aPerk.PerkName != "")
		{
			rowId = lstPerks.AddRow(aPerk.PerkName);
			
			if(aPerk.bInstalled)
				lstPerks.SetField(rowId, 1, "C");
			
			lstPerks.SetRowClientObject(rowId, aPerk);
		}
		
		aPerk = aPerk.next;
	}
}

event bool ListSelectionChanged(window list, int numSelections, int focusRowId)
{
	if(list == lstPerks)
	{
		focusPerkRowId = focusRowId;		
		selectedPerk  = Perk(lstPerks.GetRowClientObject(focusPerkRowId));
		selectedPerk.UpdateInfo(winInfo2);
		EnableButtons();
	}
	// Set a flag to later clear the "*New*" in the second column
	//lstImages.SetFieldValue(focusPerkRowId, 2, 1);
	
	return True;
}

function PersonaPerkButtonWindow CreatePerkButton(Perk anPerk)
{
	local PersonaPerkButtonWindow newButton;

	newButton = PersonaPerkButtonWindow(winTile2.NewChild(Class'PersonaPerkButtonWindow'));
	newButton.SetPos(StartX + SpaceX * anPerk.PerkPosition.X, StartY + SpaceY * anPerk.PerkPosition.Y);
	newButton.SetClientObject(anPerk);
	newButton.SetIcon(anPerk.PerkIcon);
	//newButton.SetActive(anPerk.bInstalled);
	newButton.SetSensitivity(True);

	return newButton;
}

// ----------------------------------------------------------------------
// CreateSkillsList()
// ----------------------------------------------------------------------
function CreateSkillsList()
{
	local Skill aSkill;
	local int   buttonIndex;
	local PersonaSkillButtonWindow skillButton;
	local PersonaSkillButtonWindow firstButton;

	// Iterate through the skills, adding them to our list
	aSkill = player.SkillSystem.FirstSkill;
	while(aSkill != None)
	{
		if (aSkill.SkillName != "")
		{
			skillButton = PersonaSkillButtonWindow(winTile.NewChild(Class'PersonaSkillButtonWindow'));
			skillButton.SetSkill(aSkill);

			skillButtons[buttonIndex++] = skillButton;

			if (firstButton == None)
				firstButton = skillButton;
		}
		aSkill = aSkill.next;
	}

	// Select the first skill
	SelectSkillButton(firstButton);
}

// ----------------------------------------------------------------------
// CreateUpgradePointsWindow()
// ----------------------------------------------------------------------
function CreateUpgradePointsWindow()
{
	winUpgradePointsTitle = PersonaHeaderTextWindow(winClient.NewChild(Class'PersonaHeaderTextWindow'));
	winUpgradePointsTitle.SetPos(160, 412);
	winUpgradePointsTitle.SetSize(128, 15);
	winUpgradePointsTitle.SetTextAlignments(HALIGN_Right, VALIGN_Center);
	winUpgradePointsTitle.SetHeight(15);
	
	if(player.UpgradePoints > 0)
		winUpgradePointsTitle.SetText(UpgradePointsHeaderText);
	else
		winUpgradePointsTitle.SetText("");

	winUpgradePoints = PersonaHeaderTextWindow(winClient.NewChild(Class'PersonaHeaderTextWindow'));
	winUpgradePoints.SetPos(284, 412);
	winUpgradePoints.SetSize(22, 15);
	winUpgradePoints.SetTextAlignments(HALIGN_Right, VALIGN_Center);
	
	if(player.UpgradePoints > 0)
		winUpgradePoints.SetText(player.UpgradePoints);
	else
		winUpgradePoints.SetText("");
		
	winUpgradePointsTitle = PersonaHeaderTextWindow(winClient.NewChild(Class'PersonaHeaderTextWindow'));
	winUpgradePointsTitle.SetPos(12, 432);
	winUpgradePointsTitle.SetSize(60, 15);
	winUpgradePointsTitle.SetTextAlignments(HALIGN_Left, VALIGN_Center);
	winUpgradePointsTitle.SetHeight(15);
	winUpgradePointsTitle.SetText(ExperienceHeaderText);
	
	winTotalExperience = PersonaHeaderTextWindow(winClient.NewChild(Class'PersonaHeaderTextWindow'));
	winTotalExperience.SetPos(67, 432);
	winTotalExperience.SetSize(39, 15);
	winTotalExperience.SetTextAlignments(HALIGN_Right, VALIGN_Center);
	winTotalExperience.SetText(player.ExperiencePoints);
}

// ----------------------------------------------------------------------
// CreateSkillPointsWindow()
// ----------------------------------------------------------------------
function CreateSkillPointsWindow()
{
	local PersonaHeaderTextWindow winText;

	winText = PersonaHeaderTextWindow(winClient.NewChild(Class'PersonaHeaderTextWindow'));
	winText.SetPos(160, 233);//180-395
	winText.SetSize(112, 15);
	winText.SetTextAlignments(HALIGN_Right, VALIGN_Center);
	winText.SetText(SkillPointsHeaderText);

	winSkillPoints = PersonaHeaderTextWindow(winClient.NewChild(Class'PersonaHeaderTextWindow'));
	winSkillPoints.SetPos(263, 233);//247-395
	winSkillPoints.SetSize(43, 15);
	winSkillPoints.SetTextAlignments(HALIGN_Right, VALIGN_Center);
	winSkillPoints.SetText(player.SkillPointsAvail);
}

// ----------------------------------------------------------------------
// ButtonActivated()
// ----------------------------------------------------------------------
function bool ButtonActivated( Window buttonPressed )
{
	local bool bHandled;

	if (Super.ButtonActivated(buttonPressed))
		return True;

	bHandled   = True;

	if (buttonPressed.IsA('PersonaSkillButtonWindow'))
	{
		SelectSkillButton(PersonaSkillButtonWindow(buttonPressed));
	}
	else if (buttonPressed.IsA('PersonaPerkButtonWindow'))
	{
		SelectPerkButton(PersonaPerkButtonWindow(buttonPressed));
	}
	else if (buttonPressed.IsA('PersonaAgentButtonWindow'))
	{
		SelectAgentButton(PersonaAgentButtonWindow(buttonPressed));
	}
	else
	{
		switch(buttonPressed)
		{
			case btnUpgrade:
				UpgradeSkill();
				break;

			case btnUpgrade2:
				InstallPerk();
				break;

			default:
				bHandled = False;
				break;
		}
	}

	return bHandled;
}

// ----------------------------------------------------------------------
// VirtualKeyPressed()
// ----------------------------------------------------------------------
event bool VirtualKeyPressed(EInputKey key, bool bRepeat)
{
	local bool bHandled;

	bHandled = True;

	switch( key ) 
	{
		case IK_Up:
			SelectPreviousSkillButton();
			break;

		case IK_Down:
			SelectNextSkillButton();
			break;

		default:
			bHandled = False;
			break;
	}

	return bHandled;
}

// ----------------------------------------------------------------------
// SelectAgentButton()
// ----------------------------------------------------------------------
function SelectAgentButton(PersonaAgentButtonWindow buttonPressed)
{
	if (selectedAgentButton != buttonPressed)
	{
		if (selectedAgentButton != None)
			selectedAgentButton.SelectButton(False);
	
		if(selectedPerkButton != None){
			selectedPerkButton.SelectButton(False);
			selectedPerkButton = None;
		}

		selectedAgentButton = buttonPressed;

		winInfo2.Clear();
		winInfo2.SetTitle(selectedAgentButton.GetWinTitle());
		winInfo2.SetText(selectedAgentButton.GetWinText());
		selectedAgentButton.SelectButton(True);

		EnableButtons();
		btnUpgrade2.SetSensitivity(False);
	}
}

// ----------------------------------------------------------------------
// SelectPerkButton()
// ----------------------------------------------------------------------
function SelectPerkButton(PersonaPerkButtonWindow buttonPressed)
{
	if (selectedPerkButton != buttonPressed)
	{
		if (selectedPerkButton != None)
			selectedPerkButton.SelectButton(False);
	
		if(selectedAgentButton != None){
			selectedAgentButton.SelectButton(False);
			selectedAgentButton = None;
		}

		selectedPerkButton = buttonPressed;
		selectedPerk       = selectedPerkButton.GetPerk();

		selectedPerk.UpdateInfo(winInfo2);
		selectedPerkButton.SelectButton(True);

		EnableButtons();
	}
}

// ----------------------------------------------------------------------
// SelectSkillButton()
// ----------------------------------------------------------------------
function SelectSkillButton(PersonaSkillButtonWindow buttonPressed)
{
	if (selectedSkillButton != buttonPressed)
	{
		if (selectedSkillButton != None)
			selectedSkillButton.SelectButton(False);

		selectedSkillButton = buttonPressed;
		selectedSkill       = selectedSkillButton.GetSkill();

		selectedSkill.UpdateInfo(winInfo);
		selectedSkillButton.SelectButton(True);

		EnableButtons();
	}
}

// ----------------------------------------------------------------------
// SelectPreviousSkillButton()
// ----------------------------------------------------------------------
function SelectPreviousSkillButton()
{
	local int skillIndex;

	skillIndex = GetCurrentSkillButtonIndex();

	if (--skillIndex < 0)
		skillIndex = GetSkillButtonCount() - 1;

	skillButtons[skillIndex].ActivateButton(IK_LeftMouse);
}

// ----------------------------------------------------------------------
// SelectNextSkillButton()
// ----------------------------------------------------------------------
function SelectNextSkillButton()
{
	local int skillIndex;

	skillIndex = GetCurrentSkillButtonIndex();

	if (++skillIndex >= GetSkillButtonCount())
		skillIndex = 0;

	skillButtons[skillIndex].ActivateButton(IK_LeftMouse);
}

// ----------------------------------------------------------------------
// GetCurrentSkillButtonIndex()
// ----------------------------------------------------------------------
function int GetCurrentSkillButtonIndex()
{
	local int buttonIndex;
	local int returnIndex;

	returnIndex = -1;

	for(buttonIndex=0; buttonIndex<arrayCount(skillButtons); buttonIndex++)
	{
		if (skillButtons[buttonIndex] == selectedSkillButton)
		{
			returnIndex = buttonIndex;
			break;
		}		
	}

	return returnIndex;
}

// ----------------------------------------------------------------------
// GetSkillButtonCount()
// ----------------------------------------------------------------------
function int GetSkillButtonCount()
{
	local int buttonIndex;

	for(buttonIndex=0; buttonIndex<arrayCount(skillButtons); buttonIndex++)
	{
		if (skillButtons[buttonIndex] == None)
			break;
	}	

	return buttonIndex;
}

// ----------------------------------------------------------------------
// InstallPerk()
// ----------------------------------------------------------------------
function InstallPerk()
{
	local int i;

	if (selectedPerk == None)
		return;

	selectedPerk.InstallPerk();

	winStatus2.AddText(Sprintf(PerkInstalledLabel, selectedPerk.PerkName));

	if(player.UpgradePoints > 0)
		winUpgradePointsTitle.SetText(ExperienceHeaderText);
	else
		winUpgradePointsTitle.SetText("");

	if(player.UpgradePoints > 0)
		winUpgradePoints.SetText(player.UpgradePoints);
	else
		winUpgradePoints.SetText("");
	
	lstPerks.SetField(focusPerkRowId, 1, "C");

	EnableButtons();
}

// ----------------------------------------------------------------------
// UpgradeSkill()
// ----------------------------------------------------------------------
function UpgradeSkill()
{
	if (selectedSkill == None)
		return;

	selectedSkill.IncLevel();
	selectedSkillButton.RefreshSkillInfo();

	winStatus.AddText(Sprintf(SkillUpgradedLevelLabel, selectedSkill.SkillName));
	
	winSkillPoints.SetText(player.SkillPointsAvail);
		
	EnableButtons();
}

// ----------------------------------------------------------------------
// EnableButtons()
// ----------------------------------------------------------------------
function EnableButtons()
{
	if (selectedSkill == None)
		btnUpgrade.SetSensitivity(False);
	else
		btnUpgrade.EnableWindow(selectedSkill.CanAffordToUpgrade(player.SkillPointsAvail));

	if (selectedPerk == None)
		btnUpgrade2.SetSensitivity(False);
	else		
		btnUpgrade2.EnableWindow(selectedPerk.CanBeInstalled() && selectedPerk.CanAffordToInstall(player.UpgradePoints));
}

// ----------------------------------------------------------------------
// RefreshWindow()
// ----------------------------------------------------------------------
function RefreshWindow(float DeltaTime)
{
    if (selectedSkill != None)
        selectedSkillButton.RefreshSkillInfo();

	if(player.UpgradePoints > 0)
		winUpgradePointsTitle.SetText(UpgradePointsHeaderText);
	else
		winUpgradePointsTitle.SetText("");

	if(player.UpgradePoints > 0)
		winUpgradePoints.SetText(player.UpgradePoints);
	else
		winUpgradePoints.SetText("");

    winSkillPoints.SetText(player.SkillPointsAvail);
    EnableButtons();
    RefreshProgressBar();
    
    Super.RefreshWindow(DeltaTime);
}

event StyleChanged()
{
	local ColorTheme theme;

	super.StyleChanged();

	theme = player.ThemeManager.GetCurrentHUDColorTheme();
	BarColor = theme.GetColorFromName('HUDColor_ButtonTextNormal');
}

defaultproperties
{
	 BarBackgroundColor=(R=200,G=200,B=200)
	 BarColor=(R=0,G=255,B=0)
     clientBorderOffsetY=33
     ClientWidth=604
     ClientHeight=510
     clientBorderWidth=640
     clientBorderHeight=545
     clientOffsetX=19
     clientOffsetY=12
     clientTextures(0)=Texture'DeusExUI.UserInterface.SkillsBackground_1'
     clientTextures(1)=Texture'DeusExUI.UserInterface.SkillsBackground_2'
     clientTextures(2)=Texture'DeusExUI.UserInterface.SkillsBackground_3'
     clientTextures(3)=Texture'DeusExUI.UserInterface.SkillsBackground_4'
     clientTextures(4)=Texture'DeusExUI.UserInterface.SkillsBackground_5'
     clientTextures(5)=Texture'DeusExUI.UserInterface.SkillsBackground_6'
     clientBorderTextures(0)=Texture'DeusExUI.UserInterface.SkillsBorder_1'
     clientBorderTextures(1)=Texture'DeusExUI.UserInterface.SkillsBorder_2'
     clientBorderTextures(2)=Texture'DeusExUI.UserInterface.SkillsBorder_3'
     clientBorderTextures(3)=Texture'DeusExUI.UserInterface.SkillsBorder_4'
     clientBorderTextures(4)=Texture'DeusExUI.UserInterface.SkillsBorder_5'
     clientBorderTextures(5)=Texture'DeusExUI.UserInterface.SkillsBorder_6'
     clientTextureRows=2
     clientTextureCols=3
     clientBorderTextureRows=2
     clientBorderTextureCols=3
     StartX=87
     StartY=5
     SpaceX=60
     SpaceY=48
}
