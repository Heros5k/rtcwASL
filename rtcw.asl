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

	vars.mapListChapter1 = new List<string> { "escape1", "escape2", "tram", "village1", "crypt1", "crypt2", "church", "boss1" };
	vars.mapListChapter2 = new List<string> { "forest", "rocket", "baseout", "assault" };
	vars.mapListChapter3 = new List<string> { "sfm", "factory", "trainyard", "swf"};
	vars.mapListChapter4 = new List<string> { "norway", "xlabs", "boss2" };
	vars.mapListChapter5 = new List<string> { "dam", "village2", "chateau", "dark", "dig", "castle", "end" };

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

	refreshRate = 84;

}

init{
	
	// Useful for debugViewer
	// https://docs.microsoft.com/en-us/sysinternals/downloads/debugview
	
	vars.debugMessage 	= 	false;

	int idGame = modules.First().ModuleMemorySize;
	
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

	vars.firstcs 		= 	true;
	vars.loadStarted 	= 	false;
	vars.bsp_list 		= 	new List<String>();
	vars.visited 		= 	new List<String>();
	
}

exit{
	timer.IsGameTimePaused = true;
	vars.running 		= 	false;
}

shutdown{
	timer.IsGameTimePaused = true;
	vars.running 		= 	false;
}

start{	

	int listChapters = 0;
	bool firstLevelChapter = false;

	for(int i = 1; i <= 5; i ++){
		foreach (var maps in ( i == 1 ? vars.mapListChapter1 : i == 2 ? vars.mapListChapter2 : i == 3 ? vars.mapListChapter3 : i == 4 ? vars.mapListChapter4 : vars.mapListChapter5 )) {
			if(settings["miss" + (listChapters+1) + "_chap_"+ i ]) vars.bsp_list.Add("/" + maps + ".bsp");
			if(settings["cat_all"] || settings["cat_chap"+ i ]) vars.bsp_list.Add("/" + maps + ".bsp");
			listChapters++;
		}
		listChapters = 0;
	}

	// ================================================================= FULL GAME 

	if(settings["cat_all"]){
		if (current.bsp == "/cutscene1.bsp" && current.cs == 1 && old.cs == 0) {
			if(vars.debugMessage) vars.DebugOutput("Timer started");
			vars.firstcs = true;
			vars.visited.Clear();
			vars.visited.Add("/cutscene1.bsp");
			vars.visited.Add("/escape1.bsp");
			return true;
		}
	}

	// ================================================================= CHAPTER 1 / 2 / 3 / 4 / 5

	for(int i = 1; i <= 5; i ++){
		foreach (var maps in ( i == 1 ? vars.mapListChapter1 : i == 2 ? vars.mapListChapter2 : i == 3 ? vars.mapListChapter3 : i == 4 ? vars.mapListChapter4 : vars.mapListChapter5 )) {
			if(listChapters == 0){
				firstLevelChapter = true;
			} else firstLevelChapter = false;
			listChapters++;
			if((settings["cat_chap"+i] && firstLevelChapter) || settings["miss" + (listChapters) + "_chap_"+i]){
				if (current.bsp == "/" + maps + ".bsp" && old.bsp != "/" + maps + ".bsp") {
					if(vars.debugMessage) vars.DebugOutput("Timer started");
					vars.firstcs = true;
					vars.visited.Clear();
					vars.visited.Add("/" + maps + ".bsp");
					return true;
				}
			}
		}
		listChapters = 0;
	}
}

split{
	
	if(!vars.running) return;

	bool isOld = (version == "1.42d" && current.finish != 0) ? true : false;
	bool isNew = (version == "1.45a" && current.finish == 4 && current.cs == 0 && current.stuck != 3) ? true : false;

	bool cordVillage1 = (current.zpos > 4500.0 && current.zpos < 4580.0 && current.xpos > -460.0 && current.xpos < -300.0 ) ? true : false;
	bool cordTram = (current.xpos < -3850.0 && current.ypos > -1300.0) ? true : false;
	bool cordDam = (current.zpos >= 5500.0) ? true : false;
	bool cordBoss2 = (current.xpos >= 1454.0 && old.xpos < 1454.0 && current.xpos <= 1500.0 && old.xpos > 1300.0) ? true : false;
	bool cordDark = (current.xpos > 3100.0 && current.xpos < 3360.0 && current.zpos < 3230.0 && current.zpos > 2970.0) ? true : false;

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
		if(cordBoss2){
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

	int listChapters = 0;

	foreach (var maps in vars.mapListChapter1) {
		listChapters++;
		if(maps == "boos1") continue;

		if(settings["miss" + listChapters + "_chap_1"] && current.bsp == "/" + maps + ".bsp"){
			if((isNew && maps == "tram" && cordTram) ||
				(isNew && maps == "village1" && cordVillage1) ||
				isOld || isNew
			){
				
				if(vars.debugMessage) vars.DebugOutput("The timer has stopped (" + maps +")");
				return true;
			}
		}
	}
	listChapters = 0;

	// BOSS1 - IN THE FUNCTIONS CHAPTER

	if (settings["miss1_chap_2"] && current.bsp == "/forest.bsp") {
		if(current.cs == 1 && old.cs == 0){
			if(vars.firstcs == true){
				if(vars.debugMessage) vars.DebugOutput("The timer has stopped (FOREST)");
				return true;
			}
		}
	}

	foreach (var maps in vars.mapListChapter2) {
		listChapters++;
		if(maps == "forest") continue;

		if(settings["miss" + listChapters + "_chap_2"] && current.bsp == "/" + maps + ".bsp"){
			if(isOld || isNew){
				if(vars.debugMessage) vars.DebugOutput("The timer has stopped (" + maps +")");
				return true;
			}
		}
	}
	listChapters = 0;

	foreach (var maps in vars.mapListChapter3) {
		listChapters++;
		if(settings["miss" + listChapters + "_chap_3"] && current.bsp == "/" + maps + ".bsp"){
			if(isOld || isNew){
				if(vars.debugMessage) vars.DebugOutput("The timer has stopped (" + maps +")");
				return true;
			}
		}
	}
	listChapters = 0;

	foreach (var maps in vars.mapListChapter4) {
		listChapters++;
		if(maps == "boss2") continue;

		if(settings["miss" + listChapters + "_chap_4"] && current.bsp == "/" + maps + ".bsp"){
			if(isOld || isNew){
				if(vars.debugMessage) vars.DebugOutput("The timer has stopped (" + maps +")");
				return true;
			}
		}
	}
	listChapters = 0;

	// BOSS2 - IN THE FUNCTIONS CHAPTER

	foreach (var maps in vars.mapListChapter5) {
		listChapters++;
		if(maps == "end") continue;

		if(settings["miss" + listChapters + "_chap_5"] && current.bsp == "/" + maps + ".bsp"){
			if((isNew && maps == "dam" && cordDam) ||
				(isNew && maps == "dark" && cordDark) ||
				isOld || isNew
			){
				if(vars.debugMessage) vars.DebugOutput("The timer has stopped (" + maps +")");
				return true;
			}
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
