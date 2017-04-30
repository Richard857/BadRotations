local rotationName = "CuteOne"

---------------
--- Toggles ---
---------------
local function createToggles()
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "基于范围内的目标数,在单目标和多目标自动切换输出方式.", highlight = 1, icon = br.player.spell.crashLightning},
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "使用多目标方式输出.", highlight = 0, icon = br.player.spell.crashLightning},
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "使用单目标方式输出.", highlight = 0, icon = br.player.spell.rockbiter},
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "禁用DPS输出", highlight = 0, icon = br.player.spell.healingSurge}
    };
    CreateButton("Rotation",1,0)
-- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "自动使用大技能 - 只在BOSS.", highlight = 1, icon = br.player.spell.feralSpirit},
        [2] = { mode = "On", value = 1 , overlay = "Cooldowns Enabled", tip = "不管任何目标都使用大技能.", highlight = 0, icon = br.player.spell.feralSpirit},
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "不使用大技能.", highlight = 0, icon = br.player.spell.feralSpirit}
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
            br.ui:createDropdownWithout(section, "APL模式", {"|cffFFFFFFSimC","|cffFFFFFFAMR"}, 1, "|cffFFFFFF选择输出循环.")
        -- Dummy DPS Test
            br.ui:createSpinner(section, "DPS测试",  5,  5,  60,  5,  "|cffFFFFFF设置为所需的测试的时间（分钟）. 最小: 5 / 最大: 60 / 间隔: 5")
        -- Pre-Pull Timer
            br.ui:createSpinner(section, "Pre-Pull Timer",  5,  1,  10,  1,  "|cffFFFFFF设置为所需的启动时间 Pre-Pull (必须有DBM). 最小: 1 / 最大: 10 / 间隔: 1")
        -- Artifact
            br.ui:createDropdownWithout(section,"神器技能", {"|cff00FF00任何时候","|cffFFFF00冷却技能","|cffFF0000决不"}, 1, "|cffFFFFFF何时使用神器技能.")
        -- Ghost Wolf
            br.ui:createCheckbox(section,"幽魂之狼")
        -- Feral Lunge
            br.ui:createCheckbox(section,"狂野扑击")
        -- Lightning Bolt OOC
            br.ui:createCheckbox(section,"闪电箭 脱离战斗")
        -- Spirit Walk
            br.ui:createCheckbox(section,"幽魂步")
        -- Water Walking
            br.ui:createCheckbox(section,"水上行走")
        br.ui:checkSectionState(section)
    -- Cooldown Options
        section = br.ui:createSection(br.ui.window.profile, "冷却技能")
        -- Agi Pot
            br.ui:createCheckbox(section,"爆发药水")
        -- Flask / Crystal
            br.ui:createCheckbox(section,"奥拉留斯的低语水晶")
        -- Racial
            br.ui:createCheckbox(section,"种族技能")
        -- Ring of Collapsing Futures
            br.ui:createCheckbox(section,"黑暗前途指环")
        -- Trinkets
            br.ui:createCheckbox(section,"饰品")
        -- Ascendance
            br.ui:createCheckbox(section,"升腾")
        -- Feral Spirit
            br.ui:createCheckbox(section,"野性狼魂")
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
            br.ui:createDropdown(section, "先祖之魂", {"|cffFFFF00所选的目标","|cffFF0000鼠标位置目标"}, 1, "|ccfFFFFFFT施放技能")
        -- Astral Shift
            br.ui:createSpinner(section, "星界转移",  50,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用")
        -- Cleanse Spirit
            br.ui:createDropdown(section, "净化灵魂", {"|cff00FF00只有自己","|cffFFFF00所选的目标","|cffFF0000鼠标位置目标"}, 1, "|ccfFFFFFF施放技能")
        -- Healing Surge
            br.ui:createSpinner(section, "治疗之涌",  80,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用")
        -- Lightning Surge Totem
            br.ui:createSpinner(section, "闪电奔涌图腾 - HP", 50, 0, 100, 5, "|cffFFFFFF多少血量百分比使用")
            br.ui:createSpinner(section, "闪电奔涌图腾 - AoE", 5, 0, 10, 1, "|cffFFFFFF投5码的单位数量")
        -- Purge
            br.ui:createCheckbox(section,"净化术")
        -- Rainfall
            br.ui:createSpinner(section, "降雨",  50,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用")
        br.ui:checkSectionState(section)
    -- Interrupt Options
        section = br.ui:createSection(br.ui.window.profile, "打断")
        -- Wind Shear
            br.ui:createCheckbox(section,"风剪")
        -- Hex
            br.ui:createCheckbox(section,"妖术")
        -- Lightning Surge Totem
            br.ui:createCheckbox(section,"闪电奔涌图腾")
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
        local deadMouse, hasMouse, playerMouse              = UnitIsDeadOrGhost("mouseover"), GetObjectExists("mouseover"), UnitIsPlayer("mouseover")
        local deadtar, attacktar, hastar, playertar         = UnitIsDeadOrGhost("target"), UnitCanAttack("target", "player"), GetObjectExists("target"), UnitIsPlayer("target")
        local debuff                                        = br.player.debuff
        local enemies                                       = enemies or {}
        local falling, swimming, flying, moving             = getFallTime(), IsSwimming(), IsFlying(), GetUnitSpeed("player") > 0
        local flaskBuff                                     = getBuffRemain("player",br.player.flask.wod.buff.agilityBig)
        local friendly                                      = UnitIsFriend("target", "player")
        local gcd                                           = br.player.gcd
        local hastar                                        = GetObjectExists("target")
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
        -- local multidot                                      = (useCleave() or br.player.mode.rotation ~= 3)
        local perk                                          = br.player.perk
        local php                                           = br.player.health
        local power, powmax, powgen, powerDeficit           = br.player.power.amount.maelstrom, br.player.power.maelstrom.max, br.player.power.regen, br.player.power.maelstrom.deficit
        local pullTimer                                     = br.DBM:getPulltimer()
        local racial                                        = br.player.getRacial()
        local recharge                                      = br.player.recharge
        local solo                                          = br.player.instance=="none"
        local spell                                         = br.player.spell
        local t19pc4                                        = TierScan("T19") >= 4
        local talent                                        = br.player.talent
        local ttd                                           = getTTD
        local ttm                                           = br.player.power.ttm
        local units                                         = units or {}
        
        units.dyn8 = br.player.units(8)
        units.dyn10 = br.player.units(10)
        enemies.yards5 = br.player.enemies(5)
        enemies.yards8 = br.player.enemies(8)
        enemies.yards10 = br.player.enemies(10)
        enemies.yards20 = br.player.enemies(20)
        enemies.yards30 = br.player.enemies(30)

        if profileStop == nil then profileStop = false end
        if feralSpiritCastTime == nil then feralSpiritCastTime = 0 end
        if feralSpiritRemain == nil then feralSpiritRemain = 0 end
        if lastSpell == spell.feralSpirit then feralSpiritCastTime = GetTime() + 15 end
        if feralSpiritCastTime > GetTime() then feralSpiritRemain = feralSpiritCastTime - GetTime() else feralSpiritCastTime = 0; feralSpiritRemain = 0 end
        if crashLightningCastTime == nil then crashLightningCastTime = 0 end
        if crashingStormTimer == nil then crashingStormTimer = 0 end
        if lastSpell == spell.crashLightning then crashLightningCastTime = GetTime() + 6 end
        if crashLightningCastTime > GetTime() then crashingStormTimer = crashLightningCastTime - GetTime() else crashLightningCastTime = 0; crashingStormTimer = 0 end

        -- Fury of Air
        if buff.furyOfAir.exists() and (power < 12 or #enemies.yards8 == 0 or not inCombat) then
            if cast.furyOfAir() then return end
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
            if isChecked("幽魂之狼") and not UnitBuffID("player",202477) and not (IsMounted() or IsFlying()) then
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
                    if cast.giftOfTheNaaru() then return end
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
        -- Healing Surge
                if isChecked("治疗之涌")
                    and ((inCombat and ((php <= getOptionValue("治疗之涌") / 2 and power > 20)
                        or (power >= 90 and php <= getOptionValue("治疗之涌")))) or (not inCombat and php <= getOptionValue("治疗之涌") and not moving))
                then
                    if cast.healingSurge() then return end
                end
        -- Lightning Surge Totem
                if isChecked("闪电奔涌图腾 - HP") and php <= getOptionValue("闪电奔涌图腾 - HP") and inCombat and #enemies.yards5 > 0 then
                    if cast.lightningSurgeTotem("player","ground") then return end
                end
                if isChecked("闪电奔涌图腾 - AoE") and #enemies.yards5 >= getOptionValue("闪电奔涌图腾 - AoE") and inCombat then
                    if cast.lightningSurgeTotem("best",nil,getOptionValue("闪电奔涌图腾 - AoE"),8) then return end
                end
        -- Rainfall
                if isChecked("降雨") and php <= getOptionValue("降雨") then
                    if cast.rainfall() then return end
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
                            if hasThreat(thisUnit) and not isMoving(thisUnit) and ttd(thisUnit) > 7 then
                                if cast.lightningSurgeTotem(thisUnit,"ground") then return end
                            end
                        end
                    end
                end
            end -- End useInterrupts check
        end -- End Action List - Interrupts
    -- Action List - Cooldowns
        local function actionList_Cooldowns()
            if useCDs() and getDistance("target") < 5 then
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
        -- Feral Spirit
                -- feral_spirit,if=!artifact.alpha_wolf.rank|(maelstrom>=20&cooldown.crash_lightning.remain()s<=gcd)
                if isChecked("野性狼魂") then
                    if not artifact.alphaWolf or (power >= 20 and cd.crashLightning <= gcd) then
                        if cast.feralSpirit() then return end
                    end
                end
        -- Crash Lightning
                -- crash_lightning,if=artifact.alpha_wolf.rank&prev_gcd.feral_spirit
                if artifact.alphaWolf and lastSpell == spell.feralSpirit and getEnemiesInCone(7,100) >= 1 then
                --#enemies.yards8 > 0 and getFacing("player",units.dyn8,120)
                    if cast.crashLightning() then return end
                end
        -- Ring of Collapsing Futures
                -- use_item,slot=finger1,if=buff.temptation.down
                if isChecked("黑暗前途指环") then
                    if hasEquiped(142173) and canUse(142173) and not debuff.temptation.exists("player") then
                        useItem(142173)
                    end
                end
        -- Racial: Orc Blood Fury | Troll Berserking | Blood Elf Arcane Torrent
                -- berserking,if=buff.ascendance.up|!talent.ascendance.enabled|level<100
                -- blood_fury
                if isChecked("种族技能") and (br.player.race == "Orc" or (br.player.race == "Troll" and (buff.ascendance.exists() or not talent.ascendance or level < 100))) and getSpellCD(racial) == 0 then
                    if castSpell("player",racial,false,false,false) then return end
                end
        -- Potion
                -- potion,name=prolonged_power,if=feral_spirit.remain()s>5
                if isChecked("爆发药水") and canUse(142117) and inRaid then
                    if feralSpiritRemain > 5 and not buff.prolongedPower.exists() then
                        useItem(142117)
                    end
                end
                if getOptionValue("APL模式") == 1 then -- SimC

                end
                if getOptionValue("APL模式") == 2 then -- AMR

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
            -- Lightning Shield
                -- /lightning_shield
                if cast.lightningShield() then return end
                if isChecked("Pre-Pull Timer") and pullTimer <= getOptionValue("Pre-Pull Timer") then
            -- Potion
                    -- potion,name=prolonged_power,if=feral_spirit.remain()s>5
                    if isChecked("爆发药水") and canUse(142117) and inRaid then
                        if feralSpiritRemain > 5 and not buff.prolongedPower.exists() then
                            useItem(142117)
                        end
                    end
                end -- End Pre-Pull
                if isValidUnit("target") then
            -- Feral Lunge
                    if isChecked("狂野扑击") then
                        if cast.feralLunge("target") then return end
                    end
            -- Lightning Bolt
                    if getDistance("target") >= 10 and isChecked("闪电箭 脱离战斗") and not talent.overcharge
                        and (not isChecked("狂野扑击") or not talent.feralLunge or cd.feralLunge > gcd or not castable.feralLunge)
                    then
                        if cast.lightningBolt("target") then return end
                    end
            -- Start Attack
                    if getDistance("target") < 5 then
                        StartAttack()
                    end
                end
            end -- End No Combat
        end -- End Action List - PreCombat
---------------------
--- Begin Profile ---
---------------------
    -- Profile Stop | Pause
        if not inCombat and not hastar and profileStop==true then
            profileStop = false
        elseif (inCombat and profileStop==true) or pause() or IsMounted() or IsFlying() or mode.rotation==4 then
            if buff.furyOfAir.exists() then
                cast.furyOfAir()
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
--------------------------
--- In Combat Rotation ---
--------------------------
            if inCombat and isValidUnit(units.dyn10) and profileStop==false then
    ------------------------------
    --- In Combat - Interrupts ---
    ------------------------------
                if actionList_Interrupts() then return end
    -----------------------------
    --- In Combat - Cooldowns ---
    -----------------------------
                if actionList_Cooldowns() then return end
    ---------------------------
    --- SimulationCraft APL ---
    ---------------------------
                if getOptionValue("APL模式") == 1 then
            --[[ Fury of Air - Off
                    -- if TargetsInRadius(FuryOfAir) = 1
                    if buff.furyOfAir.exists() and (power <= 12 or #enemies.yards8 == 0) then
                        if cast.furyOfAir() then return end
                    end]]
            -- Feral Lunge
                    if isChecked("狂野扑击") and hasThreat("target") then
                        if cast.feralLunge("target") then return end
                    end
            -- Start Attack
                    if getDistance("target") <= 5 then
                        StartAttack()
                    end
            -- Boulderfist
                    -- boulderfist,if=buff.boulderfist.remain()s<gcd|(maelstrom<=50&active_enemies>=3)
                    if buff.boulderfist.remain() < gcd or (power <= 50 and ((mode.rotation == 1 and #enemies.yards5 >= 3) or mode.rotation == 2)) then
                        if cast.boulderfist() then return end
                    end
                    -- boulderfist,if=buff.boulderfist.remain()s<gcd|(charges_fractional>1.75&maelstrom<=100&active_enemies<=2)
                    if buff.boulderfist.remain() < gcd or (charges.frac.boulderfist > 1.75 and power <= 100 and #enemies.yards5 <= 2) then
                        if cast.boulderfist() then return end
                    end
            -- Rockbiter
                    -- rockbiter,if=talent.landslide.enabled&buff.landslide.remain()s<gcd
                    if talent.landslide and buff.landslide.remain() < gcd then
                        if cast.rockbiter() then return end
                    end
            -- Fury of Air
                    -- fury_of_air,if=!ticking&maelstrom>22
                    if not buff.furyOfAir.exists() and power > 22 and #enemies.yards8 > 0 then
                        if cast.furyOfAir() then return end
                    end
            -- Frostbrand
                    -- frostbrand,if=talent.hailstorm.enabled&buff.frostbrand.remain()s<gcd
                    if talent.hailstorm and buff.frostbrand.remain() < gcd then
                        if cast.frostbrand() then return end
                    end
            -- Flametongue
                    -- flametongue,if=buff.flametongue.remain()s<gcd|(cooldown.doom_winds.remain()s<6&buff.flametongue.remain()s<4)
                    if buff.flametongue.remain() < gcd or (cd.doomWinds < 6 and buff.flametongue.remain() < 4) then
                        if cast.flametongue() then return end
                    end
            -- Doom Winds
                    -- doom_winds
                    if (getOptionValue("神器技能") == 1 or (getOptionValue("神器技能") == 2 and useCDs())) and getDistance("target") < 5 then
                        if cast.doomWinds() then return end
                    end
            -- Crash Lightning
                    -- crash_lightning,if=talent.crashing_storm.enabled&active_enemies>=3&(!talent.hailstorm.enabled|buff.frostbrand.remain()s>gcd)
                    if ((mode.rotation == 1 and getEnemiesInCone(7,100) >= 3) or mode.rotation == 2) then
                        if talent.crashingStorm  and (not talent.hailstorm or buff.frostbrand.remain() > gcd) then
                            if cast.crashLightning() then return end
                        end
                    end
            -- Earthen Spike
                    -- earthen_spike
                    if cast.earthenSpike() then return end
            -- Lightning Bolt
                    -- lightning_bolt,if=(talent.overcharge.enabled&maelstrom>=40&!talent.fury_of_air.enabled)|(talent.overcharge.enabled&talent.fury_of_air.enabled&maelstrom>46)
                    if (talent.overcharge and power >= 40 and not talent.furyOfAir) or (talent.overcharge and talent.furyOfAir and power > 46) then
                        if cast.lightningBolt() then return end
                    end
            -- Crash Lightning
                    -- crash_lightning,if=buff.crash_lightning.remain()s<gcd&active_enemies>=2
                    if buff.crashLightning.remain() < gcd and ((mode.rotation == 1 and getEnemiesInCone(7,100) >= 2) or mode.rotation == 2) then
                        if cast.crashLightning() then return end
                    end
            -- Windsong
                    -- windsong
                    if cast.windsong() then return end
            -- Ascendance
                    -- ascendance,if=buff.stormbringer.react
                    if useCDs() then
                        if buff.stormbringer.exists() then
                            if cast.ascendance() then return end
                        end
                    end
            -- Stormstrike/Windstrike
                    -- if=buff.stormbringer.react&((talent.fury_of_air.enabled&maelstrom>=26)|(!talent.fury_of_air.enabled))
                    if buff.stormbringer.exists() and ((talent.furyOfAir and power >= 26) or (not talent.furyOfAir)) then
                        if buff.ascendance.exists() then
                            if cast.windstrike() then return end
                        else
                            if cast.stormstrike() then return end
                        end
                    end
            -- Lava Lash
                    -- lava_lash,if=talent.hot_hand.enabled&buff.hot_hand.react
                    if talent.hotHand and buff.hotHand.exists() then
                        if cast.lavaLash() then return end
                    end
            -- Crash Lightning
                    -- crash_lightning,if=active_enemies>=4
                    if ((mode.rotation == 1 and getEnemiesInCone(7,100) >= 4) or mode.rotation == 2) then
                        if cast.crashLightning() then return end
                    end
            -- Windstrike
                    -- windstrike
                    if buff.ascendance.exists() then
                        if cast.windstrike() then return end
                    end
            -- Stormstrike
                    -- stormstrike,if=talent.overcharge.enabled&cooldown.lightning_bolt.remain()s<gcd&maelstrom>80
                    if not buff.ascendance.exists() and talent.overcharge and cd.lightningBolt < gcd and power > 80 then
                        if cast.stormstrike() then return end
                    end
                    -- stormstrike,if=talent.fury_of_air.enabled&maelstrom>46&(cooldown.lightning_bolt.remain()s>gcd|!talent.overcharge.enabled)
                    if not buff.ascendance.exists() and talent.furyOfAir and power > 46 and (cd.lightningBolt > gcd or not talent.overcharge) then
                        if cast.stormstrike() then return end
                    end
                    -- stormstrike,if=!talent.overcharge.enabled&!talent.fury_of_air.enabled
                    if not talent.overcharge and not talent.furyOfAir then
                        if cast.stormstrike() then return end
                    end
            -- Crash Lightning
                    -- crash_lightning,if=((active_enemies>1|talent.crashing_storm.enabled|talent.boulderfist.enabled)&!set_bonus.tier19_4pc)|feral_spirit.remain()s>5
                    if (((mode.rotation == 1 and getEnemiesInCone(7,100) > 1) or talent.crashingStorm or talent.boulderfist or mode.rotation == 2) and not t19pc4) or (feralSpiritRemain > 5 and artifact.alphaWolf) then
                        if cast.crashLightning() then return end
                    end
            -- Frostbrand
                    -- frostbrand,if=talent.hailstorm.enabled&buff.frostbrand.remain()s<4.8
                    if talent.hailstorm and buff.frostbrand.remain() < 4.8 then
                        if cast.frostbrand() then return end
                    end
            -- Lava Lash
                    -- lava_lash,if=talent.fury_of_air.enabled&talent.overcharge.enabled&(set_bonus.tier19_4pc&maelstrom>=80)
                    if talent.furyOfAir and talent.overcharge and (t19pc4 and power >= 80) then
                        if cast.lavaLash() then return end
                    end
                    -- lava_lash,if=talent.fury_of_air.enabled&!talent.overcharge.enabled&(set_bonus.tier19_4pc&maelstrom>=53)
                    if talent.furyOfAir and not talent.overcharge and (t19pc4 and power >= 53) then
                        if cast.lavaLash() then return end
                    end
                    -- lava_lash,if=(!set_bonus.tier19_4pc&maelstrom>=120)|(!talent.fury_of_air.enabled&set_bonus.tier19_4pc&maelstrom>=40)
                    if (not t19pc4 and power >= 120) or (not talent.furyOfAir and t19pc4 and power >= 40) then
                        if cast.lavaLash() then return end
                    end
            -- Flametongue
                    -- flametongue,if=buff.flametongue.remain()s<4.8
                    if buff.flametongue.remain() < 4.8 then
                        if cast.flametongue() then return end
                    end
            -- Sundering
                    -- sundering
                    if getDistance(units.dyn8) < 8 then
                        if cast.sundering() then return end
                    end
            -- Rockbiter
                    -- rockbiter
                    if cast.rockbiter() then return end
            -- Flametongue
                    -- flametongue
                    if cast.flametongue() then return end
            -- Boulderfist
                    -- boulderfist
                    if cast.boulderfist() then return end
                end -- End SimC APL
    ----------------------
    --- AskMrRobot APL ---
    ----------------------
                if getOptionValue("APL模式") == 2 then
            -- Fury of Air - Off
                    -- if TargetsInRadius(FuryOfAir) = 1
                    if buff.furyOfAir.exists() and #enemies.yards8 < 2 then
                        if cast.furyOfAir() then return end
                    end
            -- Boulderfist
                    -- if BuffRemainingSec(BoulderfistEnhance) <= GlobalCooldownSec or ChargesRemaining(Boulderfist) = SpellCharges(Boulderfist)
                    if buff.boulderfist.remain() <= gcd or charges.boulderfist == charges.max.boulderfist then
                        if cast.boulderfist() then return end
                    end
            -- Rockbiter
                    -- if BuffRemainingSec(Landslide) <= GlobalCooldownSec and HasTalent(Landslide)
                    if buff.landslide.remain() <= gcd and talent.landslide then
                        if cast.rockbiter() then return end
                    end
            -- Frostbrand
                    -- if BuffRemainingSec(Frostbrand) <= GlobalCooldownSec and HasTalent(Hailstorm)
                    if buff.frostbrand.remain() <= gcd and talent.hailstorm then
                        if cast.frostbrand() then return end
                    end
            -- Windsong
                    if cast.windsong() then return end
            -- Doom Winds
                    if (getOptionValue("神器技能") == 1 or (getOptionValue("神器技能") == 2 and useCDs())) and getDistance("target") < 5 then
                        if cast.doomWinds() then return end
                    end
            -- Ascendance
                    if useCDs() and lastSpell == spell.doomWinds then
                        if cast.ascendance() then return end
                    end
            -- Earthen Spike
                    if cast.earthenSpike() then return end
            -- Frostbrand
                    -- if HasTalent(Hailstorm) and BuffRemainingSec(Frostbrand) <= 0.3 * BuffDurationSec(Frostbrand)
                    if talent.hailstorm and buff.frostbrand.refresh() then
                        if cast.frostbrand() then return end
                    end
            -- Windstike
                    if cast.windstrike() then return end
            -- Stormstrike
                    if cast.stormstrike() then return end
            -- Crash Lightning
                    -- if (HasTalent(CrashingStorm) and TimerSecRemaining(CrashingStormTimer) = 0) or TargetsInRadius(CrashLightning) > 3 or (ArtifactTraitRank(GatheringStorms) > 0 and not HasBuff(GatheringStorms))
                    if (talent.crashingStorm and crashingStormTimer == 0) or getEnemiesInCone(7,100) > 3 or (artifact.gatheringStorms and not buff.gatheringStorms.exists()) then
                        if cast.crashLightning() then return end
                    end
            -- Flame Tongue
                    -- if BuffRemainingSec(Flametongue) <= 0.3 * BuffDurationSec(Flametongue)
                    if buff.flametongue.refresh() then
                        if cast.flametongue() then return end
                    end
            -- Sundering
                    if getDistance(units.dyn8) < 8 then
                        if cast.sundering() then return end
                    end
            -- Lightning Bolt
                    -- if HasTalent(Overcharge) and AlternatePower >= 45
                    if talent.overcharge and power >= 45 then
                        if cast.lightningBolt() then return end
                    end
            -- Fury of Air
                    -- if TargetsInRadius(FuryOfAir) > 1
                    if #enemies.yards8 > 1 then
                        if cast.furyOfAir() then return end
                    end
            -- Frostbrand
                    -- if HasItem(AkainusAbsoluteJustice) and not HasBuff(Frostbrand)
            -- Lava Lash
                    -- if HasBuff(HotHand) or AlternatePower > 40
                    if buff.hotHand.exists() or power > 40 then
                        if cast.lavaLash() then return end
                    end
            -- Boulderfist
                    if cast.boulderfist() then return end
            -- Rockbiter
                    if cast.rockbiter() then return end
                end
            end --End In Combat
        end --End Rotation Logic
    end -- End Timer
end -- End runRotation
local id = 263
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})
