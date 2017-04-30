local rotationName = "CuteOne"

---------------
--- Toggles ---
---------------
local function createToggles()
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "基于范围内的目标数,在单目标和多目标自动切换输出方式.", highlight = 1, icon = br.player.spell.demonwrath},
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "使用多目标方式输出.", highlight = 0, icon = br.player.spell.demonwrath},
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "使用单目标方式输出.", highlight = 0, icon = br.player.spell.shadowbolt},
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "禁用DPS输出", highlight = 0, icon = br.player.spell.drainLife}
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
        -- Summon Pet
            br.ui:createDropdownWithout(section, "召唤宠物", {"小鬼","虚空行者","地狱猎犬","魅魔","恶魔卫士"}, 1, "|cffFFFFFF选择默认宠物召唤.")
        -- Grimoire of Service
            br.ui:createDropdownWithout(section, "侍从魔典", {"小鬼","虚空行者","地狱猎犬","魅魔","恶魔卫士","没有"}, 1, "|cffFFFFFF选择侍从魔典的宠物.")
            br.ui:createDropdownWithout(section,"侍从魔典使用方式", {"|cff00FF00任何时候","|cffFFFF00冷却技能","|cffFF0000决不"}, 1, "|cffFFFFFF选择侍从魔典的使用方式.")
        -- Demonwrath
            br.ui:createDropdownWithout(section, "恶魔之怒", {"两者","AoE","移动","没有"}, 1, "|cffFFFFFF Select Demonwrath usage.")
        -- Felstorm
            br.ui:createSpinner(section, "邪能风暴", 3, 1, 10, 1, "|cffFFFFFF最少多少个敌人才使用邪能风暴.")
        -- Mana Tap
            br.ui:createSpinner(section, "生命分流 血量", 30, 0, 100, 5, "|cffFFFFFFHP限制生命分流血量将不会施放.")
        -- Multi-Dot Limit
            br.ui:createSpinnerWithout(section, "多目标 Dot限制", 5, 0, 10, 1, "|cffFFFFFF单位数量限制投放DoT.")
            br.ui:createSpinnerWithout(section, "多目标 Dot血量限制", 5, 0, 10, 1, "|cffFFFFFF限制DoT将被投射/刷新.")
            br.ui:createSpinnerWithout(section, "末日降临Boss血量限制", 10, 1, 20, 1, "|cffFFFFFF限制相对于Boss HP将施放/刷新.")
        br.ui:checkSectionState(section)
    -- Cooldown Options
        section = br.ui:createSection(br.ui.window.profile, "冷却技能")
        -- Racial
            br.ui:createCheckbox(section,"种族技能")
        -- Trinkets
            br.ui:createCheckbox(section,"饰品")
        -- Soul Harvest
            br.ui:createSpinner(section,"灵魂收割", 2, 1, 5, 1, "|cffFFFFFF Minimal Doom DoTs to cast Soul Harvest")
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
    if br.timer:useTimer("debugDemonology", math.random(0.15,0.3)) then
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
        local lastSpell                                     = lastSpellCastSuccess
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
        local travelTime                                    = getDistance("target")/16
        local ttd                                           = getTTD
        local ttm                                           = br.player.power.ttm
        local units                                         = units or {}

        units.dyn40 = br.player.units(40)
        enemies.yards8t = br.player.enemies(8,br.player.units(8,true))
        enemies.yards30 = br.player.enemies(30)
        enemies.yards40 = br.player.enemies(40)

   		if leftCombat == nil then leftCombat = GetTime() end
		if profileStop == nil or not inCombat then profileStop = false end
        if castSummonId == nil then castSummonId = 0 end
        if handTimer == nil then handTimer = GetTime() end
        if isBoss() then dotHPLimit = getOptionValue("多目标 Dot血量限制")/10 else dotHPLimit = getOptionValue("多目标 Dot血量限制") end
        if sindoreiSpiteOffCD == nil then sindoreiSpiteOffCD = true end
        if buff.sindoreiSpite.exits and sindoreiSpiteOffCD then
            sindoreiSpiteOffCD = false
            C_Timer.After(180, function()
                sindoreiSpiteOffCD = true
            end)
        end

        -- Opener Variables
        if not inCombat and not GetObjectExists("target") then
            DE1 = false
            DSB1 = false
            DOOM = false
            SDG = false
            FSDG = false
            GRF = false
            FGRF = false
            DE2 = false
            DSB2 = false
            DGL = false
            FDGL = false
            DE3 = false
            DSB3 = false
            DSB4 = false
            DSB5 = false
            HVST = false
            FHVST = false
            DRS = false
            HOG = false
            DE5 = false
            TKC = false
            opener = false
        end

        -- Pet Data
        if summonPet == 1 then summonId = 416 end
        if summonPet == 2 then summonId = 1860 end
        if summonPet == 3 then summonId = 417 end
        if summonPet == 4 then summonId = 1863 end
        if summonPet == 5 then summonId = 17252 end
        if cd.grimoireOfService == 0 or prevService == nil then prevService = "None" end

        local wildImpCount = 0
        local wildImpDE = false
        local wildImpNoDEcount = 0
        local dreadStalkers = false
        local dreadStalkersCount = 0
        local dreadStalkersDE = false
        local dreadStalkersNoDEcount = 0
        local darkglare = false
        local darkglareDE = false
        local doomguard = false
        local doomguardDE = false
        local infernal = false
        local infernalDE = false
        local felguard = false
        local felguardEnemies = 0
        local petDE = UnitBuffID("pet",spell.buffs.demonicEmpowerment,"player") ~= nil --buff.pet.demonicEmpowerment
        local demonwrathPet = false
        local missingDE = 0
        if petInfo ~= nil then
            for k, v in pairs(petInfo) do
            -- for i = 1, #br.player.petInfo do
                local thisUnit = petInfo[k].id or 0
                local hasDEbuff = petInfo[k].deBuff or false
                local enemyCount = petInfo[k].numEnemies or 0
                if enemyCount >= 3 then
                    demonwrathPet = true;
                    break
                else
                    demonwrathPet = false
                end
                if thisUnit == 55659 then
                    wildImpCount = wildImpCount + 1
                    wildImpDE = hasDEbuff
                    if not hasDEbuff then wildImpNoDEcount = wildImpNoDEcount + 1 end
                end
                if thisUnit == 98035 then
                    dreadStalkers = true
                    dreadStalkersCount = dreadStalkersCount + 1
                    dreadStalkersDE = hasDEbuff
                    if not hasDEbuff then dreadStalkersNoDEcount = dreadStalkersNoDEcount + 1 end
                end
                if thisUnit == 103673 then darkglare = true; darkglareDE = hasDEbuff end
                if thisUnit == 11859 then doomguard = true; doomguardDE = hasDEbuff end
                if thisUnit == 89 then infernal = true; infernalDE = hasDEbuff end
                if thisUnit == 17252 then felguard = true; felguardEnemies = petInfo[k].numEnemies end
                if not petInfo[k].deBuff then
                    missingDE = missingDE + 1
                end
            end
        end
        if wildImpCount > 0 and wildImpDuration == 0 then wildImpDuration = GetTime() + 12 end
        if wildImpCount > 0 and wildImpDuration ~= 0 then wildImpRemain = wildImpDuration - GetTime() end
        if wildImpCount == 0 then wildImpDuration = 0; wildImpRemain = 0 end
        if dreadStalkers and dreadStalkersDuration == 0 then dreadStalkersDuration = GetTime() + 12 end
        if dreadStalkers and dreadStalkersDuration ~= 0 then dreadStalkersRemain = dreadStalkersDuration - GetTime() end
        if not dreadStalkers then dreadStalkersDuration = 0; dreadStalkersRemain = 0 end


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
                        PetStopAttack()
                        PetFollow()
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
                if isChecked("吸取生命") and php <= getOptionValue("吸取生命") and isValidTarget("target") then
                    if cast.drainLife() then return end
                end
        -- Health Funnel
                if isChecked("生命通道") and getHP("pet") <= getOptionValue("生命通道") and GetObjectExists("pet") == true and not UnitIsDeadOrGhost("pet") then
                    if cast.healthFunnel("pet") then return end
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
                if isChecked("灵魂收割") and getOptionValue("灵魂收割") >= debuff.doom.count() then
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
            if not (IsFlying() or IsMounted()) and not talent.grimoireOfSupremacy and (not talent.grimoireOfSacrifice or not buff.demonicPower.exists()) and br.timer:useTimer("summonPet", getCastTime(spell.summonVoidwalker) + gcd) then
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
                if not isChecked("Opener") or not isBoss("target") then
                -- Summon Infernal
                    -- summon_infernal,if=talent.grimoire_of_supremacy.enabled&active_enemies>=3
                    if useCDs() and isChecked("召唤地狱火") then
                        if talent.grimoireOfSupremacy and #enemies.yards8t >= 3 then
                            if cast.summonInfernal() then return end
                        end
                    end
                -- Summon Doomguard
                    -- summon_doomguard,if=talent.grimoire_of_supremacy.enabled&active_enemies<3
                    if useCDs() and isChecked("召唤末日守卫") then
                        if talent.grimoireOfSupremacy and #enemies.yards8t < 3 then
                            if cast.summonDoomguard("player") then return end
                        end
                    end
                    if isChecked("Pre-Pull Timer") and pullTimer <= getOptionValue("Pre-Pull Timer") and pullTimer ~= 999 then
                        return true
                    end -- End Pre-Pull
                    if isValidUnit("target") and getDistance("target") < 40 then
                -- Augmentation
                        -- augmentation,type=defiled
                        -- TODO
                -- Potion
                        -- potion,name=deadly_grace
                        -- TODO
                -- Demonic Empowerment
                        -- demonic_empowerment
                        if activePet ~= "None" and not petDE and lastSpell ~= spell.demonicEmpowerment then
                            if cast.demonicEmpowerment() then return end
                        end
                -- Demonbolt
                        -- demonbolt,if=talent.demonbolt.enabled
                        if talent.demonbolt --[[and br.timer:useTimer("travelTime", travelTime)]] then
                            if cast.demonbolt("target") then return end
                        end
                -- Shadowbolt
                        -- shadow_bolt,if=!talent.demonbolt.enabled
                        if not talent.demonbolt --[[and br.timer:useTimer("travelTime", travelTime)]] then
                            if cast.shadowbolt("target") then return end
                        end
                -- Pet Attack/Follow
                        if GetUnitExists("target") and not UnitAffectingCombat("pet") then
                            PetAssistMode()
                            PetAttack("target")
                        end
                    end
                end
            end -- End No Combat
        end -- End Action List - PreCombat
        local function actionList_Opener()
            if isBoss("target") and isValidUnit("target") and opener == false then
                if (isChecked("Pre-Pull Timer") and pullTimer <= getOptionValue("Pre-Pull Timer")) or not isChecked("Pre-Pull Timer") or pullTimer == 999 then
                -- Demonic Empowerment
                    if not DE1 and not isMoving("player") then
                        castOpener("demonicEmpowerment","DE1",1)
                -- Potion
                    -- potion
                    elseif useCDs() and canUse(142117) and isChecked("Potion") and getDistance("target") < 15 then
                        Print("Potion Used!");
                        useItem(142117)
                -- Demonbolt/Shadowbolt
                    elseif DE1 and not DSB1 and not isMoving("player") then
                        if shards < 5 then
                            if talent.demonbolt then
                                castOpener("demonbolt","DSB1",2)
                            else
                                castOpener("shadowbolt","DSB1",2)
                            end
                        else
                            DSB1 = true
                        end
                -- Pet Attack
                        if not UnitIsUnit("pettarget","target") then
                            PetAttack()
                        end
                -- Doom
                    elseif DSB1 and not DOOM then
                        castOpener("doom","DOOM",3)
                -- Summon Doomguard
                    elseif DOOM and not (SDG or FSDG) then
                        if cd.summonDoomguard == 0  then
                            castOpener("summonDoomguard","SDG",4)
                        elseif cd.summonDoomguard > br.player.gcd then
                            print("4. Summon Doom Guard: Not Cast (Cooldown)")
                            FSDG = true
                        end
                -- Grimoire: Felguard
                    elseif (SDG or DOOM) and not (GRF or FGRF) then
                        if cd.grimoireFelguard == 0 then
                            castOpener("grimoireFelguard","GRF",5)
                        elseif cd.grimoireFelguard > br.player.gcd then
                            print("5. Grimore Felguard: Not Cast(Cooldown)")
                            FGRF = true
                        end
                -- Demonic Empowerment
                    elseif (GRF or SDG) and not DE2 and not isMoving("player") then
                        castOpener("demonicEmpowerment","DE2",6)
                -- Demonbolt/Shadowbolt
                    elseif (DE2 or DOOM) and not DSB2 and not isMoving("player") then
                        if shards < 5 then
                            if talent.demonbolt then
                                castOpener("demonbolt","DSB2",7)
                            else
                                castOpener("shadowbolt","DSB2",7)
                            end
                        else
                            DSB2 = true
                        end
                -- Summon Darkglare
                    elseif DSB2 and not (DGL or FDGL) then
                        if talent.summonDarkglare then
                            if cd.summonDarkglare == 0 then
                                castOpener("summonDarkglare","DGL",8)
                            elseif cd.summonDarkglare > br.player.gcd then
                                print("8. Summon Darkglare: Not Cast(Cooldown)")
                                FDGL = true
                            end
                        else
                            print("8. Summon Darkglare: Not Cast(Not Talented)")
                            FDGL = true
                        end
                -- Demonic Empowerment
                    elseif DGL and not DE3 and not isMoving("player") then
                        castOpener("demonicEmpowerment","DE3",9)
                -- Demonbolt/Shadowbolt
                    elseif (DE3 or DSB2) and not DSB3 and not isMoving("player") then
                        if shards < 5 then
                            if talent.demonbolt then
                                castOpener("demonbolt","DSB3",10)
                            else
                                castOpener("shadowbolt","DSB3",10)
                            end
                        else
                            DSB3 = true
                        end
                -- Demonbolt/Shadowbolt
                    elseif DSB3 and not DSB4 and not isMoving("player") then
                        if shards < 5 then
                            if talent.demonbolt then
                                castOpener("demonbolt","DSB4",11)
                            else
                                castOpener("shadowbolt","DSB4",11)
                            end
                        else
                            DSB4 = true
                        end
                -- Demonbolt/Shadowbolt
                    elseif DSB4 and not DSB5 and not isMoving("player") then
                        if shards < 5 then
                            if talent.demonbolt then
                                castOpener("demonbolt","DSB5",12)
                            else
                                castOpener("shadowbolt","DSB5",12)
                            end
                        else
                            DSB5 = true
                        end
                -- Soul Harvest
                    elseif DSB5 and not (HVST or FHVST) then
                        if talent.soulHarvest then
                            if cd.soulHarvest == 0 then
                                castOpener("soulHarvest","HVST",13)
                            elseif cd.soulHarvest > br.player.gcd then
                                print("13. Soul Harvest: Not Cast(Cooldown)")
                                FHVST = true
                            end
                        else
                            print("13. Soul Harvest: Not Cast(Not Talented)")
                            FHVST = true
                        end
                -- Call Dreadstalkers
                    elseif (HVST or DSB5) and not DRS and not isMoving("player") then
                        castOpener("callDreadstalkers","DRS",14)
                -- Hand of Guldan
                    elseif DRS and not HOG and not isMoving("player") then
                        castOpener("handOfGuldan","HOG",15)
                -- Demonic Empowerment
                    elseif HOG and not DE5 then
                        castOpener("demonicEmpowerment","DE5",16)
                -- Thal'kiel's Consumption
                    elseif DE5 and not TKC then
                        castOpener("thalkielsConsumption","TKC",17)
                    elseif TKC then
                        print("Opener Complete")
                        opener = true
                    end
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
            if not pause() and IsPetAttackActive() then
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
------------------------------
--- Out of Combat Rotation ---
------------------------------
            if actionList_PreCombat() then return end
-----------------------
--- Opener Rotation ---
-----------------------
            if opener == false and isChecked("Opener") and isBoss("target") then
                if actionList_Opener() then return end
            end
--------------------------
--- In Combat Rotation ---
--------------------------
            if inCombat and not IsMounted() and profileStop==false and isValidUnit(units.dyn40) and getDistance(units.dyn40) < 40
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
                    if not UnitIsUnit("pettarget","target") then
                        PetAttack()
                    end
        -- Implosion
                    -- implosion,if=wild_imp_remaining_duration<=action.shadow_bolt.execute_time&(buff.demonic_synergy.remain()s|talent.soul_conduit.enabled|(!talent.soul_conduit.enabled&spell_targets.implosion>1)|wild_imp_count<=4)
                    if wildImpRemain <= getCastTime(spell.shadowbolt) and (buff.demonicSynergy.exists() or talent.soulConduit or (not talent.soulConduit and #enemies.yards8t > 1) or wildImpCount <= 4) then
                        if cast.implosion() then return end
                    end
                    -- implosion,if=prev_gcd.1.hand_of_guldan&((wild_imp_remaining_duration<=3&buff.demonic_synergy.remain()s)|(wild_imp_remaining_duration<=4&spell_targets.implosion>2))
                    if lastSpell == spell.handOfGuldan and ((wildImpRemain <= 3 and buff.demonicSynergy.exists()) or (wildImpRemain <= 4 and #enemies.yards8t)) then
                        if cast.implosion() then return end
                    end
        -- Shadowflame
                    -- shadowflame,if=((debuff.shadowflame.stack()>0&remains<action.shadow_bolt.cast_time+travel_time)|(charges=2&soul_shard<5))&spell_targets.demonwrath<5
                    if ((debuff.shadowflame.stack(units.dyn40) > 0 and debuff.shadowflame.remain(units.dyn40) < getCastTime(spell.shadowbolt) + travelTime)
                        or (charges.shadowflame == 2 and shards < 5)) and #enemies.yards8t < 5
                    then
                        if cast.shadowflame() then return end
                    end
        -- Service Pet
                    -- service_pet
                    if br.timer:useTimer("castGrim", gcd+1) and shards > 0 and (getOptionValue("侍从魔典使用方式") == 1 or (getOptionValue("侍从魔典使用方式") == 2 and useCDs())) then
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
                        if summonPet == 6 then return end
                    end
        -- Summon Doomguard
                    -- summon_doomguard,if=!talent.grimoire_of_supremacy.enabled&spell_targets.infernal_awakening<=2&(target.time_to_die>180|target.health.pct<=20|target.time_to_die<30)
                    if useCDs() and isChecked("召唤末日守卫") then
                        if not talent.grimoireOfSupremacy and #enemies.yards8t <= 2 and (ttd("target") > 180 or getHP("target") <= 20 or ttd("target") < 30) then
                            if cast.summonDoomguard() then return end
                        end
                    end
        -- Summon Infernal
                    -- summon_infernal,if=!talent.grimoire_of_supremacy.enabled&spell_targets.infernal_awakening>2
                    if useCDs() and isChecked("召唤地狱火") then
                        if not talent.grimoireOfSupremacy and #enemies.yards8t > 2 then
                            if cast.summonInfernal() then return end
                        end
                    end
        -- Summon Doomguard
                    -- summon_doomguard,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal=1&equipped.132379&!cooldown.sindorei_spite_icd.remain()s
                    if talent.grimoireOfSupremacy and #enemies.yards8t == 1 and hasEquiped(132379) and not sindoreiSpiteOffCD then
                        if cast.summonDoomguard() then return end
                    end
        -- Summon Infernal
                    -- summon_infernal,if=talent.grimoire_of_supremacy.enabled&spell_targets.summon_infernal>1&equipped.132379&!cooldown.sindorei_spite_icd.remain()s
                    if talent.grimoireOfSupremacy and #enemies.yards8t > 1 and hasEquiped(132379) and not sindoreiSpiteOffCD then
                        if cast.summonInfernal() then return end
                    end
        -- Call Dreadstalkers
                    -- call_dreadstalkers,if=(!talent.summon_darkglare.enabled|talent.power_trip.enabled)&(spell_targets.implosion<3|!talent.implosion.enabled)
                    if (not talent.summonDarkglare or talent.powerTrip) and (#enemies.yards8t < 3 or not talent.implosion) then
                        if cast.callDreadstalkers() then return end
                    end
        -- Hand of Guldan
                    -- hand_of_guldan,if=soul_shard>=4&!talent.summon_darkglare.enabled
                    if shards >= 4 and not talent.summonDarkglare and lastSpell ~= spell.handOfGuldan then
                        if GetTime() > handTimer then
                            if cast.handOfGuldan() then handTimer = GetTime() + 2; return end
                        end
                    end
        -- Doom
                    -- doom,cycle_targets=1,if=!talent.hand_of_doom.enabled&target.time_to_die>duration&(!ticking|remains<duration*0.3)
                    if debuff.doom.count() < getOptionValue("多目标 Dot限制") and getHP(thisUnit) > dotHPLimit and isValidUnit(thisUnit)
                        and bossHPLimit(thisUnit,getOptionValue("末日降临Boss血量限制"))
                    then
                        for i = 1, #enemies.yards40 do
                            local thisUnit = enemies.yards40[i]
                            if UnitIsUnit(thisUnit,"target") or hasThreat(thisUnit) or isDummy(thisUnit) then
                                if not talent.handOfDoom and ttd(thisUnit) > debuff.doom.duration(thisUnit) and debuff.doom.refresh(thisUnit) then
                                    if cast.doom(thisUnit) then return end
                                end
                            end
                        end
                    end
        -- Summon Darkglare
                    -- summon_darkglare,if=prev_gcd.1.hand_of_guldan|prev_gcd.1.call_dreadstalkers|talent.power_trip.enabled
                    if lastSpell == spell.handOfGuldan or lastSpell == spell.callDreadstalkers or talent.powerTrip then
                        if cast.summonDarkglare() then return end
                    end
                    -- summon_darkglare,if=cooldown.call_dreadstalkers.remain()s>5&soul_shard<3
                    if cd.callDreadstalkers > 5 and shards < 3 then
                        if cast.summonDarkglare() then return end
                    end
                    -- summon_darkglare,if=cooldown.call_dreadstalkers.remain()s<=action.summon_darkglare.cast_time&(soul_shard>=3|soul_shard>=1&buff.demonic_calling.react)
                    if cd.callDreadstalkers <= getCastTime(spell.summonDarkglare) and (shards >= 3 or shards >= 1 and buff.demonicCalling.exists()) then
                        if cast.summonDarkglare() then return end
                    end
        -- Call Dreadstalkers
                    -- call_dreadstalkers,if=talent.summon_darkglare.enabled&(spell_targets.implosion<3|!talent.implosion.enabled)&(cooldown.summon_darkglare.remain()s>2|prev_gcd.1.summon_darkglare|cooldown.summon_darkglare.remain()s<=action.call_dreadstalkers.cast_time&soul_shard>=3|cooldown.summon_darkglare.remain()s<=action.call_dreadstalkers.cast_time&soul_shard>=1&buff.demonic_calling.react)
                    if talent.summonDarkglare and (#enemies.yards8t < 3 or not talent.implosion)
                        and (cd.summonDarkglare > 2 or lastSpell == summonDarkglare
                            or (cd.summonDarkglare <= getCastTime(spell.callDreadstalkers) and shards >= 3)
                            or (cd.summonDarkglare <= getCastTime(spell.callDreadstalkers) and shards >= 1 and buff.demonicCalling.exists()))
                    then
                        if cast.callDreadstalkers() then return end
                    end
        -- Hand of Guldan
                    -- hand_of_guldan,if=(soul_shard>=3&prev_gcd.1.call_dreadstalkers)|soul_shard>=5|(soul_shard>=4&cooldown.summon_darkglare.remain()s>2)
                    if (shards >= 3 and lastSpell == spell.callDreadstalkers) or shards >= 5 or (shards >= 4 and cd.summonDarkglare > 2) then
                        if GetTime() > handTimer then
                            if cast.handOfGuldan() then handTimer = GetTime() + 2; return end
                        end
                    end
        -- Demonic Empowerment
                    -- demonic_empowerment,if=(((talent.power_trip.enabled&(!talent.implosion.enabled|spell_targets.demonwrath<=1))|!talent.implosion.enabled|(talent.implosion.enabled&!talent.soul_conduit.enabled&spell_targets.demonwrath<=3))&(wild_imp_no_de>3|prev_gcd.1.hand_of_guldan))|(prev_gcd.1.hand_of_guldan&wild_imp_no_de=0&wild_imp_remaining_duration<=0)|(prev_gcd.1.implosion&wild_imp_no_de>0)
                    if lastSpell ~= spell.demonicEmpowerment then              
                        if (((talent.powerTrip and (not talent.implosion or #enemies.yards8t <= 1)) or not talent.implosion
                                or (talent.implosion and not talent.soulConduit and #enemies.yards8t <= 3))
                                and ((wildImp and wildImpNoDEcount > 3) or lastSpell == spell.handOfGuldan))
                            or (lastSpell == spell.handOfGuldan and wildImpNoDEcount == 0 and wildImpRemain <= 0)
                            or (lastSpell == spell.implosion and wildImp and wildImpNoDEcount > 0)
                        then
                            if cast.demonicEmpowerment() then return end
                        end
                    -- demonic_empowerment,if=dreadstalker_no_de>0|darkglare_no_de>0|doomguard_no_de>0|infernal_no_de>0|service_no_de>0
                        if (dreadStalkers and dreadStalkersNoDEcount > 0)
                            or (darkglare and not darkglareDE)
                            or (doomguard and not doomguardDE)
                            or (infernal and not infernalDE)
                            or (activePet and not petDE)
                        then
                            if cast.demonicEmpowerment() then return end
                        end
                    end
        -- Felstorm
                    -- felguard:felstorm
                    if isChecked("邪能风暴") and felguard and felguardEnemies ~= nil and felguardEnemies >= getOptionValue("邪能风暴") and cd.felstorm == 0 then
                        if cast.commandDemon() then return end
                    end
        -- Cooldowns
                    if actionList_Cooldowns() then return end
        -- Shadowflame
                    -- shadowflame,if=charges=2&spell_targets.demonwrath<5
                    if charges.shadowflame == 2 and #enemies.yards8t < 5 then
                        if cast.shadowflame() then return end
                    end
           -- Thal'kiel's Consumption
                -- thalkiels_consumption,if=(dreadstalker_remaining_duration>execute_time|talent.implosion.enabled&spell_targets.implosion>=3)&wild_imp_count>3&wild_imp_remaining_duration>execute_time
                    if getOptionValue("神器技能") == 1 or (getOptionValue("神器技能") == 2 and useCDs()) then
                        if (dreadStalkersRemain > getCastTime(spell.thalkielsConsumption) or (talent.implosion and #enemies.yards8t >= 3)) and wildImpCount > 3 and (tonumber(wildImpRemain) > getCastTime(spell.thalkielsConsumption)) then
                            -- print(isChecked("Summon Doomguard"))
                            -- print(isChecked("Summon Infernal"))
                            -- print(getOptionValue("Grimoire of Service - Use"))
                            if ((cd.summonDoomguard > 15 or isChecked("召唤末日守卫") == false) and (cd.summonInfernal > 15 or isChecked("Summon Infernal") == false) and (cd.grimoireFelguard > 15 or getOptionValue("Grimoire of Service - Use") == 3)) or not isBoss(units.dyn40) then 
                                if cd.thalkielsConsumption <= 2 then
                             --   if missingDE == 0 then
                                    if cast.thalkielsConsumption() then return end
                                end
                            end
                        end
                    end
        -- Life Tap
                    -- life_tap,if=mana.pct<=30
                    if manaPercent <= 30 and php > getOptionValue("生命分流 血量") then
                        if cast.lifeTap() then return end
                    end
        -- Demonwrath
                    -- demonwrath,chain=1,interrupt=1,if=spell_targets.demonwrath>=3
                    -- demonwrath,moving=1,chain=1,interrupt=1
                    if (getOptionValue("恶魔之怒") == 1 and (demonwrathPet or moving)) 
                        or (getOptionValue("恶魔之怒") == 2 and demonwrathPet) 
                        or (getOptionValue("恶魔之怒") == 3 and moving) 
                    then
                        if cast.demonwrath() then return end
                    end
        -- Demonbolt
                    -- demonbolt
                    -- if br.timer:useTimer("travelTime", travelTime) then
                        if cast.demonbolt() then return end
                    -- end
        -- Shadow Bolt
                    -- shadow_bolt
                    -- if br.timer:useTimer("travelTime", travelTime) then
                        if cast.shadowbolt() then return end
                    -- end
        -- Life Tap
                    --life_tap
                    if manaPercent < 70 and php > getOptionValue("生命分流 血量") then
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
local id = 266
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})