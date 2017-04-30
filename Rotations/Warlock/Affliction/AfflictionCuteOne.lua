local rotationName = "CuteOne"

---------------
--- Toggles ---
---------------
local function createToggles()
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "基于范围内的目标数,在单目标和多目标自动切换输出方式.", highlight = 1, icon = br.player.spell.agony},
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "使用多目标方式输出.", highlight = 0, icon = br.player.spell.corruption},
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "使用单目标方式输出.", highlight = 0, icon = br.player.spell.drainSoul},
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "禁用DPS输出", highlight = 0, icon = br.player.spell.healthFunnel}
    };
    CreateButton("Rotation",1,0)
-- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "自动使用大技能 - 只在BOSS.", highlight = 1, icon = br.player.spell.summonDoomguard},
        [2] = { mode = "On", value = 1 , overlay = "Cooldowns Enabled", tip = "不管任何目标都使用大技能.", highlight = 0, icon = br.player.spell.summonDoomguard},
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "不使用大技能.", highlight = 0, icon = br.player.spell.summonDoomguard}
    };
   	CreateButton("Cooldown",2,0)
-- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "使用保命技能.", highlight = 1, icon = br.player.spell.unendingResolve},
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "不使用保命技能.", highlight = 0, icon = br.player.spell.unendingResolve}
    };
    CreateButton("Defensive",3,0)
-- Interrupt Button
    InterruptModes = {
        [1] = { mode = "On", value = 1 , overlay = "Interrupts Enabled", tip = "使用打断.", highlight = 1, icon = br.player.spell.fear},
        [2] = { mode = "Off", value = 2 , overlay = "Interrupts Disabled", tip = "不使用打断.", highlight = 0, icon = br.player.spell.fear}
    };
    CreateButton("Interrupt",4,0)
-- Multi-Dot Button
    MultiDotModes = {
        [1] = { mode = "On", value = 1 , overlay = "Multi-Dot Only Disabled", tip = "Will use UA, Drain, and Reap.", highlight = 1, icon = br.player.spell.unstableAffliction},
        [2] = { mode = "Off", value = 2 , overlay = "Multi-Dot Only Enabled", tip = "Does not use UA, Drain, and Reap.", highlight = 0, icon = br.player.spell.corruption}
    };
    CreateButton("MultiDot",5,0)
-- SoC Button
    SeedofCorruptionModes = {
      [1] = { mode = "On", value = 1 , overlay = "Seed of Corruption Toggle Enabled", tip = "使用腐蚀之种 ", highlight = 1, icon = br.player.spell.seedOfCorruption},
      [2] = { mode = "Off", value = 2 , overlay = "Seed of Corruption Toggle Disabled", tip = "不使用腐蚀之种", highlight = 0, icon = br.player.spell.seedOfCorruption}
    };
    CreateButton("SeedofCorruption",6,0)
-- Soul Effy Button
	EffigyModes = {
      [1] = { mode = "On", value = 1 , overlay = "Effigy Toggle Enabled", tip = "使用灵魂雕像 ", highlight = 1, icon = br.player.spell.soulEffigy},
      [2] = { mode = "Off", value = 2 , overlay = "Effigy Toggle Disabled", tip = "不使用灵魂雕像", highlight = 0, icon = br.player.spell.soulEffigy}
    };
    CreateButton("Effigy",7,0)

end

---------------
--- OPTIONS ---
---------------
local function createOptions()
    local optionTable

    local function rotationOptions()
        local section
    -- General Options
        section = br.ui:createSection(br.ui.window.profile, "一般")
        -- APL
            br.ui:createDropdownWithout(section, "APL模式", {"|cffFFFFFF正式版","|cffFFFFFF测试版"}, 1, "|cffFFFFFF选择输出循环.")
        -- Dummy DPS Test
            br.ui:createSpinner(section, "DPS测试",  5,  5,  60,  5,  "|cffFFFFFF设置为所需的测试的时间（分钟）. 最小: 5 / 最大: 60 / 间隔: 5")
        -- Pre-Pull Timer
            br.ui:createSpinner(section, "Pre-Pull Timer",  2,  1,  10,  1,  "|cffFFFFFF设置为所需的启动时间 Pre-Pull (必须有DBM). 最小: 1 / 最大: 10 / 间隔: 1")
        -- Opener
            br.ui:createCheckbox(section,"Opener")
        -- Pet Management
            br.ui:createCheckbox(section, "宠物管理", "|cffFFFFFF 选择启用/禁用自动宠物管理")
        -- Summon Pet
            br.ui:createDropdownWithout(section, "召唤宠物", {"小鬼","虚空行者","地狱猎犬","魅魔","恶魔卫士", "末日守卫", "地狱火", "没有"}, 1, "|cffFFFFFF选择默认宠物召唤.")
        -- Grimoire of Service
            br.ui:createDropdownWithout(section, "侍从魔典", {"小鬼","虚空行者","地狱猎犬","魅魔","恶魔卫士","没有"}, 1, "|cffFFFFFF选择侍从魔典的宠物.")
            br.ui:createDropdownWithout(section,"侍从魔典使用方式", {"|cff00FF00任何时候","|cffFFFF00冷却技能","|cffFF0000决不"}, 1, "|cffFFFFFF选择侍从魔典的使用方式.")
        -- Artifact
            br.ui:createDropdownWithout(section,"神器技能", {"|cff00FF00任何时候","|cffFFFF00冷却技能","|cffFF0000决不"}, 1, "|cffFFFFFF何时使用神器技能.")
        -- Mana Tap
            br.ui:createSpinner(section, "生命分流 血量", 30, 0, 100, 5, "|cffFFFFFFHP限制生命分流血量将不会施放.")
        -- Multi-Dot Limit
            br.ui:createSpinnerWithout(section, "多目标 Dot限制", 5, 0, 10, 1, "|cffFFFFFF单位数量限制投放DoT")
            br.ui:createSpinnerWithout(section, "多目标 Dot血量限制", 5, 0, 10, 1, "|cffFFFFFFHP限制DoT将被投射/刷新.")
            br.ui:createSpinnerWithout(section, "痛楚 Boss血量限制", 10, 1, 20, 1, "|cffFFFFFFHP限制相对于Boss HP将施放/刷新.")
        -- Seed of Corruption units
            br.ui:createSpinnerWithout(section, "腐蚀之种 数量", 4, 3, 10, 1, "|cffFFFFFF使用腐蚀种子的敌人数量.")
		-- Wrath of Consumption
			br.ui:createCheckbox(section, "Wrath of Consumption", "|cffFFFFFF Select to enable/disable Wrath of Consumption Stacking")
        br.ui:checkSectionState(section)
    -- Cooldown Options
        section = br.ui:createSection(br.ui.window.profile, "冷却技能")
        -- Racial
            br.ui:createCheckbox(section,"种族技能")
        -- Trinkets
            br.ui:createCheckbox(section,"饰品")
        -- Soul Harvest
            br.ui:createSpinner(section,"灵魂收割", 2, 1, 5, 1, "|cffFFFFFF Minimal Agony DoTs to cast Soul Harvest")
        -- Summon Doomguard
            br.ui:createCheckbox(section,"召唤末日守卫")
        -- Summon Infernal
            br.ui:createCheckbox(section,"召唤地狱火")
        br.ui:checkSectionState(section)
    -- Defensive Options
        section = br.ui:createSection(br.ui.window.profile, "保命")
        -- Healthstone
            br.ui:createSpinner(section, "药水/治疗石",  60,  0,  100,  5,  "|cffFFFFFF百分几血量使用")
        -- Heirloom Neck
            br.ui:createSpinner(section, "传家宝项链",  60,  0,  100,  5,  "|cffFFBB00百分几血量使用");
        -- Gift of The Naaru
            if br.player.race == "Draenei" then
                br.ui:createSpinner(section, "纳鲁的赐福",  50,  0,  100,  5,  "|cffFFFFFF百分几血量使用")
            end
        -- Dark Pact
            br.ui:createSpinner(section, "黑暗契约", 50, 0, 100, 5, "|cffFFFFFF百分几血量使用")
        -- Drain Soul
            br.ui:createSpinner(section, "吸取灵魂", 50, 0, 100, 5, "|cffFFFFFF百分几血量使用")
        -- Health Funnel
            br.ui:createSpinner(section, "生命通道", 50, 0, 100, 5, "|cffFFFFFF百分几血量使用")
        -- Unending Resolve
            br.ui:createSpinner(section, "不灭决心", 50, 0, 100, 5, "|cffFFFFFF百分几血量使用")
        br.ui:checkSectionState(section)
    -- Interrupt Options
        section = br.ui:createSection(br.ui.window.profile, "打断")
    -- Interrupt Percentage
            br.ui:createSpinner(section, "打断",  0,  0,  95,  5,  "|cffFFFFFF读条百分几打断")
        br.ui:checkSectionState(section)
    -- Toggle Key Options
        section = br.ui:createSection(br.ui.window.profile, "切换快捷键")
        -- Single/Multi Toggle
            br.ui:createDropdown(section, "Rotation Mode", br.dropOptions.Toggle,  4)
        -- Cooldown Key Toggle
            br.ui:createDropdown(section, "Cooldown Mode", br.dropOptions.Toggle,  3)
        -- Defensive Key Toggle
            br.ui:createDropdown(section, "Defensive Mode", br.dropOptions.Toggle,  6)
        -- Interrupts Key Toggle
            br.ui:createDropdown(section, "Interrupt Mode", br.dropOptions.Toggle,  6)
        -- Multi-Dot Key Toggle
            br.ui:createDropdown(section, "MultiDot Mode", br.dropOptions.Toggle,  6)
        -- Pause Toggle
            br.ui:createDropdown(section, "暂停模式", br.dropOptions.Toggle,  6)
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
local function runRotation()
    if br.timer:useTimer("debugAffliction", math.random(0.15,0.3)) then
        --Print("Running: "..rotationName)

---------------
--- Toggles ---
---------------
        UpdateToggle("Rotation",0.25)
        UpdateToggle("Cooldown",0.25)
        UpdateToggle("Defensive",0.25)
        UpdateToggle("Interrupt",0.25)
        UpdateToggle("MultiDot",0.25)
        br.player.mode.multidot = br.data.settings[br.selectedSpec].toggles["MultiDot"]
        br.player.mode.soc = br.data.settings[br.selectedSpec].toggles["SeedofCorruption"]
		br.player.mode.effigy = br.data.settings[br.selectedSpec].toggles["Effigy"]

--------------
--- Locals ---
--------------
        local addsExist                                     = false
        local addsIn                                        = 999
        local activePet                                     = br.player.pet
        local activePetId                                   = br.player.petId
        local artifact                                      = br.player.artifact
        local buff                                          = br.player.buff
        local cast                                          = br.player.cast
        local castable                                      = br.player.cast.debug
        local combatTime                                    = getCombatTime()
        local cd                                            = br.player.cd
        local charges                                       = br.player.charges
        local deadMouse                                     = UnitIsDeadOrGhost("mouseover")
        local deadtar, attacktar, hastar, playertar         = deadtar or UnitIsDeadOrGhost("target"), attacktar or UnitCanAttack("target", "player"), hastar or GetObjectExists("target"), UnitIsPlayer("target")
        local debuff                                        = br.player.debuff
        local enemies                                       = enemies or {}
        local falling, swimming, flying, moving             = getFallTime(), IsSwimming(), IsFlying(), GetUnitSpeed("player")>0
        local flaskBuff                                     = getBuffRemain("player",br.player.flask.wod.buff.agilityBig)
        local friendly                                      = friendly or UnitIsFriend("target", "player")
        local gcd                                           = br.player.gcd
        local grimoirePet                                   = getOptionValue("侍从魔典")
        local hasMouse                                      = GetObjectExists("mouseover")
        local hasteAmount                                   = GetHaste()/100
        local hasPet                                        = IsPetActive()
        local healPot                                       = getHealthPot()
        local heirloomNeck                                  = 122663 or 122664
        local inCombat                                      = br.player.inCombat
        local inInstance                                    = br.player.instance=="party"
        local inRaid                                        = br.player.instance=="raid"
        local lastSpell                                     = lastSpellCast
        local level                                         = br.player.level
        local lootDelay                                     = getOptionValue("LootDelay")
        local lowestHP                                      = br.friend[1].unit
        local manaPercent                                   = br.player.power.mana.percent
        local mode                                          = br.player.mode
        local moveIn                                        = 999
        local moving                                        = isMoving("player")
        local perk                                          = br.player.perk
        local petInfo                                       = br.player.petInfo
        local php                                           = br.player.health
        local playerMouse                                   = UnitIsPlayer("mouseover")
        local power, powmax, powgen, powerDeficit           = br.player.power.amount.mana, br.player.power.mana.max, br.player.power.regen, br.player.power.mana.deficit
        local pullTimer                                     = br.DBM:getPulltimer()
        local racial                                        = br.player.getRacial()
        local recharge                                      = br.player.recharge
        local shards                                        = br.player.power.amount.soulShards
        local summonPet                                     = getOptionValue("召唤宠物")
        local solo                                          = br.player.instance=="none"
        local spell                                         = br.player.spell
        local talent                                        = br.player.talent
        local t19_4pc                                       = TierScan("T19") >= 4
        local travelTime                                    = getDistance("target")/16
        local ttd                                           = getTTD
        local ttm                                           = br.player.power.ttm
        local units                                         = units or {}

        units.dyn40 = br.player.units(40)
        enemies.yards8t = br.player.enemies(8,br.player.units(8,true))
        enemies.yards10t = br.player.enemies(10,br.player.units(10,true))
        enemies.yards30 = br.player.enemies(30)
        enemies.yards40 = br.player.enemies(40)

        if t19_4pc then hasT19 = 1 else hasT19 = 0 end
		if leftCombat == nil then leftCombat = GetTime() end
	    if profileStop == nil or not inCombat then profileStop = false end
        if castSummonId == nil then castSummonId = 0 end
        if summonTime == nil then summonTime = 0 end
        if effigied == nil then effigied = false; effigyCount = 0 end
        if hasEquiped(144364) then reapAndSow = 1 else reapAndSow = 0 end
        if isBoss() then dotHPLimit = getOptionValue("多目标 Dot血量限制")/10 else dotHPLimit = getOptionValue("多目标 Dot血量限制") end

        -- if debuff.unstableAffliction1.exists(units.dyn40) then UA1 = 1; UA1remain = debuff.unstableAffliction1.remain(units.dyn40) else UA1 = 0; UA1remain = 0 end
        -- if debuff.unstableAffliction2.exists(units.dyn40) then UA2 = 1; UA2remain = debuff.unstableAffliction2.remain(units.dyn40) else UA2 = 0; UA2remain = 0 end
        -- if debuff.unstableAffliction3.exists(units.dyn40) then UA3 = 1; UA3remain = debuff.unstableAffliction3.remain(units.dyn40) else UA3 = 0; UA3remain = 0 end
        -- if debuff.unstableAffliction4.exists(units.dyn40) then UA4 = 1; UA4remain = debuff.unstableAffliction4.remain(units.dyn40) else UA4 = 0; UA4remain = 0 end
        -- if debuff.unstableAffliction5.exists(units.dyn40) then UA5 = 1; UA5remain = debuff.unstableAffliction5.remain(units.dyn40) else UA5 = 0; UA5remain = 0 end
        if debuff.unstableAffliction == nil then debuff.unstableAffliction = {} end
        function debuff.unstableAffliction.stack(unit)
            local uaStack = 0
            if unit == nil then unit = units.dyn40 end
            if debuff.unstableAffliction1.exists(unit,"exact") then uaStack = 1 end
            if debuff.unstableAffliction2.exists(unit,"exact") then uaStack = 2 end
            if debuff.unstableAffliction3.exists(unit,"exact") then uaStack = 3 end
            if debuff.unstableAffliction4.exists(unit,"exact") then uaStack = 4 end
            if debuff.unstableAffliction5.exists(unit,"exact") then uaStack = 5 end
            return uaStack
        end

        function debuff.unstableAffliction.remain(stack,unit)
            if unit == nil then unit = units.dyn40 end
            return debuff["unstableAffliction"..stack].remain(unit,"exact")
        end

        if sindoreiSpiteOffCD == nil then sindoreiSpiteOffCD = true end
        if buff.sindoreiSpite.exists() and sindoreiSpiteOffCD then
            sindoreiSpiteOffCD = false
            C_Timer.After(180, function()
                sindoreiSpiteOffCD = true
            end)
        end

        -- Opener Variables
        if not inCombat and not GetObjectExists("target") then
            -- DE1 = false
            -- DSB1 = false
            -- DOOM = false
            -- SDG = false
            -- GRF = false
            -- DE2 = false
            -- DSB2 = false
            -- DGL = false
            -- DE3 = false
            -- DSB3 = false
            -- DSB4 = false
            -- DSB5 = false
            -- HVST = false
            -- DRS = false
            -- HOG = false
            -- DE5 = false
            -- TKC = false
            opener = false
        end

        -- Effigy Info
        for i = 1, #enemies.yards40 do
            local thisUnit = enemies.yards40[i]
            if ObjectID(thisUnit) == 103679 then
                effigyUnit = thisUnit;
                effigied = true;
                effigyCount = 1;
                break
            end
            effigyUnit = "player";
            effigyCount = 0;
            effigied = false
        end
        if GetUnitExists(effigyUnit) and UnitIsUnit("target",effigyUnit) and not UnitIsUnit("target","player") then FocusUnit(effigyUnit); ClearTarget(); TargetUnit(units.dyn40); return end

        -- Pet Data
        if summonPet == 1 then summonId = 416 end
        if summonPet == 2 then summonId = 1860 end
        if summonPet == 3 then summonId = 417 end
        if summonPet == 4 then summonId = 1863 end
        if summonPet == 5 then summonId = 17252 end
        if summonPet == 6 then summonId = 78158 end
        if summonPet == 7 then summonId = 78217 end
        if cd.grimoireOfService == 0 or prevService == nil then prevService = "None" end

        local doomguard = false
        local infernal = false
        if br.player.petInfo ~= nil then
            for i = 1, #br.player.petInfo do
                local thisUnit = br.player.petInfo[i].id
                if thisUnit == 11859 then doomguard = true end
                if thisUnit == 89 then infernal = true end
            end
        end

        local lowestAgony = lowestAgony or "player"
        for i = 1, #enemies.yards40 do
            local thisUnit = enemies.yards40[i]
            if debuff.agony.exists(thisUnit) then
                if debuff.agony.exists(lowestAgony) then
                    agonyRemaining = debuff.agony.remain(lowestAgony)
                else
                    agonyRemaining = 40
                end
                if debuff.agony.remain(thisUnit) < agonyRemaining then
                    lowestAgony = thisUnit
                end
            end
        end
        -- Agony - Drain Soul Break
        -- agony,cycle_targets=1,if=remains<=tick_time+gcd
        if mode.rotation ~= 4 and inCombat and not (IsMounted() or IsFlying()) then
            if debuff.agony.exists(lowestAgony) and debuff.agony.remain(lowestAgony) <= 2 + gcd then
                if cast.agony(lowestAgony,"aoe") then return end
            end
            if effigied and debuff.agony.remain(effigyUnit) < 3 + gcd then
                if cast.agony(effigyUnit,"aoe") then return end
            end
            for i = 1, #enemies.yards40 do
                local thisUnit = enemies.yards40[i]
            --     if effigied and ObjectID(thisUnit) == 103679 then
            --         if debuff.agony.remain(thisUnit) < 4 + gcd then
            --             if cast.agony(thisUnit,"aoe") then return end
            --         end
            --     end
                if (debuff.agony.count() < getOptionValue("多目标 Dot限制") + effigyCount or debuff.agony.exists(thisUnit)) and getHP(thisUnit) > dotHPLimit and debuff.agony.remain(thisUnit) <= 3 + gcd
                    and isValidUnit(thisUnit) and bossHPLimit(thisUnit,getOptionValue("痛楚 Boss血量限制")) --(not inBossFight or (inBossFight and UnitHealthMax(thisUnit) > bossHPMax * (getOptionValue("痛楚 Boss血量限制") / 100)))
                then
                    if cast.agony(thisUnit,"aoe") then return end
                end
            end
        end

        -- if GetUnitExists("target") then ChatOverlay(lowestAgony) end

--------------------
--- Action Lists ---
--------------------
	-- Action List - Extras
		local function actionList_Extras()
		-- Dummy Test
			if isChecked("DPS测试") then
				if GetObjectExists("target") then
					if getCombatTime() >= (tonumber(getOptionValue("DPS测试"))*60) and isDummy() then
                        StopAttack()
                        ClearTarget()
                        if isChecked("宠物管理") then
                            PetStopAttack()
                            PetFollow()
                        end
						Print(tonumber(getOptionValue("DPS测试")) .." Minute Dummy Test Concluded - Profile Stopped")
						profileStop = true
					end
				end
			end -- End Dummy Test
		end -- End Action List - Extras
	-- Action List - Defensive
		local function actionList_Defensive()
			if useDefensive() then
		-- Pot/Stoned
                if isChecked("药水/治疗石") and php <= getOptionValue("药水/治疗石")
                    and inCombat and (hasHealthPot() or hasItem(5512))
                then
                    if canUse(5512) then
                        useItem(5512)
                    elseif canUse(healPot) then
                        useItem(healPot)
                    end
                end
        -- Heirloom Neck
                if isChecked("传家宝项链") and php <= getOptionValue("传家宝项链") then
                    if hasEquiped(heirloomNeck) then
                        if GetItemCooldown(heirloomNeck)==0 then
                            useItem(heirloomNeck)
                        end
                    end
                end
        -- Gift of the Naaru
                if isChecked("纳鲁的赐福") and php <= getOptionValue("纳鲁的赐福") and php > 0 and br.player.race == "Draenei" then
                    if castSpell("player",racial,false,false,false) then return end
                end
        -- Dark Pact
                if isChecked("黑暗契约") and php <= getOptionValue("黑暗契约") then
                    if cast.darkPact() then return end
                end
        -- Drain Soul
                if isChecked("吸取灵魂") and php <= getOptionValue("吸取灵魂") and isValidTarget("target") then
                    if cast.drainSoul() then return end
                end
        -- Health Funnel
                if isChecked("生命通道") and getHP("pet") <= getOptionValue("生命通道") and GetObjectExists("pet") == true and not UnitIsDeadOrGhost("pet") then
                    if cast.healthFunnel() then return end
                end
        -- Unending gResolve
                if isChecked("不灭决心") and php <= getOptionValue("不灭决心") and inCombat then
                    if cast.unendingResolve() then return end
                end
    		end -- End Defensive Toggle
		end -- End Action List - Defensive
	-- Action List - Interrupts
		local function actionList_Interrupts()
			if useInterrupts() and activePetId ~= nil and (activePetId == 417 or activePetId == 78158) then
                for i=1, #enemies.yards30 do
                    thisUnit = enemies.yards30[i]
                    if canInterrupt(thisUnit,getOptionValue("打断")) then
					  if activePetId == 417 then
						if cast.spellLock(thisUnit) then return end
						elseif activePetId == 78158 then
						if cast.shadowLock(thisUnit) then return end
                      end
                    end
                end
            end -- End useInterrupts check
		end -- End Action List - Interrupts
	-- Action List - Cooldowns
		local function actionList_Cooldowns()
			if useCDs() and getDistance(units.dyn40) < 40 then
        -- Trinkets
                -- use_item,slot=trinket2,if=buff.chaos_blades.up|!talent.chaos_blades.enabled
                if isChecked("饰品") then
                    -- if buff.chaosBlades or not talent.chaosBlades then
                        if canUse(13) then
                            useItem(13)
                        end
                        if canUse(14) then
                            useItem(14)
                        end
                    -- end
                end
        -- Racial: Orc Blood Fury | Troll Berserking | Blood Elf Arcane Torrent
                -- blood_fury | berserking | arcane_torrent
                if isChecked("种族技能") and (br.player.race == "Orc" or br.player.race == "Troll" or br.player.race == "BloodElf") then
                    if castSpell("player",racial,false,false,false) then return end
                end
        -- Soul Harvest
                -- soul_harvest
                if isChecked("灵魂收割") and getOptionValue("灵魂收割") >= debuff.agony.count() then
                    if cast.soulHarvest() then return end
                end
        -- Potion
                -- potion,name=deadly_grace,if=buff.soul_harvest.remain()s|target.time_to_die<=45|trinket.proc.any.react
                -- TODO
            end -- End useCDs check
        end -- End Action List - Cooldowns
    -- Action List - PreCombat
        local function actionList_PreCombat()
            -- Summon Pet
            -- summon_pet,if=!talent.grimoire_of_supremacy.enabled&(!talent.grimoire_of_sacrifice.enabled|buff.demonic_power.down)
            if isChecked("宠物管理") and not (IsFlying() or IsMounted()) and (not talent.grimoireOfSacrifice or not buff.demonicPower.exists()) and level >= 5 and br.timer:useTimer("summonPet", getCastTime(spell.summonVoidwalker) + gcd) then
                if (activePetId == 0 or activePetId ~= summonId) and (lastSpell ~= castSummonId or activePetId ~= summonId or activePetId == 0) then
                    if summonPet == 1 then
                        if isKnown(spell.summonFelImp) and (lastSpell ~= spell.summonFelImp or activePetId == 0) then
                            if cast.summonFelImp("player") then castSummonId = spell.summonFelImp; return end
                        elseif lastSpell ~= spell.summonImp then
                            if cast.summonImp("player") then castSummonId = spell.summonImp; return end
                        end
                    end
                    if summonPet == 2 and (lastSpell ~= spell.summonVoidwalker or activePetId == 0) then
                        if cast.summonVoidwalker("player") then castSummonId = spell.summonVoidwalker; return end
                    end
                    if summonPet == 3 and (lastSpell ~= spell.summonFelhunter or activePetId == 0) then
                        if cast.summonFelhunter("player") then castSummonId = spell.summonFelhunter; return end
                    end
                    if summonPet == 4 and (lastSpell ~= spell.summonSuccubus or activePetId == 0) then
                        if cast.summonSuccubus("player") then castSummonId = spell.summonSuccubus; return end
                    end
                    if summonPet == 5 and (lastSpell ~= spell.summonFelguard or activePetId == 0) then
                        if cast.summonFelguard("player") then castSummonId = spell.summonFelguard; return end
                    end
                    if summonPet == 6 and (lastSpell ~= spell.summonDoomguard or activePetId == 0) then
                        if talent.grimoireOfSupremacy then
                            if cast.summonDoomguard("player") then castSummonId = spell.summonDoomguard; return end
                        end
                    end
                    if summonPet == 7 and (lastSpell ~= spell.summonInfernal or activePetId == 0) then
                        if talent.grimoireOfSupremacy then
                            if cast.summonInfernal("player") then castSummonId = spell.summonInfernal; return end
                        end
                    end
                    if summonPet == 8 then return end
                end
            end
            if not inCombat and not (IsFlying() or IsMounted()) then
            -- Flask
                -- flask,type=whispered_pact
                -- TODO
            -- Food
                -- food,type=azshari_salad
                -- TODO
                if (not isChecked("Opener") or opener == true) then
                -- Augmentation
                    -- augmentation,type=defiled
                    -- TODO
                -- Grimoire of Sacrifice
                    -- grimoire_of_sacrifice,if=talent.grimoire_of_sacrifice.enabled
                    if talent.grimoireOfSacrifice and GetObjectExists("pet") and not UnitIsDeadOrGhost("pet") then
                        if cast.grimoireOfSacrifice() then return end
                    end
                    if useCDs() and isChecked("Pre-Pull Timer") then --and pullTimer <= getOptionValue("Pre-Pull Timer") then
                        if pullTimer <= getOptionValue("Pre-Pull Timer") - 0.5 then
                            if canUse(142117) and not buff.prolongedPower.exists() then
                                useItem(142117);
                                return true
                            end
                        end
                        if pullTimer <= getOptionValue("Pre-Pull Timer") - 0.5 then
                            if talent.soulEffigy and not effigied then
                                if not GetObjectExists("target") then
                                    TargetUnit(units.dyn40)
                                end
                                if GetObjectExists("target") then
                                    if cast.soulEffigy("target") then return end
                                end
                            end
                        end
                    end -- End Pre-Pull
                    if isValidUnit("target") and getDistance("target") < 40 and (not isChecked("Opener") or opener == true) then
                -- Life Tap
                        -- life_tap,if=talent.empowered_life_tap.enabled&!buff.empowered_life_tap.remain()s
                        if talent.empoweredLifeTap and not buff.empoweredLifeTap.exists() then
                            if cast.lifeTap() then return end
                        end
                -- Potion
                        -- potion,name=prolonged_power
                        -- TODO
                -- Pet Attack/Follow
                        if isChecked("宠物管理") and GetUnitExists("target") and not UnitAffectingCombat("pet") then
                            PetAssistMode()
                            PetAttack("target")
                        end
                -- Opening Ability
                        if cast.agony("target","aoe") then return end
                        if level < 10 then
                            if cast.shadowBolt() then return end
                        end
                    end
                end
            end -- End No Combat
        end -- End Action List - PreCombat
        local function actionList_Opener()
            if isBoss("target") and isValidUnit("target") and opener == false then
                if (isChecked("Pre-Pull Timer") and pullTimer <= getOptionValue("Pre-Pull Timer")) or not isChecked("Pre-Pull Timer") then
                        opener = true
                end
            end
        end
---------------------
--- Begin Profile ---
---------------------
    -- Profile Stop | Pause
        if not inCombat and not hastar and profileStop==true then
            profileStop = false
        elseif (inCombat and profileStop==true) or IsMounted() or IsFlying() or pause() or mode.rotation==4 then
            if not pause() and IsPetAttackActive() and isChecked("宠物管理") then
                PetStopAttack()
                PetFollow()
            end
            return true
        else
-----------------------
--- Extras Rotation ---
-----------------------
            if actionList_Extras() then return end
--------------------------
--- Defensive Rotation ---
--------------------------
            if actionList_Defensive() then return end
-----------------------
--- Opener Rotation ---
-----------------------
            if opener == false and isChecked("Opener") and isBoss("target") then
                if actionList_Opener() then return end
            end
---------------------------
--- Pre-Combat Rotation ---
---------------------------
			if actionList_PreCombat() then return end
--------------------------
--- In Combat Rotation ---
--------------------------
            if inCombat and profileStop==false and isValidUnit(units.dyn40) and getDistance(units.dyn40) < 40
                and (opener == true or not isChecked("Opener") or not isBoss("target"))
            then
    ------------------------------
    --- In Combat - Interrupts ---
    ------------------------------
                if actionList_Interrupts() then return end
    ---------------------------
    --- SimulationCraft APL ---
    ---------------------------
                if getOptionValue("APL模式") == 1 then
        -- Pet Attack
                    if isChecked("宠物管理") and UnitIsUnit("target",units.dyn40) and not UnitIsUnit("pettarget",units.dyn40) then
                        PetAttack()
                    end
        -- Reap Souls
                    -- reap_souls,if=!buff.deadwind_harvester.remains&(buff.soul_harvest.remains>5+equipped.144364*1.5&!talent.malefic_grasp.enabled&buff.active_uas.stack>1|buff.tormented_souls.react>=8|target.time_to_die<=buff.tormented_souls.react*5+equipped.144364*1.5|!talent.malefic_grasp.enabled&(trinket.proc.any.react|trinket.stacking_proc.any.react))
                    --if not buff.deadwindHarvester.exists() and (buff.soulHarvest.exists() or buff.tormentedSouls.stack() >= 8 or ttd(units.dyn40) <= buff.tormentedSouls.stack() * 5) then
                    if (getOptionValue("神器技能") == 1 or (getOptionValue("神器技能") == 2 and useCDs())) and mode.multidot == 1
                        and (buff.tormentedSouls.stack() >= 5 or (hasEquiped(144364) and buff.tormentedSouls.stack() >= 4))
                        or debuff.unstableAffliction.stack() >= 3 and buff.tormentedSouls.exists()
						and not buff.deadwindHarvester.exists() and buff.deadwindHarvester.remain() <= 5
                     then
                        if cast.reapSouls() then return end
                    end
        -- Agony
                    -- agony,cycle_targets=1,if=remains<=tick_time+gcd
                    if debuff.agony.exists(lowestAgony) and debuff.agony.remain(lowestAgony) <= 2 + gcd then
                        if cast.agony(lowestAgony,"aoe") then return end
                    end
        -- Soul Effigy
                    -- soul_effigy,if=!pet.soul_effigy.active
                    if not effigied and br.player.mode.effigy == 1 then
                        if cast.soulEffigy("target") then return end
                    end
                    if effigied then
                        for i = 1, #enemies.yards40 do
                            local thisUnit = enemies.yards40[i]
                            if ObjectID(thisUnit) == 103679 then
                                -- Agony
                                if debuff.agony.remain(thisUnit) < 2 + gcd then
                                    if cast.agony(thisUnit,"aoe") then return end
                                end
                                -- Corruption
                                if (talent.writheInAgony and debuff.corruption.remain(thisUnit) < 2 + gcd) then
                                    if cast.corruption(thisUnit,"aoe") then return end
                                end
                                -- Siphon Life
                                if (talent.writheInAgony and debuff.siphonLife.remain(thisUnit) < 2 + gcd) then
                                    if cast.siphonLife(thisUnit,"aoe") then return end
                                end
                            end
                        end
                    end
        -- Agony
                    -- agony,cycle_targets=1,if=remains<=tick_time+gcd
                    for i = 1, #enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        if (debuff.agony.count() < getOptionValue("多目标 Dot限制") + effigyCount or debuff.agony.exists(thisUnit)) and getHP(thisUnit) > dotHPLimit and debuff.agony.remain(thisUnit) <= 6.5 + gcd
                            and isValidUnit(thisUnit) and bossHPLimit(thisUnit,getOptionValue("痛楚 Boss血量限制")) --(not inBossFight or (inBossFight and UnitHealthMax(thisUnit) > bossHPMax * (getOptionValue("痛楚 Boss血量限制") / 100)))
                        then
                            if cast.agony(thisUnit,"aoe") then return end
                        end
                    end
		--Corruption (moving)
					if (moving and debuff.corruption.remain(units.dyn40) <= 4 + gcd) then
						if cast.corruption(units.dyn40,"aoe") then return end
					end					
		-- UA Priority
			-- With Reap
                    if not moving then
    					if talent.maleficGrasp and buff.deadwindHarvester.exists() and debuff.unstableAffliction.stack() < 3
                            and debuff.agony.remain("target") > 6.5
                            and (not talent.soulEffigy or debuff.agony.remain("Soul Effigy") > 6.5)
                            -- and (debuff.corruption.remain(units.dyn40) > getCastTime(spell.unstableAffliction) + 3 or talent.absoluteCorruption)
                            -- and (debuff.siphonLife.remain(units.dyn40) > getCastTime(spell.unstableAffliction) + 3 or not talent.siphonLife)
                        then
                            if cast.unstableAffliction("target","aoe") then return end
                        end
		-- Drain life
			-- With Reap
				    if not moving then
						if talent.maleficGrasp and buff.deadwindHarvester.exists() and debuff.unstableAffliction.stack() > 2
						then
						    if cast.drainSoul("target") then return end
						end
					end
		-- Service Pet
                    -- service_pet,if=dot.corruption.remain()s&dot.agony.remain()s
                    if isChecked("宠物管理") and GetObjectExists("target") and (getOptionValue("侍从魔典使用方式") == 1 or (getOptionValue("侍从魔典使用方式") == 2 and useCDs())) then
                        if debuff.corruption.exists() and debuff.agony.exists() and br.timer:useTimer("summonPet", getCastTime(spell.summonVoidwalker)+gcd) then
                            if grimoirePet == 1 and lastSpell ~= spell.grimoireImp then
                                if cast.grimoireImp("target") then prevService = "Imp"; return end
                            end
                            if grimoirePet == 2 and lastSpell ~= spell.grimoireVoidwalker then
                                if cast.grimoireVoidwalker("target") then prevService = "Voidwalker"; return end
                            end
                            if grimoirePet == 3 and lastSpell ~= spell.grimoireFelhunter then
                                if cast.grimoireFelhunter("target") then prevService = "Felhunter"; return end
                            end
                            if grimoirePet == 4 and lastSpell ~= spell.summonSuccubus then
                                if cast.grimoireSuccubus("target") then prevService = "Succubus"; return end
                            end
                            if grimoirePet == 5 and lastSpell ~= spell.summonFelguard then
                                if cast.grimoireFelguard("target") then prevService = "Felguard"; return end
                            end
                            if summonPet == 6 and lastSpell ~= spell.summonDoomguard then
                               if talent.grimoireOfSupremacy and not hasEquiped(132379) then
                                    if cast.summonDoomguard("target") then castSummonId = spell.summonDoomguard; return end
                                end
                            end
                            if summonPet == 7 and lastSpell ~= spell.summonInfernal then
                                if talent.grimoireOfSupremacy and not hasEquiped(132379) then
                                    if cast.summonInfernal("target") then castSummonId = spell.summonInfernal; return end
                                end
                            end
                            if summonPet == 8 then return end
                        end
                    end
        -- Summon Doomguard
                    -- summon_doomguard,if=!talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal<=2&(target.time_to_die>180|target.health.pct<=20|target.time_to_die<30)
                    if isChecked("宠物管理") and useCDs() and isChecked("召唤末日守卫") and lastSpell ~= spell.summonDoomguard then
                        if not talent.grimoireOfSupremacy and #enemies.yards8t <= 2
                            and (ttd(units.dyn40) > 180 or getHP(units.dyn40) <= 20 or ttd(units.dyn40) < 30 or isDummy())
                        then
                            if cast.summonDoomguard() then summonTime = GetTime(); return end
                        end
                    end
        -- Summon Infernal
                    -- summon_infernal,if=!talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal>2
                    if isChecked("宠物管理") and useCDs() and isChecked("召唤地狱火") and lastSpell ~= spell.summonInfernal then
                        if not talent.grimoireOfSupremacy and #enemies.yards8t > 2 then
                            if cast.summonInfernal() then summonTime = GetTime(); return end
                        end
                    end
        -- Summon Doomguard
                    -- summon_doomguard,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal=1&equipped.132379&!cooldown.sindorei_spite_icd.remain()s
                    if isChecked("宠物管理") and useCDs() and isChecked("召唤末日守卫") and lastSpell ~= spell.summonDoomguard then
                        if talent.grimoireOfSupremacy and #enemies.yards8t == 1 and hasEquiped(132379) and sindoreiSpiteOffCD and GetTime() > summonTime + 275 then

                            if cast.summonDoomguard() then summonTime = GetTime(); return end
                        end
                    end
        -- Summon Infernal
                    -- summon_infernal,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal>1&equipped.132379&!cooldown.sindorei_spite_icd.remain()s
                    if isChecked("宠物管理") and useCDs() and isChecked("召唤地狱火") and lastSpell ~= spell.summonInfernal then
                        if talent.grimoireOfSupremacy and #enemies.yards8t > 1 and hasEquiped(132379) and sindoreiSpiteOffCD and GetTime() > summonTime + 275 then

                            if cast.summonInfernal() then summonTime = GetTime(); return end
                        end
                    end
        -- Cooldowns
                    if actionList_Cooldowns() then return end
        -- Seed of Corruption
                   -- seed_of_corruption,if=talent.sow_the_seeds.enabled&spell_targets.seed_of_corruption>=3|spell_targets.seed_of_corruption>=4|spell_targets.seed_of_corruption=3&dot.corruption.remain()s<=cast_time+travel_time
                   if br.player.mode.soc == 1 then
                     if #enemies.yards10t >= getOptionValue("腐蚀之种 数量") or (#enemies.yards10t == getOptionValue("腐蚀之种 数量") and debuff.corruption[units.dyn40] ~= nil and debuff.corruption[units.dyn40].remain() <= getCastTime(spell.seedOfCorruption))
                     then
                    --if (mode.rotation == 1 and #enemies.yards10t >= getOptionValue("腐蚀之种 数量")) or mode.rotation == 2 then
                      if cast.seedOfCorruption() then return end
                    end
                  end
        -- Corruption
                    -- corruption,if=remains<=tick_time+gcd&(spell_targets.seed_of_corruption<3&talent.sow_the_seeds.enabled|spell_targets.seed_of_corruption<4)
                    if debuff.corruption.count() < getOptionValue("多目标 Dot限制") + effigyCount and getHP(units.dyn40) > dotHPLimit then
                        if debuff.corruption.remain(units.dyn40) <= 2 + gcd and ((#enemies.yards10t < 10 and talent.sowTheSeeds) or #enemies.yards10t < 4) then
                            if cast.corruption(units.dyn40,"aoe") then return end
                        end
                    end
                    -- corruption,cycle_targets=1,if=(talent.absolute_corruption.enabled|!talent.malefic_grasp.enabled|!talent.soul_effigy.enabled)&remains<=tick_time+gcd&(spell_targets.seed_of_corruption<3&talent.sow_the_seeds.enabled|spell_targets.seed_of_corruption<4)
                    if ((mode.rotation == 1 and #enemies.yards40 > 1) or mode.rotation == 2) then
                        for i = 1, #enemies.yards40 do
                            local thisUnit = enemies.yards40[i]
                        if debuff.corruption.count() < getOptionValue("多目标 Dot限制") + effigyCount and getHP(thisUnit) > dotHPLimit and isValidUnit(thisUnit) then
                                if (talent.absoluteCorruption or not talent.maleficGrasp or not talent.soulEffigy) and debuff.corruption.remain(thisUnit) <= 3 + gcd
                                    and ((#enemies.yards10t < 10 and talent.sowTheSeeds) or #enemies.yards10t < 4)
                                then
                                    if cast.corruption(thisUnit,"aoe") then return end
                                end
                            end
                        end
                    end
		-- Siphon Life
                    -- siphon_life,if=remains<=tick_time+gcd
                    -- siphon_life,if=remains<=tick_time+gcd&(dot.unstable_affliction_1.ticking+dot.unstable_affliction_2.ticking+dot.unstable_affliction_3.ticking+dot.unstable_affliction_4.ticking+dot.unstable_affliction_5.ticking)<2
                    if debuff.siphonLife.count() < getOptionValue("多目标 Dot限制") + effigyCount and getHP(units.dyn40) > dotHPLimit then
                        if debuff.siphonLife.remain(units.dyn40) <= 2 + gcd and debuff.unstableAffliction.stack() < 1 then
                            if cast.siphonLife(units.dyn40,"aoe") then return end
                        end
                    end
                    -- siphon_life,cycle_targets=1,if=(!talent.malefic_grasp.enabled||!talent.soul_effigy.enabled)&remains<=tick_time+gcd
                    if ((mode.rotation == 1 and #enemies.yards40 > 1) or mode.rotation == 2) then
                        for i = 1, #enemies.yards40 do
                            local thisUnit = enemies.yards40[i]
                        if debuff.siphonLife.count() < getOptionValue("多目标 Dot限制") + effigyCount and getHP(thisUnit) > dotHPLimit and isValidUnit(thisUnit) then
                                if (not talent.maleficGrasp or not talent.soulEffigy) and debuff.siphonLife.remain(thisUnit) <= 2 + gcd then
                                    if cast.siphonLife(thisUnit,"aoe") then return end
                                end
                            end
                        end
                    end
        -- Life Tap
                    -- life_tap,if=talent.empowered_life_tap.enabled&buff.empowered_life_tap.remain()s<=gcd
                    if talent.empoweredLifeTap and buff.empoweredLifeTap.remain() <= gcd then
                        if cast.lifeTap() then return end
                    end
        -- Phantom Singularity
                    -- phantom_singularity
                    if castable.phantomSingularity then
                        if cast.phantomSingularity() then return end
                    end
        -- Haunt
                    -- haunt
                    if castable.haunt then
                        if cast.haunt() then return end
                    end
        -- Agony
                    for i = 1, #enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        if debuff.agony.count() < getOptionValue("多目标 Dot限制") + effigyCount and getHP(thisUnit) > dotHPLimit and isValidUnit(thisUnit)
                            and bossHPLimit(thisUnit,getOptionValue("痛楚 Boss血量限制")) --(not inBossFight or (inBossFight and UnitHealthMax(thisUnit) > bossHPMax * (getOptionValue("痛楚 Boss血量限制") / 100)))
                        then
                            -- agony,cycle_targets=1,if=!talent.malefic_grasp.enabled&remains<=duration*0.3&target.time_to_die>=remains
                            if not talent.maleficGrasp and debuff.agony.refresh(thisUnit) and ttd(thisUnit) >= debuff.agony.remain(thisUnit) then
                                if cast.agony(thisUnit,"aoe") then return end
                            end
                            -- agony,cycle_targets=1,if=remains<=duration*0.3&target.time_to_die>=remains&(dot.unstable_affliction_1.ticking+dot.unstable_affliction_2.ticking+dot.unstable_affliction_3.ticking+dot.unstable_affliction_4.ticking+dot.unstable_affliction_5.ticking)=0
                            if debuff.agony.refresh() and ttd(thisUnit) >= debuff.agony.remain() and debuff.unstableAffliction.stack() == 0 then --(ua1count + ua2count + ua3count + ua4count + ua5count) == 0 then
                                if cast.agony(thisUnit,"aoe") then return end
                            end
                        end
                    end
        -- Life Tap
                    -- life_tap,if=talent.empowered_life_tap.enabled&buff.empowered_life_tap.remain()s<duration*0.3|talent.malefic_grasp.enabled&target.time_to_die>15&mana.pct<10
                    if talent.empoweredLifeTap and (buff.empoweredLifeTap.refresh() or (talent.maleficGrasp and ttd(units.dyn40) > 15 and manaPercent < 10)) then
                        if cast.lifeTap() then return end
                    end
        -- Corruption
                    if debuff.corruption.count() < getOptionValue("多目标 Dot限制") + effigyCount and getHP(units.dyn40) > dotHPLimit then
                        -- corruption,if=!talent.malefic_grasp.enabled&remains<=duration*0.3&target.time_to_die>=remains
                        if not talent.maleficGrasp and debuff.corruption.refresh(units.dyn40) and ttd(units.dyn40) >= debuff.corruption.remain(units.dyn40) then
                            if cast.corruption(units.dyn40,"aoe") then return end
                        end
                        -- corruption,if=remains<=duration*0.3&target.time_to_die>=remains&(dot.unstable_affliction_1.ticking+dot.unstable_affliction_2.ticking+dot.unstable_affliction_3.ticking+dot.unstable_affliction_4.ticking+dot.unstable_affliction_5.ticking)=0
                        if debuff.corruption.refresh(units.dyn40) and debuff.unstableAffliction.stack() == 0 then --(UA1 + UA2 + UA3 + UA4 + UA5) == 0 then
                            if cast.corruption(units.dyn40,"aoe") then return end
                        end
                    end
                    -- corruption,cycle_targets=1,if=(talent.absolute_corruption.enabled|!talent.malefic_grasp.enabled|!talent.soul_effigy.enabled)&remains<=duration*0.3&target.time_to_die>=remains
                    if ((mode.rotation == 1 and #enemies.yards40 > 1) or mode.rotation == 2) then
                        for i = 1, #enemies.yards40 do
                            local thisUnit = enemies.yards40[i]
                        if debuff.corruption.count() < getOptionValue("多目标 Dot限制") + effigyCount and getHP(thisUnit) > dotHPLimit and isValidUnit(thisUnit) then
                                if (talent.absoluteCorruption or not talent.maleficGrasp or not talent.soulEffigy) and debuff.corruption.refresh(thisUnit) and ttd(thisUnit) >= debuff.corruption.remain(thisUnit) then
                                    if cast.corruption(thisUnit,"aoe") then return end
                                end
                            end
                        end
                    end
				-- Wrath of Consumption Stacking
					if isChecked("Wrath of Consumption") and not isBoss() and not debuff.corruption.exists() 
					and (ttd(units.dyn40) < 5 and buff.wrathOfConsumption.stack() < 5) then
						if cast.corruption(units.dyn40,"aoe") then return end
					end
        -- Siphon Life
                    if debuff.siphonLife.count() < getOptionValue("多目标 Dot限制") + effigyCount and getHP(units.dyn40) > dotHPLimit then
                        -- siphon_life,if=!talent.malefic_grasp.enabled&remains<=duration*0.3&target.time_to_die>=remains
                        if not talent.maleficGrasp and debuff.siphonLife.refresh(units.dyn40) and ttd(units.dyn40) >= debuff.siphonLife.remain(units.dyn40) then
                            if cast.siphonLife(units.dyn40,"aoe") then return end
                        end
                    end
                    -- siphon_life,cycle_targets=1,if=(!talent.malefic_grasp.enabled|!talent.soul_effigy.enabled)&remains<=duration*0.3&target.time_to_die>=remains
                    if ((mode.rotation == 1 and #enemies.yards40 > 1) or mode.rotation == 2) then
                        for i = 1, #enemies.yards40 do
                            local thisUnit = enemies.yards40[i]
                        if debuff.siphonLife.count() < getOptionValue("多目标 Dot限制") + effigyCount and getHP(thisUnit) > dotHPLimit and isValidUnit(thisUnit) then
                                if isValidUnit(thisUnit) and (not talent.maleficGrasp or not talent.soulEffigy) and debuff.siphonLife.refresh(thisUnit) and ttd(thisUnit) >= debuff.siphonLife.remain(thisUnit) then
                                    if cast.siphonLife(thisUnit,"aoe") then return end
                                end
                            end
                        end
                    end
        -- Unstable Affliction
          	            -- MG UA (without Reap)
                        if talent.maleficGrasp and debuff.unstableAffliction.stack() < 3 or shards > 2
                            and debuff.agony.remain(units.dyn40) > getCastTime(spell.unstableAffliction) * 2 + 4.5
                            and (not talent.soulEffigy or debuff.agony.remain("Soul Effigy") > getCastTime(spell.unstableAffliction) * 2 + 4.5)
                            -- and (debuff.corruption.remain(units.dyn40) > getCastTime(spell.unstableAffliction) + 3 or talent.absoluteCorruption)
                            -- and (debuff.siphonLife.remain(units.dyn40) > getCastTime(spell.unstableAffliction) + 3 or not talent.siphonLife)
                        then
                            if cast.unstableAffliction(units.dyn40,"aoe") then return end
                        end
    				-- WiA UA (Reap)
                        if talent.writheInAgony and (buff.deadwindHarvester.exists() and debuff.unstableAffliction.stack() <= 5) then
    						if cast.unstableAffliction(units.dyn40,"aoe") then return end
                        end
    					-- WiA UA (without reap)
                        if talent.writheInAgony and (debuff.unstableAffliction.stack() < 3 and shards > 4 - hasT19) then
                            if cast.unstableAffliction(units.dyn40,"aoe") then return end
                        end
    		            -- MG Rotation
    		            if ((mode.rotation == 1 and #enemies.yards10t < getOptionValue("腐蚀之种 数量")) or mode.rotation == 3) and mode.multidot == 1
                            and (debuff.unstableAffliction.stack() == 0 or (debuff.unstableAffliction.stack() >= 1 and br.timer:useTimer("unstableRecast", getCastTime(spell.unstableAffliction) + gcd)))
                        then
                          	-- MG UA (without Reap)
                            if talent.maleficGrasp and debuff.unstableAffliction.stack() < 3
                                and debuff.agony.remain(units.dyn40) > getCastTime(spell.unstableAffliction) * 2 + 4.5
                                and (not talent.soulEffigy or debuff.agony.remain("Soul Effigy") > getCastTime(spell.unstableAffliction) * 3 + 4.5)
                                -- and (debuff.corruption.remain(units.dyn40) > getCastTime(spell.unstableAffliction) + 3 or talent.absoluteCorruption)
                                -- and (debuff.siphonLife.remain(units.dyn40) > getCastTime(spell.unstableAffliction) + 3 or not talent.siphonLife)
                            then
                                if cast.unstableAffliction(units.dyn40,"aoe") then return end
                            end
    				        -- reap soul UA loadup
                            if (getOptionValue("神器技能") == 1 or (getOptionValue("神器技能") == 2 and useCDs()))
                                and (buff.tormentedSouls.stack() >= 5 or (hasEquiped(144364) and buff.tormentedSouls.stack() >= 4))
                                and debuff.unstableAffliction.stack() > 2
								and not buff.deadwindHarvester.exists() and buff.deadwindHarvester.remain() <= 5
                            then
                                if cast.unstableAffliction(units.dyn40,"aoe") then return end
                            end
                            -- legendary UA multi-dot
                            if hasEquiped(132381) and debuff.unstableAffliction1.count() < 2 and ((mode.rotation == 1 and #enemies.yards40 > 2) or mode.rotation == 2) then
                                for i = 1, #enemies.yards40 do
                                    local thisUnit = enemies.yards40[i]
                                    if not UnitIsUnit(thisUnit,effigyUnit) and debuff.unstableAffliction.stack(thisUnit) < 1 then
                                        if cast.unstableAffliction(thisUnit,"aoe") then return end
                                    end
                                end
                            end
                        end
                    end
		-- Haunt for the Newbs
					if talent.haunt and (shards >= 4 - hasT19 or (debuff.haunt.exists(units.dyn40)) or (ttd(units.dyn40) < 30 and debuff.unstableAffliction.stack() < 1)) then
                        if cast.unstableAffliction(units.dyn40,"aoe") then return end
					end
		-- Reap Soul
                    if (getOptionValue("神器技能") == 1 or (getOptionValue("神器技能") == 2 and useCDs())) and mode.multidot == 1
						and (buff.tormentedSouls.stack() >= 5 or (hasEquiped(144364) and buff.tormentedSouls.stack() >= 4))
                    then
						if cast.reapSouls() then return end
					end
        -- Life Tap
                    --life_tap
                    if (manaPercent < 40 or (moving and manaPercent < 70)) and php > getOptionValue("生命分流 血量") then
                        if cast.lifeTap() then return end
                    end
        -- Drain Soul
                    -- drain_soul,chain=1,interrupt=1
                    if not isCastingSpell(spell.drainSoul,"player") and mode.multidot == 1 and not moving then
                        if not GetObjectExists("target") then TargetUnit("target") end
                        if cast.drainSoul("target") then return end
                    end
					-- WiA UA (without reap)
                    if talent.writheInAgony then
                        if not GetObjectExists("target") then TargetUnit("target") end
                        if cast.drainSoul("target") then return end
                    end
        -- Cont + SE
					if effigied then
                        for i = 1, #enemies.yards40 do
                            local thisUnit = enemies.yards40[i]
                            if ObjectID(thisUnit) == 103679 then
                                -- Corruption
                                if debuff.corruption.remain(thisUnit) < 2 + gcd then
                                    if cast.corruption(thisUnit,"aoe") then return end
                                end
                                -- Siphon Life
                                if debuff.siphonLife.remain(thisUnit) < 1 + gcd then
                                    if cast.siphonLife(thisUnit,"aoe") then return end
                                end
                            end
                        end
                    end
		
		-- Life Tap
                    --life_tap
                    if (manaPercent < 40 or (moving and manaPercent < 70)) and php > getOptionValue("生命分流 血量") then
                        if cast.lifeTap() then return end
                    end
        -- Shadow Bolt
                    if level < 13 then
                        if cast.shadowBolt() then return end
                    end
                end -- End SimC APL
    ----------------------
    --- AskMrRobot APL ---
    ----------------------
                if getOptionValue("APL模式") == 2 then
-- Pet Attack
                    if isChecked("宠物管理") and UnitIsUnit("target",units.dyn40) and not UnitIsUnit("pettarget",units.dyn40) then
                        PetAttack()
                    end
        -- Reap Souls
                    -- reap_souls,if=!buff.deadwind_harvester.remains&(buff.soul_harvest.remains>5+equipped.144364*1.5&!talent.malefic_grasp.enabled&buff.active_uas.stack>1|buff.tormented_souls.react>=8|target.time_to_die<=buff.tormented_souls.react*5+equipped.144364*1.5|!talent.malefic_grasp.enabled&(trinket.proc.any.react|trinket.stacking_proc.any.react))
                    --if not buff.deadwindHarvester.exists() and (buff.soulHarvest.exists() or buff.tormentedSouls.stack() >= 8 or ttd(units.dyn40) <= buff.tormentedSouls.stack() * 5) then
                    if (getOptionValue("神器技能") == 1 or (getOptionValue("神器技能") == 2 and useCDs())) and mode.multidot == 1
                        and (buff.tormentedSouls.stack() >= 5 or (hasEquiped(144364) and buff.tormentedSouls.stack() >= 4))
                        or debuff.unstableAffliction.stack() >= 2 and buff.tormentedSouls.exists()
						and not buff.deadwindHarvester.exists() and buff.deadwindHarvester.remain() <= 5
                     then
                        if cast.reapSouls() then return end
                    end
        -- Agony
                    -- agony,cycle_targets=1,if=remains<=tick_time+gcd
                    if debuff.agony.exists(lowestAgony) and debuff.agony.remain(lowestAgony) <= 3 + gcd then
                        if cast.agony(lowestAgony,"aoe") then return end
                    end
        -- Soul Effigy
                    -- soul_effigy,if=!pet.soul_effigy.active
                    if not effigied and br.player.mode.effigy == 1 then
                        if cast.soulEffigy("target") then return end
                    end
                    if effigied then
                        for i = 1, #enemies.yards40 do
                            local thisUnit = enemies.yards40[i]
                            if ObjectID(thisUnit) == 103679 then
                                -- Agony
                                if debuff.agony.remain(thisUnit) < 2 + gcd then
                                    if cast.agony(thisUnit,"aoe") then return end
                                end
                                -- Corruption
                                if (talent.writheInAgony and debuff.corruption.remain(thisUnit) < 2 + gcd) then
                                    if cast.corruption(thisUnit,"aoe") then return end
                                end
                                -- Siphon Life
                                if (talent.writheInAgony and debuff.siphonLife.remain(thisUnit) < 2 + gcd) then
                                    if cast.siphonLife(thisUnit,"aoe") then return end
                                end
                            end
                        end
                    end
        -- Agony
                    -- agony,cycle_targets=1,if=remains<=tick_time+gcd
                    for i = 1, #enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        if (debuff.agony.count() < getOptionValue("多目标 Dot限制") + effigyCount or debuff.agony.exists(thisUnit)) and getHP(thisUnit) > dotHPLimit and debuff.agony.remain(thisUnit) <= 6.5 + gcd
                            and isValidUnit(thisUnit) and bossHPLimit(thisUnit,getOptionValue("痛楚 Boss血量限制")) --(not inBossFight or (inBossFight and UnitHealthMax(thisUnit) > bossHPMax * (getOptionValue("痛楚 Boss血量限制") / 100)))
                        then
                            if cast.agony(thisUnit,"aoe") then return end
                        end
                    end
				-- UA Priority
				-- With Reap
                    if not moving then
    					if talent.maleficGrasp and buff.deadwindHarvester.exists() and debuff.unstableAffliction.stack() < 2
                            and debuff.agony.remain(units.dyn40) > 2                         
                        then
                            if cast.unstableAffliction("target","aoe") then return end
                        end
		-- Service Pet
                    -- service_pet,if=dot.corruption.remain()s&dot.agony.remain()s
                    if isChecked("宠物管理") and GetObjectExists("target") and (getOptionValue("侍从魔典使用方式") == 1 or (getOptionValue("侍从魔典使用方式") == 2 and useCDs())) then
                        if debuff.corruption.exists() and debuff.agony.exists() and br.timer:useTimer("summonPet", getCastTime(spell.summonVoidwalker)+gcd) then
                            if grimoirePet == 1 and lastSpell ~= spell.grimoireImp then
                                if cast.grimoireImp("target") then prevService = "Imp"; return end
                            end
                            if grimoirePet == 2 and lastSpell ~= spell.grimoireVoidwalker then
                                if cast.grimoireVoidwalker("target") then prevService = "Voidwalker"; return end
                            end
                            if grimoirePet == 3 and lastSpell ~= spell.grimoireFelhunter then
                                if cast.grimoireFelhunter("target") then prevService = "Felhunter"; return end
                            end
                            if grimoirePet == 4 and lastSpell ~= spell.summonSuccubus then
                                if cast.grimoireSuccubus("target") then prevService = "Succubus"; return end
                            end
                            if grimoirePet == 5 and lastSpell ~= spell.summonFelguard then
                                if cast.grimoireFelguard("target") then prevService = "Felguard"; return end
                            end
                            if summonPet == 6 and lastSpell ~= spell.summonDoomguard then
                               if talent.grimoireOfSupremacy and not hasEquiped(132379) then
                                    if cast.summonDoomguard("target") then castSummonId = spell.summonDoomguard; return end
                                end
                            end
                            if summonPet == 7 and lastSpell ~= spell.summonInfernal then
                                if talent.grimoireOfSupremacy and not hasEquiped(132379) then
                                    if cast.summonInfernal("target") then castSummonId = spell.summonInfernal; return end
                                end
                            end
                            if summonPet == 8 then return end
                        end
                    end
        -- Summon Doomguard
                    -- summon_doomguard,if=!talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal<=2&(target.time_to_die>180|target.health.pct<=20|target.time_to_die<30)
                    if isChecked("宠物管理") and useCDs() and isChecked("召唤末日守卫") and lastSpell ~= spell.summonDoomguard then
                        if not talent.grimoireOfSupremacy and #enemies.yards8t <= 2
                            and (ttd(units.dyn40) > 180 or getHP(units.dyn40) <= 20 or ttd(units.dyn40) < 30 or isDummy())
                        then
                            if cast.summonDoomguard() then summonTime = GetTime(); return end
                        end
                    end
        -- Summon Infernal
                    -- summon_infernal,if=!talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal>2
                    if isChecked("宠物管理") and useCDs() and isChecked("召唤地狱火") and lastSpell ~= spell.summonInfernal then
                        if not talent.grimoireOfSupremacy and #enemies.yards8t > 2 then
                            if cast.summonInfernal() then summonTime = GetTime(); return end
                        end
                    end
        -- Summon Doomguard
                    -- summon_doomguard,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal=1&equipped.132379&!cooldown.sindorei_spite_icd.remain()s
                    if isChecked("宠物管理") and useCDs() and isChecked("召唤末日守卫") and lastSpell ~= spell.summonDoomguard then
                        if talent.grimoireOfSupremacy and #enemies.yards8t == 1 and hasEquiped(132379) and sindoreiSpiteOffCD and GetTime() > summonTime + 275 then

                            if cast.summonDoomguard() then summonTime = GetTime(); return end
                        end
                    end
        -- Summon Infernal
                    -- summon_infernal,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal>1&equipped.132379&!cooldown.sindorei_spite_icd.remain()s
                    if isChecked("宠物管理") and useCDs() and isChecked("召唤地狱火") and lastSpell ~= spell.summonInfernal then
                        if talent.grimoireOfSupremacy and #enemies.yards8t > 1 and hasEquiped(132379) and sindoreiSpiteOffCD and GetTime() > summonTime + 275 then

                            if cast.summonInfernal() then summonTime = GetTime(); return end
                        end
                    end
        -- Cooldowns
                    if actionList_Cooldowns() then return end
        -- Seed of Corruption
                   -- seed_of_corruption,if=talent.sow_the_seeds.enabled&spell_targets.seed_of_corruption>=3|spell_targets.seed_of_corruption>=4|spell_targets.seed_of_corruption=3&dot.corruption.remain()s<=cast_time+travel_time
                   if br.player.mode.soc == 1 then
                     if #enemies.yards10t >= getOptionValue("腐蚀之种 数量") or (#enemies.yards10t == getOptionValue("腐蚀之种 数量") and debuff.corruption[units.dyn40] ~= nil and debuff.corruption[units.dyn40].remain() <= getCastTime(spell.seedOfCorruption))
                     then
                    --if (mode.rotation == 1 and #enemies.yards10t >= getOptionValue("腐蚀之种 数量")) or mode.rotation == 2 then
                      if cast.seedOfCorruption() then return end
                    end
                  end
        -- Corruption
                    -- corruption,if=remains<=tick_time+gcd&(spell_targets.seed_of_corruption<3&talent.sow_the_seeds.enabled|spell_targets.seed_of_corruption<4)
                    if debuff.corruption.count() < getOptionValue("多目标 Dot限制") + effigyCount and getHP(units.dyn40) > dotHPLimit then
                        if debuff.corruption.remain(units.dyn40) <= 2 + gcd and ((#enemies.yards10t < 10 and talent.sowTheSeeds) or #enemies.yards10t < 4) then
							if (debuff.corruption.remain(units.dyn40) <= 4 + gcd and moving) then
								if cast.corruption(units.dyn40,"aoe") then return end
							end
						end
                    end
                    -- corruption,cycle_targets=1,if=(talent.absolute_corruption.enabled|!talent.malefic_grasp.enabled|!talent.soul_effigy.enabled)&remains<=tick_time+gcd&(spell_targets.seed_of_corruption<3&talent.sow_the_seeds.enabled|spell_targets.seed_of_corruption<4)
                    if ((mode.rotation == 1 and #enemies.yards40 > 1) or mode.rotation == 2) then
                        for i = 1, #enemies.yards40 do
                            local thisUnit = enemies.yards40[i]
                            if debuff.corruption.count() < getOptionValue("多目标 Dot限制") + effigyCount and getHP(thisUnit) > dotHPLimit and isValidUnit(thisUnit) then
                                if (talent.absoluteCorruption or not talent.maleficGrasp or not talent.soulEffigy) and debuff.corruption.remain(thisUnit) <= 3 + gcd
                                    and ((#enemies.yards10t < 10 and talent.sowTheSeeds) or #enemies.yards10t < 4)
                                then
                                    if cast.corruption(thisUnit,"aoe") then return end
                                end
                            end
                        end
                    end
        -- Siphon Life
                    -- siphon_life,if=remains<=tick_time+gcd
                    if debuff.siphonLife.count() < getOptionValue("多目标 Dot限制") + effigyCount and getHP(units.dyn40) > dotHPLimit then
                        if debuff.siphonLife.remain(units.dyn40) <= 2 + gcd and debuff.unstableAffliction.stack() < 1 then
                            if cast.siphonLife(units.dyn40,"aoe") then return end
                        end
                    end
                    -- siphon_life,cycle_targets=1,if=(!talent.malefic_grasp.enabled||!talent.soul_effigy.enabled)&remains<=tick_time+gcd
                    if ((mode.rotation == 1 and #enemies.yards40 > 1) or mode.rotation == 2) then
                        for i = 1, #enemies.yards40 do
                            local thisUnit = enemies.yards40[i]
                            if debuff.siphonLife.count() < getOptionValue("多目标 Dot限制") + effigyCount and getHP(thisUnit) > dotHPLimit and isValidUnit(thisUnit) then
                                if (not talent.maleficGrasp or not talent.soulEffigy) and debuff.siphonLife.remain(thisUnit) <= 2 + gcd then
                                    if cast.siphonLife(thisUnit,"aoe") then return end
                                end
                            end
                        end
                    end
        -- Life Tap
                    -- life_tap,if=talent.empowered_life_tap.enabled&buff.empowered_life_tap.remain()s<=gcd
                    if talent.empoweredLifeTap and buff.empoweredLifeTap.remain() <= gcd then
                        if cast.lifeTap() then return end
                    end
        -- Phantom Singularity
                    -- phantom_singularity
                    if castable.phantomSingularity then
                        if cast.phantomSingularity() then return end
                    end
        -- Haunt
                    -- haunt
                    if castable.haunt then
                        if cast.haunt() then return end
                    end
        -- Agony
                    for i = 1, #enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        if debuff.agony.count() < getOptionValue("多目标 Dot限制") + effigyCount and getHP(thisUnit) > dotHPLimit and isValidUnit(thisUnit)
                            and bossHPLimit(thisUnit,getOptionValue("痛楚 Boss血量限制")) --(not inBossFight or (inBossFight and UnitHealthMax(thisUnit) > bossHPMax * (getOptionValue("痛楚 Boss血量限制") / 100)))
                        then
                            -- agony,cycle_targets=1,if=!talent.malefic_grasp.enabled&remains<=duration*0.3&target.time_to_die>=remains
                            if not talent.maleficGrasp and debuff.agony.refresh(thisUnit) and ttd(thisUnit) >= debuff.agony.remain(thisUnit) then
                                if cast.agony(thisUnit,"aoe") then return end
                            end
                            -- agony,cycle_targets=1,if=remains<=duration*0.3&target.time_to_die>=remains&(dot.unstable_affliction_1.ticking+dot.unstable_affliction_2.ticking+dot.unstable_affliction_3.ticking+dot.unstable_affliction_4.ticking+dot.unstable_affliction_5.ticking)=0
                            if debuff.agony.refresh() and ttd(thisUnit) >= debuff.agony.remain() and debuff.unstableAffliction.stack() == 0 then --(ua1count + ua2count + ua3count + ua4count + ua5count) == 0 then
                                if cast.agony(thisUnit,"aoe") then return end
                            end
                        end
                    end
        -- Life Tap
                    -- life_tap,if=talent.empowered_life_tap.enabled&buff.empowered_life_tap.remain()s<duration*0.3|talent.malefic_grasp.enabled&target.time_to_die>15&mana.pct<10
                    if talent.empoweredLifeTap and (buff.empoweredLifeTap.refresh() or (talent.maleficGrasp and ttd(units.dyn40) > 15 and manaPercent < 10)) then
                        if cast.lifeTap() then return end
                    end
        -- Corruption
                    if debuff.corruption.count() < getOptionValue("多目标 Dot限制") + effigyCount and getHP(units.dyn40) > dotHPLimit then
                        -- corruption,if=!talent.malefic_grasp.enabled&remains<=duration*0.3&target.time_to_die>=remains
                        if not talent.maleficGrasp and debuff.corruption.refresh(units.dyn40) and ttd(units.dyn40) >= debuff.corruption.remain(units.dyn40) then
                            if cast.corruption(units.dyn40,"aoe") then return end
                        end
                        -- corruption,if=remains<=duration*0.3&target.time_to_die>=remains&(dot.unstable_affliction_1.ticking+dot.unstable_affliction_2.ticking+dot.unstable_affliction_3.ticking+dot.unstable_affliction_4.ticking+dot.unstable_affliction_5.ticking)=0
                        if debuff.corruption.refresh(units.dyn40) and debuff.unstableAffliction.stack() == 0 then --(UA1 + UA2 + UA3 + UA4 + UA5) == 0 then
                            if cast.corruption(units.dyn40,"aoe") then return end
                        end
                    end
                    -- corruption,cycle_targets=1,if=(talent.absolute_corruption.enabled|!talent.malefic_grasp.enabled|!talent.soul_effigy.enabled)&remains<=duration*0.3&target.time_to_die>=remains
                    if ((mode.rotation == 1 and #enemies.yards40 > 1) or mode.rotation == 2) then
                        for i = 1, #enemies.yards40 do
                            local thisUnit = enemies.yards40[i]
                            if debuff.corruption.count() < getOptionValue("多目标 Dot限制") + effigyCount and getHP(thisUnit) > dotHPLimit and isValidUnit(thisUnit) then
                                if (talent.absoluteCorruption or not talent.maleficGrasp or not talent.soulEffigy) and debuff.corruption.refresh(thisUnit) and ttd(thisUnit) >= debuff.corruption.remain(thisUnit) then
                                    if cast.corruption(thisUnit,"aoe") then return end
                                end
                            end
                        end
                    end
				-- Wrath of Consumption Stacking
					if isChecked("Wrath of Consumption") and not isBoss() and not debuff.corruption.exists() 
					and (ttd(units.dyn40) < 5 and buff.wrathOfConsumption.stack() < 5) then
						if cast.corruption(units.dyn40,"aoe") then return end
					end
        -- Siphon Life
                    if debuff.siphonLife.count() < getOptionValue("多目标 Dot限制") + effigyCount and getHP(units.dyn40) > dotHPLimit then
                        -- siphon_life,if=!talent.malefic_grasp.enabled&remains<=duration*0.3&target.time_to_die>=remains
                        if not talent.maleficGrasp and debuff.siphonLife.refresh(units.dyn40) and ttd(units.dyn40) >= debuff.siphonLife.remain(units.dyn40) then
                            if cast.siphonLife(units.dyn40,"aoe") then return end
                        end
                    end
                    -- siphon_life,cycle_targets=1,if=(!talent.malefic_grasp.enabled|!talent.soul_effigy.enabled)&remains<=duration*0.3&target.time_to_die>=remains
                    if ((mode.rotation == 1 and #enemies.yards40 > 1) or mode.rotation == 2) then
                        for i = 1, #enemies.yards40 do
                            local thisUnit = enemies.yards40[i]
                            if debuff.siphonLife.count() < getOptionValue("多目标 Dot限制") + effigyCount and getHP(thisUnit) > dotHPLimit and isValidUnit(thisUnit) then
                                if isValidUnit(thisUnit) and (not talent.maleficGrasp or not talent.soulEffigy) and debuff.siphonLife.refresh(thisUnit) and ttd(thisUnit) >= debuff.siphonLife.remain(thisUnit) then
                                    if cast.siphonLife(thisUnit,"aoe") then return end
                                end
                            end
                        end
                    end
        -- Unstable Affliction
          	            -- MG UA (without Reap)
                        if talent.maleficGrasp and debuff.unstableAffliction.stack() < 2 or shards > 3
                            and debuff.agony.remain(units.dyn40) > 3
                            and (not talent.soulEffigy or debuff.agony.remain("Soul Effigy") > 2)
                        then
                            if cast.unstableAffliction(units.dyn40,"aoe") then return end
                        end
    				-- WiA UA (Reap)
                        if talent.writheInAgony and (buff.deadwindHarvester.exists() and debuff.unstableAffliction.stack() <= 5) then
    						if cast.unstableAffliction(units.dyn40,"aoe") then return end
                        end
    					-- WiA UA (without reap)
                        if talent.writheInAgony and (debuff.unstableAffliction.stack() < 3 and shards > 4 - hasT19) then
                            if cast.unstableAffliction(units.dyn40,"aoe") then return end
                        end
    		            -- MG Rotation
    		            if ((mode.rotation == 1 and #enemies.yards10t < getOptionValue("腐蚀之种 数量")) or mode.rotation == 3) and mode.multidot == 1
                            and (debuff.unstableAffliction.stack() == 0 or (debuff.unstableAffliction.stack() >= 1 and br.timer:useTimer("unstableRecast", getCastTime(spell.unstableAffliction) + gcd)))
                        then
                          	-- MG UA (without Reap)
                            if talent.maleficGrasp and debuff.unstableAffliction.stack() < 2
                                and debuff.agony.remain(units.dyn40) > getCastTime(spell.unstableAffliction) * 2 + 4.5
                                and (not talent.soulEffigy or debuff.agony.remain("Soul Effigy") > getCastTime(spell.unstableAffliction) * 3 + 4.5)
                                -- and (debuff.corruption.remain(units.dyn40) > getCastTime(spell.unstableAffliction) + 3 or talent.absoluteCorruption)
                                -- and (debuff.siphonLife.remain(units.dyn40) > getCastTime(spell.unstableAffliction) + 3 or not talent.siphonLife)
                            then
                                if cast.unstableAffliction(units.dyn40,"aoe") then return end
                            end
    				        -- reap soul UA loadup
                            if (getOptionValue("神器技能") == 1 or (getOptionValue("神器技能") == 2 and useCDs()))
                                and (buff.tormentedSouls.stack() >= 5 or (hasEquiped(144364) and buff.tormentedSouls.stack() >= 4))
                                and debuff.unstableAffliction.stack() > 1
								and not buff.deadwindHarvester.exists() and buff.deadwindHarvester.remain() <= 5
                            then
                                if cast.unstableAffliction(units.dyn40,"aoe") then return end
                            end
                            -- legendary UA multi-dot
                            if hasEquiped(132381) and debuff.unstableAffliction1.count() < 2 and ((mode.rotation == 1 and #enemies.yards40 > 2) or mode.rotation == 2) then
                                for i = 1, #enemies.yards40 do
                                    local thisUnit = enemies.yards40[i]
                                    if not UnitIsUnit(thisUnit,effigyUnit) and debuff.unstableAffliction.stack(thisUnit) < 1 then
                                        if cast.unstableAffliction(thisUnit,"aoe") then return end
                                    end
                                end
                            end
                        end
                    end
		-- Haunt for the Newbs
					if talent.haunt and (shards >= 4 - hasT19 or (debuff.haunt.exists(units.dyn40)) or (ttd(units.dyn40) < 30 and debuff.unstableAffliction.stack() < 1)) then
                        if cast.unstableAffliction(units.dyn40,"aoe") then return end
					end
		-- Reap Soul
                    if (getOptionValue("神器技能") == 1 or (getOptionValue("神器技能") == 2 and useCDs())) and mode.multidot == 1
						and (buff.tormentedSouls.stack() >= 5 or (hasEquiped(144364) and buff.tormentedSouls.stack() >= 4))
                    then
						if cast.reapSouls() then return end
					end
        -- Life Tap
                    --life_tap
                    if (manaPercent < 20 or (moving and manaPercent < 70)) and php > getOptionValue("生命分流 血量") then
                        if cast.lifeTap() then return end
                    end
        -- Drain Soul
                    -- drain_soul,chain=1,interrupt=1
                    if not isCastingSpell(spell.drainSoul,"player") and mode.multidot == 1 and not moving then
                        if not GetObjectExists("target") then TargetUnit("target") end
                        if cast.drainSoul("target") then return end
                    end
					-- WiA UA (without reap)
                    if talent.writheInAgony then
                        if not GetObjectExists("target") then TargetUnit("target") end
                        if cast.drainSoul("target") then return end
                    end
        -- Cont + SE
					if effigied then
                        for i = 1, #enemies.yards40 do
                            local thisUnit = enemies.yards40[i]
                            if ObjectID(thisUnit) == 103679 then
                                -- Corruption
                                if debuff.corruption.remain(thisUnit) < 2 + gcd then
                                    if cast.corruption(thisUnit,"aoe") then return end
                                end
                                -- Siphon Life
                                if debuff.siphonLife.remain(thisUnit) < 1 + gcd then
                                    if cast.siphonLife(thisUnit,"aoe") then return end
                                end
                            end
                        end
                    end
		
		-- Life Tap
                    --life_tap
                    if moving and (manaPercent < 20 or (moving and manaPercent < 70)) and php > getOptionValue("生命分流 血量") then
                        if cast.lifeTap() then return end
                    end
        -- Shadow Bolt
                    if level < 13 then
                        if cast.shadowBolt() then return end
                    end
                end
			end --End In Combat
		end --End Rotation Logic
    end -- End Timer
 end -- End runRotation
local id = 265
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})
