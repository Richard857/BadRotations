local rotationName = "CuteOne"

---------------
--- Toggles ---
---------------
local function createToggles()
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "基于范围内的目标数,在单目标和多目标自动切换输出方式.", highlight = 1, icon = br.player.spell.howlingBlast },
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "使用多目标方式输出.", highlight = 0, icon = br.player.spell.howlingBlast },
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "使用单目标方式输出.", highlight = 0, icon = br.player.spell.frostStrike },
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "禁用DPS输出", highlight = 0, icon = br.player.spell.deathStrike}
    };
    CreateButton("Rotation",1,0)
-- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "自动使用大技能 - 只在BOSS.", highlight = 1, icon = br.player.spell.empowerRuneWeapon },
        [2] = { mode = "On", value = 1 , overlay = "Cooldowns Enabled", tip = "不管任何目标都使用大技能.", highlight = 0, icon = br.player.spell.empowerRuneWeapon },
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "不使用大技能.", highlight = 0, icon = br.player.spell.empowerRuneWeapon }
    };
    CreateButton("Cooldown",2,0)
-- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "使用保命技能.", highlight = 1, icon = br.player.spell.iceboundFortitude },
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "不使用保命技能.", highlight = 0, icon = br.player.spell.iceboundFortitude }
    };
    CreateButton("Defensive",3,0)
-- Interrupt Button
    InterruptModes = {
        [1] = { mode = "On", value = 1 , overlay = "Interrupts Enabled", tip = "使用打断.", highlight = 1, icon = br.player.spell.mindFreeze },
        [2] = { mode = "Off", value = 2 , overlay = "Interrupts Disabled", tip = "不使用打断.", highlight = 0, icon = br.player.spell.mindFreeze }
    };
    CreateButton("Interrupt",4,0)
end

---------------
--- OPTIONS ---
---------------
local function createOptions()
    local optionTable

    local function rotationOptions()
        -----------------------
        --- GENERAL OPTIONS ---
        -----------------------
        section = br.ui:createSection(br.ui.window.profile,  "一般")
            -- APL
            br.ui:createDropdownWithout(section, "APL模式", {"|cffFFFFFFSimC"}, 1, "|cffFFFFFF选择输出循环.")
            -- Dummy DPS Test
            br.ui:createSpinner(section, "DPS测试",  5,  5,  60,  5,  "|cffFFFFFF设置为所需的测试的时间（分钟）. 最小: 5 / 最大: 60 / 间隔: 5")
            -- Artifact
            br.ui:createDropdownWithout(section, "神器技能", {"|cff00FF00任何时候","|cffFFFF00冷却技能","|cffFF0000决不"}, 1, "|cffFFFFFF何时使用神器技能.")
            br.ui:createSpinnerWithout(section, "神器技能 数量",  5,  1,  10,  1,  "|cffFFFFFF多少敌人才使用. 最小: 1 / 最大: 10 / 间隔: 1")
            -- Death Grip
            br.ui:createCheckbox(section,"死亡之握")
            -- Glacial Advance
            br.ui:createSpinner(section, "冰川突进",  5,  1,  10,  1,  "|cffFFFFFF多少敌人才使用. 最小: 1 / 最大: 10 / 间隔: 1")
            -- Path of Frost
            br.ui:createCheckbox(section,"冰霜之路")
            -- Pre-Pull Timer
            br.ui:createSpinner(section, "Pre-Pull Timer",  5,  1,  10,  1,  "|cffFFFFFF设置为所需的启动时间 Pre-Pull (必须有DBM). 最小: 1 / 最大: 10 / 间隔: 1")
        br.ui:checkSectionState(section)
        ------------------------
        --- COOLDOWN OPTIONS ---
        ------------------------
        section = br.ui:createSection(br.ui.window.profile,  "冷却技能")
            -- Flask / Crystal
            br.ui:createCheckbox(section,"奥拉留斯的低语水晶")
            -- Potion
            br.ui:createCheckbox(section,"爆发药水")
            -- Racial
            br.ui:createCheckbox(section,"种族技能")
            -- Trinkets
            br.ui:createCheckbox(section,"饰品")
            -- Breath of Sindragosa
            br.ui:createCheckbox(section,"冰龙吐息")
            -- Empower Rune Weapon
            br.ui:createCheckbox(section,"符文武器")
            -- Obliteration
            br.ui:createCheckbox(section,"湮没")
            -- Pillar of Frost
            br.ui:createDropdownWithout(section, "冰霜之柱", {"|cff00FF00任何时候","|cffFFFF00冷却技能","|cffFF0000决不"}, 1, "|cffFFFFFF何时使用.")
        br.ui:checkSectionState(section)
        -------------------------
        --- DEFENSIVE OPTIONS ---
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, "保命")
            -- Healthstone
            br.ui:createSpinner(section, "治疗石",  60,  0,  100,  5,  "|cffFFBB00多少百分比血量使用")
            -- Heirloom Neck
            br.ui:createSpinner(section, "传家宝项链",  60,  0,  100,  5,  "|cffFFBB00多少百分比血量使用")
            -- Anti-Magic Shell
            br.ui:createSpinner(section, "反魔法护罩",  75,  0,  100,  5,  "|cffFFFFFF多少百分比血量使用")
            -- Blinding Sleet
            br.ui:createSpinner(section, "致盲冰雨",  75,  0,  100,  5,  "|cffFFFFFF多少百分比血量使用")
            -- Death Strike
            br.ui:createSpinner(section, "灵界打击",  75,  0,  100,  5,  "|cffFFFFFF多少百分比血量使用")
            -- Icebound Fortitude
            br.ui:createSpinner(section, "冰封之韧",  75,  0,  100,  5,  "|cffFFFFFF多少百分比血量使用")
            -- Raise Ally
            br.ui:createCheckbox(section,"复活盟友")
            br.ui:createDropdownWithout(section, "复活盟友 - 目标", {"|cff00FF00目标","|cffFF0000鼠标位置"}, 1, "|cffFFFFFF选择目标")
        br.ui:checkSectionState(section)
        -------------------------
        --- INTERRUPT OPTIONS ---
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, "打断")
            -- Anti-Magic Zone
            -- br.ui:createCheckbox(section,"Anti-Magic Zone - Int")
            -- Blinding Sleet
            -- br.ui:createCheckbox(section,"Blinding Sleet - Int")
            -- Mind Freeze
            br.ui:createCheckbox(section,"心灵冰冻")
            -- Interrupt Percentage
            br.ui:createSpinnerWithout(section,  "打断",  0,  0,  95,  5,  "|cffFFBB00读条百分几打断")
        br.ui:checkSectionState(section)
        ----------------------
        --- TOGGLE OPTIONS ---
        ----------------------
        section = br.ui:createSection(br.ui.window.profile,  "切换快捷键")
            -- Single/Multi Toggle
            br.ui:createDropdownWithout(section,  "运行模式", br.dropOptions.Toggle,  4)
            --Cooldown Key Toggle
            br.ui:createDropdownWithout(section,  "冷却技能模式", br.dropOptions.Toggle,  3)
            --Defensive Key Toggle
            br.ui:createDropdownWithout(section,  "保命模式", br.dropOptions.Toggle,  6)
            -- Interrupts Key Toggle
            br.ui:createDropdownWithout(section,  "打断模式", br.dropOptions.Toggle,  6)
            -- Cleave Toggle
            br.ui:createDropdownWithout(section,  "输出模式", br.dropOptions.Toggle,  6)
            -- Pause Toggle
            br.ui:createDropdown(section,  "暂停模式", br.dropOptions.Toggle,  6)
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
    if br.timer:useTimer("debugFrost", 0.1) then
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
        local attacktar         = UnitCanAttack("target", "player")
        local buff              = br.player.buff
        local cast              = br.player.cast
        local cd                = br.player.cd
        local charges           = br.player.charges
        local deadtar           = UnitIsDeadOrGhost("target") or isDummy()
        local debuff            = br.player.debuff
        local enemies           = enemies or {}
        local gcd               = br.player.gcd
        local glyph             = br.player.glyph
        local healPot           = getHealthPot()
        local inCombat          = br.player.inCombat
        local level             = br.player.level
        local mode              = br.player.mode
        local moving            = GetUnitSpeed("player")>0
        local php               = br.player.health
        local power             = br.player.power
        local pullTimer         = br.DBM:getPulltimer()
        local racial            = br.player.getRacial()
        local runicPower        = br.player.power.amount.runicPower
        local runicPowerDeficit = br.player.power.runicPower.deficit
        local runes             = br.player.power.runes.frac
        local swimming          = IsSwimming()
        local talent            = br.player.talent
        local t19_2pc           = TierScan("T19") >= 2
        local t19_4pc           = TierScan("T19") >= 4
        local ttd               = getTTD
        local units             = units or {}

        units.dyn5 = br.player.units(5)
        units.dyn8 = br.player.units(8)
        units.dyn30 = br.player.units(30)
        enemies.yards8 = br.player.enemies(8)
        enemies.yards10 = br.player.enemies(10)
        enemies.yards10t = br.player.enemies(10,br.player.units(10,true))
        enemies.yards15 = br.player.enemies(15)
        enemies.yards30 = br.player.enemies(30)
        enemies.yards40 = br.player.enemies(40)

    -- Profile Stop
        if profileStop == nil then profileStop = false end
--------------------
--- Action Lists ---
--------------------
    -- Action List - Extras
        local function actionList_Extras()
        -- Dummy Test
            if isChecked("DPS测试") then
                if GetObjectExists("target") then
                    if getCombatTime() >= (tonumber(getValue("DPS测试"))*60) and isDummy() then
                        profileStop = true
                        StopAttack()
                        ClearTarget()
                        Print(tonumber(getValue("DPS测试")) .." Minute Dummy Test Concluded - Profile Stopped")
                        return true
                    end
                end
            end
        -- Chains of Ice
            if isChecked("寒冰锁链") then
                for i = 1, #enemies.yards30 do
                    local thisUnit = enemies.yards30[i]
                    if not debuff.chainsOfIce.exists(thisUnit) and not getFacing(thisUnit,"player") and getFacing("player",thisUnit)
                        and isMoving(thisUnit) and getDistance(thisUnit) > 8 and inCombat
                    then
                        if cast.chainsOfIce(thisUnit) then return end
                    end
                end
            end
        -- Death Grip
            if isChecked("死亡之握") then
                if inCombat and isValidUnit(units.dyn30) and getDistance(units.dyn30) > 8 and not isDummy(units.dyn30) then
                    if cast.deathGrip(units.dyn30) then return end
                end
            end
        -- Path of Frost
            if isChecked("冰霜之路") then
                if not inCombat and swimming and not buff.pathOfFrost.exists() then
                    if cast.pathOfFrost() then return end
                end
            end
        end -- End Action List - Extras
    -- Action List - Defensive
        local function actionList_Defensive()
            if useDefensive() and not IsMounted() then
        -- Healthstone
                if isChecked("治疗石") and php <= getOptionValue("治疗石") and inCombat and (hasHealthPot() or hasItem(5512)) then
                    if canUse(5512) then
                        useItem(5512)
                    elseif canUse(healPot) then
                        useItem(healPot)
                    end
                end
        -- Anti-Magic Shell
                if isChecked("反魔法护罩") and php < getOptionValue("反魔法护罩") and inCombat then
                    if cast.antiMagicShell() then return end
                end
        -- Blinding Sleet
                if isChecked("致盲冰雨") and php < getOptionValue("致盲冰雨") and inCombat then
                    if cast.blindingSleet() then return end
                end
        -- Death Strike
                if isChecked("灵界打击") and inCombat and (buff.darkSuccor.exists() or php < getOptionValue("灵界打击"))
                    and (not talent.breathOfSindragosa or (cd.breathOfSindragosa > 15 and not buff.breathOfSindragosa.exists()) or not useCDs() or not isChecked("冰龙吐息"))
                then
                    if cast.deathStrike() then return end
                end
        -- Icebound Fortitude
                if isChecked("冰封之韧") and php < getOptionValue("冰封之韧") and inCombat then
                    if cast.iceboundFortitude() then return end
                end
        -- Raise Ally
                if isChecked("复活盟友") then
                    if getOptionValue("复活盟友 - 目标")==1
                        and UnitIsPlayer("target") and UnitIsDeadOrGhost("target") and UnitIsFriend("target","player")
                    then
                        if cast.raiseAlly("target","dead") then return end
                    end
                    if getOptionValue("复活盟友 - 目标")==2
                        and UnitIsPlayer("mouseover") and UnitIsDeadOrGhost("mouseover") and UnitIsFriend("mouseover","player")
                    then
                        if cast.raiseAlly("mouseover","dead") then return end
                    end
                end
            end -- End Use Defensive Check
        end -- End Action List - Defensive
    -- Action List - Interrupts
        local function actionList_Interrupts()
            if useInterrupts() then
        -- Mind Freeze
                if isChecked("心灵冰冻") then
                    for i=1, #enemies.yards15 do
                        thisUnit = enemies.yards15[i]
                        if canInterrupt(thisUnit,getOptionValue("打断")) then
                            if cast.mindFreeze(thisUnit) then return end
                        end
                    end
                end
            end -- End Use Interrupts Check
        end -- End Action List - Interrupts
    -- Action List - Cooldowns
        local function actionList_Cooldowns()
            if useCDs() and getDistance(units.dyn5) < 5 then
        -- Trinkets
                if isChecked("饰品") then
                    if canUse(13) then
                        useItem(13)
                    end
                    if canUse(14) then
                        useItem(14)
                    end
                end
        -- Racial: Orc Blood Fury | Troll Berserking | Blood Elf Arcane Torrent
                -- arcane_torrent,if=runic_power.deficit>20
                -- blood_fury,if=buff.pillar_of_frost.up
                -- berserking,if=buff.pillar_of_frost.up
                if isChecked("种族技能") and (((br.player.race == "Troll" or br.player.race == "Orc") and buff.pillarOfFrost.exists())
                    or (br.player.race == "BloodElf" and runicPowerDeficit > 20)) and getSpellCD(racial) == 0
                then
                    if castSpell("player",racial,false,false,false) then return end
                end
        -- Potion
                -- potion,name=old_war,if=buff.pillar_of_frost.up
                if raid and buff.pillarOfFrost.exists() then
                    -- TODO
                end
            end -- End Use Cooldowns Check
        end -- End Action List - Cooldowns
    -- Action List - Pre-Combat
        local function actionList_PreCombat()
        -- Flask / Crystal
            -- flask,name=countless_armies
            if isChecked("奥拉留斯的低语水晶") and not (IsFlying() or IsMounted()) then
                if (raid or solo) and not (buff.strenthFlaskLow or buff.strengthFlaskBig) then--Draenor Str Flasks
                    if not UnitBuffID("player",176151) and canUse(118922) then --Draenor Insanity Crystal
                        if br.player.useCrystal() then return end
                    end
                end
            end
        -- Food
            -- food,type=food,name=fishbrul_special
            -- TODO
        -- Augmentation
            -- augmentation,name=defiled
            -- TODO
        -- Potion
            -- potion,name=old_war
            -- TODO
        -- Pre-pull
            if isChecked("Pre-Pull Timer") and pullTimer <= getOptionValue("Pre-Pull Timer") then

            end -- Pre-Pull
        -- Start Attack
            if isValidUnit("target") and not inCombat then
                StartAttack()
            end
        end -- End Action List - PreCombat
    -- Action List - Breath of Sindragosa
        local function actionList_BreathOfSindragosa()
        -- Frost Strike
            -- frost_strike,if=talent.icy_talons.enabled&buff.icy_talons.remains<1.5&cooldown.breath_of_sindragosa.remains>6
            if talent.icyTalons and buff.icyTalons.remain() < 1.5 and (cd.breathOfSindragosa > 6 or not useCDs() or not isChecked("冰龙吐息")) then
                if cast.frostStrike() then return end
            end
        -- Remorseless Winter
            -- remorseless_winter,if=talent.gathering_storm.enable
            if talent.gatheringStorm and getDistance(units.dyn5) < 5 then
                if cast.remorselessWinter() then return end
            end
        -- Howling Blast
            -- howling_blast,target_if=!dot.frost_fever.ticking
            if not debuff.frostFever.exists(units.dyn30) then
                if cast.howlingBlast() then return end
            end
        -- Breath of Sindragosa
            -- breath_of_sindragosa,if=runic_power>=50&(!equipped.140806|cooldown.hungering_rune_weapon.remains<10)
            if useCDs() and isChecked("冰龙吐息") then
                if runicPowerDeficit < 20 and (not hasEquiped(140806) or cd.hungeringRuneWeapon < 10) then
                    if cast.breathOfSindragosa() then return end
                end
            end
        -- Frost Strike
            -- frost_strike,if=runic_power>=90&set_bonus.tier19_4pc
            if runicPower >= 90 and t19_4pc then
                if cast.frostStrike() then return end
            end
        -- Remorseless Winter
            -- remorseless_winter,if=buff.rime.react&equipped.132459
            if (buff.rime.exists() and hasEquiped(132459)) and getDistance(units.dyn5) < 5 then
                if cast.remorselessWinter() then return end
            end
        -- Howling Blast
            -- howling_blast,if=buff.rime.react&(dot.remorseless_winter.ticking|cooldown.remorseless_winter.remains>1.5|!equipped.132459)
            if buff.rime.exists() and (buff.remorselessWinter.exists() or cd.remorselessWinter > 1.5 or not hasEquiped(132459)) then
                if cast.howlingBlast() then return end
            end
        -- Obliterate
            -- obliterate,if=!buff.rime.react&!(talent.gathering_storm.enabled&!(cooldown.remorseless_winter.remains>2|rune>4))&rune>3
            if not buff.rime.exists() and not (talent.gatheringStorm and not (cd.remorselessWinter >2 or runes > 4)) and runes > 3 then
                if cast.obliterate() then return end
            end
        -- Frost Strike
            -- frost_strike,if=runic_power>=70|((talent.gathering_storm.enabled&cooldown.remorseless_winter.remains<3&cooldown.breath_of_sindragosa.remains>10)&rune<5)
            if runicPower >= 70 or ((talent.gatheringStorm and cd.remorselessWinter < 3 and (cd.breathOfSindragosa > 10 or not useCDs() or not isChecked("冰龙吐息"))) and runes < 5) then
                if cast.frostStrike() then return end
            end
        -- Obliterate
            -- obliterate,if=!buff.rime.react&!(talent.gathering_storm.enabled&!(cooldown.remorseless_winter.remains>2|rune>4))
            if not buff.rime.exists() and not (talent.gatheringStorm and not (cd.remorselessWinter > 2 or runes > 4)) then
                if cast.obliterate() then return end
            end
        -- Horn of Winter
            -- horn_of_winter,if=cooldown.breath_of_sindragosa.remains>15&runic_power<=70&rune<4
            if (cd.breathOfSindragosa > 15 or not useCDs() or not isChecked("冰龙吐息")) and runicPower <= 70 and runes < 4 then
                if cast.hornOfWinter() then return end
            end
        -- Frost Strike
            -- frost_strike,if=cooldown.breath_of_sindragosa.remains>15
            if cd.breathOfSindragosa > 15 or not useCDs() or not isChecked("冰龙吐息") then
                if cast.frostStrike() then return end
            end
        -- Remorseless Winter
            -- remorseless_winter,if=cooldown.breath_of_sindragosa.remains>10
            if (cd.breathOfSindragosa > 10 or not useCDs() or not isChecked("冰龙吐息")) and getDistance(units.dyn5) < 5 then
                if cast.remorselessWinter() then return end
            end
        end
    -- Action List - Breath of Sindragosa Ticking
        local function actionList_BreathOfSindragosaTicking()
        -- Howling Blast
            -- howling_blast,target_if=!dot.frost_fever.ticking
            if not debuff.frostFever.exists(units.dyn30) then
                if cast.howlingBlast() then return end
            end
        -- Remorseless Winter
            -- remorseless_winter,if=runic_power>=30&((buff.rime.react&equipped.132459)|(talent.gathering_storm.enabled&(dot.remorseless_winter.remains<=gcd|!dot.remorseless_winter.ticking)))
            if runicPower >= 30 and ((buff.rime.exists() and hasEquiped(132459)) or (talent.gatheringStorm and (buff.remorselessWinter.remain() <= gcd or not buff.remorselessWinter.exists()))) 
                and getDistance(units.dyn5) < 5 
            then
                if cast.remorselessWinter() then return end
            end
        -- Howling Blast
            -- howling_blast,if=((runic_power>=20&set_bonus.tier19_4pc)|runic_power>=30)&buff.rime.react
            if ((runicPower >= 20 and t19_4pc) or runicPower >= 30) and buff.rime.exists() then
                if cast.howlingBlast() then return end
            end
        -- Obliterate
            -- obliterate,if=runic_power<=75|rune>3
            if runicPower <= 75 or runes > 3 then
                if cast.obliterate() then return end
            end
        -- Horn of Winter
            -- horn_of_winter,if=runic_power<70&!buff.hungering_rune_weapon.up&rune<5
            if runicPower < 70 and not buff.hungeringRuneWeapon.exists() then --and runes < 5 then
                if cast.hornOfWinter() then return end
            end
            if isChecked("符文武器") and useCDs() then
        -- Hungering Rune Weapon
                -- hungering_rune_weapon,if=equipped.140806&(runic_power<30|(runic_power<70&talent.gathering_storm.enabled))&!buff.hungering_rune_weapon.up&rune<2
                if hasEquiped(140806) and (runicPower < 30 or (runicPower < 70 and talent.gatheringStorm)) and not buff.hungeringRuneWeapon.exists() and cd.hornOfWinter ~= 0 then -- and runes < 2 then
                    if cast.hungeringRuneWeapon() then return end
                end
                -- hungering_rune_weapon,if=talent.runic_attenuation.enabled&runic_power<30&!buff.hungering_rune_weapon.up&rune<2
                if talent.runicAttenuation and runicPower < 30 and not buff.hungeringRuneWeapon.exists() and cd.hornOfWinter ~= 0 then --and runes < 2 then
                    if cast.hungeringRuneWeapon() then return end
                end
                -- hungering_rune_weapon,if=runic_power<35&!buff.hungering_rune_weapon.up&rune<2
                if runicPower < 35 and not buff.hungeringRuneWeapon.exists() and cd.hornOfWinter ~= 0 and runes < 2 then
                    if cast.hungeringRuneWeapon() then return end
                end
                -- hungering_rune_weapon,if=runic_power<25&!buff.hungering_rune_weapon.up&rune<1
                if runicPower < 25 and not buff.hungeringRuneWeapon.exists() and cd.hornOfWinter ~= 0 and runes < 1 then
                    if cast.hungeringRuneWeapon() then return end
                end
        -- Empower Rune Weapon
                -- empower_rune_weapon,if=runic_power<20
                if runicPower < 20 and cd.hornOfWinter ~= 0 then
                    if cast.empowerRuneWeapon() then return end
                end
            end
        -- Remorseless Winter
            -- remorseless_winter,if=talent.gathering_storm.enabled|!set_bonus.tier19_4pc|runic_power<30
            if (talent.gatheringStorm or not t19_4pc or runicPower < 30) and getDistance(units.dyn5) < 5 then
                if cast.remorselessWinter() then return end
            end
        end
    -- Action List - Generic
        local function actionList_Generic()
        -- Frost Strike
            -- frost_strike,if=!talent.shattering_strikes.enabled&(buff.icy_talons.remains<1.5&talent.icy_talons.enabled)
            if not talent.shatteringStrikes and (buff.icyTalons.remain() < 1.5 and talent.icyTalons) then
                if cast.frostStrike() then return end
            end
            -- frost_strike,if=talent.shattering_strikes.enabled&debuff.razorice.stack=5
            if talent.shatteringStrikes and debuff.razorice.stack(units.dyn5) == 5 then
                if cast.frostStrike() then return end
            end
        -- Howling Blast
            -- howling_blast,target_if=!dot.frost_fever.ticking
            if not debuff.frostFever.exists(units.dyn30) then
                if cast.howlingBlast() then return end
            end
        -- Remorseless Winter
            -- remorseless_winter,if=(buff.rime.react&equipped.132459&!(buff.obliteration.up&spell_targets.howling_blast<2))|talent.gathering_storm.enabled
            if ((buff.rime.exists() and hasEquiped(132459) and not (buff.obliteration.exists() and #enemies.yards10 < 2)) or talent.gatheringStorm)
                and getDistance(units.dyn5) < 5
            then
                if cast.remorselessWinter() then return end
            end
        -- Howling Blast
            -- howling_blast,if=buff.rime.react&!(buff.obliteration.up&spell_targets.howling_blast<2)&!(equipped.132459&talent.gathering_storm.enabled)
            if buff.rime.exist and not (buff.obliteration.exists() and #enemies.yards10t < 2) and not (hasEquiped(132459) and talent.gatheringStorm) then
                if cast.howlingBlast() then return end
            end
            -- howling_blast,if=buff.rime.react&!(buff.obliteration.up&spell_targets.howling_blast<2)&equipped.132459&talent.gathering_storm.enabled&(debuff.perseverance_of_the_ebon_martyr.up|cooldown.remorseless_winter.remains>3)
            if buff.rime.exist and not (buff.obliteration.exists() and #enemies.yards10t < 2) and hasEquiped(132459) and talent.gatheringStorm and (debuff.remorselessWinter.exists() or cd.remorselessWinter > 3) then
                if cast.howlingBlast() then return end
            end
        -- Obliterate
            -- obliterate,if=!buff.obliteration.up&(equipped.132366&talent.frozen_pulse.enabled&(set_bonus.tier19_2pc=1|set_bonus.tier19_4pc=1))
            if not buff.obliteration and (hasEquiped(132366) and talent.frozenPulse and (t19_2pc or t19_4pc)) then
                if cast.obliterate() then return end
            end
        -- Frost Strike
            -- frost_strike,if=runic_power.deficit<=10
            if runicPowerDeficit <= 10 then
                if cast.frostStrike() then return end
            end
            -- frost_strike,if=buff.obliteration.up&!buff.killing_machine.react
            if buff.obliteration.exists() and not buff.killingMachine.exists() then
                if cast.frostStrike() then return end
            end
        -- Remorseless Winter
            -- remorseless_winter,if=spell_targets.remorseless_winter>=2&!(talent.frostscythe.enabled&buff.killing_machine.react&spell_targets.frostscythe>=2)
            if #enemies.yards10t >= 2 and getDistance(units.dyn5) < 5 and not (talent.frostscythe and buff.killingMachine.exists() and ((mode.rotation == 1 and #enemies.yards8 >= 2) or mode.rotation == 2)) then
                if cast.remorselessWinter() then return end
            end
        -- Frostscythe
            -- frostscythe,if=(buff.killing_machine.react&spell_targets.frostscythe>=2)
            if buff.killingMachine.exists() and ((mode.rotation == 1 and #enemies.yards8 >= 2) or mode.rotation == 2) then
                if cast.frostscythe() then return end
            end
        -- Glacial Advance
            -- glacial_advance,if=spell_targets.glacial_advance>=2
            if ((mode.rotation == 1 and #enemies.yards10 >= getOptionValue("冰川突进")) or mode.rotation == 2) then
                if cast.glacialAdvance("player") then return end
            end
        -- Frostscythe
            -- frostscythe,if=spell_targets.frostscythe>=3
            if ((mode.rotation == 1 and #enemies.yards8 >= 3) or mode.rotation == 2) then
                if cast.frostscythe() then return end
            end
        -- Obliterate
            -- obliterate,if=buff.killing_machine.react
            if buff.killingMachine.exists() then
                if cast.obliterate() then return end
            end
        -- Frost Strike
            -- frost_strike,if=talent.gathering_storm.enabled&talent.murderous_efficiency.enabled&(set_bonus.tier19_2pc=1|set_bonus.tier19_4pc=1)
            if talent.gatheringStorm and talent.murderousEfficiency and (t19_2pc or t19_4pc) then
                if cast.frostStrike() then return end
            end
            -- frost_strike,if=(talent.horn_of_winter.enabled|talent.hungering_rune_weapon.enabled)&(set_bonus.tier19_2pc=1|set_bonus.tier19_4pc=1)
            if (talent.hornOfWinter or talent.hungeringRuneWeapon) and (t19_2pc or t19_4pc) then
                if cast.frostStrike() then return end
            end
        -- Obliterate
            -- obliterate
            if cast.obliterate() then return end
        -- Glacial Advance
            -- glacial_advance
            if #enemies.yards10 >= getOptionValue("冰川突进") then
                if cast.glacialAdvance("player") then return end
            end
        -- Horn of Winter
            -- horn_of_winter,if=!dot.hungering_rune_weapon.ticking
            if not buff.hungeringRuneWeapon.exists() then
                if cast.hornOfWinter() then return end
            end
        -- Frost Strike
            -- frost_strike
            if cast.frostStrike() then return end
        -- Remorseless Winter
            -- remorseless_winter,if=talent.frozen_pulse.enabled
            if talent.frozenPulse and getDistance(units.dyn5) < 5 then
                if cast.remorselessWinter() then return end
            end
            if isChecked("符文武器") and useCDs() then
        -- Empower Rune Weapon
                -- empower_rune_weapon
                if cast.empowerRuneWeapon() then return end
        -- Hungering Rune Weapon
                -- hungering_rune_weapon,if=!dot.hungering_rune_weapon.ticking
                if not buff.hungeringRuneWeapon.exists() then
                    if cast.hungeringRuneWeapon() then return end
                end
            end
        end
    -- Action List - Gathering Storm Ticking
        local function actionList_GatheringStormTicking()
        -- Frost Strike
            -- frost_strike,if=buff.icy_talons.remains<1.5&talent.icy_talons.enabled
            if buff.icyTalons.remain() < 1.5 and talent.icyTalons then
                if cast.frostStrike() then return end
            end
        -- Remorseless Winter
            if getDistance(units.dyn5) < 5 then
                if cast.remorselessWinter() then return end
            end
        -- Howling Blast
            -- howling_blast,target_if=!dot.frost_fever.ticking
            if not debuff.frostFever.exists(units.dyn30) then
                if cast.howlingBlast() then return end
            end
            -- howling_blast,if=buff.rime.react&!(buff.obliteration.up&spell_targets.howling_blast<2)
            if buff.rime.exists() and not (buff.obliteration.exists() and #enemies.yards10t < 2) then
                if cast.howlingBlast() then return end
            end
        -- Obliteration
            -- obliteration,if=(!talent.frozen_pulse.enabled|(rune<2&runic_power<28))
            if isChecked("湮没") and useCDs() then
                if not talent.frozenPulse or (runes < 2 and runicPower < 28) then
                    if cast.obliteration() then return end
                end
            end
        -- Obliterate
            -- obliterate,if=rune>3|buff.killing_machine.react|buff.obliteration.up
            if runes > 3 or buff.killingMachine.exists() or buff.obliteration.exists() then
                if cast.obliterate() then return end
            end
        -- Frost Strike
            -- frost_strike,if=runic_power>80|(buff.obliteration.up&!buff.killing_machine.react)
            if runicPower > 80 or (buff.obliteration.exists() or not buff.killingMachine.exists()) then
                if cast.frostStrike() then return end
            end
        -- Obliterate
            -- obliterate
            if cast.obliterate() then return end
        -- Horn of Winter
            -- horn_of_winter,if=runic_power<70&!dot.hungering_rune_weapon.ticking
            if runicPower < 70 and not buff.hungeringRuneWeapon.exists() then
                if cast.hornOfWinter() then return end
            end
        -- Glacial Advance
            -- glacial_advance
            if #enemies.yards10 >= getOptionValue("冰川突进") then
                if cast.glacialAdvance("player") then return end
            end
        -- Frost Strike
            -- frost_strike
            if cast.frostStrike() then return end
            if isChecked("符文武器") and useCDs() then
        -- Hungering Rune Weapon
                -- hungering_rune_weapon,if=!dot.hungering_rune_weapon.ticking
                if not buff.hungeringRuneWeapon.exists() then
                    if cast.hungeringRuneWeapon() then return end
                end
        -- Empower Rune Weapon
                -- empower_rune_weapon
                if cast.empowerRuneWeapon() then return end
            end
        end
---------------------
--- Begin Profile ---
---------------------
    -- Profile Stop | Pause
        if not inCombat and not hastar and profileStop==true then
            profileStop = false
        elseif (inCombat and profileStop==true) or pause() or mode.rotation==4 then
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
        -- Cat is 4 fyte!
            if inCombat and profileStop==false and isValidUnit(units.dyn5) then
                -- auto_attack
                if getDistance(units.dyn5) < 5 then
                    StartAttack()
                end
    ------------------------------
    --- In Combat - Interrupts ---
    ------------------------------
                if actionList_Interrupts() then return end
    -----------------------------
    --- In Combat - Cooldowns ---
    -----------------------------
        -- Pillar of Frost
                -- pillar_of_frost
                if getOptionValue("冰霜之柱") == 1 or (getOptionValue("冰霜之柱") == 2 and useCDs()) and getDistance(units.dyn5) < 5 then
                    if cast.pillarOfFrost() then return end
                end
                if actionList_Cooldowns() then return end
    ---------------------------
    --- SimulationCraft APL ---
    ---------------------------
                if getOptionValue("APL模式") == 1 then
        -- Singragosa's Fury
                    -- sindragosas_fury,if=buff.pillar_of_frost.up&(buff.unholy_strength.up|(buff.pillar_of_frost.remains<3&target.time_to_die<60))&debuff.razorice.stack=5&!buff.obliteration.up
                    if getOptionValue("神器技能") == 1 or (getOptionValue("神器技能") == 2 and useCDs()) then
                        if buff.pillarOfFrost.exists() and (buff.unholyStrength.exists() or (buff.pillarOfFrost.remain() < 3 and (ttd(units.dyn5) < 60 or isDummy(units.dyn5))))
                            and debuff.razorice.stack(units.dyn5) == 5 and not buff.obliteration.exists()
                            and #enemies.yards40 >= getOptionValue("神器技能 数量") and getFacing("player",units.dyn8)
                        then
                            if cast.sindragosasFury() then return end
                        end
                    end
        -- Obliteration
                    -- obliteration,if=(!talent.frozen_pulse.enabled|(rune<2&runic_power<28))&!talent.gathering_storm.enabled
                    if isChecked("湮没") and useCDs() then
                        if (not talent.frozenPulse or (runes < 2 and runicPower < 28)) or not talent.gatheringStorm then
                            if cast.obliteration() then return end
                        end
                    end
        -- Generic
                    -- call_action_list,name=generic,if=!talent.breath_of_sindragosa.enabled&!(talent.gathering_storm.enabled&buff.remorseless_winter.remains)
                    if not talent.breathOfSindragosa and not (talent.gatheringStorm and buff.remorselessWinder.exists()) then
                        if actionList_Generic() then return end
                    end
        -- Breath of Sindragosa
                    -- call_action_list,name=bos,if=talent.breath_of_sindragosa.enabled&!dot.breath_of_sindragosa.ticking
                    if talent.breathOfSindragosa and not buff.breathOfSindragosa.exists() then
                        if actionList_BreathOfSindragosa() then return end
                    end
                    -- call_action_list,name=bos_ticking,if=talent.breath_of_sindragosa.enabled&dot.breath_of_sindragosa.ticking
                    if talent.breathOfSindragosa and buff.breathOfSindragosa.exists() then
                        if actionList_BreathOfSindragosaTicking() then return end
                    end
        -- Gathering Storm
                    -- call_action_list,name=gs_ticking,if=talent.gathering_storm.enabled&buff.remorseless_winter.remain()s&!talent.breath_of_sindragosa.enabled
                    if talent.gatheringStorm and buff.remorselessWinter.exists() and not talent.breathOfSindragosa then
                        if actionList_GatheringStormTicking() then return end
                    end
                end -- End Simc APL
            end -- End Combat Check
        end -- End Rotation Pause
    end -- End Timer
end -- runRotation
local id = 251
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})
