local rotationName = "Kuukuu" -- Change to name of profile listed in options drop down

---------------
--- Toggles ---
---------------
local function createToggles() -- Define custom toggles
-- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "自动使用大技能 - 只在BOSS.", highlight = 1, icon = br.player.spell.holyAvenger},
        [2] = { mode = "On", value = 1 , overlay = "Cooldowns Enabled", tip = "不管任何目标都使用大技能.", highlight = 0, icon = br.player.spell.auraMastery},
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "不使用大技能.", highlight = 0, icon = br.player.spell.absolution}
    };
    CreateButton("Cooldown",1,0)
-- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "使用保命技能.", highlight = 1, icon = br.player.spell.divineProtection},
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "不使用保命技能.", highlight = 0, icon = br.player.spell.blessingOfProtection}
    };
    CreateButton("Defensive",2,0)
-- Interrupt Button
    InterruptModes = {
        [1] = { mode = "On", value = 1 , overlay = "Interrupts Enabled", tip = "使用打断.", highlight = 1, icon = br.player.spell.hammerOfJustice},
        [2] = { mode = "Off", value = 2 , overlay = "Interrupts Disabled", tip = "不使用打断.", highlight = 0, icon = br.player.spell.hammerOfJustice}
    };
    CreateButton("Interrupt",3,0)
-- Cleanse Button
    CleanseModes = {
        [1] = { mode = "On", value = 1 , overlay = "Cleanse Enabled", tip = "启用驱散", highlight = 1, icon = br.player.spell.cleanse },
        [2] = { mode = "Off", value = 2 , overlay = "Cleanse Disabled", tip = "禁用驱散", highlight = 0, icon = br.player.spell.cleanse }
    };
    CreateButton("Cleanse",4,0)
-- DPS
    DPSModes = {
        [1] = { mode = "On", value = 1 , overlay = "DPS Enabled", tip = "启用DPS", highlight = 1, icon = br.player.spell.judgment },
        [2] = { mode = "Off", value = 2 , overlay = "DPS Disabled", tip = "禁用DPS", highlight = 0, icon = br.player.spell.judgment }
    };
    CreateButton("DPS",5,0)	
end

---------------
--- OPTIONS ---
---------------
local function createOptions()
    local optionTable

    local function rotationOptions()
        -----------------------
        --- GENERAL OPTIONS --- -- Define General Options
        -----------------------
        section = br.ui:createSection(br.ui.window.profile,  "一般")
        --    br.ui:createCheckbox(section, "Boss Helper")
        -- Hand of Freedom
            br.ui:createCheckbox(section, "自由祝福")	
	    -- 延时之力药水	
		    br.ui:createSpinner(section, "延时之力药水",  5,  0,  20,  1,  "|cffFFFFFF根据DBM倒数计时多少秒使用延时之力药水.")			
        --Beacon of Light
            br.ui:createCheckbox(section, "圣光道标")
			br.ui:createCheckbox(section, "信仰道标")
        -- Redemption
            br.ui:createDropdown(section, "救赎", {"|cffFFFFFF目标","|cffFFFFFF鼠标位置"}, 1, "","|cffFFFFFF选择救赎目标.")
		-- 紧急治疗
            br.ui:createSpinner (section, "紧急治疗", 30, 0, 100, 5, "","|cffFFFFFF多少血量百分比以下紧急治疗")			
		-- 过量治疗取消读条
            br.ui:createSpinner (section, "过量治疗取消读条", 95, 0, 100, 5, "","|cffFFFFFF多少血量百分比以上取消读条")				
        br.ui:checkSectionState(section)	
        -------------------------
        ------ DEFENSIVES -------
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, "保命")
            -- Pot/Stone
            br.ui:createSpinner (section, "药水/治疗石", 30, 0, 100, 5, "","|cffFFFFFF多少血量百分比使用")
            br.ui:createSpinner (section, "圣佑术", 60, 0, 100, 5, "","|cffFFFFFF多少血量百分比使用")
			br.ui:createSpinner (section, "圣盾术", 20, 0, 100, 5, "","|cffFFFFFF多少血量百分比使用")
        br.ui:checkSectionState(section)
        -------------------------
        --- INTERRUPT OPTIONS ---
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, "打断")
        --Hammer of Justice
            br.ui:createCheckbox(section, "制裁之锤")
		-- Blinding Light
            br.ui:createCheckbox(section, "盲目之光")		
        -- Interrupt Percentage
            br.ui:createSpinner(section,  "打断",  95,  0,  95,  5,  "","|cffFFBB00读条百分几打断")
        br.ui:checkSectionState(section)
        -------------------------
        ---- SINGLE TARGET ------
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, "单目标治疗")
            --Flash of Light
            br.ui:createSpinner(section, "圣光闪现",  70,  0,  100,  5,  "","|cffFFFFFF多少血量百分比使用")
            br.ui:createDropdownWithout(section, "圣光闪现 灌注", {"|cffFFFFFF正常","|cffFFFFFF只用圣光灌注"}, 1, "|cffFFFFFF只用圣光灌注来放圣光闪现.")
            --Holy Light
            br.ui:createSpinner(section, "圣光术",  85,  0,  100,  5,  "","|cffFFFFFF多少血量百分比使用")
            br.ui:createDropdownWithout(section, "圣光术 灌注", {"|cffFFFFFF正常","|cffFFFFFF只用圣光灌注"}, 2, "|cffFFFFFF只用圣光灌注来放圣光术.")
            --Holy Shock
            br.ui:createSpinner(section, "神圣震击", 90, 0, 100, 5, "","|cffFFFFFF多少血量百分比使用")
            --Bestow Faith
            br.ui:createSpinner(section, "赋予信仰", 80, 0, 100, 5, "","|cffFFFFFF多少血量百分比使用")
            br.ui:createDropdownWithout(section, "赋予信仰 目标", {"|cffFFFFFF所有","|cffFFFFFF坦克","|cffFFFFFF自己+使用殉道"}, 3, "|cffFFFFFF赋予信仰的目标选择")
            -- Light of the Martyr
            br.ui:createSpinner(section, "殉道者之光", 40, 0, 100, 5, "","|cffFFFFFF多少血量百分比使用")
            br.ui:createSpinner(section, "移动时 殉道者之光", 80, 0, 100, 5, "","|cffFFFFFF你在移动时队友多少血量百分比以下使用")
			br.ui:createSpinner(section, "殉道者之光 自身血量限制", 30, 0, 100, 5, "","|cffFFFFFF自身多少血量百分比以下不使用殉道者之光", true)
        br.ui:checkSectionState(section)
        -------------------------
        ------ AOE HEALING ------
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, "AOE 治疗")
		    -- Rule of Law
            br.ui:createSpinner(section, "律法之则",  70,  0,  100,  5,  "","|cffFFFFFF多少血量百分比使用")
            br.ui:createSpinner(section, "律法之则 目标",  3,  0,  40,  1,  "","|cffFFFFFF多少目标才使用", true)			
            -- Light of Dawn
            br.ui:createSpinner(section, "黎明之光",  90,  0,  100,  5,  "","|cffFFFFFF多少血量百分比使用")
            br.ui:createSpinner(section, "黎明之光 目标",  3,  0,  40,  1,  "","|cffFFFFFF多少目标才使用", true)
            -- Tyr's Deliverance
            br.ui:createSpinner(section, "提尔的拯救", 70, 0, 100, 5, "","|cffFFFFFF多少血量百分比使用")
			br.ui:createSpinner(section, "提尔的拯救 目标",  3,  0,  40,  1,  "","|cffFFFFFF多少目标才放美德道标", true)
        -- Beacon of Virtue
            br.ui:createSpinner(section, "美德道标", 80, 0, 100, 5, "","|cffFFFFFF多少血量百分比使用")
            br.ui:createSpinner(section, "美德道标 目标",  3,  0,  40,  1,  "","|cffFFFFFF多少目标才放美德道标", true)
		-- Holy Prism
            br.ui:createSpinner(section, "神圣棱镜", 80, 0, 100, 5, "","|cffFFFFFF多少血量百分比使用")
            br.ui:createSpinner(section, "神圣棱镜 目标",  3,  0,  40,  1,  "","|cffFFFFFF多少目标才放神圣棱镜", true)
		-- Light's Hammer
            br.ui:createSpinner(section, "圣光之锤", 80, 0, 100, 5, "","|cffFFFFFF多少血量百分比使用")
            br.ui:createSpinner(section, "圣光之锤 目标",  3,  0,  40,  1,  "","|cffFFFFFF多少目标才放圣光之锤", true)
            br.ui:createDropdown(section,"圣光之锤快捷键", br.dropOptions.Toggle, 6, "","|cffFFFFFF按下快捷键就在鼠标位置放置圣光之锤.", true)
		-- Divine Shield and Light of the Martyr
            br.ui:createSpinner(section, "无敌+殉道者之光",  30, 0, 100, 5, "","|cffFFFFFF多少血量百分比使用")
            br.ui:createSpinner(section, "无敌+殉道者之光 目标",  3,  0,  40,  1,  "","|cffFFFFFF多少目标才用无敌+殉道者之光", true)
        br.ui:checkSectionState(section)
        -------------------------
        ---------- DPS ----------
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, "DPS")
            br.ui:createSpinner(section, "DPS", 70, 0, 100, 5, "","|cffFFFFFF队友多少血量以下不打输出")
            -- Consecration
            br.ui:createSpinner(section, "奉献",  1,  0,  40,  1,  "","|cffFFFFFF最小的奉献的目标")
			-- Blinding Light
            br.ui:createSpinner(section, "盲目之光 输出", 4, 0, 10, 1, "","|cffFFFFFF多少敌人在10码内才使用")			
            -- Holy Prism
            br.ui:createSpinner(section, "神圣棱镜 输出",  3,  0,  40,  1,  "","|cffFFFFFF最小的棱镜目标")
            -- Light's Hammer
            br.ui:createSpinner(section, "圣光之锤 输出",  3,  0,  40,  1,  "","|cffFFFFFF最小的光锤目标")
            -- Judgement
            br.ui:createCheckbox(section, "审判")
            -- Holy Shock
            br.ui:createCheckbox(section, "神圣震击 输出")
            -- Crusader Strike
            br.ui:createCheckbox(section, "十字军打击")
        br.ui:checkSectionState(section)
        -------------------------
        ------ COOL  DOWNS ------
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, "冷却技能")
            -- Trinkets
            br.ui:createSpinner(section, "饰品 1",  70,  0,  100,  5,  "多少血量百分比使用") 
            br.ui:createSpinnerWithout(section, "饰品 1 目标",  3,  1,  40,  1,  "","最低多少个人才使用饰品1", true)
            br.ui:createSpinner(section, "饰品 2",  70,  0,  100,  5,  "多少血量百分比使用") 
            br.ui:createSpinnerWithout(section, "饰品 2 目标",  3,  1,  40,  1,  "","最低多少个人才使用饰品2", true)		
            -- Lay on Hands
            br.ui:createSpinner(section, "圣疗术", 20, 0, 100, 5, "","|cffFFFFFF多少血量百分比使用")
            br.ui:createDropdownWithout(section, "圣疗术 目标", {"|cffFFFFFF所有","|cffFFFFFF坦克", "|cffFFFFFF自己"}, 1, "|cffFFFFFF使用圣疗术的目标")
            -- 保护祝福
            br.ui:createSpinner(section, "保护祝福", 20, 0, 100, 5, "","|cffFFFFFF多少血量百分比使用")
            br.ui:createDropdownWithout(section, "保护祝福 目标", {"|cffFFFFFF所有","|cffFFFFFF坦克","|cffFFFFFF奶妈/DPS", "|cffFFFFFF自己"}, 3, "|cffFFFFFF使用保护祝福的目标")	
            -- 牺牲祝福
            br.ui:createSpinner(section, "牺牲祝福", 30, 0, 100, 5, "","|cffFFFFFF多少血量百分比使用")
            br.ui:createDropdownWithout(section, "牺牲祝福 目标", {"|cffFFFFFF所有","|cffFFFFFF坦克","|cffFFFFFFDPS"}, 3, "|cffFFFFFF使用牺牲祝福的目标")			
            -- Avenging Wrath
            br.ui:createSpinner(section, "复仇之怒", 50, 0, 100, 5, "","|cffFFFFFF多少血量百分比使用")
            br.ui:createSpinner(section, "复仇之怒 目标",  4,  0,  40,  1,  "","|cffFFFFFF多少目标才使用", true)			
            -- Holy Avenger
            br.ui:createSpinner(section, "神圣复仇者", 60, 0, 100, 5, "","|cffFFFFFF多少血量百分比使用")
            br.ui:createSpinner(section, "神圣复仇者 目标",  3,  0,  40,  1,  "","|cffFFFFFF多少目标才使用", true)
            -- Aura Mastery
            br.ui:createSpinner(section, "光环掌握",  50,  0,  100,  5,  "","|cffFFFFFF多少血量百分比使用")
            br.ui:createSpinner(section, "光环掌握 目标",  3,  0,  40,  1,  "","|cffFFFFFF多少目标才使用", true)
        br.ui:checkSectionState(section)
    end
    optionTable = {{
        [1] = "脚本选项",
        [2] = rotationOptions,
    }}
    return optionTable
end

----------------
--- ROTATION ---
----------------
local healing_obj = nil

local function runRotation()
    if br.timer:useTimer("debugHoly", 0.1) then --change "debugFury" to "debugSpec" (IE: debugFire)
        --Print("Running: "..rotationName)

---------------
--- Toggles --- -- List toggles here in order to update when pressed
---------------
        UpdateToggle("Rotation",0.25)
        UpdateToggle("Cooldown",0.25)
        UpdateToggle("Defensive",0.25)
        UpdateToggle("Interrupt",0.25)
        br.player.mode.cleanse = br.data.settings[br.selectedSpec].toggles["Cleanse"]
		br.player.mode.DPS = br.data.settings[br.selectedSpec].toggles["DPS"]
--------------
--- Locals ---
--------------
        local artifact                                      = br.player.artifact
        local buff                                          = br.player.buff
        local cast                                          = br.player.cast
        local combatTime                                    = getCombatTime()
        local cd                                            = br.player.cd
        local charges                                       = br.player.charges
        local debuff                                        = br.player.debuff
        local enemies                                       = enemies or {}
        local falling, swimming, flying, moving             = getFallTime(), IsSwimming(), IsFlying(), GetUnitSpeed("player")>0
        local gcd                                           = br.player.gcd
        local healPot                                       = getHealthPot()
        local inCombat                                      = br.player.inCombat
        local inInstance                                    = br.player.instance=="party"
        local inRaid                                        = br.player.instance=="raid"
        local level                                         = br.player.level
        local lowestHP                                      = br.friend[1].unit
        local lowest                                        = br.friend[1]		
        local mana                                          = br.player.powerPercentMana
        local mode                                          = br.player.mode
        local perk                                          = br.player.perk
        local php                                           = br.player.health
        local power, powmax, powgen                         = br.player.power.amount.mana, br.player.power.mana.max, br.player.power.regen
        local pullTimer                                     = br.DBM:getPulltimer()
        local race                                          = br.player.race
        local racial                                        = br.player.getRacial()
        local recharge                                      = br.player.recharge
        local spell                                         = br.player.spell
        local talent                                        = br.player.talent
        local ttm                                           = br.player.power.ttm
        local units                                         = units or {}	
        local LightCount                                    = 0
        local FaithCount                                    = 0		
		
		
		
        units.dyn5 = br.player.units(5)
        units.dyn15 = br.player.units(15)
        units.dyn30 = br.player.units(30)
        units.dyn40 = br.player.units(40)
        units.dyn30AoE = br.player.units(30,true)
        enemies.yards8 = br.player.enemies(8)
        enemies.yards10 = br.player.enemies(10)
        enemies.yards15 = br.player.enemies(15)
        enemies.yards30 = br.player.enemies(30)
        enemies.yards40 = br.player.enemies(40)

        local lowest                                        = {}    --Lowest Unit
        lowest.hp                                           = br.friend[1].hp
        lowest.role                                         = br.friend[1].role
        lowest.unit                                         = br.friend[1].unit
        lowest.range                                        = br.friend[1].range
        lowest.guid                                         = br.friend[1].guid
        local lowestTank                                    = {}    --Tank                                    
        local tHp                                           = 95
        local averageHealth                                 = 100

        if leftCombat == nil then leftCombat = GetTime() end
        if profileStop == nil then profileStop = false end

--------------------
--- Action Lists ---
--------------------
		-- 延时之力药水
			if isChecked("延时之力药水") and pullTimer <= getOptionValue("延时之力药水") then
                if pullTimer <= getOptionValue("延时之力药水") then
                    if canUse(142117) and not buff.prolongedPower.exists() then
                        useItem(142117);
                            return true
                            end
                        end
		            end		
        local function actionList_Defensive()
            if useDefensive() then
                if isChecked("药水/治疗石") and php <= getValue("药水/治疗石") and inCombat and (hasHealthPot() or hasItem(5512))
                then
                    if canUse(5512) then
                        useItem(5512)
                    elseif canUse(getHealthPot()) then
                        useItem(getHealthPot())
                    end
                end
                if isChecked("圣佑术") then
                    if php <= getOptionValue("圣佑术") and inCombat then
                        if cast.divineProtection() then return end
					elseif buff.blessingOfSacrifice.exists("player") then
					    if cast.divineProtection() then return end
                    end
                end
                if isChecked("圣盾术") then
                    if php <= getOptionValue("圣盾术") and not debuff.forbearance.exists("player") and inCombat then
                        if cast.divineShield() then return end				
                    end
				end
                    if isChecked("自由祝福") and hasNoControl("player") then
                        if cast.blessingOfFreedom("player") then return end
                    end				
			    end
		    end	
-----------------
--- Rotations ---
-----------------
        if not IsMounted() or buff.divineSteed.exists() then
            if actionList_Defensive() then return end
             -- Redemption
            if isChecked("救赎") then
                if getOptionValue("救赎") == 1 and UnitIsPlayer("target") and UnitIsDeadOrGhost("target") and UnitIsFriend("target","player") then
                    if cast.redemption("target") then return end
                end
                if getOptionValue("救赎") == 2 and UnitIsPlayer("mouseover") and UnitIsDeadOrGhost("mouseover") and UnitIsFriend("mouseover","player") then
                    if cast.redemption("mouseover") then return end
                end
            end
            if br.player.mode.cleanse == 1 then
                for i = 1, #br.friend do
                    if UnitIsPlayer(br.friend[i].unit) then
                        for n = 1,40 do
                            local buff,_,_,count,bufftype,duration = UnitDebuff(br.friend[i].unit, n)
                            if buff then
                                if bufftype == "Disease" or bufftype == "Magic" or bufftype == "Poison" then
                                    if cast.cleanse(br.friend[i].unit) then return end
                                end
                            end
                        end
                    end
                end
            end
            -- Interrupt
            if useInterrupts() then
                for i=1, #getEnemies("player",10) do
                    thisUnit = getEnemies("player",10)[i]
                    distance = getDistance(thisUnit)
                    if canInterrupt(thisUnit,getOptionValue("打断")) then
                        if distance <= 10 then
        -- Hammer of Justice
            if isChecked("制裁之锤") and GetSpellCooldown(853) == 0 then
                if cast.hammerOfJustice(thisUnit) then return end
                end
        -- Blinding Light
            if isChecked("盲目之光") and distance < 10 then
                if cast.blindingLight() then return end							
                end
            end
        end
	end	
end -- End Interrupt Check
            -- Beacon of Light on Tank
            if isChecked("圣光道标") and not talent.beaconOfVirtue then
			 if inRaid and (UnitThreatSituation("player", "target") ~= nil or (UnitExists("target") and isDummy("target"))) and UnitAffectingCombat("player") then
				local bossUnit = nil
				local bossTarget = nil				
				for v=1, #enemies.yards40 do				
                    if isBoss(enemies.yards40[v]) then
						bossUnit = enemies.yards40[v]
					end
				end								
				for i=1, #br.friend do
					local threat  = nil
					if  bossUnit ~= nil then
						threat = UnitThreatSituation(br.friend[i].unit , bossUnit)
						if threat ~= nil then
						end
					end				
					if  bossUnit ~= nil and threat ~= nil and threat >= 3 then
						if (br.friend[i].role == "TANK" or UnitGroupRolesAssigned(br.friend[i].unit) == "TANK") and UnitAffectingCombat(br.friend[i].unit) 
						and not buff.beaconOfLight.exists(br.friend[i].unit) and not buff.beaconOfFaith.exists(br.friend[i].unit) then
							CastSpellByName(GetSpellInfo(53563),br.friend[i].unit)
						end
					end
				end
			end
			    LightCount = 0
                for i=1, #br.friend do
                    if buff.beaconOfLight.exists(br.friend[i].unit) then
                        LightCount = LightCount + 1
                    end
                end				
                for i = 1, #br.friend do
				    if LightCount < 1 and not buff.beaconOfLight.exists(br.friend[i].unit) and not buff.beaconOfFaith.exists(br.friend[i].unit) and UnitGroupRolesAssigned(br.friend[i].unit) == "TANK" then
					    if cast.beaconOfLight(br.friend[i].unit) then return end
					end
				end			
		    end	
            -- Beacon of Faith on Off Tank
            if isChecked("信仰道标") and talent.beaconOfFaith then
			    FaithCount = 0
                for i=1, #br.friend do
                    if buff.beaconOfFaith.exists(br.friend[i].unit) then
                        FaithCount = FaithCount + 1
                    end
                end
				for i = 1, #br.friend do
				    if FaithCount < 1 and not buff.beaconOfLight.exists(br.friend[i].unit) and not buff.beaconOfFaith.exists(br.friend[i].unit) and UnitGroupRolesAssigned(br.friend[i].unit) == "TANK" then
					    if cast.beaconOfFaith(br.friend[i].unit) then return end
				    elseif FaithCount < 1 and not inRaid and not buff.beaconOfLight.exists(br.friend[i].unit) and not buff.beaconOfFaith.exists(br.friend[i].unit) then	
				        if cast.beaconOfFaith(br.friend[i].unit) then return end
					end
				end
			end	
            ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
            -- DPS ----------- DPS ----------- DPS ----------- DPS ----------- DPS ----------- DPS ----------- DPS ----------- DPS ----------- DPS ----------- DPS ----------- DPS -----------
            ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
            if mode.DPS == 1 and isChecked("DPS") and lowest.hp >= getValue("DPS") and not UnitIsFriend("target", "player") then
                --Consecration
                if isChecked( "奉献") and #enemies.yards8 >= getValue( "奉献") and not isMoving("player") then
                    if cast.consecration() then return end
                end
                -- Blinding Light
                if isChecked("盲目之光 输出") and #enemies.yards10 >= getOptionValue("盲目之光 输出") and inCombat then
                    if cast.blindingLight() then return end
                end
                -- Holy Prism
                if isChecked("神圣棱镜 输出") and talent.holyPrism and #enemies.yards15 >= getValue("神圣棱镜 输出") and php < 90 then
                    if cast.holyPrism(units.dyn15) then return end
                end
                -- Light's Hammer
                if isChecked("圣光之锤 输出") and talent.lightsHammer and not isMoving("player") and #enemies.yards10 >= getValue("圣光之锤 输出") then
                    if cast.lightsHammer("best",nil,1,10) then return end
                end
                -- Judgement
                if isChecked("审判") then
                    if cast.judgment(units.dyn40) then return end
                end
                -- Holy Shock
                if isChecked("神圣震击 输出") then
                    if cast.holyShock(units.dyn40) then return end
                end
                -- Crusader Strike
                if isChecked("十字军打击") and (charges.crusaderStrike == 2 or debuff.judgement.exists(units.dyn5) or (charges.crusaderStrike >= 1 and recharge.crusaderStrike < 3)) then
                    if cast.crusaderStrike(units.dyn5) then return end
                end
            end
            -- Cool downs
            if inCombat then
                ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                --Cooldowns ----- Cooldowns -----Cooldowns ----- Cooldowns ----- Cooldowns ----- Cooldowns ----- Cooldowns ----- Cooldowns ----- Cooldowns ----- Cooldowns ----- Cooldowns ----- 
                ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                -- Lay on Hands
                if isChecked("圣疗术") and GetSpellCooldown(633) == 0 then
                    if getOptionValue("圣疗术 目标") == 1 then
                        for i = 1, #br.friend do
                            if br.friend[i].hp <= getValue ("圣疗术") and not debuff.forbearance.exists(br.friend[i].unit) then
                                if isCastingSpell(spell.holyLight) then
                                    SpellStopCasting()
                                end
                                if cast.layOnHands(br.friend[i].unit) then return end
                            end
                        end
                    elseif getOptionValue("圣疗术 目标") == 2 then
                        for i = 1, #br.friend do
                            if br.friend[i].hp <= getValue ("圣疗术") and not debuff.forbearance.exists(br.friend[i].unit) and UnitGroupRolesAssigned(br.friend[i].unit) == "TANK" then
                                if cast.layOnHands(br.friend[i].unit) then return end
                            end
                        end
                    elseif getOptionValue("圣疗术 目标") == 3 then
                        if php <= getValue("圣疗术") and not debuff.forbearance.exists("player") then
                            if cast.layOnHands("player") then return end
                        end
                    end
                end
                -- 保护祝福
                if isChecked("保护祝福") and GetSpellCooldown(1022) == 0 then
                    if getOptionValue("保护祝福 目标") == 1 then
                        for i = 1, #br.friend do
                            if br.friend[i].hp <= getValue ("保护祝福") and not debuff.forbearance.exists(br.friend[i].unit) then
                                if isCastingSpell(spell.holyLight) then
                                    SpellStopCasting()
                                end
                                if cast.blessingOfProtection(br.friend[i].unit) then return end
                            end
                        end
                    elseif getOptionValue("保护祝福 目标") == 2 then
                        for i = 1, #br.friend do
                            if br.friend[i].hp <= getValue ("保护祝福") and not debuff.forbearance.exists(br.friend[i].unit) and UnitGroupRolesAssigned(br.friend[i].unit) == "TANK" then
                                if cast.blessingOfProtection(br.friend[i].unit) then return end
                            end
                        end
					elseif getOptionValue("保护祝福 目标") == 3 then
                        for i = 1, #br.friend do
                            if br.friend[i].hp <= getValue ("保护祝福") and not debuff.forbearance.exists(br.friend[i].unit) and (UnitGroupRolesAssigned(br.friend[i].unit) == "HEALER" or UnitGroupRolesAssigned(br.friend[i].unit) == "DAMAGER") then
                                if cast.blessingOfProtection(br.friend[i].unit) then return end
                            end
                        end					
                    elseif getOptionValue("保护祝福 目标") == 4 then
                        if php <= getValue("保护祝福") and not debuff.forbearance.exists("player") then
                            if cast.blessingOfProtection("player") then return end
                        end
                    end
                end
                -- 牺牲祝福
                if isChecked("牺牲祝福") and GetSpellCooldown(6940) == 0 then
                    if getOptionValue("牺牲祝福 目标") == 1 then
                        for i = 1, #br.friend do
                            if br.friend[i].hp <= getValue ("牺牲祝福") and not debuff.forbearance.exists(br.friend[i].unit) then
                                if isCastingSpell(spell.holyLight) then
                                    SpellStopCasting()
                                end
                                if cast.blessingOfSacrifice(br.friend[i].unit) then return end
                            end
                        end
                    elseif getOptionValue("牺牲祝福 目标") == 2 then
                        for i = 1, #br.friend do
                            if br.friend[i].hp <= getValue ("牺牲祝福") and not debuff.forbearance.exists(br.friend[i].unit) and UnitGroupRolesAssigned(br.friend[i].unit) == "TANK" then
                                if cast.blessingOfSacrifice(br.friend[i].unit) then return end
                            end
                        end
                    elseif getOptionValue("牺牲祝福 目标") == 3 then
                        for i = 1, #br.friend do
                            if br.friend[i].hp <= getValue ("牺牲祝福") and not debuff.forbearance.exists(br.friend[i].unit) and UnitGroupRolesAssigned(br.friend[i].unit) == "DAMAGER" then
                                if cast.blessingOfSacrifice(br.friend[i].unit) then return end
                            end
                        end						
					end
				end
            -- Trinkets
            if isChecked("饰品 1") and getLowAllies(getValue("饰品 1")) >= getValue("饰品 1 目标") then
                if canUse(13) then
                    useItem(13)
                    return true
                end
            end
            if isChecked("饰品 2") and getLowAllies(getValue("饰品 2")) >= getValue("饰品 2 目标") then
                if canUse(14) then
                    useItem(14)
                    return true
                end
            end				
				-- Flash of Light
				for i = 1, #br.friend do
				    if not isMoving("player") and br.friend[i].hp <= getValue("过量治疗取消读条") and buff.theLightSaves.exists("player") and (buff.beaconOfLight.exists(br.friend[i].unit) or buff.beaconOfFaith.exists(br.friend[i].unit)) then
                        if cast.flashOfLight(br.friend[i].unit) then
							healing_obj = br.friend[i].unit
							return
						end
					end
				end	
			    -- Divine Shield and Light of the Martyr
				if isChecked("无敌+殉道者之光") and not debuff.forbearance.exists("player") and getLowAllies(getValue"无敌+殉道者之光") >= getValue("无敌+殉道者之光 目标") then
				    if php <= 100 then
					    if cast.divineShield() then return end
					end
				end	
					for i = 1, #br.friend do
                        if br.friend[i].hp <= 100 and buff.divineShield.exists("player") and not UnitIsUnit(br.friend[i].unit,"player") then
                            if cast.lightOfTheMartyr(br.friend[i].unit) then return end
						end
					end					
				-- Rule of Law
				if isChecked("律法之则") and talent.ruleOfLaw and not buff.ruleOfLaw.exists("player") then
				    if getLowAllies(getValue"律法之则") >= getValue("律法之则 目标") then
					    if cast.ruleOfLaw() then return end
					end
				end	
                -- Tyr's Deliverance
                if isChecked("提尔的拯救") and not isMoving("player") then
                    if getLowAllies(getValue"提尔的拯救") >= getValue("提尔的拯救 目标") then
                        if cast.tyrsDeliverance() then return end
                    end
				end	
                -- Avenging Wrath
                if isChecked("复仇之怒") and not buff.auraMastery.exists("player") and GetSpellCooldown(31842) == 0 then
                    if getLowAllies(getValue"复仇之怒") >= getValue("复仇之怒 目标") then
                        if isCastingSpell(spell.holyLight) then
                            SpellStopCasting()
                        end    
                        if cast.avengingWrath() then return end
                    end
                end
                -- Holy Avenger
                if isChecked("神圣复仇者") and talent.holyAvenger then
                   if getLowAllies(getValue"神圣复仇者") >= getValue("神圣复仇者 目标") then
                        if cast.holyAvenger() then return end
                    end
                end
                -- Aura Mastery
                if isChecked("光环掌握") and not buff.avengingWrath.exists("player") then
                    if getLowAllies(getValue"光环掌握") >= getValue("光环掌握 目标") then
                        if cast.auraMastery() then return end
                    end
                end
            end
            -- Holy Prism
            if isChecked("神圣棱镜") and talent.holyPrism then
                if getLowAllies(getValue"神圣棱镜") >= getValue("神圣棱镜 目标") then
                    if cast.holyPrism(units.dyn15) then return end
                end
            end
            -- Light of Dawn
            if isChecked("黎明之光") then
                 for i = 1, #br.friend do
                    if br.friend[i].hp <= getValue("黎明之光") then
                        local lowHealthCandidates = getUnitsToHealAround(br.friend[i].unit,15,getValue("黎明之光"),#br.friend)
                        if #lowHealthCandidates >= getValue("黎明之光 目标") and getFacing("player",br.friend[i].unit) then
                            if GetSpellCooldown(85222) == 0 then
                            CastSpellByName(GetSpellInfo(85222),br.friend[i].unit)
                            end
                        end
                    end
                end
            end
            --Beacon of Virtue
            if talent.beaconOfVirtue and isChecked("美德道标") then
                for i= 1, #br.friend do
                    if not buff.beaconOfVirtue.exists(br.friend[i].unit)  then
                        local lowHealthCandidates = getUnitsToHealAround(br.friend[i].unit,30,getValue("美德道标"),#br.friend)
                        if #lowHealthCandidates >= getValue("美德道标 目标") then
                            if cast.beaconOfVirtue(br.friend[i].unit) then return end
                        end
                    end
                end
            end			
			-- Light's Hammer
            if (SpecificToggle("圣光之锤快捷键") and not GetCurrentKeyBoardFocus()) then
                    CastSpellByName(GetSpellInfo(spell.lightsHammer),"cursor")
                    return
                end			
			if isChecked("圣光之锤") and talent.lightsHammer and not isMoving("player") then
			    if getLowAllies(getValue("圣光之锤")) >= getValue("圣光之锤 目标") then
				    if castGroundAtBestLocation(spell.lightsHammer, 20, 0, 40, 0, "heal") then return end
				end
			end	
            -- Bestow Faith
            if isChecked("赋予信仰") and talent.bestowFaith then
                if getOptionValue("赋予信仰 目标") == 1 then
                    for i = 1, #br.friend do
                        if br.friend[i].hp <= getValue ("赋予信仰") then
                            if cast.bestowFaith(br.friend[i].unit) then return end
                        end
                    end
                elseif getOptionValue("赋予信仰 目标") == 2 then
                    for i = 1, #br.friend do
                        if br.friend[i].hp <= getValue ("赋予信仰") and UnitGroupRolesAssigned(br.friend[i].unit) == "TANK" then
                            if cast.bestowFaith(br.friend[i].unit) then return end
                        end
                    end
				elseif 	getOptionValue("赋予信仰 目标") == 3 then
				    for i = 1, #br.friend do
					    if br.friend[i].hp <= getValue ("赋予信仰") then
						    if cast.bestowFaith("player") then return end
						end
						if br.friend[i].hp <= getValue ("赋予信仰") and php >= getOptionValue("殉道者之光 自身血量限制") and buff.bestowFaith.exists("player") and not UnitIsUnit(br.friend[i].unit,"player") then
						    if cast.lightOfTheMartyr(br.friend[i].unit) then return end
						end	
					end
				end
			end	
            -- Judgement
			if not UnitIsFriend("target", "player") and inCombat then
			    if talent.judgmentOfLight and not debuff.judgmentoflight.exists(units.dyn40) then
				    if cast.judgment(units.dyn40) then return end
                elseif talent.fistOfJustice and GetSpellCooldown(853) > 0 then
                    if cast.judgment(units.dyn40) then return end
				end
			end	
			-- Crusader Strike
            if talent.crusadersMight and GetSpellCooldown(20473) > 1 and not UnitIsFriend("target", "player") and inCombat then
                if cast.crusaderStrike(units.dyn5) then return end
            end				
            -- Holy Shock		
            if isChecked("神圣震击") then
                for i = 1, #br.friend do
				    if isChecked("紧急治疗") and br.friend[i].hp <= getValue("紧急治疗") then
                        if cast.holyShock(br.friend[i].unit) then return end
				    elseif inRaid and php <= 80 and not buff.beaconOfLight.exists("player") and not buff.beaconOfFaith.exists("player") then
					    if cast.holyShock("player") then return end
				    elseif br.friend[i].hp <= getValue("神圣震击")  and not buff.beaconOfLight.exists(br.friend[i].unit) and not buff.beaconOfFaith.exists(br.friend[i].unit) then
                        if cast.holyShock(br.friend[i].unit) then return end
                    elseif br.friend[i].hp <= getValue("神圣震击") then
                        if cast.holyShock(br.friend[i].unit) then return end
                    end
                end
            end			
            -- Light of Martyr
            if isChecked("殉道者之光") and php >= getOptionValue("殉道者之光 自身血量限制") then
                for i = 1, #br.friend do
                    if br.friend[i].hp <= getValue ("殉道者之光") and not UnitIsUnit(br.friend[i].unit,"player") then
                        if cast.lightOfTheMartyr(br.friend[i].unit) then return end
                    end
                end
            end
            -- Flash of Light
            if isChecked("圣光闪现") and not isMoving("player") and (getOptionValue("圣光闪现 灌注") == 1 or (getOptionValue("圣光闪现 灌注") == 2 and buff.infusionOfLight.exists("player"))) then
                for i = 1, #br.friend do
				    if isChecked("紧急治疗") and br.friend[i].hp <= getValue("紧急治疗") then
                        if cast.flashOfLight(br.friend[i].unit) then
							healing_obj = br.friend[i].unit
							return
						end					
                    elseif br.friend[i].hp <= getValue("圣光闪现") and not buff.beaconOfLight.exists(br.friend[i].unit) and not buff.beaconOfFaith.exists(br.friend[i].unit) then
                        if cast.flashOfLight(br.friend[i].unit) then
							healing_obj = br.friend[i].unit
							return
						end
					elseif br.friend[i].hp <= getValue("圣光闪现") then
					    if cast.flashOfLight(br.friend[i].unit) then 
							healing_obj = br.friend[i].unit
							return
						end
					end	
                end
				
            end
            -- Holy Light
            if isChecked("圣光术") and not isMoving("player") and (getOptionValue("圣光术 灌注") == 1 or (getOptionValue("圣光术 灌注") == 2 and buff.infusionOfLight.exists("player") and GetSpellCooldown(20473) > 0 )) then                 
                for i = 1, #br.friend do
                    if br.friend[i].hp <= getValue("圣光术") and not buff.beaconOfLight.exists(br.friend[i].unit) and not buff.beaconOfFaith.exists(br.friend[i].unit) then
                        if cast.holyLight(br.friend[i].unit) then
							healing_obj = br.friend[i].unit
							return
						end
					elseif br.friend[i].hp <= getValue("圣光术") then
					    if cast.holyLight(br.friend[i].unit) then
							healing_obj = br.friend[i].unit
							return
						end
					end	
                end
            end
            -- Emergency Martyr Heals
            if isChecked("移动时 殉道者之光") and isMoving("player") and php >= getOptionValue("殉道者之光 自身血量限制") then
                for i = 1, #br.friend do
                    if br.friend[i].hp <= getValue("移动时 殉道者之光") and not UnitIsUnit(br.friend[i].unit,"player") then
                        if cast.lightOfTheMartyr(br.friend[i].unit) then return end
                    end
                end
            end
		    if isChecked("过量治疗取消读条") and healing_obj ~= nil then
			    if getHP(healing_obj) >= getValue("过量治疗取消读条") and (isCastingSpell(spell.flashOfLight) or isCastingSpell(spell.holyLight)) then
				    SpellStopCasting()
				    healing_obj = nil
				    Print("Cancel casting...")
			    end
		    end             
        end -- Test Mode      
    end -- End Timer
end -- End runRotation

                --if isChecked("Boss Helper") then
                  --      bossManager()
                --end
local id = 65
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation, 
})
