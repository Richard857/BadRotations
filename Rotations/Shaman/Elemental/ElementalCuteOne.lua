local rotationName = "CuteOne"

---------------
--- Toggles ---
---------------
local function createToggles()
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "基于范围内的目标数,在单目标和多目标自动切换输出方式.", highlight = 1, icon = br.player.spell.lavaBeam},
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "使用多目标方式输出.", highlight = 0, icon = br.player.spell.chainLightning},
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "使用单目标方式输出.", highlight = 0, icon = br.player.spell.lightningBolt},
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "禁用DPS输出", highlight = 0, icon = br.player.spell.healingSurge}
    };
    CreateButton("Rotation",1,0)
-- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "自动使用大技能 - 只在BOSS.", highlight = 1, icon = br.player.spell.fireElemental},
        [2] = { mode = "On", value = 1 , overlay = "Cooldowns Enabled", tip = "不管任何目标都使用大技能.", highlight = 0, icon = br.player.spell.fireElemental},
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "不使用大技能.", highlight = 0, icon = br.player.spell.fireElemental}
    };
   	CreateButton("Cooldown",2,0)
-- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "使用保命技能.", highlight = 1, icon = br.player.spell.astralShift},
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "不使用保命技能.", highlight = 0, icon = br.player.spell.astralShift}
    };
    CreateButton("Defensive",3,0)
-- Interrupt Button
    InterruptModes = {
        [1] = { mode = "On", value = 1 , overlay = "Interrupts Enabled", tip = "使用打断.", highlight = 1, icon = br.player.spell.windShear},
        [2] = { mode = "Off", value = 2 , overlay = "Interrupts Disabled", tip = "不使用打断.", highlight = 0, icon = br.player.spell.windShear}
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
            br.ui:createDropdownWithout(section, "APL模式", {"|cffFFFFFFSimC"--[[,"|cffFFFFFFAMR"]]}, 1, "|cffFFFFFF选择输出循环.")
        -- Dummy DPS Test
            br.ui:createSpinner(section, "DPS测试",  5,  5,  60,  5,  "|cffFFFFFF设置为所需的测试的时间（分钟）. 最小: 5 / 最大: 60 / 间隔: 5")
        -- Pre-Pull Timer
            br.ui:createSpinner(section, "Pre-Pull Timer",  5,  1,  10,  1,  "|cffFFFFFF设置为所需的启动时间 Pre-Pull (必须有DBM). 最小: 1 / 最大: 10 / 间隔: 1")
        -- Ghost Wolf
            br.ui:createCheckbox(section,"幽魂之狼")
        -- Spirit Walk
            br.ui:createCheckbox(section,"幽魂步")
        -- Water Walking
            br.ui:createCheckbox(section,"水上行走")
        -- Artifact
            br.ui:createDropdownWithout(section,"神器技能", {"|cff00FF00任何时候","|cffFFFF00冷却技能","|cffFF0000决不"}, 1, "|cffFFFFFF何时使用神器技能.")
        br.ui:checkSectionState(section)
    -- Cooldown Options
        section = br.ui:createSection(br.ui.window.profile, "冷却技能")
        -- Agi Pot
            br.ui:createCheckbox(section,"爆发药水")
        -- Flask / Crystal
            br.ui:createCheckbox(section,"奥拉留斯的低语水晶")
        -- Legendary Ring
            br.ui:createCheckbox(section,"传奇戒指")
        -- Racial
            br.ui:createCheckbox(section,"种族技能")
        -- Trinkets
            br.ui:createCheckbox(section,"饰品")
        -- Ascendance
            br.ui:createCheckbox(section,"升腾")
        -- Elemental Mastery
            br.ui:createCheckbox(section,"元素掌握")
        -- Fire/Storm Elemental Totem
            br.ui:createCheckbox(section,"风暴元素")
        br.ui:checkSectionState(section)
    -- Defensive Options
        section = br.ui:createSection(br.ui.window.profile, "保命")
        -- Healthstone
            br.ui:createSpinner(section, "药水/治疗石",  60,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用")
        -- Heirloom Neck
            br.ui:createSpinner(section, "传家宝项链",  60,  0,  100,  5,  "|cffFFBB00多少血量百分比使用");
        -- Gift of The Naaru
            if br.player.race == "Draenei" then
                br.ui:createSpinner(section, "纳鲁的赐福",  50,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用")
            end
        -- Ancestral Spirit
            br.ui:createDropdown(section, "先祖之魂", {"|cffFFFF00所选的目标","|cffFF0000鼠标位置目标"}, 1, "|ccfFFFFFF施放技能")
        -- Astral Shift
            br.ui:createSpinner(section, "星界转移",  50,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用")
        -- Cleanse Spirit
            br.ui:createDropdown(section, "净化灵魂", {"|cff00FF00仅限玩家","|cffFFFF00所选的目标","|cffFF0000鼠标位置目标"}, 1, "|ccfFFFFFF施放技能")
        -- Earth Elemental Totem
            br.ui:createSpinner(section, "土元素", 30, 0, 100, 5, "|cffFFFFFF多少血量百分比使用")
        -- Earthquake
            br.ui:createSpinner(section, "震地图腾", 40, 0, 100, 5, "|cffFFFFFF多少血量百分比使用")
        -- Healing Surge
            br.ui:createSpinner(section, "治疗之涌",  80,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用")
        -- Lightning Surge Totem
            br.ui:createSpinner(section, "闪电奔涌图腾 - HP", 50, 0, 100, 5, "|cffFFFFFF多少血量百分比使用")
            br.ui:createSpinner(section, "闪电奔涌图腾 - AoE", 5, 0, 10, 1, "|cffFFFFFF投5码的单位数量")
        -- Purge
            br.ui:createCheckbox(section,"净化术")
        -- Thunderstorm
            br.ui:createSpinner(section, "雷霆风暴", 25, 0, 100, 5, "|cffFFFFFF多少血量百分比使用")
        br.ui:checkSectionState(section)
    -- Interrupt Options
        section = br.ui:createSection(br.ui.window.profile, "打断")
        -- Wind Shear
            br.ui:createCheckbox(section,"风剪")
        -- Hex
            br.ui:createCheckbox(section,"妖术")
        -- Lightning Surge Totem
            br.ui:createCheckbox(section,"闪电奔涌图腾")
        -- Thunderstorm
            br.ui:createCheckbox(section,"雷霆风暴")
        -- Earthquake
            br.ui:createCheckbox(section,"震地图腾")
        -- Interrupt Percentage
            br.ui:createSpinner(section, "打断",  0,  0,  95,  5,  "|cffFFFFFF百分几打断")
        br.ui:checkSectionState(section)
    -- Toggle Key Options
        section = br.ui:createSection(br.ui.window.profile, "切换快捷键")
        -- Single/Multi Toggle
            br.ui:createDropdown(section, "运行模式", br.dropOptions.Toggle,  4)
        -- Cooldown Key Toggle
            br.ui:createDropdown(section, "冷却技能模式", br.dropOptions.Toggle,  3)
        -- Defensive Key Toggle
            br.ui:createDropdown(section, "保命模式", br.dropOptions.Toggle,  6)
        -- Interrupts Key Toggle
            br.ui:createDropdown(section, "打断模式", br.dropOptions.Toggle,  6)
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
    if br.timer:useTimer("debugElemental", math.random(0.15,0.3)) then
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
        local artifact                                      = br.player.artifact
        local buff                                          = br.player.buff
        local canFlask                                      = canUse(br.player.flask.wod.agilityBig)
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
        local hasMouse                                      = GetObjectExists("mouseover")
        local healPot                                       = getHealthPot()
        local inCombat                                      = br.player.inCombat
        local inInstance                                    = br.player.instance=="party"
        local inRaid                                        = br.player.instance=="raid"
        local lastSpell                                     = lastSpellCast
        local level                                         = br.player.level
        local lootDelay                                     = getOptionValue("LootDelay")
        local lowestHP                                      = br.friend[1].unit
        local mode                                          = br.player.mode
        local moveIn                                        = 999
        local moving                                        = isMoving("player")
        -- local multidot                                      = (useCleave() or br.player.mode.rotation ~= 3)
        local perk                                          = br.player.perk
        local php                                           = br.player.health
        local playerMouse                                   = UnitIsPlayer("mouseover")
        local power, powmax, powgen, powerDeficit           = br.player.power.amount.maelstrom, br.player.power.maelstrom.max, br.player.power.regen, br.player.power.maelstrom.deficit
        local pullTimer                                     = br.DBM:getPulltimer()
        local racial                                        = br.player.getRacial()
        local recharge                                      = br.player.recharge
        local solo                                          = br.player.instance=="none"
        local spell                                         = br.player.spell
        local talent                                        = br.player.talent
        local ttd                                           = getTTD
        local ttm                                           = br.player.power.ttm
        local units                                         = units or {}

        units.dyn8 = br.player.units(8)
        units.dyn40 = br.player.units(40)
        enemies.yards5 = br.player.enemies(5)
        enemies.yards8 = br.player.enemies(8)
        enemies.yards8t = br.player.enemies(8,br.player.units(8,true))
        enemies.yards10 = br.player.enemies(10)
        enemies.yards20 = br.player.enemies(20)
        enemies.yards30 = br.player.enemies(30)
        enemies.yards40 = br.player.enemies(40)

   		if leftCombat == nil then leftCombat = GetTime() end
		if profileStop == nil then profileStop = false end
        if resonanceTotemCastTime == nil then resonanceTotemCastTime = 0 end
        if resonanceTotemTimer == nil then resonanceTotemTimer = 0 end
        if lastSpell == spell.totemMastery then resonanceTotemCastTime = GetTime() + 120 end
        if resonanceTotemCastTime > GetTime() then resonanceTotemTimer = resonanceTotemCastTime - GetTime() else resonanceTotemCastTime = 0; resonanceTotemTimer = 0 end

        flameShockCounter = 0
        for i = 1, #enemies.yards40 do
            local thisUnit = enemies.yards40[i]
            if debuff.flameShock.exists(thisUnit) then
                flameShockCounter = flameShockCounter + 1
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
						Print(tonumber(getOptionValue("DPS测试")) .." Minute Dummy Test Concluded - Profile Stopped")
						profileStop = true
					end
				end
			end -- End Dummy Test
        -- Ghost Wolf
            if isChecked("幽魂之狼") and not UnitBuffID("player",202477) then
                if ((#enemies.yards20 == 0 and not inCombat) or (#enemies.yards10 == 0 and inCombat)) and isMoving("player") and not buff.ghostWolf.exists() then
                    if cast.ghostWolf() then return end
                end
            end
        -- Purge
            if isChecked("净化术") and canDispel("target",spell.purge) and not isBoss() and GetObjectExists("target") then
                if cast.purge() then return end
            end
        -- Spirit Walk
            if isChecked("幽魂步") and hasNoControl(spell.spiritWalk) then
                if cast.spiritWalk() then return end
            end
        -- Water Walking
            if falling > 1.5 and buff.waterWalking.exists() then
                CancelUnitBuffID("player", spell.waterWalking)
            end
            if isChecked("水上行走") and not inCombat and IsSwimming() then
                if cast.waterWalking() then return end
            end
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
                    if hasEquiped(122668) then
                        if GetItemCooldown(122668)==0 then
                            useItem(122668)
                        end
                    end
                end
        -- Gift of the Naaru
                if isChecked("纳鲁的赐福") and php <= getOptionValue("纳鲁的赐福") and php > 0 and br.player.race == "Draenei" then
                    if castSpell("player",racial,false,false,false) then return end
                end
        -- Ancestral Spirit
                if isChecked("先祖之魂") then
                    if getOptionValue("先祖之魂")==1 and hastar and playertar and deadtar then
                        if cast.ancestralSpirit("target") then return end
                    end
                    if getOptionValue("先祖之魂")==2 and hasMouse and playerMouse and deadMouse then
                        if cast.ancestralSpirit("mouseover") then return end
                    end
                end
        -- Astral Shift
                if isChecked("星界转移") and php <= getOptionValue("星界转移") and inCombat then
                    if cast.astralShift() then return end
                end
        -- Cleanse Spirit
                if isChecked("Cleanse Spirit") then
                    if getOptionValue("Cleanse Spirit")==1 and canDispel("player",spell.cleanseSpirit) then
                        if cast.cleanseSpirit("player") then return; end
                    end
                    if getOptionValue("Cleanse Spirit")==2 and canDispel("target",spell.cleanseSpirit) then
                        if cast.cleanseSpirit("target") then return end
                    end
                    if getOptionValue("Cleanse Spirit")==3 and canDispel("mouseover",spell.cleanseSpirit) then
                        if cast.cleanseSpirit("mouseover") then return end
                    end
                end
        -- Earth Elemental Totem
                if isChecked("土元素") then
                    if inCombat and php <= getOptionValue("土元素") then
                        if cast.earthElemental() then return end
                    end
                end
        -- Earthquake
                if isChecked("震地图腾") then
                    if inCombat and php <= getOptionValue("震地图腾") and lastSpell ~= spell.earthquake then
                        if cast.earthquake() then return end
                    end
                end
        -- Healing Surge
                if isChecked("治疗之涌")
                    and ((inCombat and ((php <= getOptionValue("治疗之涌") / 2 and power > 20)
                        or (power >= 90 and php <= getOptionValue("治疗之涌")))) or (not inCombat and php <= getOptionValue("治疗之涌") and not moving))
                then
                    if cast.healingSurge() then return end
                end
        -- Lightning Surge Totem
                if isChecked("闪电奔涌图腾 - HP") and php <= getOptionValue("闪电奔涌图腾 - HP") and inCombat and #enemies.yards5 > 0 and lastSpell ~= spell.lightningSurgeTotem then
                    if cast.lightningSurgeTotem("player","ground") then return end
                end
                if isChecked("闪电奔涌图腾 - AoE") and #enemies.yards5 >= getOptionValue("闪电奔涌图腾 - AoE") and inCombat and lastSpell ~= spell.lightningSurgeTotem then
                    if cast.lightningSurgeTotem("best",nil,getOptionValue("闪电奔涌图腾 - AoE"),8) then return end
                end
        -- Thunderstorm
                if inCombat and isChecked("雷霆风暴") and php <= getOptionValue("雷霆风暴") and #enemies.yards5 >= 0 then
                    if cast.thunderstorm() then return end
                end
    		end -- End Defensive Toggle
		end -- End Action List - Defensive
	-- Action List - Interrupts
		local function actionList_Interrupts()
			if useInterrupts() then
                for i=1, #enemies.yards30 do
                    thisUnit = enemies.yards30[i]
                    if canInterrupt(thisUnit,getOptionValue("打断")) then
        -- Wind Shear
                        -- wind_shear
                        if isChecked("风剪") then
                            if cast.windShear(thisUnit) then return end
                        end
        -- Hex
                        if isChecked("妖术") then
                            if cast.hex(thisUnit) then return end
                        end
        -- Lightning Surge Totem
                        if isChecked("闪电奔涌图腾") and cd.windShear > gcd then
                            if hasThreat(thisUnit) and not isMoving(thisUnit) and ttd(thisUnit) > 7 and lastSpell ~= spell.lightningSurgeTotem then
                                if cast.lightningSurgeTotem(thisUnit,"ground") then return end
                            end
                        end
        -- Tunderstorm
                        if isChecked("雷霆风暴") and cd.windShear > gcd and cd.lightningSurgeTotem > gcd then
                            if getDistance(thisUnit) < 10 then
                                if cast.thunderstorm() then return end
                            end
                        end
        -- Earthquake
                        if isChecked("震地图腾") and cd.windShear > gcd and cd.lightningSurgeTotem > gcd and lastSpell ~= spell.earthquake then
                            if getDistance(thisUnit) < 8 then
                                if cast.earthquake() then return end
                            end
                        end
                    end
                end
            end -- End useInterrupts check
		end -- End Action List - Interrupts
	-- Action List - Cooldowns
		local function actionList_Cooldowns()
			if useCDs() and getDistance(units.dyn40) < 40 then
        -- Trinkets
                if isChecked("饰品") then
                    if canUse(11) then
                        useItem(11)
                    end
                    if canUse(12) then
                        useItem(12)
                    end
                    if canUse(13) then
                        useItem(13)
                    end
                    if canUse(14) then
                        useItem(14)
                    end
                end
        -- Legendary Ring
                -- use_item,slot=finger1
                if isChecked("传奇戒指") then
                    if hasEquiped(124636) and canUse(124636) then
                        useItem(124636)
                    end
                end
        -- Racial: Orc Blood Fury | Troll Berserking | Blood Elf Arcane Torrent
                -- blood_fury,buff.tigers_fury | berserking,buff.tigers_fury | arcane_torrent,buff.tigers_fury
                if isChecked("种族技能") and (br.player.race == "Orc" or br.player.race == "Troll" or br.player.race == "BloodElf") then
                    if castSpell("player",racial,false,false,false) then return end
                end
                if getOptionValue("APL模式") == 1 then -- SimC

                end
                if getOptionValue("APL模式") == 2 then -- AMR

                end
        -- Agi-Pot
                -- potion,name=deadly_grace,if=buff.metamorphosis.remain()s>25
                if isChecked("爆发药水") and canUse(109217) and inRaid then
                    -- if buff.remain().metamorphosis > 25 then
                        useItem(109217)
                    -- end
                end
            end -- End useCDs check
        end -- End Action List - Cooldowns
    -- Action List - PreCombat
        local function actionList_PreCombat()
            if not inCombat and not (IsFlying() or IsMounted()) then
            -- Flask / Crystal
                -- flask,type=flask_of_the_seventh_demon
                if isChecked("奥拉留斯的低语水晶") then
                    if inRaid and canFlask and flaskBuff==0 and not UnitBuffID("player",188033) then
                        useItem(br.player.flask.wod.agilityBig)
                        return true
                    end
                    if flaskBuff==0 then
                        if not UnitBuffID("player",188033) and canUse(118922) then --Draenor Insanity Crystal
                            useItem(118922)
                            return true
                        end
                    end
                end
                if isChecked("Pre-Pull Timer") and pullTimer <= getOptionValue("Pre-Pull Timer") then
            -- Potion - Deadly Grace
                --TODO

                end -- End Pre-Pull
                if isValidUnit("target") and getDistance("target") < 40 then
            -- Totem Mastery
                    if br.timer:useTimer("delayTotemMastery", gcd) and lastSpell ~= spell.totemMastery and not buff.resonanceTotem.exists() then
                        if cast.totemMastery() then resonanceTotemCastTime = GetTime() + 120; return end
                    end
            -- Stormkeeper
                    if getOptionValue("神器技能") == 1 or (getOptionValue("神器技能") == 2 and useCDs()) then
                        if cast.stormkeeper() then return end
                    end
            -- Flame Shock
                    if debuff.flameShock.refresh("target") and ttd("target") > 15 then
                        if cast.flameShock("target") then StartAttack(); return end
                    else
            -- Lightning Bolt
                        if cast.lightningBolt("target") then StartAttack(); return end
                    end
                end
            end -- End No Combat
        end -- End Action List - PreCombat
    -- Action List - Multi Target
        local function actionList_MultiTarget()
        -- Stormkeeper
            -- stormkeeper
            if getOptionValue("神器技能") == 1 or (getOptionValue("神器技能") == 2 and useCDs()) then
                if cast.stormkeeper() then return end
            end
        -- Ascendance
            -- ascendance
            if useCDs() and isChecked("升腾") then
                if cast.ascendance() then return end
            end
        -- Liquid Magma Totem
            -- liquid_magma_totem
            if lastSpell ~= spell.liquidMagmaTotem then
                if cast.liquidMagmaTotem("target") then return end
            end
        -- Flame Shock
            -- -- flame_shock,if=spell_targets.chain_lightning<4&maelstrom>=20&!talent.lightning_rod.enabled,target_if=refreshable
            -- if #enemies.yards8t < 4 and power >= 20 and not talent.lightningRod and debuff.flameShock.refresh(units.dyn40) then
            --     if cast.flameShock(thisUnit) then return end
            -- end
            if debuff.flameShock.count() < 4 then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if ((isBoss() and bossHPLimit(thisUnit,10)) or solo) and (hasThreat(thisUnit) or isDummy(thisUnit)) then 
                        if debuff.flameShock.refresh(thisUnit) and ttd(thisUnit) > 15 then
                            if cast.flameShock(thisUnit) then return end
                        end
                    end
                end
            end
        -- Earthquake
            -- earthquake
            if lastSpell ~= spell.earthquake and power >= 50 and (not hasEquiped(137074) or not buff.echoesOfTheGreatSundering.exists() or #enemies.yards8t > 3) then
                if cast.earthquake() then return end
            end
        -- Earth Shock
            if power >= 50 and #enemies.yards8t < 4 and buff.echoesOfTheGreatSundering.exists() and hasEquiped(137074) then
                if cast.earthShock() then return end
            end
        -- Lava Burst
            -- lava_burst,if=dot.flame_shock.remains>cast_time&buff.lava_surge.up&!talent.lightning_rod.enabled&spell_targets.chain_lightning<4
            if debuff.flameShock.remain(units.dyn40) > getCastTime(spell.lavaBurst) and buff.lavaSurge.exists() and not talent.lightningRod
                and ((mode.rotation == 1 and #enemies.yards8t < 4) or mode.rotation == 2)
            then
                if cast.lavaBurst() then return end
            end
        -- Elemental Blast
            -- elemental_blast,if=!talent.lightning_rod.enabled&spell_targets.chain_lightning<5|talent.lightning_rod.enabled&spell_targets.chain_lightning<4
            if not talent.lightningRod and ((mode.rotation == 1 and (#enemies.yards8t < 5 or (talent.lightningRod and #enemies.yards8t < 4))) or mode.rotation == 2) then
                if cast.elementalBlast() then return end
            end
        -- Lava Beam
            -- lava_beam
            if cast.lavaBeam() then return end
        -- Chain Lightning
            -- chain_lightning,target_if=!debuff.lightning_rod.up
            -- chain_lightning
            if not debuff.lightningRod.exists(units.dyn40) then
                if cast.chainLightning() then return end
            end
            if cast.chainLightning() then return end
        -- Lava Burst
            -- lava_burst,moving=1
            if moving and buff.lavaSurge then
                if cast.lavaBurst() then return end
            end
        -- Flame Shock
            -- flame_shock,moving=1,target_if=refreshable
            if flameShockCounter < 4 and moving then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if ((isBoss() and bossHPLimit(thisUnit,10)) or solo) and (hasThreat(thisUnit) or isDummy(thisUnit)) then 
                        if debuff.flameShock.refresh(thisUnit) and ttd(thisUnit) > 15 and debuff.flameShock.remain(thisUnit) < 2 then
                            if cast.flameShock(thisUnit) then return end
                        end
                    end
                end
            end
        end -- End Multi Target Action List
    -- Action List - Single Target: Ascendance
        local function actionList_Ascendance()
        -- Ascendance
            -- ascendance,if=dot.flame_shock.remains>buff.ascendance.duration&(time>=60|buff.bloodlust.up)&cooldown.lava_burst.remains>0&!buff.stormkeeper.up
            if useCDs() and isChecked("升腾") then
                if debuff.flameShock.remain(units.dyn40) > buff.ascendance.duration()
                    and (combatTime >= 60 or hasBloodLust()) and cd.lavaBurst > 0 and not buff.stormkeeper.exits
                then
                    if cast.ascendance() then return end
                end
            end
        -- Flame Shock
            -- flame_shock,if=!ticking|dot.flame_shock.remains<=gcd
            if debuff.flameShock.count() < 3 then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if ((isBoss() and bossHPLimit(thisUnit,10)) or solo) and (hasThreat(thisUnit) or isDummy(thisUnit)) then 
                        if debuff.flameShock.refresh(thisUnit) and ttd(thisUnit) > 15 then
                            if cast.flameShock(thisUnit) then return end
                        end
                    end
                end
            end
            -- flame_shock,if=maelstrom>=20&remains<=buff.ascendance.duration&cooldown.ascendance.remains+buff.ascendance.duration<=duration
            if power >= 20 and debuff.flameShock.remain(units.dyn40) <= buff.ascendance.duration()
                and cd.ascendance + buff.ascendance.duration() <= debuff.flameShock.duration(units.dyn40)
                and ttd(units.dyn40) > 15
            then
                if cast.flameShock() then return end
            end
        -- Earthquake
            -- earthquake,if=buff.echoes_of_the_great_sundering.up&!buff.ascendance.up&maelstrom>=86
            if buff.echoesOfTheGreatSundering.exists() and not buff.ascendance.exists() and power >= 86 then
                if cast.earthquake() then return end
            end
        -- Earth Shock
            -- earth_shock,if=maelstrom>=117|!artifact.swelling_maelstrom.enabled&maelstrom>=92
            if power >= 117 or (not artifact.swellingMaelstrom and power >= 92) then
                if cast.earthShock() then return end
            end
        -- Stormkeeper
            -- stormkeeper,if=raid_event.adds.count<3|raid_event.adds.in>50
            if getOptionValue("神器技能") == 1 or (getOptionValue("神器技能") == 2 and useCDs()) and (#enemies.yards40 < 3 or addsIn > 50) then
                if cast.stormkeeper() then return end
            end
        -- Elemental Blast
            -- elemental_blast
            if cast.elementalBlast() then return end
        -- Liquid Magma Totem
            -- liquid_magma_totem,if=raid_event.adds.count<3|raid_event.adds.in>50
            if (#enemies.yards8 < 3) and getDistance(units.dyn8) < 8 and lastSpell ~= spell.liquidMagmaTotem then
                if cast.liquidMagmaTotem("target") then return end
            end
        -- Lightning Bolt
            -- lightning_bolt,if=buff.power_of_the_maelstrom.up&buff.stormkeeper.up&spell_targets.chain_lightning<3
            if buff.powerOfTheMaelstrom.exists() and buff.stormkeeper.exists() and #enemies.yards8t < 3 then
                if cast.lightningBolt() then return end
            end
        -- Lava Burst
            -- lava_burst,if=dot.flame_shock.remains>cast_time&(cooldown_react|buff.ascendance.up)
            if debuff.flameShock.remain(units.dyn40) > getCastTime(spell.lavaBurst) and (cd.lavaBurst == 0 or buff.ascendance.exists()) then
                if cast.lavaBurst() then return end
            end
        -- Flame Shock
            -- flame_shock,if=maelstrom>=20&buff.elemental_focus.up,target_if=refreshable
            if power >= 20 and buff.elementalFocus.exists() and debuff.flameShock.refresh(units.dyn40) and ttd(units.dyn40) > 15 then
                if cast.flameShock() then return end
            end
        -- Earth Shock
            -- earth_shock,if=maelstrom>=111|!artifact.swelling_maelstrom.enabled&maelstrom>=86
            if power >= 111 or (not artifact.swellingMaelstrom and power >= 86) then
                if cast.earthShock() then return end
            end
        -- Totem Mastery
            -- totem_mastery,if=buff.resonance_totem.remains<10|(buff.resonance_totem.remains<(buff.ascendance.duration+cooldown.ascendance.remains)&cooldown.ascendance.remains<15)
            if (resonanceTotemTimer < 10 or (resonanceTotemTimer < (buff.ascendance.duration() + cd.ascendance) and cd.ascendance < 15)) and lastSpell ~= spell.totemMastery then
                if cast.totemMastery() then resonanceTotemCastTime = GetTime() + 120; return end
            end
        -- Earthquake
            -- earthquake,if=buff.echoes_of_the_great_sundering.up
            if buff.echoesOfTheGreatSundering.exists() then
                if cast.earthquake() then return end
            end
        -- Lava Beam
            -- lava_beam,if=active_enemies>1&spell_targets.lava_beam>1
            if #enemies.yards40 > 1 and not mode.rotation == 3 then
                if cast.lavaBeam() then return end
            end
        -- Lightning Bolt
            -- lightning_bolt,if=buff.power_of_the_maelstrom.up&spell_targets.chain_lightning<3
            if buff.powerOfTheMaelstrom.exists() and #enemies.yards8t < 3 then
                if cast.lightningBolt() then return end
            end
        -- Chain Lightning
            -- chain_lightning,if=active_enemies>1&spell_targets.chain_lightning>1
            if #enemies.yards8t > 1 or mode.rotation == 2 then
                if cast.chainLightning() then return end
            end
        -- Lightning Bolt
            -- lightning_bolt
            if #enemies.yards8t <= 1 or mode.rotation == 3 then
                if cast.lightningBolt() then return end
            end
        -- Flame Shock
            -- flame_shock,moving=1,target_if=refreshable
            if moving and debuff.flameShock.refresh(units.dyn40) and ttd(units.dyn40) > 15 then
                if cast.flameShock() then return end
            end
        -- Earth Shock
            -- earth_shock,moving=1
            if moving then
                if cast.earthShock() then return end
            end
        -- Flame Shock
            -- flame_shock,moving=1,if=movement.distance>6
            if moving and getDistance("target") > 6 and ttd("target") > 15 then
                if cast.flameShock("target") then return end
            end
        end -- End Action List - Single Target: Ascendance
    -- Action List - Single Target: Icefury
        local function actionList_Icefury()
        -- Flame Shock
            -- flame_shock,if=!ticking|dot.flame_shock.remains<=gcd
            if debuff.flameShock.count() < 3 then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if ((isBoss() and bossHPLimit(thisUnit,10)) or solo) and (hasThreat(thisUnit) or isDummy(thisUnit)) then 
                        if debuff.flameShock.refresh(thisUnit) and ttd(thisUnit) > 15 then --and (not debuff.flameShock.exists(thisUnit) or debuff.flameShock.remain(thisUnit) <= gcd) then
                            if cast.flameShock(thisUnit) then return end
                        end
                    end
                end
            end
        -- Earthquake
            -- earthquake,if=buff.echoes_of_the_great_sundering.up&maelstrom>=86
            if buff.echoesOfTheGreatSundering.exists() and power >= 86 then
                if cast.earthquake() then return end
            end
        -- Frost Shock
            -- frost_shock,if=buff.icefury.up&maelstrom>=111
            if buff.icefury.exists() and power >= 111 then
                if cast.frostShock() then return end
            end
        -- Earth Shock
            -- earth_shock,if=maelstrom>=117|!artifact.swelling_maelstrom.enabled&maelstrom>=92
            if power >= 117 or (not artifact.swellingMaelstrom and power >= 92) then
                if cast.earthShock() then return end
            end
        -- Stormkeeper
            -- stormkeeper,if=raid_event.adds.count<3|raid_event.adds.in>50
            if getOptionValue("神器技能") == 1 or (getOptionValue("神器技能") == 2 and useCDs()) and (#enemies.yards40 < 3 or addsIn > 50) then
                if cast.stormkeeper() then return end
            end
        -- Elemental Blast
            -- elemental_blast
            if cast.elementalBlast() then return end
        -- Ice Fury
            -- icefury,if=raid_event.movement.in<5|maelstrom<=101
            if moveIn < 5 or power <= 101 then
                if cast.icefury() then return end
            end
        -- Liquid Magma Totem
            -- liquid_magma_totem,if=raid_event.adds.count<3|raid_event.adds.in>50
            if (#enemies.yards8 < 3) and getDistance(units.dyn8) < 8 and lastSpell ~= spell.liquidMagmaTotem then
                if cast.liquidMagmaTotem("target") then return end
            end
        -- Lightning Bolt
            -- lightning_bolt,if=buff.power_of_the_maelstrom.up&buff.stormkeeper.up&spell_targets.chain_lightning<3
            if buff.powerOfTheMaelstrom.exists() and buff.stormkeeper.exists() and #enemies.yards8t < 3 then
                if cast.lightningBolt() then return end
            end
        -- Lava Burst
            -- lava_burst,if=dot.flame_shock.remains>cast_time&cooldown_react
            if debuff.flameShock.remain(units.dyn40) > getCastTime(spell.lavaBurst) and cd.lavaBurst == 0 then
                if cast.lavaBurst() then return end
            end
        -- Frost Shock
            -- frost_shock,if=buff.icefury.up&((maelstrom>=20&raid_event.movement.in>buff.icefury.remains)|buff.icefury.remains<(1.5*spell_haste*buff.icefury.stack+1))
            if buff.icefury.exists() and power >= 20 and buff.icefury.remain() < (1.5 * UnitSpellHaste("player") * buff.icefury.stack() + 1) then
                if cast.frostShock() then return end
            end
        -- Flame Shock
            -- flame_shock,if=maelstrom>=20&buff.elemental_focus.up,target_if=refreshable
            if power >= 20 and buff.elementalFocus.exists() and debuff.flameShock.refresh(units.dyn40) and ttd(units.dyn40) > 15 then
                if cast.flameShock() then return end
            end
        -- Frost Shock
            -- frost_shock,moving=1,if=buff.icefury.up
            if moving and buff.icefury.exists() and power >= 20 then
                if cast.frostShock() then return end
            end
        -- Earth Shock
            -- earth_shock,if=maelstrom>=111|!artifact.swelling_maelstrom.enabled&maelstrom>=86
            if power >= 111 or (not artifact.swellingMaelstrom and power >= 86) then
                if cast.earthShock() then return end
            end
        -- Totem Mastery
            -- totem_mastery,if=buff.resonance_totem.remains<10
            if resonanceTotemTimer < 10 and lastSpell ~= spell.totemMastery then
                if cast.totemMastery() then resonanceTotemCastTime = GetTime() + 120; return end
            end
        -- Earthquake
            -- earthquake,if=buff.echoes_of_the_great_sundering.up
            if buff.echoesOfTheGreatSundering.exists() then
                if cast.earthquake() then return end
            end
        -- Lightning Bolt
            -- lightning_bolt,if=buff.power_of_the_maelstrom.up&spell_targets.chain_lightning<3
            if buff.powerOfTheMaelstrom.exists() and #enemies.yards8t < 3 then
                if cast.lightningBolt() then return end
            end
        -- Chain Lightning
            -- chain_lightning,if=active_enemies>1&spell_targets.chain_lightning>1
            if (#enemies.yards8t > 1 or mode.rotation == 2) then
                if cast.chainLightning() then return end
            end
        -- Lightning Bolt
            -- lightning_bolt
            if (#enemies.yards8t <= 1 or mode.rotation == 3) then
                if cast.lightningBolt() then return end
            end
        -- Flame Shock
            -- flame_shock,moving=1,target_if=refreshable
            if moving and debuff.flameShock.refresh(units.dyn40) and ttd(units.dyn40) > 15 then
                if cast.flameShock() then return end
            end
        -- Earth Shock
            -- earth_shock,moving=1
            if moving then
                if cast.earthShock() then return end
            end
        -- Flame Shock
            -- flame_shock,moving=1,if=movement.distance>6
            if moving and getDistance("target") > 6 and ttd("target") > 15 then
                if cast.flameShock("target") then return end
            end
        end -- End Action List - Single Target: Icy Fury
    -- Action List - Single Target: Lightning Rod
        local function actionList_LightningRod()
        -- Flame Shock
            -- flame_shock,if=!ticking|dot.flame_shock.remains<=gcd
            if debuff.flameShock.count() < 3 then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if ((isBoss() and bossHPLimit(thisUnit,10)) or solo) and (hasThreat(thisUnit) or isDummy(thisUnit)) then 
                        if debuff.flameShock.refresh(thisUnit) and ttd(thisUnit) > 15 then
                            if cast.flameShock(thisUnit) then return end
                        end
                    end
                end
            end
        -- Earthquake
            -- earthquake,if=buff.echoes_of_the_great_sundering.up&maelstrom>=86
            if buff.echoesOfTheGreatSundering.exists() and power >= 86 then
                if cast.earthquake() then return end
            end
        -- Earth Shock
            -- earth_shock,if=maelstrom>=117|!artifact.swelling_maelstrom.enabled&maelstrom>=92
            if power >= 117 or (not artifact.swellingMaelstrom and power >= 92) then
                if cast.earthShock() then return end
            end
        -- Stormkeeper
            -- stormkeeper,if=raid_event.adds.count<3|raid_event.adds.in>50
            if getOptionValue("神器技能") == 1 or (getOptionValue("神器技能") == 2 and useCDs()) and (#enemies.yards40 < 3) then
                if cast.stormkeeper() then return end
            end
        -- Elemental Blast
            -- elemental_blast
            if cast.elementalBlast() then return end
        -- Liquid Magma Totem
            -- liquid_magma_totem,if=raid_event.adds.count<3|raid_event.adds.in>50
            if (#enemies.yards8 < 3) and getDistance(units.dyn8) < 8 and lastSpell ~= spell.liquidMagmaTotem then
                if cast.liquidMagmaTotem("target") then return end
            end
        -- Lava Burst
            -- lava_burst,if=dot.flame_shock.remains>cast_time&cooldown_react
            if debuff.flameShock.remain(units.dyn40) > getCastTime(spell.lavaBurst) and cd.lavaBurst == 0 then
                if cast.lavaBurst() then return end
            end
        -- Flame Shock
            -- flame_shock,if=maelstrom>=20&buff.elemental_focus.up,target_if=refreshable
            if power >= 20 and buff.elementalFocus.exists() and debuff.flameShock.exists(units.dyn40) and debuff.flameShock.refresh(units.dyn40) and ttd(units.dyn40) > 15 then
                if cast.flameShock() then return end
            end
        -- Earth Shock
            -- earth_shock,if=maelstrom>=111|!artifact.swelling_maelstrom.enabled&maelstrom>=86
            if power >= 111 or (not artifact.swellingMaelstrom and power >= 86) then
                if cast.earthShock() then return end
            end
        -- Totem Mastery
            -- totem_mastery,if=buff.resonance_totem.remains<10|(buff.resonance_totem.remains<(buff.ascendance.duration+cooldown.ascendance.remains)&cooldown.ascendance.remain()s<15)
            if (resonanceTotemTimer < 10 or (resonanceTotemTimer < (buff.ascendance.duration() + cd.ascendance) and cd.ascendance < 15)) and lastSpell ~= spell.totemMastery then
                if cast.totemMastery() then resonanceTotemCastTime = GetTime() + 120; return end
            end
        -- Earthquake
            -- earthquake,if=buff.echoes_of_the_great_sundering.up
            if buff.echoesOfTheGreatSundering.exists() then
                if cast.earthquake() then return end
            end
        -- Lightning Bolt
            -- lightning_bolt,if=buff.power_of_the_maelstrom.up&spell_targets.chain_lightning<3,target_if=debuff.lightning_rod.down
            if buff.powerOfTheMaelstrom.exists() and #enemies.yards8t < 3 and not debuff.lightningRod.exists(units.dyn40) then
                if cast.lightningBolt() then return end
            end
            -- lightning_bolt,if=buff.power_of_the_maelstrom.up&spell_targets.chain_lightning<3
            if buff.powerOfTheMaelstrom.exists() and #enemies.yards8t < 3 then
                if cast.lightningBolt() then return end
            end
        -- Chain Lightning
            -- chain_lightning,if=active_enemies>1&spell_targets.chain_lightning>1,target_if=debuff.lightning_rod.down
            if (#enemies.yards8t > 1 or mode.rotation == 2) and not debuff.lightningRod.exists(units.dyn40) then
                if cast.chainLightning() then return end
            end
            -- chain_lightning,if=active_enemies>1&spell_targets.chain_lightning>1
            if (#enemies.yards8t > 1 or mode.rotation == 2) then
                if cast.chainLightning() then return end
            end
        -- Lightning Bolt
            -- lightning_bolt,target_if=!debuff.lightning_rod.up
            if (#enemies.yards8t <= 1 or mode.rotation == 3) and not debuff.lightningRod.exists(units.dyn40) then
                if cast.lightningBolt() then return end
            end
            -- lightning_bolt
            if (#enemies.yards8t <= 1 or mode.rotation == 3) then
                if cast.lightningBolt() then return end
            end
        -- Flame Shock
            -- flame_shock,moving=1,target_if=refreshable
            if moving and debuff.flameShock.refresh(units.dyn40) and ttd(units.dyn40) > 15 then
                if cast.flameShock() then return end
            end
        -- Earth Shock
            -- earth_shock,moving=1
            if moving then
                if cast.earthShock() then return end
            end
        -- Flame Shock
            -- flame_shock,moving=1,if=movement.distance>6
            if moving and getDistance("target") > 6 and ttd("target") > 15 then
                if cast.flameShock("target") then return end
            end
        end  -- End Single Target Action List
---------------------
--- Begin Profile ---
---------------------
    -- Profile Stop | Pause
        if not inCombat and not hastar and profileStop==true then
            profileStop = false
        elseif (inCombat and profileStop==true) or pause() or IsMounted() or mode.rotation==4 then
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
--------------------------
--- In Combat Rotation ---
--------------------------
            if inCombat and profileStop==false and isValidUnit(units.dyn40) and getDistance(units.dyn40) < 40 then
    ------------------------------
    --- In Combat - Interrupts ---
    ------------------------------
                if actionList_Interrupts() then return end
    ---------------------------
    --- SimulationCraft APL ---
    ---------------------------
                if getOptionValue("APL模式") == 1 then
            -- Potion - Deadly Grace
                    -- if=buff.ascendance.up|target.time_to_die<=30
                    -- TODO
            -- Totem Mastery
                    -- totem_mastery,if=buff.resonance_totem.remain()s<2
                    if resonanceTotemTimer < 2 and lastSpell ~= spell.totemMastery then
                        if cast.totemMastery() then resonanceTotemCastTime = GetTime() + 120; return end
                    end
                    if useCDs() then
                        if isChecked("风暴元素") then
            -- Fire Elemental
                            -- fire_elemental
                            if cast.fireElemental() then return end
            -- Storm Elemental
                            -- storm_elemental
                            if cast.stormElemental() then return end
                        end
                        if isChecked("元素掌握") then
            -- Elemental Mastery
                            -- elemental_mastery
                            if cast.elementalMastery() then return end
                        end
            -- Trinkets
                        if isChecked("饰品") then
                            if canUse(13) then
                                useItem(13)
                            end
                            if canUse(14) then
                                useItem(14)
                            end
                        end
        -- Legendary Ring
                        -- use_item,slot=finger1
                        if isChecked("传奇戒指") then
                            if hasEquiped(124636) and canUse(124636) then
                                useItem(124636)
                            end
                        end
        -- Gnawed Thumb Ring
                        -- use_item,name=gnawed_thumb_ring,if=equipped.gnawed_thumb_ring&(talent.ascendance.enabled&!buff.ascendance.up|!talent.ascendance.enabled)
                        if hasEquiped(134526) and ((talent.ascendance and not buff.ascendance) or not talent.ascendance) then
                            useItem(134526)
                        end
        -- Racial: Orc Blood Fury | Troll Berserking
                        -- blood_fury,if=!talent.ascendance.enabled|buff.ascendance.up|cooldown.ascendance.remain()s>50
                        -- berserking,if=!talent.ascendance.enabled|buff.ascendance.up
                        if isChecked("种族技能") and getSpellCD(racial) == 0 then
                            if not talent.ascendance or buff.ascendance.exists() or cd.ascendance > 50 then
                                if br.player.race == "Orc" then
                                    if castSpell("player",racial,false,false,false)  then return end
                                end
                            end
                            if not talent.ascendance or buff.ascendance.exists() then
                                if br.player.race == "Troll" then
                                    if castSpell("player",racial,false,false,false)  then return end
                                end
                            end
                        end
                    end
            -- Action List - Multi Target
                    -- run_action_list,name=aoe,if=active_enemies>2&(spell_targets.chain_lightning>2|spell_targets.lava_beam>2)
                    if (#enemies.yards8t > 2 and mode.rotation == 1) or mode.rotation == 2 then
                        if actionList_MultiTarget() then return end
                    end
            -- Action List - Single Target: Ascendance
                    -- run_action_list,name=single_asc,if=talent.ascendance.enabled
                    if talent.ascendance and ((#enemies.yards8t <= 2 and mode.rotation == 1) or mode.rotation == 3) then
                        if actionList_Ascendance() then return end
                    end
                    -- run_action_list,name=single_if,if=talent.icefury.enabled
                    if talent.icefury and ((#enemies.yards8t <= 2 and mode.rotation == 1) or mode.rotation == 3) then
                        if actionList_Icefury() then return end
                    end
                    -- run_action_list,name=single_lr,if=talent.lightning_rod.enabled
                    if (talent.lightningRod or level < 100) and ((#enemies.yards8t <= 2 and mode.rotation == 1) or mode.rotation == 3) then
                        if actionList_LightningRod() then return end
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
local id = 262
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})
