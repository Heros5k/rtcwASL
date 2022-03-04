// ----------------------------------------
// GAME: Return to Castle Wolfenstein
// https://store.steampowered.com/app/9010/
// ----------------------------------------

// Patch by KoRrNiK
// The bytes were found by KoRrNiK
state("WolfSP", "1.45a"){
	
	string16 bsp 		: 		"WolfSP.exe", 		0x693664;
	byte cs 			: 		"WolfSP.exe", 		0xEA7B64;
	
	int client_status	: 		"WolfSP.exe", 		0x613420;
	byte ESC			:		"WolfSP.exe", 		0xCCAF24; 	// 2 == ESC | 1 == CONSOLE
	
	float camera_x		: 		"WolfSP.exe", 		0x7A2F9C;
	float xpos 			: 		"WolfSP.exe", 		0x77B0DC;
	float ypos 			: 		"WolfSP.exe", 		0x7A2FA4;
	float zpos 			: 		"WolfSP.exe", 		0x77B0E0;
	
	// Only used for individual chapter levels
	int finish			: 		"WolfSP.exe", 		0xDBC164;
	
	byte stuck			:		"WolfSP.exe",		0xDCB9E1;
	
}

// Patch by Knightmare
// The bytes were found by Hoyo & KoRrNiK
state("WolfSP", "1.42d"){
	
	string16 bsp 		: 		0x13D4, 			0x8;
	byte cs 			: 		0x26F4, 			0x0;
	int client_status	: 		0xB24EE0;
	
	float camera_x		: 		"WolfSP.exe", 		0xDA9D3C;
	float xpos 			: 		"WolfSP.exe", 		0x5F8Da4;
	float ypos 			: 		"WolfSP.exe", 		0x5F8Da8;
	float zpos 			: 		"WolfSP.exe", 		0x5F8Dac;
	
	// Only used for individual chapter levels
	int finish			: 		"qagamex86.dll", 	0x57D7D0, 	0x42c; 
}

startup {
	
	// Full Game
	settings.Add("cat_all", 			true, 		"Full game");
	
	// Only chapter
	settings.Add("chaptersOnly", 		false, 		"Chapters");
	
	settings.Add("cat_chap1", 			false, 		"Ominous Rumors + Dark Secret", 				"chaptersOnly");
	settings.Add("cat_chap2", 			false, 		"Weapons of Vengeance", 						"chaptersOnly");
	settings.Add("cat_chap3", 			false, 		"Deadly Designs", 								"chaptersOnly");
	settings.Add("cat_chap4", 			false, 		"Deathshead's Playground", 						"chaptersOnly");
	settings.Add("cat_chap5", 			false, 		"Return Engagement + Operation Resurrection", 	"chaptersOnly");

	// Individual chapter levels
	settings.Add("individualLevelsC1", 	false, 		"Chapter 1 Individual Levels");
	settings.Add("miss1_chap_1", 		false, 		"Escape!", 										"individualLevelsC1");
	settings.Add("miss2_chap_1", 		false, 		"Castle Keep", 									"individualLevelsC1");
	settings.Add("miss3_chap_1", 		false, 		"Tram Ride", 									"individualLevelsC1");
	settings.Add("miss4_chap_1", 		false, 		"Village", 										"individualLevelsC1");
	settings.Add("miss5_chap_1", 		false, 		"Catacombs", 									"individualLevelsC1");
	settings.Add("miss6_chap_1", 		false, 		"Crypt", 										"individualLevelsC1");
	settings.Add("miss7_chap_1", 		false, 		"The Defiled Church", 							"individualLevelsC1");
	settings.Add("miss8_chap_1", 		false, 		"Tomb", 										"individualLevelsC1");

	settings.Add("individualLevelsC2", 	false, 		"Chapter 2 Individual Levels");
	settings.Add("miss1_chap_2", 		false, 		"Forest Compound", 								"individualLevelsC2");
	settings.Add("miss2_chap_2", 		false, 		"Rocket Base", 									"individualLevelsC2");
	settings.Add("miss3_chap_2", 		false, 		"Radar Installation", 							"individualLevelsC2");
	settings.Add("miss4_chap_2", 		false, 		"Air Base Assault", 							"individualLevelsC2");

	settings.Add("individualLevelsC3", 	false, 		"Chapter 3 Individual Levels");
	settings.Add("miss1_chap_3", 		false, 		"Kugelstadt", 									"individualLevelsC3");
	settings.Add("miss2_chap_3", 		false, 		"The Bombed Factory", 							"individualLevelsC3");
	settings.Add("miss3_chap_3", 		false, 		"The Trainyards", 								"individualLevelsC3");
	settings.Add("miss4_chap_3", 		false, 		"Secret Weapons Facility", 						"individualLevelsC3");

	settings.Add("individualLevelsC4", 	false, 		"Chapter 4 Individual Levels");
	settings.Add("miss1_chap_4", 		false, 		"Ice Station Norway", 							"individualLevelsC4");
	settings.Add("miss2_chap_4", 		false, 		"X-Labs", 										"individualLevelsC4");
	settings.Add("miss3_chap_4", 		false, 		"Super Soldier", 								"individualLevelsC4");
	
	settings.Add("individualLevelsC5", 	false, 		"Chapter 5 Individual Levels");
	settings.Add("miss1_chap_5", 		false, 		"Bramburg Dam", 								"individualLevelsC5");
	settings.Add("miss2_chap_5", 		false, 		"Paderborn Village", 							"individualLevelsC5");
	settings.Add("miss3_chap_5", 		false, 		"Chateau Schufstaffel", 						"individualLevelsC5");
	settings.Add("miss4_chap_5", 		false, 		"Unhallowed Ground", 							"individualLevelsC5");
	settings.Add("miss5_chap_5", 		false, 		"The Dig", 										"individualLevelsC5");
	settings.Add("miss6_chap_5", 		false, 		"Return to Castle Wolfenstein", 				"individualLevelsC5");
	settings.Add("miss7_chap_5", 		false, 		"Heinrich", 									"individualLevelsC5");
	
	// DEBUG MESSAGE
	Action<string> DebugOutput = (text) => {
		print("[RTCW Autosplitter] " + text);
	};
	vars.DebugOutput = DebugOutput;

}

init{
	
	// Useful for debugViewer
	// https://docs.microsoft.com/en-us/sysinternals/downloads/debugview
	
	vars.debugMessage 	= 	false;

	int idGame = modules.First().ModuleMemorySize;
	
	int patch_142d = 14643200;
	int patch_145a = 19324928;
	
	switch(idGame){
		case 14643200:{
			version 		= 	"1.42d";
			vars.running 	= 	true;
			break;
		}
		case 19324928:{
			version 		= 	"1.45a";
			vars.running 	=	 true;
			break;
		}
		default:{
			if(vars.debugMessage) vars.DebugOutput("Unrecognized game version. Disabling functionality.");
			version 		= 	"Unknown";
			vars.running 	= 	false;
			return false;
			break;
		}
	}
	

	if(vars.debugMessage){
		vars.DebugOutput("Game found!");
		vars.DebugOutput("Module size: " + idGame);
		vars.DebugOutput("Found Patch " + version);
	}

	vars.isTimer 		=	false;
	vars.firstcs 		= 	true;
	vars.loadStarted 	= 	false;
	vars.bsp_list 		= 	new List<String>();
	vars.visited 		= 	new List<String>();
	
}

exit{
	vars.isTimer 		=	false;
	timer.IsGameTimePaused = true;
	vars.running 		= 	false;
}

shutdown{
	vars.isTimer 		=	false;
	vars.running 		= 	false;
}

start{	

	if(settings["miss1_chap_1"]) vars.bsp_list.Add("/escape1.bsp");
	if(settings["miss2_chap_1"]) vars.bsp_list.Add("/escape2.bsp");
	if(settings["miss3_chap_1"]) vars.bsp_list.Add("/tram.bsp");
	if(settings["miss4_chap_1"]) vars.bsp_list.Add("/village1.bsp");
	if(settings["miss5_chap_1"]) vars.bsp_list.Add("/crypt1.bsp");
	if(settings["miss6_chap_1"]) vars.bsp_list.Add("/crypt2.bsp");
	if(settings["miss7_chap_1"]) vars.bsp_list.Add("/church.bsp");
	if(settings["miss8_chap_1"]) vars.bsp_list.Add("/boss1.bsp");
	
	if(settings["miss1_chap_2"]) vars.bsp_list.Add("/forest.bsp");
	if(settings["miss2_chap_2"]) vars.bsp_list.Add("/rocket.bsp");
	if(settings["miss3_chap_2"]) vars.bsp_list.Add("/baseout.bsp");
	if(settings["miss4_chap_2"]) vars.bsp_list.Add("/assault.bsp");

	if(settings["miss1_chap_3"]) vars.bsp_list.Add("/sfm.bsp");
	if(settings["miss2_chap_3"]) vars.bsp_list.Add("/factory.bsp");
	if(settings["miss3_chap_3"]) vars.bsp_list.Add("/trainyard.bsp");
	if(settings["miss4_chap_3"]) vars.bsp_list.Add("/swf.bsp");

	if(settings["miss1_chap_4"]) vars.bsp_list.Add("/norway.bsp");
	if(settings["miss2_chap_4"]) vars.bsp_list.Add("/xlabs.bsp");
	if(settings["miss3_chap_4"]) vars.bsp_list.Add("/boss2.bsp");
	
	if(settings["miss1_chap_5"]) vars.bsp_list.Add("/dam.bsp");
	if(settings["miss2_chap_5"]) vars.bsp_list.Add("/village2.bsp");
	if(settings["miss3_chap_5"]) vars.bsp_list.Add("/chateau.bsp");
	if(settings["miss4_chap_5"]) vars.bsp_list.Add("/dark.bsp");
	if(settings["miss5_chap_5"]) vars.bsp_list.Add("/dig.bsp");
	if(settings["miss6_chap_5"]) vars.bsp_list.Add("/castle.bsp");
	if(settings["miss7_chap_5"]) vars.bsp_list.Add("/end.bsp");

	if(settings["cat_all"] || settings["cat_chap1"]){
		vars.bsp_list.Add("/escape1.bsp");
		vars.bsp_list.Add("/escape2.bsp");
		vars.bsp_list.Add("/tram.bsp");
		vars.bsp_list.Add("/village1.bsp");
		vars.bsp_list.Add("/crypt1.bsp");
		vars.bsp_list.Add("/crypt2.bsp");
		vars.bsp_list.Add("/church.bsp");
		vars.bsp_list.Add("/boss1.bsp");
	}
	
	if(settings["cat_all"] || settings["cat_chap2"]){
		vars.bsp_list.Add("/forest.bsp");
		vars.bsp_list.Add("/rocket.bsp");
		vars.bsp_list.Add("/baseout.bsp");
		vars.bsp_list.Add("/assault.bsp");
	}
	
	if(settings["cat_all"] | settings["cat_chap3"]){
		vars.bsp_list.Add("/sfm.bsp");
		vars.bsp_list.Add("/factory.bsp");
		vars.bsp_list.Add("/trainyard.bsp");
		vars.bsp_list.Add("/swf.bsp");
	}

	if(settings["cat_all"] || settings["cat_chap4"]){
		vars.bsp_list.Add("/norway.bsp");
		vars.bsp_list.Add("/xlabs.bsp");
		vars.bsp_list.Add("/boss2.bsp");
	}

	if(settings["cat_all"] || settings["cat_chap5"]){ 
		vars.bsp_list.Add("/dam.bsp");
		vars.bsp_list.Add("/village2.bsp");
		vars.bsp_list.Add("/chateau.bsp");
		vars.bsp_list.Add("/dark.bsp");
		vars.bsp_list.Add("/dig.bsp");
		vars.bsp_list.Add("/castle.bsp");
		vars.bsp_list.Add("/end.bsp");
	}

	/* ================================================================= FULL GAME */

	if(settings["cat_all"]){
		if (current.bsp == "/cutscene1.bsp" && current.cs == 1 && old.cs == 0) {
			vars.isTimer = true;
			vars.firstcs = true;
			vars.visited.Clear();
			vars.visited.Add("/cutscene1.bsp");
			vars.visited.Add("/escape1.bsp");
			return true;
		}
	}

	/* ================================================================= */

	/* ================================================================= CHAPTER 1 */

	if(settings["cat_chap1"] || settings["miss1_chap_1"]){
		if (current.bsp == "/escape1.bsp" && old.bsp != "/escape1.bsp") {
			vars.isTimer = true;
			vars.firstcs = true;
			vars.visited.Clear();
			vars.visited.Add("/escape1.bsp");
			return true;
		}
	}

	if(settings["miss2_chap_1"]){
		if (current.bsp == "/escape2.bsp" && old.bsp != "/escape2.bsp") {
			vars.isTimer = true;
			vars.firstcs = true;
			vars.visited.Clear();
			vars.visited.Add("/escape2.bsp");
			return true;
		}
	}

	if(settings["miss3_chap_1"]){
		if (current.bsp == "/tram.bsp" && old.bsp != "/tram.bsp") {
			vars.isTimer = true;
			vars.firstcs = true;
			vars.visited.Clear();
			vars.visited.Add("/tram.bsp");
			return true;
		}
	}

	if(settings["miss4_chap_1"]){
		if (current.bsp == "/village1.bsp" && old.bsp != "/village1.bsp") {
			vars.isTimer = true;
			vars.firstcs = true;
			vars.visited.Clear();
			vars.visited.Add("/village1.bsp");
			return true;
		}
	}
	
	if(settings["miss5_chap_1"]){
		if (current.bsp == "/crypt1.bsp" && old.bsp != "/crypt1.bsp") {
			vars.isTimer = true;
			vars.firstcs = true;
			vars.visited.Clear();
			vars.visited.Add("/crypt1.bsp");
			return true;
		}
	}

	if(settings["miss6_chap_1"]){
		if (current.bsp == "/crypt2.bsp" && old.bsp != "/crypt2.bsp") {
			vars.isTimer = true;
			vars.firstcs = true;
			vars.visited.Clear();
			vars.visited.Add("/crypt2.bsp");
			return true;
		}
	}
	
	if(settings["miss7_chap_1"]){
		if (current.bsp == "/church.bsp" && old.bsp != "/church.bsp") {
			vars.isTimer = true;
			vars.firstcs = true;
			vars.visited.Clear();
			vars.visited.Add("/church.bsp");
			return true;
		}
	}
	
	if(settings["miss8_chap_1"]){
		if (current.bsp == "/boss1.bsp" && old.bsp != "/boss1.bsp") {
			vars.isTimer = true;
			vars.firstcs = true;
			vars.visited.Clear();
			vars.visited.Add("/boss1.bsp");
			return true;
		}
	}

	/* ================================================================= */

	/* ================================================================= CHAPTER 2 */

	if(settings["cat_chap2"] || settings["miss1_chap_2"]){
		if (current.bsp == "/forest.bsp" && old.bsp != "/forest.bsp") {
			vars.isTimer = true;
			vars.firstcs = true;
			vars.visited.Clear();
			vars.visited.Add("/forest.bsp");
			return true;
		}
	}

	if(settings["miss2_chap_2"]){
		if (current.bsp == "/rocket.bsp" && old.bsp != "/rocket.bsp") {
			vars.isTimer = true;
			vars.firstcs = true;
			vars.visited.Clear();
			vars.visited.Add("/rocket.bsp");
			return true;
		}
	}

	if(settings["miss3_chap_2"]){
		if (current.bsp == "/baseout.bsp" && old.bsp != "/baseout.bsp") {
			vars.isTimer = true;
			vars.firstcs = true;
			vars.visited.Clear();
			vars.visited.Add("/baseout.bsp");
			return true;
		}
	}

	if(settings["miss4_chap_2"]){
		if (current.bsp == "/assault.bsp" && old.bsp != "/assault.bsp") {
			vars.isTimer = true;
			vars.firstcs = true;
			vars.visited.Clear();
			vars.visited.Add("/assault.bsp");
			return true;
		}
	}

	/* ================================================================= */

	/* ================================================================= CHAPTER 3 */

	if(settings["cat_chap3"] || settings["miss1_chap_3"]){
		if (current.bsp == "/sfm.bsp" && old.bsp != "/sfm.bsp") {
			vars.isTimer = true;
			vars.firstcs = true;
			vars.visited.Clear();
			vars.visited.Add("/sfm.bsp");
			return true;
		}
	}

	if(settings["miss2_chap_3"]){
		if (current.bsp == "/factory.bsp" && old.bsp != "/factory.bsp") {
			vars.isTimer = true;
			vars.firstcs = true;
			vars.visited.Clear();
			vars.visited.Add("/factory.bsp");
			return true;
		}
	}

	if(settings["miss3_chap_3"]){
		if (current.bsp == "/trainyard.bsp" && old.bsp != "/trainyard.bsp") {
			vars.isTimer = true;
			vars.firstcs = true;
			vars.visited.Clear();
			vars.visited.Add("/trainyard.bsp");
			return true;
		}
	}

	if(settings["miss4_chap_3"]){
		if (current.bsp == "/swf.bsp" && old.bsp != "/swf.bsp") {
			vars.isTimer = true;
			vars.firstcs = true;
			vars.visited.Clear();
			vars.visited.Add("/swf.bsp");
			return true;
		}
	}

	/* ================================================================= */
	
	/* ================================================================= CHAPTER 4 */

	if(settings["cat_chap4"] || settings["miss1_chap_4"]){
		if (current.bsp == "/norway.bsp" && old.bsp != "/norway.bsp") {
			vars.isTimer = true;
			vars.firstcs = true;
			vars.visited.Clear();
			vars.visited.Add("/norway.bsp");
			return true;
		}
	}

	if(settings["miss2_chap_4"]){
		if (current.bsp == "/xlabs.bsp" && old.bsp != "/xlabs.bsp") {
			vars.isTimer = true;
			vars.firstcs = true;
			vars.visited.Clear();
			vars.visited.Add("/xlabs.bsp");
			return true;
		}
	}

	if(settings["miss3_chap_4"]){
		if (current.bsp == "/boss2.bsp" && old.bsp != "/boss2.bsp") {
			vars.isTimer = true;
			vars.firstcs = true;
			vars.visited.Clear();
			vars.visited.Add("/boss2.bsp");
			return true;
		}
	}

	/* ================================================================= */
	
	/* ================================================================= CHAPTER 5 */
	
	if(settings["cat_chap5"] || settings["miss1_chap_5"]){
		if (current.bsp == "/dam.bsp" && old.bsp != "/dam.bsp") {
			vars.isTimer = true;
			vars.firstcs = true;
			vars.visited.Clear();
			vars.visited.Add("/dam.bsp");
			return true;
		}
	}

	if(settings["miss2_chap_5"]){
		if (current.bsp == "/village2.bsp" && old.bsp != "/village2.bsp") {
			vars.isTimer = true;
			vars.firstcs = true;
			vars.visited.Clear();
			vars.visited.Add("/village2.bsp");
			return true;
		}
	}

	if(settings["miss3_chap_5"]){
		if (current.bsp == "/chateau.bsp" && old.bsp != "/chateau.bsp") {
			vars.isTimer = true;
			vars.firstcs = true;
			vars.visited.Clear();
			vars.visited.Add("/chateau.bsp");
			return true;
		}
	}

	if(settings["miss4_chap_5"]){
		if (current.bsp == "/dark.bsp" && old.bsp != "/dark.bsp") {
			vars.isTimer = true;
			vars.firstcs = true;
			vars.visited.Clear();
			vars.visited.Add("/dark.bsp");
			return true;
		}
	}

	if(settings["miss5_chap_5"]){
		if (current.bsp == "/dig.bsp" && old.bsp != "/dig.bsp") {
			vars.isTimer = true;
			vars.firstcs = true;
			vars.visited.Clear();
			vars.visited.Add("/dig.bsp");
			return true;
		}
	}

	if(settings["miss6_chap_5"]){
		if (current.bsp == "/castle.bsp" && old.bsp != "/castle.bsp") {
			vars.isTimer = true;
			vars.firstcs = true;
			vars.visited.Clear();
			vars.visited.Add("/castle.bsp");
			return true;
		}
	}
	if(settings["miss7_chap_5"]){
		if (current.bsp == "/end.bsp" && old.bsp != "/end.bsp") {
			vars.isTimer = true;
			vars.firstcs = true;
			vars.visited.Clear();
			vars.visited.Add("/end.bsp");
			return true;
		}
	}

	/* ================================================================= */

	if(vars.isTimer){
		if(vars.debugMessage) vars.DebugOutput("Timer started");
	}
	
	
}



split{
	
	if(!vars.running) return;

	if(current.bsp != old.bsp) {
		if(vars.debugMessage) vars.DebugOutput("Map changed to " + current.bsp);
		if(vars.bsp_list.Contains(current.bsp) && !vars.visited.Contains(current.bsp)){
			if(vars.debugMessage) vars.DebugOutput("Map change valid.");
			vars.visited.Add(current.bsp);
			vars.firstcs = true;
			return true;
		}
		else if(vars.debugMessage) vars.DebugOutput("Map change ignored.");
	}
	
	if(settings["cat_chap1"] || settings["miss8_chap_1"]){
		if (current.bsp == "/boss1.bsp" && current.cs == 1 && old.cs == 0) {
			if(vars.firstcs == false) {
				if(vars.debugMessage) vars.DebugOutput("Second cutscene.");
				return true;
			}
			if(vars.firstcs == true) {
				vars.firstcs = false;
				if(vars.debugMessage) vars.DebugOutput("First cutscene.");
			}
		}
	}
	
	if(settings["cat_chap2"]){
		if (current.bsp == "/assault.bsp" && current.cs == 1 && old.cs == 0) {
			if(vars.firstcs == true) {
				vars.firstcs = false;
				if(vars.debugMessage) vars.DebugOutput("First cutscene.");
				return true;
			}
		}
	}
	
	if(settings["cat_chap3"]){
		if (current.bsp == "/swf.bsp" && current.cs == 1 && old.cs == 0) {
			if(vars.firstcs == false) {
				if(vars.debugMessage) vars.DebugOutput("Second cutscene.");
				return true;
			}
			if(vars.firstcs == true) {
				vars.firstcs = false;
				if(vars.debugMessage) vars.DebugOutput("First cutscene.");
			}
		}
	}
	
	if(( settings["cat_chap4"] || settings["miss3_chap_4"] ) && current.bsp == "/boss2.bsp"){
		if(current.xpos >= 1454.0 && old.xpos < 1454.0 && current.xpos <= 1500.0 && old.xpos > 1300.0){
			if(vars.debugMessage) vars.DebugOutput("The timer has stopped (BOSS2)");
			return true;
		}
	}

	if (current.bsp == "/end.bsp" && current.cs == 1 && old.cs == 0) {
		if(vars.firstcs == false) {
			if(vars.debugMessage) vars.DebugOutput("Second cutscene.");
			return true;
		}
		if(vars.firstcs == true) {
			vars.firstcs = false;
			if(vars.debugMessage) vars.DebugOutput("First cutscene.");
		}
	}
	
	/* ================================================================= */

	/* ================================================================= CHAPTER 1 */

	if(settings["miss1_chap_1"] && current.bsp == "/escape1.bsp"){
		if((version == "1.42d" && current.finish != 0 ) ||
			(version == "1.45a" && current.finish == 4 && current.cs == 0 && current.stuck != 3 )){
			if(vars.debugMessage) vars.DebugOutput("The timer has stopped (ESCAPE1)");
			return true;
		}
	}

	if(settings["miss2_chap_1"] && current.bsp == "/escape2.bsp"){
		if((version == "1.42d" && current.finish != 0 ) ||
			(version == "1.45a" && current.finish == 4 && current.cs == 0 && current.stuck != 3)){
			if(vars.debugMessage) vars.DebugOutput("The timer has stopped (ESCAPE2)");
			return true;
		}
	}
	
	if(settings["miss3_chap_1"] && current.bsp == "/tram.bsp"){
		if((version == "1.42d" && current.finish != 0 ) ||
			(version == "1.45a" && current.finish == 4 && current.cs == 0 && current.xpos < -3850.0 && current.ypos > -1300.0 )){
			if(vars.debugMessage) vars.DebugOutput("The timer has stopped (TRAM)");
			return true;
		}
	}

	if(settings["miss4_chap_1"] && current.bsp == "/village1.bsp"){
		if((version == "1.42d" && current.finish != 0 ) ||
			(version == "1.45a" && current.finish == 4 && current.cs == 0 && current.stuck != 3)){
			if(vars.debugMessage) vars.DebugOutput("The timer has stopped (VILLAGE1)");
			return true;
		}
	}
	
	if(settings["miss5_chap_1"] && current.bsp == "/crypt1.bsp"){
		if((version == "1.42d" && current.finish != 0 ) ||
			(version == "1.45a" && current.finish == 4 && current.cs == 0 && current.stuck != 3)){
			if(vars.debugMessage) vars.DebugOutput("The timer has stopped (CRYPT1)");
			return true;
		}
	}
	
	if(settings["miss6_chap_1"] && current.bsp == "/crypt2.bsp"){
		if((version == "1.42d" && current.finish != 0 ) ||
			(version == "1.45a" && current.finish == 4 && current.cs == 0 && current.stuck != 3)){
			if(vars.debugMessage) vars.DebugOutput("The timer has stopped (CRYPT2)");
			return true;
		}
	}
	
	if(settings["miss7_chap_1"] && current.bsp == "/church.bsp"){
		if((version == "1.42d" && current.finish != 0 ) ||
			(version == "1.45a" && current.finish == 4 && current.cs == 0 && current.stuck != 3)){
			if(vars.debugMessage) vars.DebugOutput("The timer has stopped (CHURCH)");
			return true;
		}
	}
	
	// BOSS1 UP /\
	
	/* ================================================================= */

	/* ================================================================= CHAPTER 2 */

	if (settings["miss1_chap_2"] && current.bsp == "/forest.bsp" && current.cs == 1 && old.cs == 0) {
		if(vars.firstcs == true){
			if(vars.debugMessage) vars.DebugOutput("The timer has stopped (FOREST)");
			return true;
		}
	}

	if(settings["miss2_chap_2"] && current.bsp == "/rocket.bsp"){
		if((version == "1.42d" && current.finish != 0 ) ||
			(version == "1.45a" && current.finish == 4 && current.cs == 0 && current.stuck != 3 )){
			if(vars.debugMessage) vars.DebugOutput("The timer has stopped (ROCKET)");
			return true;
		}
	}

	if(settings["miss3_chap_2"] && current.bsp == "/baseout.bsp"){
		if((version == "1.42d" && current.finish != 0 ) ||
			(version == "1.45a" && current.finish == 4 && current.cs == 0 && current.stuck != 3)){
			if(vars.debugMessage) vars.DebugOutput("The timer has stopped (BASEOUT)");
			return true;
		}
	}

	if(settings["miss4_chap_2"] && current.bsp == "/assault.bsp"){
		if((version == "1.42d" && current.finish != 0 ) ||
			(version == "1.45a" && current.finish == 4 && current.cs == 0 && current.stuck != 3)){
			if(vars.debugMessage) vars.DebugOutput("The timer has stopped (ASSAULT)");
			return true;
		}
	}

	/* =============================================================== */

	if(settings["miss1_chap_3"] && current.bsp == "/sfm.bsp"){
		if((version == "1.42d" && current.finish != 0 ) ||
			(version == "1.45a" && current.finish == 4 && current.cs == 0 && current.stuck != 3)){
			if(vars.debugMessage) vars.DebugOutput("The timer has stopped (SFM)");
			return true;
		}
	}

	if(settings["miss2_chap_3"] && current.bsp == "/factory.bsp"){
		if((version == "1.42d" && current.finish != 0 ) ||
			(version == "1.45a" && current.finish == 4 && current.cs == 0 && current.stuck != 3)){
			if(vars.debugMessage) vars.DebugOutput("The timer has stopped (FACTORY)");
			return true;
		}
	}

	if(settings["miss3_chap_3"] && current.bsp == "/trainyard.bsp"){
		if((version == "1.42d" && current.finish != 0 ) ||
			(version == "1.45a" && current.finish == 4 && current.cs == 0 && current.stuck != 3)){
			if(vars.debugMessage) vars.DebugOutput("The timer has stopped (TRAINYARD)");
			return true;
		}
	}

	if(settings["miss4_chap_3"] && current.bsp == "/swf.bsp"){
		if((version == "1.42d" && current.finish != 0 ) ||
			(version == "1.45a" && current.finish == 4 && current.cs == 0 && current.stuck != 3)){
			if(vars.debugMessage) vars.DebugOutput("The timer has stopped (SWF)");
			return true;
		}
	}

	/* =============================================================== */

	if(settings["miss1_chap_4"] && current.bsp == "/norway.bsp"){
		if((version == "1.42d" && current.finish != 0 ) ||
			(version == "1.45a" && current.finish == 4 && current.cs == 0 && current.stuck != 3)){
			if(vars.debugMessage) vars.DebugOutput("The timer has stopped (NORWAY)");
			return true;
		}
	}

	if(settings["miss2_chap_4"] && current.bsp == "/xlabs.bsp"){
		if((version == "1.42d" && current.finish != 0 ) ||
			(version == "1.45a" && current.finish == 4 && current.cs == 0 && current.stuck != 3)){
			if(vars.debugMessage) vars.DebugOutput("The timer has stopped (XLABS)");
			return true;
		}
	}

	// BOSS2 UP /\

	/* =============================================================== */

	if(settings["miss1_chap_5"] && current.bsp == "/dam.bsp"){
		if((version == "1.42d" && current.finish != 0 ) ||
			(version == "1.45a" && current.finish == 4 && current.zpos >= 5500.0 && current.cs == 0 )){
			if(vars.debugMessage) vars.DebugOutput("The timer has stopped (DAM)");
			return true;
		}
	}

	if(settings["miss2_chap_5"] && current.bsp == "/village2.bsp"){
		if((version == "1.42d" && current.finish != 0 ) ||
			(version == "1.45a" && current.finish == 4 && current.cs == 0 && current.stuck != 3)){
			if(vars.debugMessage) vars.DebugOutput("The timer has stopped (VILLAGE2)");
			return true;
		}
	}

	if(settings["miss3_chap_5"] && current.bsp == "/chateau.bsp"){
		if((version == "1.42d" && current.finish != 0 ) ||
			(version == "1.45a" && current.finish == 4  && current.cs == 0 && current.stuck != 3)){
			if(vars.debugMessage) vars.DebugOutput("The timer has stopped (CHATEAU)");
			return true;
		}
	}
	
	if(settings["miss4_chap_5"] && current.bsp == "/dark.bsp"){
		if((version == "1.42d" && current.finish != 0 ) ||
			(version == "1.45a" && current.finish == 4 && current.cs == 0 && current.stuck != 3)){
			if(vars.debugMessage) vars.DebugOutput("The timer has stopped (DARK)");
			return true;
		}
	}

	if(settings["miss5_chap_5"] && current.bsp == "/dig.bsp"){
		if((version == "1.42d" && current.finish != 0 ) ||
			(version == "1.45a" && current.finish == 4 && current.cs == 0 && current.stuck != 3)){
			if(vars.debugMessage) vars.DebugOutput("The timer has stopped (DIG)");
			return true;
		}
	}
	
	if(settings["miss6_chap_5"] && current.bsp == "/castle.bsp"){
		if((version == "1.42d" && current.finish != 0 ) ||
			(version == "1.45a" && current.finish == 4 && current.cs == 0 && current.stuck != 3)){
			if(vars.debugMessage) vars.DebugOutput("The timer has stopped (CASTLE)");
			return true;
		}
	}

}

update{
		
	if(!vars.running) return;
	
	switch(version){
		case "1.45a": {
			if((current.client_status == 0) || current.ESC == 2) vars.loadStarted = true;
			else{	
				if(current.camera_x != 0) vars.loadStarted = false;
			}
			break;
		}
		case "1.42d":{
			if(current.client_status != 8 && current.client_status != 1) vars.loadStarted = true;
			else{	
				if(current.camera_x != 0) vars.loadStarted = false;
			}
			break;
		}
		default:{ 
			return;
			break;
		}
	}

	if(vars.debugMessage){
		vars.DebugOutput("POSS: X " + current.xpos + " Y " + current.ypos + " Z " + current.zpos + " CS " + current.cs + " F " + current.finish + " CLS " + current.client_status + " S " + current.stuck );
	}
	
}

isLoading{	 
	return vars.loadStarted;
}
