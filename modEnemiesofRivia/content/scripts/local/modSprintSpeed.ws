exec function SetSprintingSpeed(speed : float)
{
	thePlayer.SetSprintingSpeed(speed);
	GetWitcherPlayer().DisplayHudMessage( "Player SprintingSpeed: " + FloatToString(speed) );
}

exec function SetDivingSpeed(speed : float)
{
	thePlayer.SetDivingSpeed(speed);
	GetWitcherPlayer().DisplayHudMessage( "Player DivingSpeed: " + FloatToString(speed) );
}

exec function SetSwimmingSpeed(speed : float)
{
	thePlayer.SetSwimmingSpeed(speed);
	GetWitcherPlayer().DisplayHudMessage( "Player SwimmingSpeed: " + FloatToString(speed) );
}

exec function SetRunningSpeed(speed : float)
{
	thePlayer.SetRunningSpeed(speed);
	GetWitcherPlayer().DisplayHudMessage( "Player SetRunningSpeed: " + FloatToString(speed) );
}

exec function modSpeedInCombat(flag : bool)
{
	thePlayer.modSpeedInCombat(flag);
	if(flag)
		GetWitcherPlayer().DisplayHudMessage( "Player modSpeedInCombat enabled" );
	else
		GetWitcherPlayer().DisplayHudMessage( "Player modSpeedInCombat disabled" );
}
