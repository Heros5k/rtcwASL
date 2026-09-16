// ----------------------------------------
// GAME: Return to Castle Wolfenstein
// https://store.steampowered.com/app/9010/
// ----------------------------------------

// Patch by KoRrNiK | The bytes were found by KoRrNiK
state("WolfSP", "1.45a"){   
    string16 bsp        :       "WolfSP.exe",       0x693664;
    byte cs             :       "WolfSP.exe",       0xEA7B64;
    
    int client_status   :       "WolfSP.exe",       0x613420;
    byte ESC            :       "WolfSP.exe",       0xCCAF24;   // 2 == ESC | 1 == CONSOLE

    float camera_x      :       "WolfSP.exe",       0x7A2F9C;
    float xpos          :       "WolfSP.exe",       0x77B0DC;
    float ypos          :       "WolfSP.exe",       0x7A2FA4;
    float zpos          :       "WolfSP.exe",       0x77B0E0;
    
    int finish          :       "WolfSP.exe",       0xDBC164;
    byte stuck          :       "WolfSP.exe",       0xDCB9E1;
}

// Patch by Knightmare | The bytes were found by Hoyo & KoRrNiK
// Updated for 1.42d using new freeze / cutscene flags
state("WolfSP", "1.42d"){
    string16 bsp        :       0x13D4,             0x8;
    byte cs             :       0x26F4,             0x0;
    
    int client_status   :       0xB24EE0;
    byte ESC            :       "WolfSP.exe",       0x6899D8;   // 1 == ESC
    
    float camera_x      :       "WolfSP.exe",       0xDA9D3C;
    float xpos          :       "WolfSP.exe",       0x5F8Da4;
    float ypos          :       "WolfSP.exe",       0x5F8Da8;
    float zpos          :       "WolfSP.exe",       0x5F8Dac;

    // New flags
    int freeze          :       "WolfSP.exe",      0xA394A4;
    int in_cutscene     :       "WolfSP.exe",      0xB24EA4;
    int freeze_flag1     :      "WolfSP.exe",      0x5A886C;
	int freeze_flag2    :       "WolfSP.exe",      0xA41B1C;
}

// TrueFix telemetry path.
state("WolfSP", "1.43d")
{
    uint sr_flags              : "WolfSP.exe", 0x115CF8; 
    uint sr_mapSequence        : "WolfSP.exe", 0x115CFC;
    uint sr_transitionSequence : "WolfSP.exe", 0x115D00;
    string32 sr_mapName        : "WolfSP.exe", 0x115D04;
    // Temporary chapter/IL startup load-removal compatibility hack.
    // tr.refdef.vieworg[0], relative to WolfSP.exe.
    float camera_x             : "WolfSP.exe", 0xCC5BF8;
}

startup {
    int m_chap = 0, i_chap = 0;

    vars.mapListChapter1 = new List<string> { "escape1", "escape2", "tram", "village1", "crypt1", "crypt2", "church", "boss1" };
    vars.mapListChapter2 = new List<string> { "forest", "rocket", "baseout", "assault" };
    vars.mapListChapter3 = new List<string> { "sfm", "factory", "trainyard", "swf"};
    vars.mapListChapter4 = new List<string> { "norway", "xlabs", "boss2" };
    vars.mapListChapter5 = new List<string> { "dam", "village2", "chateau", "dark", "dig", "castle", "end" };

    vars.chapterNames = new List<string> { "Ominous Rumors + Dark Secret", "Weapons of Vengeance", "Deadly Designs", "Deathshead's Playground", "Return Engagement + Operation Resurrection" };
    vars.individualNames1 = new List<string> { "Escape!", "Castle Keep", "Tram Ride", "Village", "Catacombs", "Crypt", "The Defiled Church", "Tomb" };
    vars.individualNames2 = new List<string> { "Forest Compound", "Rocket Base", "Radar Installation", "Air Base Assault" };
    vars.individualNames3 = new List<string> { "Kugelstadt", "The Bombed Factory", "The Trainyards", "Secret Weapons Facility" };
    vars.individualNames4 = new List<string> { "Ice Station Norway", "X-Labs", "Super Soldier" };
    vars.individualNames5 = new List<string> { "Bramburg Dam", "Paderborn Village", "Chateau Schufstaffel", "Unhallowed Ground", "The Dig", "Return to Castle Wolfenstein", "Heinrich" };

    vars.gameplayMaps = new HashSet<string>();
    foreach (var map in vars.mapListChapter1) vars.gameplayMaps.Add(map);
    foreach (var map in vars.mapListChapter2) vars.gameplayMaps.Add(map);
    foreach (var map in vars.mapListChapter3) vars.gameplayMaps.Add(map);
    foreach (var map in vars.mapListChapter4) vars.gameplayMaps.Add(map);
    foreach (var map in vars.mapListChapter5) vars.gameplayMaps.Add(map);

    // Full Game
    settings.Add("cat_all",             true,       "Full game");
    
    // Only chapter
    settings.Add("chaptersOnly",        false,      "Chapters");
    foreach (var names in vars.chapterNames){
        m_chap++;
        settings.Add("cat_chap"+m_chap, false, names, "chaptersOnly");
    }

    // Individual chapter levels
    for(int i = 1; i <= 5; i++){
        settings.Add("individualLevelsC"+i,     false,      "Chapter "+i+" Individual Levels");
        foreach (var names in ( i == 1 ? vars.individualNames1 : i == 2 ? vars.individualNames2 : i == 3 ? vars.individualNames3 : i == 4 ? vars.individualNames4 : vars.individualNames5 )){
            i_chap++;
            settings.Add("miss"+i_chap+"_chap_"+i, false, names, "individualLevelsC"+i);
        }
        i_chap = 0;
    }
    
    // DEBUG MESSAGE
    Action<string> DebugOutput = (text) => {
        print("[RTCW Autosplitter] " + text);
    };
    vars.DebugOutput = DebugOutput;

    refreshRate = 84;

    
    // TrueFix telemetry
    vars.SR_LEVEL_TRANSITION = 1u;
    vars.SR_LOADING          = 2u;
    vars.SR_CUTSCENE         = 4u;
    vars.SR_PLAYER_FROZEN    = 8u;
    vars.SR_CONTROL_LOCKED   = 16u;
    vars.SR_LOAD_REMOVAL     = 32u;

    vars.startNeedsLoadGuard = false;
    vars.startNeedsRenderGuard = false;
    vars.justStarted = false;
    vars.initialLoadSeen = false;
    vars.startupRenderGuard = false;

    // Split bookkeeping only. Load removal is authoritative in the engine.
    vars.cutsceneCount = 0;
    vars.secondCutsceneStarted = false;
}

init{
    print("WolfSP ModuleMemorySize: " + modules.First().ModuleMemorySize);
    // Useful for debugViewer
    // https://docs.microsoft.com/en-us/sysinternals/downloads/debugview
    
    vars.debugMessage   =   false;

    int idGame = modules.First().ModuleMemorySize;
    
    switch(idGame){
        case 14643200:{
            version         =   "1.42d";
            vars.running    =   true;
            break;
        }
        case 14585856: 
        {
            version         = "1.43d";
            vars.running    = true;
            break;
        }
        case 19324928:{
            version         =   "1.45a";
            vars.running    =    true;
            break;
        }
        default:{
            if(vars.debugMessage) vars.DebugOutput("Unrecognized game version. Disabling functionality.");
            version         =   "Unknown";
            vars.running    =   false;
            return false;
        }
    }

    if(vars.debugMessage){
        vars.DebugOutput("Game found | Found Patch" + version + " | Module size: "+ idGame);
    }

    vars.firstcs        =   true;
    vars.loadStarted    =   false;
    vars.bsp_list       =   new List<String>();
    vars.visited        =   new List<String>();

    // Keep initial attachment state identical to an explicit LiveSplit reset.
    vars.startNeedsLoadGuard = false;
    vars.startNeedsRenderGuard = false;
    vars.justStarted = false;
    vars.initialLoadSeen = false;
    vars.startupRenderGuard = false;

    vars.cutsceneCount = 0;
    vars.secondCutsceneStarted = false;

}

exit{
    timer.IsGameTimePaused = true;
    vars.running        =   false;
}

shutdown{
    timer.IsGameTimePaused = true;
    vars.running        =   false;
}

start{  
    if (!vars.running)
        return false;

    if (version == "1.43d")
    {
        bool cutsceneStarted = (current.sr_flags & vars.SR_CUTSCENE) != 0 && (old.sr_flags & vars.SR_CUTSCENE) == 0;
        bool mapChanged = current.sr_mapSequence != old.sr_mapSequence;

        if (settings["cat_all"] && current.sr_mapName == "cutscene1" && cutsceneStarted)
        {
            vars.visited.Clear();
            vars.visited.Add("cutscene1");
            vars.visited.Add("escape1");
            vars.startNeedsLoadGuard = false;
            vars.startNeedsRenderGuard = false;
            return true;
        }

        if (!mapChanged) return false;

        for (int chapter = 1; chapter <= 5; chapter++)
        {
            var maps =
                chapter == 1 ? vars.mapListChapter1 :
                chapter == 2 ? vars.mapListChapter2 :
                chapter == 3 ? vars.mapListChapter3 :
                chapter == 4 ? vars.mapListChapter4 :
                               vars.mapListChapter5;

            for (int i = 0; i < maps.Count; i++)
            {
                bool individualSelected =
                    settings["miss" + (i + 1) + "_chap_" + chapter];

                if ((settings["cat_chap" + chapter] && i == 0) ||
                    individualSelected)
                {
                    if (current.sr_mapName == maps[i])
                    {
                        vars.visited.Clear();
                        vars.visited.Add(current.sr_mapName);
                        vars.startNeedsLoadGuard = true;
                        vars.startNeedsRenderGuard = true;
                        return true;
                    }
                }
            }
        }

        return false;
    }

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

    if (settings["cat_all"] && current.bsp == "/cutscene1.bsp" && current.cs == 1 && old.cs == 0) {
        if(vars.debugMessage) vars.DebugOutput("Timer started");
        vars.firstcs = true;
        vars.visited.Clear();
        vars.visited.Add("/cutscene1.bsp");
        vars.visited.Add("/escape1.bsp");
        return true;
    }

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

onStart
{
    if (version != "1.43d")
        return;

    if (vars.startNeedsLoadGuard)
    {
        vars.justStarted = true;
        vars.initialLoadSeen = false;
        vars.startupRenderGuard = vars.startNeedsRenderGuard;

        /*
         * LiveSplit starts each attempt with Game Time uninitialized, and
         * isLoading() is not called until the next ASL iteration. Initialize
         * Game Time at zero here, then pause it immediately, so the first
         * update interval cannot leak into the run.
         */
        timer.SetGameTime(TimeSpan.Zero);
        timer.IsGameTimePaused = true;

        if (vars.debugMessage)
            vars.DebugOutput("Startup load guard armed");
    }
    else
    {
        vars.justStarted = false;
        vars.initialLoadSeen = false;
        vars.startupRenderGuard = false;
    }

    vars.startNeedsLoadGuard = false;
    vars.startNeedsRenderGuard = false;
}

onReset
{
    if (version != "1.43d")
        return;

    vars.startNeedsLoadGuard = false;
    vars.startNeedsRenderGuard = false;
    vars.justStarted = false;
    vars.initialLoadSeen = false;
    vars.startupRenderGuard = false;

    vars.cutsceneCount = 0;
    vars.secondCutsceneStarted = false;
}

split{
    if(!vars.running) return;

    if(version == "1.43d")
    {
        bool mapChanged = current.sr_mapSequence != old.sr_mapSequence;
        bool transitionTriggered = current.sr_transitionSequence != old.sr_transitionSequence;
        bool levelTransition = (current.sr_flags & vars.SR_LEVEL_TRANSITION) != 0;
        bool cutsceneStarted = (current.sr_flags & vars.SR_CUTSCENE) != 0 && (old.sr_flags & vars.SR_CUTSCENE) == 0;
        bool normalILEnd = transitionTriggered && levelTransition;

        // First-cutscene endings.
        if (current.sr_mapName == "forest" && cutsceneStarted && settings["miss1_chap_2"]) return true;
        if (current.sr_mapName == "assault" && cutsceneStarted && (settings["cat_chap2"] || settings["miss4_chap_2"])) return true;
  
        // Second-cutscene endings.
        if (current.sr_mapName == "boss1" && vars.secondCutsceneStarted && (settings["cat_chap1"] || settings["miss8_chap_1"])) return true;
        if (current.sr_mapName == "swf" && (vars.secondCutsceneStarted && (settings["cat_chap3"] || settings["miss4_chap_3"]))) return true;
        if (current.sr_mapName == "end" && vars.secondCutsceneStarted && (settings["cat_all"] || settings["cat_chap5"] || settings["miss7_chap_5"])) return true;

        // Normal transition ending.
        if (current.sr_mapName == "boss2" && normalILEnd && settings["cat_chap4"]) return true;
            
        if (settings["cat_all"] && mapChanged && current.sr_mapName != "escape1" &&
            vars.gameplayMaps.Contains(current.sr_mapName) && !vars.visited.Contains(current.sr_mapName))
        {
            vars.visited.Add(current.sr_mapName);
            return true;
        }

        if (mapChanged)
        {
            for (int chapter = 1; chapter <= 5; chapter++)
            {
                if (!settings["cat_chap" + chapter]) continue;

                var maps =
                    chapter == 1 ? vars.mapListChapter1 :
                    chapter == 2 ? vars.mapListChapter2 :
                    chapter == 3 ? vars.mapListChapter3 :
                    chapter == 4 ? vars.mapListChapter4 :
                                vars.mapListChapter5;

                for (int i = 1; i < maps.Count; i++)
                {
                    if (current.sr_mapName == maps[i] && !vars.visited.Contains(current.sr_mapName))
                    {
                        vars.visited.Add(current.sr_mapName);
                        return true;
                    }
                }
            }
        }

        for (int chapter = 1; chapter <= 5; chapter++)
        {
            var maps =
                chapter == 1 ? vars.mapListChapter1 :
                chapter == 2 ? vars.mapListChapter2 :
                chapter == 3 ? vars.mapListChapter3 :
                chapter == 4 ? vars.mapListChapter4 :
                            vars.mapListChapter5;

            for (int i = 0; i < maps.Count; i++)
            {
                bool selected = settings["miss" + (i + 1) + "_chap_" + chapter];
                if (!selected) continue;

                string map = maps[i];
                if (current.sr_mapName != map) continue;

                if (map == "forest") continue;
                if (map == "assault") continue;
                if (map == "swf") continue;
                if (map == "boss1") continue;
                if (map == "end") continue;

                if (normalILEnd) return true;
            }
        }
        return false;
    }


    // 1.42d, 1.45a
    bool isOld = (
		version == "1.42d"
		&& current.freeze == 4
        && old.freeze != 4
		&& current.freeze_flag1 == 3
		&& old.freeze_flag2 != 0
	); // CHANGE

	bool isNew = (version == "1.45a" && current.finish == 4 && current.cs == 0 && current.stuck != 3) ? true : false;

	bool cordVillage1 = (current.zpos > 4500.0 && current.zpos < 4580.0 && current.xpos > -460.0 && current.xpos < -300.0 ) ? true : false;
	bool cordTram = (current.xpos < -3850.0 && current.ypos > -1300.0) ? true : false;
	bool cordBoss2 = (current.xpos >= 1454.0 && old.xpos < 1454.0 && current.xpos <= 1500.0 && old.xpos > 1300.0) ? true : false;
	bool cordDark = (current.xpos > 3100.0 && current.xpos < 3360.0 && current.zpos < 3230.0 && current.zpos > 2970.0) ? true : false;
	bool cordEscape1 = (current.ypos > 150.0 && current.ypos < 350.0 && current.zpos >= 882.0 && current.zpos <= 1037.0) ? true : false;
	
	int listChapters = 0;
	bool stoppedTimer = false;
	bool stoppedCutscene = false;

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

	for(int i = 1; i <= 5; i ++){
		if(i == 1 && current.bsp == "/boss1.bsp" && ( settings["cat_chap"+i] || settings["miss8_chap_"+i] )) stoppedCutscene = true;
		if(settings["cat_chap"+i]){
			if((i == 2 && current.bsp == "/assault.bsp") || (i == 3 && current.bsp == "/swf.bsp")) stoppedCutscene = true;
		}
		if(i == 5 && current.bsp == "/end.bsp") stoppedCutscene = true;
		if (stoppedCutscene && current.cs == 1 && old.cs == 0) {
			if(vars.firstcs == false) {
				if(vars.debugMessage) vars.DebugOutput("Second cutscene.");
				return true;
			}
			if(vars.firstcs == true) {
				vars.firstcs = false;
				if(vars.debugMessage) vars.DebugOutput("First cutscene.");
			}
		}
		stoppedCutscene = false;
	}

	if((settings["cat_chap4"] || settings["miss3_chap_4"]) && current.bsp == "/boss2.bsp" && cordBoss2){
		if(vars.debugMessage) vars.DebugOutput("The timer has stopped (BOSS2)");
		return true;
	}

	for(int i = 1; i <= 5; i ++){
		foreach (var maps in ( i == 1 ? vars.mapListChapter1 : i == 2 ? vars.mapListChapter2 : i == 3 ? vars.mapListChapter3 : i == 4 ? vars.mapListChapter4 : vars.mapListChapter5 )) {
			listChapters++;
			
			if(version == "1.45a" && current.finish == 4 && current.stuck != 0 ) continue;

			if(i == 1 && maps == "boss1") continue;
			if(i == 4 && maps == "boss2") continue;
			if(i == 5 && maps == "end") continue;

			if(settings["miss" + listChapters + "_chap_"+i] && current.bsp == "/" + maps + ".bsp"){

				if(i == 1 && ((isNew && maps == "escape1" && cordEscape1) || (isNew && maps == "tram" && cordTram) || (isNew && maps == "village1" && cordVillage1) || isOld || (isNew && maps != "escape1"))) stoppedTimer = true;
				if(i == 2 && (((maps == "forest" || maps == "assault") && current.cs == 1 && old.cs == 0 && vars.firstcs == true) || isOld || isNew)) stoppedTimer = true;
				if((i == 3 || i == 4) && (isOld || isNew)) stoppedTimer = true;
				if(i == 5 && ((isNew && maps == "dark" && cordDark) || isOld || isNew)) stoppedTimer = true;

				if(stoppedTimer){
					if(vars.debugMessage) vars.DebugOutput("The timer has stopped (" + maps +")");
					return true;
				}
			}
		}
		listChapters = 0;
	}
}

update{
    if (!vars.running)
        return;
    
    switch(version){
        case "1.45a": {
            if((current.client_status == 0) || current.ESC == 2) vars.loadStarted = true;
            else{   
                if(current.camera_x != 0) vars.loadStarted = false;
            }
            break;
        }
        case "1.42d":{
            if((current.client_status != 8 && current.client_status != 1) || current.ESC == 1) vars.loadStarted = true;
            else{   
                if(current.camera_x != 0) vars.loadStarted = false;
            }
            break;
        }
        case "1.43d":{
            bool loadRemoval = (current.sr_flags & vars.SR_LOAD_REMOVAL) != 0;

            if (vars.justStarted)
            {
                if (loadRemoval)
                    vars.initialLoadSeen = true;

                if (vars.initialLoadSeen && !loadRemoval)
                {
                    bool renderReady = !vars.startupRenderGuard || current.camera_x != 0.0f;

                    if (renderReady)
                    {
                        vars.justStarted = false;
                        vars.startupRenderGuard = false;

                        if (vars.debugMessage)
                            vars.DebugOutput("Startup load guard released");
                    }
                }
            }

            // TrueFix provides authoritative load removal directly.
            // update() only maintains cutscene bookkeeping used by split().
            vars.secondCutsceneStarted = false;

            if (current.sr_mapSequence != old.sr_mapSequence) vars.cutsceneCount = 0;

            bool cutsceneStarted = (current.sr_flags & vars.SR_CUTSCENE) != 0 && (old.sr_flags & vars.SR_CUTSCENE) == 0;

            if (cutsceneStarted)
            {
                vars.cutsceneCount++;
                if (vars.cutsceneCount == 2) vars.secondCutsceneStarted = true;
            }

            return;
        }
        case "Unknown":{ 
            return;
        }
    }
    if(vars.debugMessage){
        //vars.DebugOutput("POSS: X " + current.xpos + " Y " + current.ypos + " Z " + current.zpos + " CS " + current.cs + " F " + current.finish + " CLS " + current.client_status + " S " + current.stuck );
        //vars.DebugOutput("BSP: " + current.bsp);
    }
}

isLoading
{
    if (!vars.running) return true;

    if (version == "1.43d")
    {
        bool loadRemoval = (current.sr_flags & vars.SR_LOAD_REMOVAL) != 0;

        // For chapter/IL startup, justStarted remains set after loadRemoval clears until the renderer has received a real camera position.
        return vars.justStarted || loadRemoval;
    }

    return vars.loadStarted;
}
