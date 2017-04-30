local rotationName = "CuteOne"

---------------
--- Toggles ---
---------------
local function createToggles()
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "基于范围内的目标数,在单目标和多目标自动切换输出方式.", highlight = 1, icon = br.player.spell.chaosBolt},
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "使用多目标方式输出.", highlight = 0, icon = br.player.spell.rainOfFire},
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "使用单目标方式输出.", highlight = 0, icon = br.player.spell.immolate},
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
            br.ui:createDropdownWithout(section, "APL模式", {"|cffFFFFFFSimC","|cffFFFFFFAMR"}, 1, "|cffFFFFFF选择输出循环.")
        -- Dummy DPS Test
            br.ui:createSpinner(section, "DPS测试",  5,  5,  60,  5,  "|cffFFFFFF设置为所需的测试的时间（分钟）. 最小: 5 / 最大: 60 / 间隔: 5")
        -- Pre-Pull Timer
            br.ui:createSpinner(section, "Pre-Pull Timer",  5,  1,  10,  1,  "|cffFFFFFF设置为所需的启动时间 Pre-Pull (必须有DBM). 最小: 1 / 最大: 10 / 间隔: 1")
        -- Opener
            br.ui:createCheckbox(section,"Opener")
        -- Artifact
            br.ui:createDropdownWithout(section,"神器技能", {"|cff00FF00任何时候","|cffFFFF00冷却技能","|cffFF0000决不"}, 1, "|cffFFFFFF何时使用神器技能.")
        -- Pet Management
            br.ui:createCheckbox(section, "宠物管理", "|cffFFFFFF Select to enable/disable auto pet management")
        -- Summon Pet
            br.ui:createDropdownWithout(section, "召唤宠物", {"小鬼","虚空行者","地狱猎犬","魅魔","恶魔卫士","没有"}, 1, "|cffFFFFFF选择默认宠物召唤.")
        -- Grimoire of Service
            br.ui:createDropdownWithout(section, "侍从魔典", {"小鬼","虚空行者","地狱猎犬","魅魔","恶魔卫士","没有"}, 1, "|cffFFFFFF选择侍从魔典的宠物.")
            br.ui:createDropdownWithout(section,"侍从魔典使用方式", {"|cff00FF00任何时候","|cffFFFF00冷却技能","|cffFF0000决不"}, 1, "|cffFFFFFF选择侍从魔典的使用方式.")
        -- Multi-Dot Limit
            br.ui:createSpinnerWithout(section, "多目标 Dot限制", 5, 0, 10, 1, "|cffFFFFFF单位数量限制投放DoT.")
            br.ui:createSpinnerWithout(section, "多目标 Dot血量限制", 5, 0, 10, 1, "|cffFFFFFFHP限制DoT将被投射/刷新.")
            br.ui:createSpinnerWithout(section, "献祭 Boss血量限制", 10, 1, 20, 1, "|cffFFFFFFHP限制相对于Boss HP将施放/刷新.")
        -- Cataclysm
            br.ui:createCheckbox(section, "大灾变")
        -- Rain of Fire
            br.ui:createSpinner(section, "火焰之雨", 3, 1, 5, 1, "|cffFFFFFF单位计数火焰之雨的最小值.")
        -- Life Tap
            br.ui:createSpinner(section, "生命分流", 30, 0, 100, 5, "|cffFFFFFFHP限制生命分流血量将不会施放.")
        -- Chaos Bolt
            br.ui:createSpinnerWithout(section, "混乱之箭 碎片", 3, 2, 5, 1, "|cffFFFFFF使用混乱之箭的碎片数量.")
        br.ui:checkSectionState(section)
    -- Cooldown Options
        section = br.ui:createSection(br.ui.window.profile, "冷却技能")
        -- Racial
            br.ui:createCheckbox(section,"种族技能")
        -- Trinkets
            br.ui:createCheckbox(section,"饰品")
        -- Soul Harvest
            br.ui:createSpinner(section,"灵魂收割", 2, 1, 5, 1, "|cffFFFFFF Minimal Immolate DoTs to cast Soul Harvest")
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
        -- Drain Life
            br.ui:createSpinner(section, "吸取生命", 50, 0, 100, 5, "|cffFFFFFF百分几血量使用")
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
    if br.timer:useTimer("debugDestruction", math.random(0.15,0.3)) then
        --Print("Running: "..rotationName)

---------------
--- Toggles ---
---------------
        UpdateToggle("Rotation",0.25)
        UpdateToggle("Cooldown",0.25)
        UpdateToggle("Defensive",0.25)
        UpdateToggle("Interrupt",0.25)

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
        local powerPercentMana                              = br.player.power.mana.percent
        local pullTimer                                     = br.DBM:getPulltimer()
        local queue                                         = br.player.queue
        local racial                                        = br.player.getRacial()
        local recharge                                      = br.player.recharge
        local shards                                        = br.player.power.amount.soulShards
        local summonPet                                     = getOptionValue("召唤宠物")
        local solo                                          = br.player.instance=="none"
        local spell                                         = br.player.spell
        local t19_4pc                                       = TierScan("T19") >= 4
        local talent                                        = br.player.talent
        local travelTime                                    = getDistance("target")/16
        local ttd                                           = getTTD
        local ttm                                           = br.player.power.ttm
        local units                                         = units or {}

        units.dyn40 = br.player.units(40)
        enemies.yards8 = br.player.enemies(8)
        enemies.yards8t = br.player.enemies(8,br.player.units(8,true))
        enemies.yards10t = br.player.enemies(10,br.player.units(10,true))
        enemies.yards30 = br.player.enemies(30)
        enemies.yards40 = br.player.enemies(40)

   		if leftCombat == nil then leftCombat = GetTime() end
	    if profileStop == nil or not inCombat then profileStop = false end
        if castSummonId == nil then castSummonId = 0 end
        if summonTime == nil then summonTime = 0 end
        if effigied == nil then effigied = false end
        if t19_4pc then hasT19 = 1 else hasT19 = 0 end
        if isBoss() then dotHPLimit = getOptionValue("多目标 Dot血量限制")/10 else dotHPLimit = getOptionValue("多目标 Dot血量限制") end

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

        -- Pet Data
        if summonPet == 1 then summonId = 416 end
        if summonPet == 2 then summonId = 1860 end
        if summonPet == 3 then summonId = 417 end
        if summonPet == 4 then summonId = 1863 end
        if summonPet == 5 then summonId = 17252 end
        if cd.grimoireOfService == 0 or prevService == nil then prevService = "没有" end

        local doomguard = false
        local infernal = false
        if br.player.petInfo ~= nil then
            for i = 1, #br.player.petInfo do
                local thisUnit = br.player.petInfo[i].id
                if thisUnit == 11859 then doomguard = true end
                if thisUnit == 89 then infernal = true end
            end
        end
        local function interruptDrain()
            if isCastingSpell(spell.drainLife,"player") or isCastingSpell(spell.drainSoul,"player") then
                MoveBackwardStart()
                MoveBackwardStop()
                return
            else
                return
            end
        end

        -- Havoc Check
        local hasHavoc
        hasHavoc = false
        if #enemies.yards40 > 0 then
            for i = 1, #enemies.yards40 do
                local thisUnit = enemies.yards40[i]
                if debuff.havoc.exists(thisUnit) then hasHavoc = true; break end
            end
        end

        -- Boss Active/Health Max
        local bossHPMax = bossHPMax or 0
        local inBossFight = inBossFight or false
        for i = 1, #enemies.yards40 do
            local thisUnit = enemies.yards40[i]
            if isBoss(thisUnit) then 
                bossHPMax = UnitHealthMax(thisUnit)
                inBossFight = true
                break 
            end
        end

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
        -- Drain Life
                if isChecked("吸取生命") and php <= getOptionValue("吸取生命") and isValidTarget("target") and not isCastingSpell(spell.drainLife) then
                    if cast.drainLife() then return end
                end
        -- Health Funnel
                if isChecked("生命通道") and getHP("pet") <= getOptionValue("生命通道") and GetObjectExists("pet") and not UnitIsDeadOrGhost("pet") then
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
                if isChecked("灵魂收割") and getOptionValue("灵魂收割") >= debuff.immolate.count() then
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
            if isChecked("宠物管理") and not (IsFlying() or IsMounted()) and not talent.grimoireOfSupremacy and (not talent.grimoireOfSacrifice or not buff.demonicPower.exists()) and br.timer:useTimer("summonPet", getCastTime(spell.summonVoidwalker) + gcd) then
                if (activePetId == 0 or activePetId ~= summonId) and (lastSpell ~= castSummonId or activePetId ~= summonId) then
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
                    if summonPet == 6 then return end
                end
            end
            if not inCombat and not (IsFlying() or IsMounted()) then
            -- Flask
                -- flask,type=whispered_pact
                -- TODO
            -- Food
                -- food,type=azshari_salad
                -- TODO
                if isChecked("宠物管理") and (not isChecked("Opener") or opener == true) then
                -- Summon Infernal
                    -- summon_infernal,if=talent.grimoire_of_supremacy.enabled&active_enemies>=3
                    if useCDs() and isChecked("召唤地狱火") then
                        if talent.grimoireOfSupremacy and #enemies.yards8 >= 3 then
                            if cast.summonInfernal() then return end
                        end
                    end
                -- Summon Doomguard
                    -- summon_doomguard,if=talent.grimoire_of_supremacy.enabled&active_enemies<3&artifact.lord_of_flames.rank=0
                    if useCDs() and isChecked("召唤末日守卫") then
                        if talent.grimoireOfSupremacy and #enemies.yards8 < 3 then
                            if cast.summonDoomguard() then return end
                        end
                    end
                -- Augmentation
                    -- augmentation,type=defiled
                    -- TODO
                -- Grimoire of Sacrifice
                    -- grimoire_of_sacrifice,if=talent.grimoire_of_sacrifice.enabled
                    if talent.grimoireOfSacrifice and GetObjectExists("pet") and not UnitIsDeadOrGhost("pet") then
                        if cast.grimoireOfSacrifice() then return end
                    end
                    if isChecked("Pre-Pull Timer") and pullTimer <= getOptionValue("Pre-Pull Timer") then

                    end -- End Pre-Pull
                    if isValidUnit("target") and getDistance("target") < 40 and (not isChecked("Opener") or opener == true) then
                -- Life Tap
                        -- life_tap,if=talent.empowered_life_tap.enabled&!buff.empowered_life_tap.remain()s
                        if isChecked("生命分流") and php > getOptionValue("生命分流") and talent.empoweredLifeTap and not buff.empoweredLifeTap.exists() then
                            if cast.lifeTap() then return end
                        end
                -- Potion
                        -- potion,name=deadly_grace
                        -- TODO
                -- Pet Attack/Follow
                        if isChecked("宠物管理") and GetUnitExists("target") and not UnitAffectingCombat("pet") then
                            PetAssistMode()
                            PetAttack("target")
                        end
                -- Chaos Bolt
                        -- chaos_bolt
                        if cast.chaosBolt("target") then return end
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
                    if isChecked("宠物管理") and not UnitIsUnit("pettarget","target") then
                        PetAttack()
                    end
        -- Havoc
                    -- havoc,target=2,if=active_enemies>1&active_enemies<6&!debuff.havoc.remain()s
                    if not hasHavoc then
                        if ((mode.rotation == 1 and #enemies.yards40 > 1) or mode.rotation == 2) and #enemies.yards40 < 6 then
                            for i = 1, #enemies.yards40 do
                                local thisUnit = enemies.yards40[i]
                                if not UnitIsUnit(thisUnit,"target") and isValidUnit(thisUnit) and (not GetUnitExists("focus") or (GetUnitExists("focus") and UnitIsUnit(thisUnit,"focus"))) then
                                    if not debuff.havoc.exists(thisUnit) then
                                        if cast.havoc(thisUnit,"aoe") then return end
                                    end
                                end
                            end
                        end
                    end
        -- Dimensional Rift
                    -- dimensional_rift,if=charges=3
                    if getOptionValue("神器技能") == 1 or (getOptionValue("神器技能") == 2 and useCDs()) then
                        if charges.dimensionalRift == 3 then
                            if cast.dimensionalRift() then return end
                        end
                    end
        -- Immolate
                    -- immolate,if=remains<=tick_time
                    if debuff.immolate.remain(units.dyn40) <= 3 
                        and debuff.immolate.count() < getOptionValue("多目标 Dot限制") and getHP(units.dyn40) > dotHPLimit 
                        and (not inBossFight or (inBossFight and UnitHealthMax(units.dyn40) > bossHPMax * (getOptionValue("献祭 Boss血量限制") / 100)))
                    then
                        if cast.immolate(units.dyn40) then return end
                    end
                    -- immolate,cycle_targets=1,if=active_enemies>1&remains<=tick_time&(!talent.roaring_blaze.enabled|(!debuff.roaring_blaze.remain()s&action.conflagrate.charges<2))
                    if (mode.rotation == 1 and #enemies.yards10t > 1) or mode.rotation == 2 then
                        for i = 1, #enemies.yards10t do
                            local thisUnit = enemies.yards10t[i]
                            if isValidUnit(thisUnit) and debuff.immolate.count() < getOptionValue("多目标 Dot限制") and getHP(thisUnit) > dotHPLimit 
                                and (not inBossFight or (inBossFight and UnitHealthMax(thisUnit) > bossHPMax * (getOptionValue("献祭 Boss血量限制") / 100)))
                            then
                                if debuff.immolate.remain(thisUnit) <= 3 and (not talent.roaringBlaze or (not debuff.roaringBlaze.exists(thisUnit) and charges.conflagrate < 2)) then
                                    if cast.immolate(thisUnit) then return end
                                end
                            end
                        end
                    end
                    -- immolate,if=talent.roaring_blaze.enabled&remains<=duration&!debuff.roaring_blaze.remain()s&target.time_to_die>10&(action.conflagrate.charges=2+set_bonus.tier19_4pc|(action.conflagrate.charges>=1+set_bonus.tier19_4pc&action.conflagrate.recharge_time<cast_time+gcd)|target.time_to_die<24
                    if talent.roaringBlaze and debuff.immolate.remain(units.dyn40) <= 18 --[[debuff.immolate.duration(units.dyn40) * 0.7 ]]and not debuff.roaringBlaze.exists(units.dyn40)
                        and ttd(units.dyn40) > 10 and (charges.conflagrate == 2 + hasT19 or (charges.conflagrate >= 1 and recharge.conflagrate < getCastTime(spell.conflagrate) + gcd) or ttd(units.dyn40) < 24)
                        and debuff.immolate.count() < getOptionValue("多目标 Dot限制") and getHP(units.dyn40) > dotHPLimit
                        and (not inBossFight or (inBossFight and UnitHealthMax(units.dyn40) > bossHPMax * (getOptionValue("献祭 Boss血量限制") / 100))) 
                    then
                        if cast.immolate(units.dyn40) then return end
                    end
        -- Racial: Orc Blood Fury | Troll Berserking | Blood Elf Arcane Torrent
                    -- blood_fury | berserking | arcane_torrent
                    if useCDs() and isChecked("种族技能") and (br.player.race == "Orc" or br.player.race == "Troll" or br.player.race == "BloodElf") then
                        if castSpell("player",racial,false,false,false) then return end
                    end
        -- Potion
                    -- potion,name=deadly_grace,if=(buff.soul_harvest.remain()s|trinket.proc.any.react|target.time_to_die<=45)
                    -- TODO
        -- Shadowburn
                    -- shadowburn,if=buff.conflagration_of_chaos.remain()s<=action.chaos_bolt.cast_time
                    if buff.conflagrationOfChaos.remain() <= getCastTime(spell.chaosBolt) then
                        if cast.shadowburn(units.dyn40) then return end
                    end
                    -- shadowburn,if=(charges=1&recharge_time<action.chaos_bolt.cast_time|charges=2)&soul_shard<5
                    if ((charges.shadowburn == 1 and recharge.shadowburn < getCastTime(spell.chaosBolt)) or charges.shadowburn == 2) and shards < 5 then
                        if cast.shadowburn(units.dyn40) then return end
                    end
        -- Conflagrate
                    -- conflagrate,if=talent.roaring_blaze.enabled&(charges=2+set_bonus.tier19_4pc|(charges>=1+set_bonus.tier19_4pc&recharge_time<gcd)|target.time_to_die<24)
                    if talent.roaringBlaze and (charges.conflagrate == 2 + hasT19 or (charges.conflagrate >= 1 + hasT19 and recharge.conflagrate < gcd) or ttd(units.dyn40) < 24) then
                        if cast.conflagrate(units.dyn40) then return end
                    end
                    -- conflagrate,if=talent.roaring_blaze.enabled&debuff.roaring_blaze.stack()>0&dot.immolate.remain()s>dot.immolate.duration()*0.3&(active_enemies=1|soul_shard<3)&soul_shard<5
                    if talent.roaringBlaze and debuff.roaringBlaze.stack(units.dyn40) > 0 and debuff.immolate.refresh(units.dyn40) and (#enemies.yards40 == 1 or shards < 3) and shards < 5 then
                        if cast.conflagrate(units.dyn40) then return end
                    end
                    -- conflagrate,if=!talent.roaring_blaze.enabled&!buff.backdraft.remain()s&buff.conflagration_of_chaos.remain()s<=action.chaos_bolt.cast_time
                    if not talent.roaringBlaze and not buff.backdraft.exists() and buff.conflagrationOfChaos.remain() <= getCastTime(spell.chaosBolt) then
                        if cast.conflagrate(units.dyn40) then return end
                    end
                    -- conflagrate,if=!talent.roaring_blaze.enabled&!buff.backdraft.remain()s&(charges=1&recharge_time<action.chaos_bolt.cast_time|charges=2)&soul_shard<5
                    if not talent.roaringBlaze and not buff.backdraft.exists() and ((charges.conflagrate == 1 and recharge.conflagrate < getCastTime(spell.chaosBolt)) or charges.conflagrate == 2) and shards < 5 then
                        if cast.conflagrate(units.dyn40) then return end
                    end
        -- Life Tap
                    -- life_tap,if=talent.empowered_life_tap.enabled&buff.empowered_life_tap.remain()s<=gcd
                    if isChecked("生命分流") and php > getOptionValue("生命分流") and talent.empoweredLifeTap and buff.empoweredLifeTap.remain() <= gcd then
                        if cast.lifeTap() then return end
                    end
        -- Dimensional Rift
                    -- dimensional_rift,if=equipped.144369&!buff.lessons_of_spacetime.remain()s&((!talent.grimoire_of_supremacy.enabled&!cooldown.summon_doomguard.remain()s)|(talent.grimoire_of_service.enabled&!cooldown.service_pet.remain()s)|(talent.soul_harvest.enabled&!cooldown.soul_harvest.remain()s))
                    if hasEquiped(144369) and not buff.lessonsOfSpaceTime.exists()
                        and ((not talent.grimoireOfSupremacy and cd.summonDoomguard > 0) or (not talent.grimoireOfService and cd.grimoireVoidwalker > 0) or (talent.soulHarvest and cd.soulHarvest > 0))
                    then
                        if cast.dimensionalRift() then return end
                    end
        -- Service Pet
                    -- service_pet
                    if isChecked("宠物管理") and GetObjectExists(units.dyn40) and (getOptionValue("侍从魔典使用方式") == 1 or (getOptionValue("侍从魔典使用方式") == 2 and useCDs())) then
                        if br.timer:useTimer("castGrim", gcd) then
                            if grimoirePet == 1 then
                                if cast.grimoireImp("target") then prevService = "Imp"; return end
                            end
                            if grimoirePet == 2 then
                                if cast.grimoireVoidwalker("target") then prevService = "Voidwalker"; return end
                            end
                            if grimoirePet == 3 then
                                if cast.grimoireFelhunter("target") then prevService = "Felhunter"; return end
                            end
                            if grimoirePet == 4 then
                                if cast.grimoireSuccubus("target") then prevService = "Succubus"; return end
                            end
                            if grimoirePet == 5 then
                                if cast.grimoireFelguard("target") then prevService = "Felguard"; return end
                            end
                            if grimoirePet == 6 then return end
                        end
                    end
        -- Summon Infernal
                    -- summon_infernal,if=artifact.lord_of_flames.rank>0&!buff.lord_of_flames.remain()s
                    if isChecked("宠物管理") and useCDs() and isChecked("召唤地狱火") then
                        if artifact.lordOfFlames and not buff.lordOfFlames.exists() then
                            if cast.summonInfernal() then return end
                        end
                    end
        -- Summon Doomguard
                    -- summon_doomguard,if=!talent.grimoire_of_supremacy.enabled&spell_targets.infernal_awakening<=2&(target.time_to_die>180|target.health.pct<=20|target.time_to_die<30)
                    if isChecked("宠物管理") and useCDs() and isChecked("召唤末日守卫") then
                        if not talent.grimoireOfSupremacy and #enemies.yards8 <= 2
                            and (ttd(units.dyn40) > 180 or getHP(units.dyn40) <= 20 or ttd(units.dyn40) < 30)
                        then
                            if cast.summonDoomguard() then return end
                        end
                    end
        -- Summon Infernal
                    -- summon_infernal,if=!talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal>2
                    if isChecked("宠物管理") and useCDs() and isChecked("召唤地狱火") then
                        if not talent.grimoireOfSupremacy and #enemies.yards8 > 2 then
                            if cast.summonInfernal() then return end
                        end
                    end
        -- Summon Doomguard
                    -- summon_doomguard,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal=1&artifact.lord_of_flames.rank>0&buff.lord_of_flames.remain()s&!pet.doomguard.active
                    if isChecked("宠物管理") and talent.grimoireOfSupremacy and #enemies.yards8 < 3 and artifact.lordOfFlames and buff.lordOfFlames.exists() then
                        if cast.summonDoomguard() then return end
                    end
        -- Summon Doomguard
                    -- summon_doomguard,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal<3&equipped.132379&!cooldown.sindorei_spite_icd.remain()s
                    if isChecked("宠物管理") and useCDs() and isChecked("召唤末日守卫") then
                        if talent.grimoireOfSupremacy and #enemies.yards8 < 3 and hasEquiped(132379) and GetTime() > summonTime + 275 then
                            interruptDrain()
                            if cast.summonDoomguard() then summonTime = GetTime(); return end
                        end
                    end
        -- Summon Infernal
                    -- summon_infernal,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal>=3&equipped.132379&!cooldown.sindorei_spite_icd.remain()s
                    if isChecked("宠物管理") and useCDs() and isChecked("召唤地狱火") then
                        if talent.grimoireOfSupremacy and #enemies.yards8 >= 3 and hasEquiped(132379) and GetTime() > summonTime + 275 then
                            interruptDrain()
                            if cast.summonInfernal() then summonTime = GetTime(); return end
                        end
                    end
        -- Cooldowns
                    if actionList_Cooldowns() then return end
        -- Channel Demonfire
                    -- channel_demonfire,if=dot.immolate.remain()s>cast_time
                    if debuff.immolate.remain(units.dyn40) > getCastTime(spell.immolate) then
                        if cast.channelDemonfire() then return end
                    end
        -- Havoc
                    -- havoc,if=active_enemies=1&talent.wreak_havoc.enabled&equipped.132375&!debuff.havoc.remain()s
                    if not hasHavoc then
                        if #enemies.yards40 == 1 and talent.wreakHavoc and hasEquiped(132375) and not debuff.havoc.exists(units.dyn40) then
                            if cast.havoc(units.dyn40,"aoe") then return end
                        end
                    end
        -- Rain of Fire
                    if isChecked("火焰之雨") then
                        -- rain_of_fire,if=active_enemies>=3&cooldown.havoc.remain()s<=12&!talent.wreak_havoc.enabled
                        if ((mode.rotation == 1 and #enemies.yards8t >= getOptionValue("火焰之雨")) or mode.rotation == 2) and cd.havoc <= 12 and not talent.wreakHavoc then
                            if cast.rainOfFire(units.dyn40,"ground") then return end
                        end
                        -- rain_of_fire,if=active_enemies>=6&talent.wreak_havoc.enabled
                        if ((mode.rotation == 1 and #enemies.yards8t >= getOptionValue("火焰之雨") + 3) or mode.rotation == 2) and talent.wreakHavoc then
                            if cast.rainOfFire(units.dyn40,"ground") then return end
                        end
                    end 
        -- Dimensional Rift
                    -- dimensional_rift,if=!equipped.144369|charges>1|((!talent.grimoire_of_service.enabled|recharge_time<cooldown.service_pet.remain()s)&(!talent.soul_harvest.enabled|recharge_time<cooldown.soul_harvest.remain()s)&(!talent.grimoire_of_supremacy.enabled|recharge_time<cooldown.summon_doomguard.remain()s))
                    if getOptionValue("神器技能") == 1 or (getOptionValue("神器技能") == 2 and useCDs()) then
                        if not hasEquiped(144369) or charges.dimensionalRift > 1 or ((not talent.grimoireOfSacrifice or recharge.dimensionalRift < cd.grimoireVoidwalker) and (not talent.soulHarvest or recharge.dimensionalRift < cd.soulHarvest) and (not talent.grimoireOfSupremacy or recharge.dimensionalRift < cd.summonDoomguard)) then
                            if cast.dimensionalRift() then return end
                        end
                    end
        -- Life Tap
                    -- life_tap,if=talent.empowered_life_tap.enabled&buff.empowered_life_tap.remain()s<duration*0.3
                    if isChecked("生命分流") and php > getOptionValue("生命分流") and talent.empoweredLifeTap and buff.empoweredLifeTap.refresh() then
                        if cast.lifeTap() then return end
                    end
        -- Cataclysm
                    -- cataclysm
                    if isChecked("大灾变") then
                        if cast.cataclysm("best",nil,4,8) then return end
                    end
        -- Chaos Bolt
                    if shards >= getOptionValue("混乱之箭 碎片") then
                        if cast.chaosBolt() then return end
                    end
                    -- chaos_bolt,if=(cooldown.havoc.remains>12&cooldown.havoc.remains|active_enemies<3|talent.wreak_havoc.enabled&active_enemies<6)
                    if ((mode.rotation == 1 and ((cd.havoc > 12 and cd.havoc > 0) or #enemies.yards40 < 3 or (talent.wreakHavoc and #enemies.yards40 < 6))) or mode.rotation == 3) and shards >= getOptionValue("混乱之箭 碎片") then
                        if cast.chaosBolt() then return end
                    end
        -- Shadowburn
                    -- shadowburn
                    if cast.shadowburn() then return end
        -- Conflagrate
                    -- conflagrate,if=!talent.roaring_blaze.enabled&!buff.backdraft.remain()s
                    if not talent.roaringBlaze and not buff.backdraft.exists() then
                        if cast.conflagrate() then return end
                    end
        -- Immolate
                    -- immolate,if=!talent.roaring_blaze.enabled&remains<=duration*0.3
                    if not talent.roaringBlaze and debuff.immolate.refresh(units.dyn40) and debuff.immolate.count() < getOptionValue("多目标 Dot限制") and getHP(units.dyn40) > dotHPLimit 
                        and (not inBossFight or (inBossFight and UnitHealthMax(units.dyn40) > bossHPMax * (getOptionValue("献祭 Boss血量限制") / 100)))
                    then
                        if cast.immolate(units.dyn40) then return end
                    end
        -- Incinerate
                    -- incinerate
                    if cast.incinerate() then return end
        -- Life Tap
                    -- life_tap
                    if isChecked("生命分流") and php > getOptionValue("生命分流") then
                        if cast.lifeTap() then return end
                    end
                end -- End SimC APL
    ----------------------
    --- AskMrRobot APL ---
    ----------------------
                if getOptionValue("APL模式") == 2 then

                end
			end --End In Combat
		end --End Rotation Logic
    end -- End Timer
end -- End runRotation
local id = 267
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})
