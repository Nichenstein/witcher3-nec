///////////////////////////////////////////////////////////////////////////
///////////////////////////// RF SCRIPTHOOK ///////////////////////////////
/////////////////////////////// by rfuzzo /////////////////////////////////
////////////////////////////// credit to KNG //////////////////////////////
///////////////////////////////////////////////////////////////////////////



class CRFScripthook extends CEntity
{
	
	//////////////////// BEGIN ////////////////////
	public var modLSS : CModLightsourceSuite;
	
	
	///////////////////// END /////////////////////
	
	event OnSpawned(spawnData : SEntitySpawnData)
	{
		Init();
	}
	
	private function Init()
	{

		
		//////////////////// BEGIN ////////////////////
		modLSS = new CModLightsourceSuite in this;
		
		
		modLSS.OnInit();
		///////////////////// END /////////////////////

		//theGame.GetGuiManager().ShowNotification("RFScripthook Init");
	}
	
	
	
	//////////////////// BEGIN ////////////////////
	public function GetModLightsourceSuite() : CModLightsourceSuite
	{	
		return modLSS;
	}
	///////////////////// END /////////////////////
	
	
}

//GLOBAL FUNCTIONS
function GetRFScripthook() : CRFScripthook
{

	var entity : CEntity;
	var scripthook : CRFScripthook;
	
	entity = theGame.GetEntityByTag('rfscripthook');
	scripthook = (CRFScripthook)entity;
	
	return scripthook;

}


//EXEC FUNCTIONS
