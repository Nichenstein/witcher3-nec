///////////////////////////////////////////////////////////////////////////
////////////////////////// MOD SHADOW SUITE ///////////////////////////////
///////////////////////////// by rfuzzo ///////////////////////////////////
///////////////////////////////////////////////////////////////////////////


enum ELightsourceType
{
	LST_undefined,
	LST_campfire,
	LST_candle,
	//LST_torch_hand,
	LST_torch,
	LST_brazier,
	LST_lantern,
	LST_other
};

struct SLightsourceConfig
{
	var colorR, colorG, colorB, colorA : int;
	var shadowCastingMode : int;
	var allowDistantFade : bool;
	var radius, brightness, attenuation : float;
	var shadowFadeDistance, shadowFadeRange, shadowBlendFactor : float;
	var autoHideDistance, autoHideRange : float;
}

	//////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////



class CModLightsourceSuite extends CRFScripthook
{

	private var igcWrapper : CInGameConfigWrapper;
	private var LSConfigGroupNames : array<name>;
	private var userLSConfig : array <SLightsourceConfig>;
	
	public var isRestoredToVanilla : bool;
	
	default isRestoredToVanilla = false;
	
	//////////////////////////////////////////////////////////////////////////////////////////
	
	
	public function IsModEnabled() : bool
	{
		return (bool)igcWrapper.GetVarValue('lss_general', 'lss_EnableMod');
	}
	public function IsModAppliedOnGameStart() : bool
	{
		return (bool)igcWrapper.GetVarValue('lss_general', 'lss_ApplyOnGameStart');
	}
	public function IsChangeOnIgni() : bool
	{
		return (bool)igcWrapper.GetVarValue('lss_general', 'lss_ChangeOnIgni');
	}
	public function IsChangeOnCloseMenu() : bool
	{
		return (bool)igcWrapper.GetVarValue('lss_general', 'lss_ApplyOnCloseMenu');
	}
	public function IsTypeEnabled( type : name ) : bool
	{
		if ( LSConfigGroupNames.Contains(type) && (type != 'LST_undefined') )
			return (bool)igcWrapper.GetVarValue(type, 'lss_EnableModComp');
		else
			return false;
	}

	
	//////////////////////////////////////////////////////////////////////////////////////////
	//INIT
	//////////////////////////////////////////////////////////////////////////////////////////
	event OnInit()
	{
		var initialized : bool;
		var i : int;
		var groupName : name;
		
		igcWrapper = theGame.GetInGameConfigWrapper();
		initialized = (bool)igcWrapper.GetVarValue('lss_general', 'lss_Init');
		
		InitConfigGroupNames();
		userLSConfig.Resize( EnumGetMax('ELightsourceType')+1 );
		
		if (!initialized)
		{
			//apply menu presets
			for (i=1;i< EnumGetMax('ELightsourceType')+1;i+=1) //ACHTUNG start with 1 (0 = LST_undefined)
			{
				groupName = LSConfigGroupNames[i];
				igcWrapper.ApplyGroupPreset( groupName, 0 );
			}
			igcWrapper.SetVarValue('lss_general', 'lss_Init', true);
		}
		
		StoreConfig();
	}
	
	//ACHTUNG these must match the hard-coded group names in the xml!
	private function InitConfigGroupNames()
	{
		LSConfigGroupNames.PushBack('LST_undefined');
		LSConfigGroupNames.PushBack('LST_campfire');
		LSConfigGroupNames.PushBack('LST_candle');
		//LSConfigGroupNames.PushBack('LST_torch_hand');
		LSConfigGroupNames.PushBack('LST_torch');
		LSConfigGroupNames.PushBack('LST_brazier');
		LSConfigGroupNames.PushBack('LST_lantern');
		LSConfigGroupNames.PushBack('LST_other');
	}
	
	
	private function StoreConfig()
	{
		var i : int;
		var groupName : name;
		
		for (i=1;i< EnumGetMax('ELightsourceType')+1;i+=1) //ACHTUNG start with 1 (0 = LST_undefined)
		{
			groupName = LSConfigGroupNames[i];
			
			//NORMAL SETTINGS
			userLSConfig[i].radius = (float)igcWrapper.GetVarValue(groupName, 'lss_Radius');
			userLSConfig[i].brightness = (float)igcWrapper.GetVarValue(groupName, 'lss_Brightness');
			userLSConfig[i].attenuation = (float)igcWrapper.GetVarValue(groupName, 'lss_Attenuation');
			userLSConfig[i].shadowCastingMode = (int)igcWrapper.GetVarValue(groupName, 'lss_ShadowMode');
			userLSConfig[i].shadowBlendFactor = (float)igcWrapper.GetVarValue(groupName, 'lss_ShadowBlendFactor');
			
			//ADVANCED SETTINGS
			userLSConfig[i].allowDistantFade = (bool)igcWrapper.GetVarValue(groupName, 'lss_AllowDistantFade');
			userLSConfig[i].shadowFadeDistance = (float)igcWrapper.GetVarValue(groupName, 'lss_ShadowFadeDistance');
			userLSConfig[i].shadowFadeRange = (float)igcWrapper.GetVarValue(groupName, 'lss_ShadowFadeRange');
			userLSConfig[i].autoHideDistance = (float)igcWrapper.GetVarValue(groupName, 'lss_AutoHideDistance');
			userLSConfig[i].autoHideRange = (float)igcWrapper.GetVarValue(groupName, 'lss_AutoHideRange');
			userLSConfig[i].colorR = (int)igcWrapper.GetVarValue(groupName, 'alss_ColorR');
			userLSConfig[i].colorG = (int)igcWrapper.GetVarValue(groupName, 'alss_ColorG');
			userLSConfig[i].colorB = (int)igcWrapper.GetVarValue(groupName, 'alss_ColorB');
			userLSConfig[i].colorA = (int)igcWrapper.GetVarValue(groupName, 'alss_ColorA');
			
		}	
	}
	
	private function LSEnumToName( type : ELightsourceType ) : name
	{
		if ( type < LSConfigGroupNames.Size()+1 )
			return LSConfigGroupNames[type];
		else
			return '';
	}
	private function LSNameToEnum( nam : name ) : ELightsourceType
	{
		var ret : int;

		ret = LSConfigGroupNames.FindFirst(nam);
		
		if (ret != -1) return ret;
		else return 0;
	}
	
	
	public function IsLSConfigGroup(nam : name) : bool
	{
		if ( LSConfigGroupNames.Contains( nam ) )
			return true;
		else 
			return false;
	}
	
	public function GetTagName(path : string) : name
	{
		var substring : string;
	
		if 		( StrContains(path, "bonfire") ) 		{ return 'LST_campfire'; }		//ACHTUNG overlap
		else if ( StrContains(path, "campfire") ) 		{ return 'LST_campfire'; }
		
		else if ( StrContains(path, "chandelier") ) 	{ return 'LST_candle'; }		//ACHTUNG If seperate must be checked before candle!
		else if ( StrContains(path, "candle") ) 		{ return 'LST_candle'; }
		
		//else if ( StrContains(path, "torch_hand") ) 	{ return 'LST_torch_hand'; }	//ACHTUNG If seperate must be checked before torch!
		//else if ( StrContains(path, "torch_wall") )	{ return 'LST_torch_wall'; }	//ACHTUNG If seperate must be checked before torch!
		else if ( StrContains(path, "torch") ) 			{ return 'LST_torch'; }		
		
		else if ( StrContains(path, "braziers_floor") ) { return 'LST_brazier'; }		//ACHTUNG If seperate must be checked before brazier!
		else if ( StrContains(path, "braziers_wall") ) 	{ return 'LST_brazier'; }		//ACHTUNG If seperate must be checked before brazier!
		else if ( StrContains(path, "brazier") ) 		{ return 'LST_brazier'; }
		
		else if ( StrContains(path, "lantern") ) 		{ return 'LST_lantern'; }		//ACHTUNG If seperate must be checked before lamp!
		else if ( StrContains(path, "lamp") ) 			{ return 'LST_lantern'; }
		
		else 											{ return 'LST_other'; }
	
	}
	
	
	
	
	
	
	
	//////////////////////////////////////////////////////////////////////////////////////////
	// MANAGE CONFIG CHANGE
	//////////////////////////////////////////////////////////////////////////////////////////
	
	
	
	//////////////////////////////////////////////////////////////////////////////////////////
	// IN called when navigated back and mod is enabled and isRestoredToVanilla is true
	public function OnModReenabled()
	{
		var lightSources : array<CEntity>;
		var i,j : int;
		
		for (i = 0;i<(EnumGetMax('ELightsourceType')+1);i+=1 )
		{
			if ( IsTypeEnabled(LSEnumToName(i)) )
				GetLSByTypeAndApply(i);
		}
		
		isRestoredToVanilla = false;
		theGame.GetGuiManager().ShowNotification( "Mod Reenabled"); //dbg
	}
	
	//////////////////////////////////////////////////////////////////////////////////////////
	// IN called when navigated back and mod is disabled
	public function GetAndRestoreToVanilla() 
	{
		var lightSources : array<CEntity>;
		var i : int;
	
		theGame.GetEntitiesByTag('lss_modded', lightSources);

		for (i = 0; i < lightSources.Size(); i+=1)
		{
			Restore( lightSources[i] );
		}
		
		isRestoredToVanilla = true;
		theGame.GetGuiManager().ShowNotification( "Mod Restored to Vanilla"); //dbg
	}
	
	private function Restore(ent : CEntity)
	{
		var pointLightComp : CPointLightComponent;
		var spotLightComp : CSpotLightComponent;
	
		pointLightComp 	= (CPointLightComponent) ent.GetComponentByClassName('CPointLightComponent');
		spotLightComp 	= (CSpotLightComponent) ent.GetComponentByClassName('CSpotLightComponent');
		
		pointLightComp.ReStoreVanillaVariables();
		spotLightComp.ReStoreVanillaVariables();
		
		///////////////////////////////
		Reload( ent , false );
		///////////////////////////////
		
		///////////////////////////////
		ent.RemoveTag('lss_modded');
		///////////////////////////////
		
	}
	
	//////////////////////////////////////////////////////////////////////////////////////////
	// IN called when menu values are changed and navigated back and mod is enabled
	public function OnLSConfigChanged( lsConfigChanged : array<name> )
	{
		var i : int;
		
		if (lsConfigChanged.Size() > 0)
		{
			for (i=0;i<lsConfigChanged.Size();i+=1)
			{
				if ( IsTypeEnabled(lsConfigChanged[i]) )
					GetLSByTypeAndApply( LSNameToEnum(lsConfigChanged[i]) );
				else
					GetLSByTypeAndRestore( LSNameToEnum(lsConfigChanged[i]) );
			}
		}
		theGame.GetGuiManager().ShowNotification( "New Configuration is being Applied"  ); //dbg
	}
	private function GetLSByTypeAndApply( type : ELightsourceType )
	{
		var lightSources : array<CEntity>;
		var i : int;
		var tags : name;
		
		//AddTimer ( 'UpdateLightsources', 0.001f, false );
		
		//FIXME timer
		theGame.GetEntitiesByTag( LSEnumToName(type) , lightSources);
		
		for (i = 0; i < lightSources.Size(); i+=1)
		{
			ApplyConfig( lightSources[i], true );
		}
	}
	
	private function GetLSByTypeAndRestore( type : ELightsourceType )
	{
		var lightSources : array<CEntity>;
		var i : int;
		var tags : name;
		
		//AddTimer ( 'UpdateLightsources', 3.0f, true );
		
		//FIXME timer
		theGame.GetEntitiesByTag( LSEnumToName(type) , lightSources);
		
		for (i = 0; i < lightSources.Size(); i+=1)
		{
			Restore( lightSources[i] );
		}
	}
	
	/*timer function UpdateLightsources( dt : float, id : int )
	{
		
		
		
	}*/
	
	public function ApplyConfig(ent : CEntity, reload : bool)
	{
		var type : name;
		var tags : array<name>;
		var cfg : SLightsourceConfig;
		var lightComp : CLightComponent;
		var pointLightComp : CPointLightComponent;
		var spotLightComp : CSpotLightComponent;
		var componentsEnabled : int;
		
		type = GetTagName( ent.GetReadableName() );
		tags = ent.GetTags();

		StoreConfig();
		
		lightComp 			= (CLightComponent) ent.GetComponentByClassName('CLightComponent');
		pointLightComp 	= (CPointLightComponent) ent.GetComponentByClassName('CPointLightComponent');
		spotLightComp 	= (CSpotLightComponent) ent.GetComponentByClassName('CSpotLightComponent');
		
		if (lightComp)
		{
			pointLightComp.StoreVanillaVariables();
			spotLightComp.StoreVanillaVariables();
			
			cfg = userLSConfig[LSNameToEnum(type)] ;
			componentsEnabled = (int)igcWrapper.GetVarValue('lss_general', 'alss_components');
			
			if ( componentsEnabled != 2 )
			{
				pointLightComp.SetRadius(cfg.radius);
				pointLightComp.SetBrightness(cfg.brightness);
				pointLightComp.SetAttenuation(cfg.attenuation);
				pointLightComp.SetLightShadowCastingMode(cfg.shadowCastingMode);
				pointLightComp.SetShadowBlendFactor(cfg.shadowBlendFactor);
				
				if ( (bool)igcWrapper.GetVarValue('lss_general', 'lss_enable_advanced_settings') )
				{
					pointLightComp.SetColor(cfg.colorR, cfg.colorG, cfg.colorB, cfg.colorA);
					pointLightComp.SetAllowDistantFade(cfg.allowDistantFade);
					pointLightComp.SetShadowFadeDistance(cfg.shadowFadeDistance);
					pointLightComp.SetShadowFadeRange(cfg.shadowFadeRange);
					pointLightComp.SetAutoHideDistance(cfg.autoHideDistance);
					pointLightComp.SetAutoHideRange(cfg.autoHideRange);
				}
			}
			
			if ( componentsEnabled != 1 )
			{
				spotLightComp.SetRadius(cfg.radius);
				spotLightComp.SetBrightness(cfg.brightness);
				spotLightComp.SetAttenuation(cfg.attenuation);
				if ((bool)igcWrapper.GetVarValue('lss_general', 'alss_enable_SpotShadows')) spotLightComp.SetLightShadowCastingMode(cfg.shadowCastingMode);
				if ((bool)igcWrapper.GetVarValue('lss_general', 'alss_enable_SpotShadows')) spotLightComp.SetShadowBlendFactor(cfg.shadowBlendFactor);
				
				if ( (bool)igcWrapper.GetVarValue('lss_general', 'lss_enable_advanced_settings') )
				{
					spotLightComp.SetColor(cfg.colorR, cfg.colorG, cfg.colorB, cfg.colorA);
					spotLightComp.SetAllowDistantFade(cfg.allowDistantFade);
					spotLightComp.SetShadowFadeDistance(cfg.shadowFadeDistance);
					spotLightComp.SetShadowFadeRange(cfg.shadowFadeRange);
					spotLightComp.SetAutoHideDistance(cfg.autoHideDistance);
					spotLightComp.SetAutoHideRange(cfg.autoHideRange);
				}
			}
			
			///////////////////////////////
			if (reload) Reload( ent ,true );
			///////////////////////////////
			
			///////////////////////////////
			if (!tags.Contains('lss_modded'))
				ent.AddTag('lss_modded');
			///////////////////////////////
		}
	}
	
	private function Reload(ent : CEntity, comesFromMenuReload : bool)
	{
		var gameplayLightComp : CGameplayLightComponent;

		gameplayLightComp = (CGameplayLightComponent) ent.GetComponentByClassName('CGameplayLightComponent');
	
		if ( gameplayLightComp && gameplayLightComp.IsLightOn() )
		{	
			gameplayLightComp.ToggleLight( comesFromMenuReload );
			gameplayLightComp.ToggleLight( comesFromMenuReload );
		}
	}
	
	
	
	
	
}
	
	


//GLOBAL FUNCTIONS
function GetModLSS() : CModLightsourceSuite
{
	return GetRFScripthook().GetModLightsourceSuite();
}

