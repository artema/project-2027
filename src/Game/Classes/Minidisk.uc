//=============================================================================
// ��������. ������� Ded'�� ��� ���� 2027
// Minidisk.  Copyright (C) 2003 Ded
// ����� ������/Model created by: Ded
// Deus Ex: 2027
//=============================================================================
class Minidisk extends DeusExDecoration;

enum ESkin
{
	ES_Blue,
	ES_Green
};

var() ESkin SkinType;

enum EContent
{
	EC_Empty,
	EC_Custom
};

var() EContent ContentType;

var localized String EmptyMsg;

var(ContentCustom) localized String CustomContent;
var(ContentCustom) Name CustomContentTag;

var String vaultString;
var bool bFirstParagraph;

function BeginPlay()
{
	Super.BeginPlay();

	switch (SkinType)
	{
		case ES_Blue:  
			MultiSkins[1] = Texture'GameMedia.Skins.MinidiskTex0';
        	break;

		case ES_Green: 
			MultiSkins[1] = Texture'GameMedia.Skins.MinidiskTex1';
            break;
	}
}


function Frob(Actor Frobber, Inventory frobWith)
{
	switch(ContentType)
	{
		case EC_Empty:
			DeusExPlayer(Frobber).ClientMessage(EmptyMsg);
			Destroy();
			return;	
		
		case EC_Custom:
			if(CustomContent != "")
			{
				DeusExPlayer(Frobber).AddNote(CustomContent, False, True);
				Destroy();
			}
			else if(CustomContentTag != '')
			{
				AddNote(CustomContentTag);
				Destroy();
			}
			break;	
	}
	
	Super.Frob(Frobber, frobWith);    
}

function AddNote(Name textTag)
{
	local DeusExTextParser parser;
	local DeusExNote note;
	local DeusExPlayer player;

	player = DeusExPlayer(GetPlayerPawn());

	if ( textTag != '' )
	{
		parser = new(None) Class'DeusExTextParser';
								    
		if ((player != None) && (parser.OpenText(textTag,"GameText")))
		{
			parser.SetPlayerName(player.TruePlayerName);
			vaultString = "";
			bFirstParagraph = True;

			while(parser.ProcessText())
				ProcessTag(parser);

			parser.CloseText();

				note = player.GetNote(textTag);

				if (note == None)
				{
					note = player.AddNote(vaultString,, True);
					note.SetTextTag(textTag);
				}

				vaultString = "";
		}
		CriticalDelete(parser);
	}
}

function ProcessTag(DeusExTextParser parser)
{
	local String text;
	local byte tag;
	local Name fontName;
	local String textPart;

	tag  = parser.GetTag();

	switch(tag)
	{
		case 0:				// TT_Text:
		case 9:				// TT_PlayerName:
		case 10:			// TT_PlayerFirstName:
			text = parser.GetText();
			vaultString = vaultString $ text;
			break;

		// Create a new text window
		case 18:			// TT_NewParagraph:
			//if (!bFirstParagraph)			
				vaultString = vaultString $ "|n";

			bFirstParagraph = False;
			break;
	}
}

defaultproperties
{
	 EmptyMsg="Nothing interesting"
     bInvincible=True
     bPushable=False
     Physics=PHYS_None
     Mesh=LodMesh'GameMedia.Minidisk'
     CollisionRadius=3.000000
     CollisionHeight=0.100000
     bCollideWorld=False
     bBlockActors=True
     Mass=0.500000
     Buoyancy=2.000000
}
