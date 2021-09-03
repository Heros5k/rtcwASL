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
	settings.Add("cat_all", true, "Full game");
	
	// Only chapter
	settings.Add("chaptersOnly", false, "Chapters");
	settings.Add("cat_chap1", false, "Ominous Rumors + Dark Secret", "chaptersOnly");
	settings.Add("cat_chap2", false, "Weapons of Vengeance", "chaptersOnly");
	settings.Add("cat_chap3", false, "Deadly Designs", "chaptersOnly");
	settings.Add("cat_chap4", false, "Deathshead's Playground", "chaptersOnly");
	settings.Add("cat_chap5", false, "Return Engagement + Operation Resurrection", "chaptersOnly");

	// Individual chapter levels
	settings.Add("individualLevels", false, "Chapter 1 Individual Levels");
	settings.Add("miss1_chap_1", false, "Escape", "individualLevels");
	settings.Add("individualLevelsC2", false, "Chapter 2 Individual Levels");
	settings.Add("miss1_chap_2", false, "Forest", "individualLevelsC2");
	settings.Add("individualLevelsC3", false, "Chapter 3 Individual Levels");
	settings.Add("miss1_chap_3", false, "SFM", "individualLevelsC3");
	settings.Add("miss2_chap_3", false, "Factory", "individualLevelsC3");
	settings.Add("individualLevelsC4", false, "Chapter 4 Individual Levels");
	settings.Add("miss1_chap_4", false, "Norway", "individualLevelsC4");
	settings.Add("individualLevelsC5", false, "Chapter 5 Individual Levels");
	settings.Add("miss1_chap_5", false, "Dam", "individualLevelsC5");
	settings.Add("miss7_chap_5", false, "Heinrich", "individualLevelsC5");
	
	// DEBUG MESSAGE
	Action<string> DebugOutput = (text) => {
		print("[RTCW Autosplitter] " + text);
	};
	vars.DebugOutput = DebugOutput;

}

init{
	
	// Useful for debugViewer
	// https://docs.microsoft.com/en-us/sysinternals/downloads/debugview
	
	vars.debugMessage 	= 	true;
	
	int idGame = modules.First().ModuleMemorySize;
	
	int patch_142d = 14643200;
	int patch_145a = 19324928;
	
	if(vars.debugMessage){
		vars.DebugOutput("Game found!");
		vars.DebugOutput("Module size: " + idGame);
	}
	
	if(idGame == patch_145a){
		version 		= 	"1.45a";
		vars.running 	=	 true;
	}
	else if(idGame == patch_142d) {
		version 		= 	"1.42d";
		vars.running 	= 	true;
	} else {
		if(vars.debugMessage) vars.DebugOutput("Unrecognized game version. Disabling functionality.");
		vars.running 	= 	false;
		return false;
	}

	if(vars.debugMessage) vars.DebugOutput("Found Patch " + version);

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
	vars.running 		= 	false;
}

start{	

	if(settings["miss1_chap_1"]) vars.bsp_list.Add("/escape1.bsp");
	if(settings["miss1_chap_2"]) vars.bsp_list.Add("/forest.bsp");
	if(settings["miss1_chap_3"]) vars.bsp_list.Add("/sfm.bsp");
	if(settings["miss2_chap_3"]) vars.bsp_list.Add("/factory.bsp");
	if(settings["miss1_chap_4"]) vars.bsp_list.Add("/norway.bsp");
	if(settings["miss1_chap_5"]) vars.bsp_list.Add("/dam.bsp");
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
	
	if(settings["cat_chap1"] || settings["miss1_chap_1"]){
		if (current.bsp == "/escape1.bsp" && old.bsp != "/escape1.bsp") {
			if(vars.debugMessage) vars.DebugOutput("Timer started");
			vars.firstcs = true;
			vars.visited.Clear();
			vars.visited.Add("/escape1.bsp");
			return true;
		}
	}
	
	if(settings["cat_chap2"] || settings["miss1_chap_2"]){
		if (current.bsp == "/forest.bsp" && old.bsp != "/forest.bsp") {
			if(vars.debugMessage) vars.DebugOutput("Timer started");
			vars.firstcs = true;
			vars.visited.Clear();
			vars.visited.Add("/forest.bsp");
			return true;
		}
	}
	
	if(settings["cat_chap3"] || settings["miss1_chap_3"]){
		if (current.bsp == "/sfm.bsp" && old.bsp != "/sfm.bsp") {
			if(vars.debugMessage) vars.DebugOutput("Timer started");
			vars.firstcs = true;
			vars.visited.Clear();
			vars.visited.Add("/sfm.bsp");
			return true;
		}
	}
	
	if(settings["cat_chap4"] || settings["miss1_chap_4"]){
		if (current.bsp == "/norway.bsp" && old.bsp != "/norway.bsp") {
			if(vars.debugMessage) vars.DebugOutput("Timer started");
			vars.firstcs = true;
			vars.visited.Clear();
			vars.visited.Add("/norway.bsp");
			return true;
		}
	}
	
	if(settings["cat_chap5"] || settings["miss1_chap_5"]){
		if (current.bsp == "/dam.bsp" && old.bsp != "/dam.bsp") {
			if(vars.debugMessage) vars.DebugOutput("Timer started");
			vars.firstcs = true;
			vars.visited.Clear();
			vars.visited.Add("/dam.bsp");
			return true;
		}
	}
	
	if(settings["miss7_chap_5"]){
		if (current.bsp == "/end.bsp" && old.bsp != "/end.bsp") {
			if(vars.debugMessage) vars.DebugOutput("Timer started");
			vars.firstcs = true;
			vars.visited.Clear();
			vars.visited.Add("/end.bsp");
			return true;
		}
	}
	
	if(settings["miss2_chap_3"]){
		if (current.bsp == "/factory.bsp" && old.bsp != "/factory.bsp") {
			if(vars.debugMessage) vars.DebugOutput("Timer started");
			vars.firstcs = true;
			vars.visited.Clear();
			vars.visited.Add("/factory.bsp");
			return true;
		}
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
	
	if(settings["cat_chap1"]){
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
	
	// cords:  current.xpos >= 1454.0 && old.xpos < 1454.0 && current.xpos <= 1500.0 && old.xpos > 1300.0
	if(settings["cat_chap4"] && current.bsp == "/boss2.bsp"){
		if(current.xpos >= 1454.0 && old.xpos < 1454.0 && current.xpos <= 1500.0 && old.xpos > 1300.0){
			if(vars.debugMessage) vars.DebugOutput("The timer has stopped (BOSS2)");
			return true;
		}
	}
	
	// cords:  old.xpos >= -3662.0 && current.xpos < -3662.0 && current.ypos >= 850.0 
	if(settings["miss1_chap_1"] && current.bsp == "/escape1.bsp"){
		if((version == "1.42d" && current.finish != 0 ) ||
			(version == "1.45a" && current.finish == 4 && current.ypos >= 150.0 && current.cs == 0 )){
			if(vars.debugMessage) vars.DebugOutput("The timer has stopped (ESCAPE1)");
			return true;
		}
	}
	
	// cords:  current.xpos == -4800.0 && current.ypos == -896.0 && current.zpos == 256.0
	if (settings["miss1_chap_2"] && current.bsp == "/forest.bsp" && current.cs == 1 && old.cs == 0) {
		if(vars.firstcs == true){
			if(vars.debugMessage) vars.DebugOutput("The timer has stopped (FOREST)");
			return true;
		}
	}
	
	// cords:  current.zpos <= -153.0 && old23xpos <= -850.0 && current.ypos >= 2150.0
	if(settings["miss1_chap_3"] && current.bsp == "/sfm.bsp"){
		if((version == "1.42d" && current.finish != 0 ) ||
			(version == "1.45a" && current.finish == 4 )){
			if(vars.debugMessage) vars.DebugOutput("The timer has stopped (SFM)");
			return true;
		}
	}
	
	// cords:  current.ypos >= -1450.0 && current.xpos <= -7998.0
	if(settings["miss1_chap_4"] && current.bsp == "/norway.bsp"){
		if((version == "1.42d" && current.finish != 0 ) ||
			(version == "1.45a" && current.finish == 4 )){
			if(vars.debugMessage) vars.DebugOutput("The timer has stopped (NORWAY)");
			return true;
		}
	}
	
	// cords: no ( trigger is diagonally )
	if(settings["miss1_chap_5"] && current.bsp == "/dam.bsp"){
		if((version == "1.42d" && current.finish != 0 ) ||
			(version == "1.45a" && current.finish == 4 && current.zpos >= 5500.0 && current.cs == 0 )){
			if(vars.debugMessage) vars.DebugOutput("The timer has stopped (DAM)");
			return true;
		}
	}
	
	if(settings["miss2_chap_3"] && current.bsp == "/factory.bsp"){
		if((version == "1.42d" && current.finish != 0 ) ||
			(version == "1.45a" && current.finish == 4 )){
			if(vars.debugMessage) vars.DebugOutput("The timer has stopped (SFM)");
			return true;
		}
	}
}

update{
	
	if(!vars.running) return;
	
	if(version == "1.42d"){
		if(current.client_status != 8 && current.client_status != 1) vars.loadStarted = true;
		else{	
			if(current.camera_x != 0) vars.loadStarted = false;
		}
	} 

	if(version == "1.45a"){	
		if((current.client_status == 0) || current.ESC == 2) vars.loadStarted = true;
		else{	
			if(current.camera_x != 0 && current.stuck == 0 ) vars.loadStarted = false;
		}
	}
	
}

isLoading{	 
	return vars.loadStarted;
}
