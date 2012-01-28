//=============================================================================
// ��������� ����������. �������� Ded'�� ��� ���� 2027
// Weapon tool. Copyright (C) 2005 Ded
//=============================================================================
class WeaponTool extends DeusExPickup
	abstract;

var() float ItemModifier;
var localized string DragToUse;
var localized string ItemFixedLabel;

replication
{
	reliable if (Role < 4)
		DestroyTool,ApplyTool;
}

function PostBeginPlay()
{
	Super.PostBeginPlay();
	LoopAnim('Cycle');
}

function ApplyTool(Inventory Item)
{
}

function bool CanFixItem(Inventory Item)
{
}

function string GetApplyMessage()
{
	return ItemFixedLabel;
}

function DestroyTool()
{
	NumCopies--;

	if(NumCopies<=0)
		Destroy();
}

simulated function bool UpdateInfo(Object winObject)
{
	local PersonaInfoWindow winInfo;

	winInfo=PersonaInfoWindow(winObject);
	if ( winInfo == None )
	{
		return False;
	}
	winInfo.Clear();
	winInfo.SetTitle(ItemName);
	winInfo.SetText(Description $ winInfo.CR() $ winInfo.CR());
	winInfo.AppendText(DragToUse);
	return True;
}

defaultproperties
{
	bCanHaveMultipleCopies=True
    PlayerViewOffset=(X=30.00, Y=0.00, Z=-12.00)
    PlayerViewMesh=LodMesh'DeusExItems.WeaponMod'
    PickupViewMesh=LodMesh'DeusExItems.WeaponMod'
    ThirdPersonMesh=LodMesh'DeusExItems.WeaponMod'
    LandSound=Sound'DeusExSounds.Generic.PlasticHit1'
    largeIconWidth=34
    largeIconHeight=49
    invSlotsX=1
    invSlotsY=1
    Mesh=LodMesh'DeusExItems.WeaponMod'
    CollisionRadius=3.50
    CollisionHeight=4.42
    Mass=1.00
}