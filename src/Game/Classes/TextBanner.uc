//======================================================
// Бегущая строка. Сделанно Ded'ом для мода 2027
// Banner. Copyright (C) 2004 Ded
//======================================================
class TextBanner expands Info;

var() Texture ScriptedTexture;
var() localized string BannerMessage;
var() Font Font;
var() color FontColor;
var() bool bCaps;
var() int PixelsPerSecond;
var() int ScrollWidth;
var() float YPos;
var() bool bResetPosOnTextChange;

var string OldText;
var int Position;
var float LastDrawTime;
var PlayerPawn Player;

simulated function FindPlayer()
{
	local DeusExPlayer P;

	foreach AllActors(class'DeusExPlayer', P)
		if(Viewport(P.Player) != None)
			Player = P;
}

simulated event RenderTexture(ScriptedTexture Tex)
{
	local string Text;
	local PlayerReplicationInfo Leading, PRI;
	local int i;

	if(Player == None)
		FindPlayer();

	if(Player == None || Player.PlayerReplicationInfo == None || Player.GameReplicationInfo == None)
		return;

	if(LastDrawTime == 0)
		Position = Tex.USize;
	else
		Position -= (Level.TimeSeconds-LastDrawTime) * PixelsPerSecond;

	if(Position < -ScrollWidth)
		Position = Tex.USize;

	LastDrawTime = Level.TimeSeconds;

	Text = BannerMessage;

	Text = Replace(Text, "%p", Player.PlayerReplicationInfo.PlayerName);

	if(bCaps)
		Text = Caps(Text);

	if(Text != OldText && bResetPosOnTextChange)
	{
		Position = Tex.USize;
		OldText = Text;
	}

	Tex.DrawColoredText( Position, YPos, Text, Font, FontColor );
}

simulated function string Replace(string Text, string Match, string Replacement)
{
	local int i;
	
	i = InStr(Text, Match);	

	if(i != -1)
		return Left(Text, i) $ Replacement $ Replace(Mid(Text, i+Len(Match)), Match, Replacement);
	else
		return Text;
}

simulated function BeginPlay()
{
	if(ScriptedTexture != None)
		ScriptedTexture(ScriptedTexture).NotifyActor = Self;
}

simulated function Destroyed()
{
	if(ScriptedTexture != None)
		ScriptedTexture(ScriptedTexture).NotifyActor = None;
}

// %p заменяется на настоящее имя игрока

defaultproperties
{
     Font=Font'DeusExUI.FontMenuTitle'
     bResetPosOnTextChange=True
}
