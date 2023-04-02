///////////////////////////////////////////////////////////////////////////
////////////////////////// MOD SHADOW SUITE ///////////////////////////////
///////////////////////////// by rfuzzo ///////////////////////////////////
///////////////////////////////////////////////////////////////////////////



/*
enum ELightShadowCastingMode
{
	LSCM_None,
	LSCM_Normal,
	LSCM_OnlyDynamic,
	LSCM_OnlyStatic
};

*/

import struct SLightFlickering
{
	import var positionOffset, flickerStrength, flickerPeriod : float;
}


import class CLightComponent extends CSpriteComponent
{
	//import var transform : EngineTransform;
	import var color : Color;
	import var lightFlickering : SLightFlickering;

	import var shadowCastingMode : ELightShadowCastingMode;
	//import var lightUsageMask : ELightUsageMask;
	import var envColorGroup : EEnvColorGroup;

	import var isEnabled : bool;
	//import var isStreamed : bool;
	import var allowDistantFade : bool;

	import var radius : float;
	import var brightness : float;
	import var attenuation : float;
	import var shadowFadeDistance : float;
	import var shadowFadeRange : float;
	import var shadowBlendFactor : float;
	import var autoHideDistance : float;
	import var autoHideRange : float;

	//////////////////////////////////////////////////////////////
	private var isStored : bool;
	
	//private var _transform : EngineTransform;
	private var _color : Color;
	private var _lightFlickering : SLightFlickering;

	private var _shadowCastingMode : ELightShadowCastingMode;
	//private var _lightUsageMask : ELightUsageMask;
	private var _envColorGroup : EEnvColorGroup;

	private var _isEnabled : bool;
	//private var _isStreamed : bool;
	private var _allowDistantFade : bool;

	private var _radius : float;
	private var _brightness : float;
	private var _attenuation : float;
	private var _shadowFadeDistance : float;
	private var _shadowFadeRange : float;
	private var _shadowBlendFactor : float;
	private var _autoHideDistance : float;
	private var _autoHideRange : float;

	
	
	default isStored = false;
	//////////////////////////////////////////////////////////////
	
	
	
	public function StoreVanillaVariables()
	{
		if ( !isStored )
		{
			//_transform = transform;
			_color = color;
			_lightFlickering = lightFlickering;

			_shadowCastingMode = shadowCastingMode;
			//_lightUsageMask = lightUsageMask;
			_envColorGroup = envColorGroup;

			_isEnabled = isEnabled;
			//_isStreamed = isStreamed;
			_allowDistantFade = allowDistantFade;
			
			_radius = radius;
			_brightness = brightness;
			_attenuation = attenuation;
			_shadowFadeDistance = shadowFadeDistance;
			_shadowFadeRange = shadowFadeRange;
			_shadowBlendFactor = shadowBlendFactor;
			_autoHideDistance = autoHideDistance;
			_autoHideRange = autoHideRange;
			
			
			isStored = true;
			//theGame.GetGuiManager().ShowNotification( "Vanilla Stored" );
		}
	}
	
	public function ReStoreVanillaVariables()
	{
		if ( isStored )
		{
			//transform = _transform;
			color = _color;
			lightFlickering = _lightFlickering;

			shadowCastingMode = _shadowCastingMode;
			//lightUsageMask = _lightUsageMask;
			envColorGroup = _envColorGroup;

			isEnabled = _isEnabled;
			//isStreamed = _isStreamed;
			allowDistantFade = _allowDistantFade;
			
			radius = _radius;
			brightness = _brightness;
			attenuation = attenuation;
			shadowFadeDistance = _shadowFadeDistance;
			shadowFadeRange = _shadowFadeRange;
			shadowBlendFactor = _shadowBlendFactor;
			autoHideDistance = _autoHideDistance;
			autoHideRange = _autoHideRange;
		}
	}

	//GET VARS
	//public function GetTransform() : EngineTransform {return transform;}
	public function GetColor() : Color {return color;}
	public function GetLightFlickering() : SLightFlickering {return lightFlickering;}

	public function GetLightShadowCastingMode() : ELightShadowCastingMode {return shadowCastingMode;}
	//public function GetLightUsageMask() : ELightUsageMask {return lightUsageMask;}
	public function GetEnvColorGroup() : EEnvColorGroup {return envColorGroup;}

	public function GetIsEnabled() : bool {return isEnabled;}
	//public function GetIsStreamed() : bool {return isStreamed;}
	public function GetAllowDistantFade() : bool {return allowDistantFade;}

	public function GetRadius() : float {return radius;}
	public function GetBrightness() : float {return brightness;}
	public function GetAttenuation() : float {return attenuation;}
	public function GetShadowFadeDistance() : float {return shadowFadeDistance;}
	public function GetShadowFadeRange() : float {return shadowFadeRange;}
	public function GetShadowBlendFactor() : float {return shadowBlendFactor;}
	public function GetAutoHideDistance() : float {return autoHideDistance;}
	public function GetAutoHideRange() : float {return autoHideRange;}



	//SET VARS
	/*public function SetTransform(offset : float, strength : float, period : float)
	{
		transform.positionOffset = offset;
		transform.flickerStrength = strength;
		transform.flickerPeriod = period;
	}*/
	public function SetColor(r : int, g : int, b : int, a : int)
	{
		color.Red = r;
		color.Green = g;
		color.Blue = b;
		color.Alpha = a;
	}
	

	public function SetLightShadowCastingMode(v : int) {shadowCastingMode = v;}
	//public function SetLightUsageMask(v : int) {lightUsageMask = v;}
	public function SetEnvColorGroup(v : int) {envColorGroup = v;}

	public function SetIsEnabled(b : bool) {isEnabled = b;}
	//public function SetIsStreamed(b : bool) {isStreamed = b;}
	public function SetAllowDistantFade(b : bool) {allowDistantFade = b;}

	public function SetLightFlickering(offset : float, strength : float, period : float)
	{
		lightFlickering.positionOffset = _lightFlickering.positionOffset * offset;
		lightFlickering.flickerStrength = _lightFlickering.flickerStrength * strength;
		lightFlickering.flickerPeriod = _lightFlickering.flickerPeriod * period;
	}
	public function SetRadius(v : float) {radius = MaxF(_radius,4.f) * v;}
	public function SetBrightness(v : float) {brightness =  MaxF(_brightness,10.f) * v;}
	public function SetAttenuation(v : float) {attenuation =  MaxF(_attenuation,0.7f) * v;}
	public function SetShadowFadeDistance(v : float) {shadowFadeDistance =  MaxF(_shadowFadeDistance,15.f) * v;}
	public function SetShadowFadeRange(v : float) {shadowFadeRange =  MaxF(_shadowFadeRange,5.f) * v;}
	public function SetShadowBlendFactor(v : float) {shadowBlendFactor =  _shadowBlendFactor;} 						//ACHTUNG not a multiplier!
	public function SetAutoHideDistance(v : float) {autoHideDistance =  MaxF(_autoHideDistance,170.f) * v;}
	public function SetAutoHideRange(v : float) {autoHideRange =  MaxF(_autoHideRange,80.f) * v;}
	
	
}

import class CPointLightComponent extends CLightComponent
{
	/*
	import var cacheStaticShadows : bool;
    import var dynamicShadowsFaceMask : ELightCubeSides;
    */
	/*
	
}

import class CSpotLightComponent extends CLightComponent
{
	/*
	import var innerAngle : float;
    import var outerAngle : float;
    import var softness : float;
    import var projectionTexture : handle:CBitmapTexture;
    import var projectionTextureAngle : float;
    import var projectionTexureUBias : float;
    import var projectionTexureVBias : float;
    */
	
}




