local rotationName = "CuteOne"

---------------
--- Toggles ---
---------------
local function createToggles()
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "基于范围内的目标数,在单目标和多目标自动切换输出方式.", highlight = 1, icon = br.player.spell.cleave },
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "使用多目标方式输出.", highlight = 0, icon = br.player.spell.whirlwind },
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "使用单目标方式输出.", highlight = 0, icon = br.player.spell.mortalStrike },
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "禁用DPS输出", highlight = 0, icon = br.player.spell.victoryRush}
    };
    CreateButton("Rotation",1,0)
-- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "自动使用大技能 - 只在BOSS.", highlight = 1, icon = br.player.spell.bladestorm },
        [2] = { mode = "On", value = 2 , overlay = "Cooldowns Enabled", tip = "不管任何目标都使用大技能.", highlight = 0, icon = br.player.spell.bladestorm },
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "不使用大技能.", highlight = 0, icon = br.player.spell.bladestorm }
    };
    CreateButton("Cooldown",2,0)
-- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "使用保命技能.", highlight = 1, icon = br.player.spell.dieByTheSword },
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "不使用保命技能.", highlight = 0, icon = br.player.spell.dieByTheSword }
    };
    CreateButton("Defensive",3,0)
-- Interrupt Button
    InterruptModes = {
        [1] = { mode = "On", value = 1 , overlay = "Interrupts Enabled", tip = "使用打断.", highlight = 1, icon = br.player.spell.pummel },
        [2] = { mode = "Off", value = 2 , overlay = "Interrupts Disabled", tip = "不使用打断.", highlight = 0, icon = br.player.spell.pummel }
    };
    CreateButton("Interrupt",4,0)
-- Movement Button
    MoverModes = {
        [1] = { mode = "On", value = 1 , overlay = "Mover Enabled", tip = "使用冲锋/英勇飞跃.", highlight = 1, icon = br.player.spell.charge },
        [2] = { mode = "Off", value = 2 , overlay = "Mover Disabled", tip = "不使用冲锋/英勇飞跃.", highlight = 0, icon = br.player.spell.charge }
    };
    CreateButton("Mover",5,0)
-- Heroic Charge
    HeroicModes = {
        [1] = { mode = "On", value = 1 , overlay = "Heroic Charge Enabled", tip = "Will use Heroic Charge.", highlight = 1, icon = br.player.spell.heroicLeap },
        [2] = { mode = "Off", value = 2 , overlay = "Heroic Charge Disabled", tip = "Will NOT use Heroic Charge.", highlight = 0, icon = br.player.spell.heroicLeap }
    };
    CreateButton("Heroic",6,0)
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
            -- Dummy DPS Test
            br.ui:createSpinner(section, "DPS测试",  5,  5,  60,  5,  "|cffFFFFFF设置为所需的测试的时间（分钟）. 最小: 5 / 最大: 60 / 间隔: 5")
            -- Pre-Pull Timer
            br.ui:createSpinner(section, "Pre-Pull Timer",  5,  1,  10,  1,  "|cffFFFFFF设置为所需的启动时间 Pre-Pull (必须有DBM). 最小: 1 / 最大: 10 / 间隔: 1")
            -- AoE Slider
            br.ui:createSpinnerWithout(section, "AoE阈值",  7,  1,  10,  1,  "|cffFFFFFF设置为所需目标以启动AoE输出. 最小: 1 / 最大: 10 / 间隔: 1")
            -- Artifact
            br.ui:createDropdownWithout(section,"神器技能", {"|cff00FF00任何时候","|cffFFFF00冷却技能","|cffFF0000决不"}, 1, "|cffFFFFFF何时使用神器技能.")
            -- Berserker Rage
            br.ui:createCheckbox(section,"狂暴之怒", "选中使用狂暴之怒")
            -- Charge
            br.ui:createCheckbox(section,"冲锋", "选中使用冲锋")
            -- Hamstring
            br.ui:createCheckbox(section,"断筋", "选中使用断筋")
            -- Heroic Leap
            br.ui:createDropdown(section,"英勇飞跃", br.dropOptions.Toggle, 6, "设置自动使用（无热键）或所需的热键以使用英雄飞跃.")
            br.ui:createDropdownWithout(section,"英勇飞跃 - 目标",{"最好","目标"},1,"期望的英雄飞跃目标")
            br.ui:createSpinner(section, "英勇飞跃距离",  15,  8,  25,  1,  "|cffFFFFFF使用英勇飞跃的距离 最小: 8 / 最大: 25 / 间隔: 1")
            -- Shockwave
            br.ui:createCheckbox(section, "震荡波")
            -- Storm Bolt
            br.ui:createCheckbox(section, "风暴之锤")
        br.ui:checkSectionState(section)
        ------------------------
        --- COOLDOWN OPTIONS ---
        ------------------------
        section = br.ui:createSection(br.ui.window.profile,  "冷却技能")
            -- Potion
            br.ui:createCheckbox(section, "爆发药水")
            -- Flask / Crystal
            br.ui:createCheckbox(section, "奥拉留斯的低语水晶")
            -- Racial
            br.ui:createCheckbox(section, "种族技能")
            -- Legendary Ring
            br.ui:createCheckbox(section, "黑暗前途指环")
            -- Draught of Souls
            br.ui:createCheckbox(section, "灵魂之引")
            -- Trinkets
            br.ui:createDropdownWithout(section, "饰品", {"|cff00FF00第一个","|cff00FF00第二个","|cffFFFF00两个都用","|cffFF0000没有"}, 1, "|cffFFFFFF选择使用饰品.")
            -- Touch of the Void
            br.ui:createCheckbox(section,"虚空之触")
             -- Avatar
            br.ui:createDropdownWithout(section, "天神下凡", {"|cff00FF00任何时候","|cffFFFF00冷却技能","|cffFF0000决不"}, 1, "|cffFFFFFF何时使用.")
            -- Battle Cry
            br.ui:createDropdownWithout(section, "战吼", {"|cff00FF00任何时候","|cffFFFF00冷却技能","|cffFF0000决不"}, 1, "|cffFFFFFF何时使用.")
            -- Bladestorm
            br.ui:createSpinner(section, "剑刃风暴",  5,  1,  10,  1,  "|cffFFFFFF设置为期望的数量，以便在设置为AOE时使用剑刃风暴. 最小: 1 / 最大: 10 / 间隔: 1")
            -- Ravager
            br.ui:createDropdown(section,"破坏者",{"最好","目标"},1,"Desired Target of Ravager")
        br.ui:checkSectionState(section)
        -------------------------
        --- DEFENSIVE OPTIONS ---
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, "保命")
            -- Healthstone
            br.ui:createSpinner(section, "药水/治疗石",  60,  0,  100,  5,  "|cffFFBB00多少血量百分几使用")
            -- Heirloom Neck
            br.ui:createSpinner(section, "传家宝项链",  60,  0,  100,  5,  "|cffFFBB00多少血量百分几使用")
            -- Gift of The Naaru
            if br.player.race == "Draenei" then
                br.ui:createSpinner(section, "纳鲁的赐福",  50,  0,  100,  5,  "|cffFFFFFF多少血量百分几使用")
            end
            -- Commanding Shout
            br.ui:createSpinner(section, "命令怒吼",  60,  0,  100,  5, "|cffFFBB00多少血量百分几使用")
            -- Defensive Stance
            br.ui:createSpinner(section, "防御姿态",  60,  0,  100,  5,  "|cffFFBB00多少血量百分几使用")
            -- Die By The Sword
            br.ui:createSpinner(section, "剑在人在",  60,  0,  100,  5,  "|cffFFBB00多少血量百分几使用")
            -- Intimidating Shout
            br.ui:createSpinner(section, "破胆怒吼",  60,  0,  100,  5,  "|cffFFBB00多少血量百分几使用")
            -- Shockwave
            br.ui:createSpinner(section, "震荡波 - HP", 60, 0, 100, 5, "|cffFFBB00多少血量百分几使用")
            br.ui:createSpinner(section, "震荡波 - 数量", 3, 1, 10, 1, "|cffFFBB00最小多少人使用.")
            -- Storm Bolt
            br.ui:createSpinner(section, "风暴之锤", 60, 0, 100, 5, "|cffFFBB00多少血量百分几使用")
            -- Victory Rush
            br.ui:createSpinner(section, "乘胜追击", 60, 0, 100, 5, "|cffFFBB00多少血量百分几使用")
        br.ui:checkSectionState(section)
        -------------------------
        --- INTERRUPT OPTIONS ---
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, "打断")
            -- Pummel
            br.ui:createCheckbox(section,"拳击")
            -- Intimidating Shout
            br.ui:createCheckbox(section,"破胆怒吼")
            -- Shockwave
            br.ui:createCheckbox(section,"震荡波")
            -- Storm Bolt
            br.ui:createCheckbox(section,"风暴之锤")
            -- Interrupt Percentage
            br.ui:createSpinner(section,  "打断",  0,  0,  95,  5,  "|cffFFBB00读条百分几打断")
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
            -- Mover Toggle
            br.ui:createDropdownWithout(section,  "移动模式", br.dropOptions.Toggle,  6)
            -- Heroic Toggle
            br.ui:createDropdownWithout(section,  "英雄模式", br.dropOptions.Toggle,  6)
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
    if br.timer:useTimer("debugArms", 0) then
        --Print("Running: "..rotationName)

---------------
--- Toggles ---
---------------
        UpdateToggle("Rotation",0.25)
        UpdateToggle("Cooldown",0.25)
        UpdateToggle("Defensive",0.25)
        UpdateToggle("Interrupt",0.25)
        UpdateToggle("Mover",0.25)
        br.player.mode.mover = br.data.settings[br.selectedSpec].toggles["Mover"]
        UpdateToggle("Heroic",0.25)
        br.player.mode.heroic = br.data.settings[br.selectedSpec].toggles["Heroic"]

--------------
--- Locals ---
--------------
        local addsExist                                     = false
        local addsIn                                        = 999
        local artifact                                      = br.player.artifact
        local buff                                          = br.player.buff
        local cast                                          = br.player.cast
        local combatTime                                    = getCombatTime()
        local cd                                            = br.player.cd
        local charges                                       = br.player.charges
        local deadMouse                                     = UnitIsDeadOrGhost("mouseover")
        local deadtar, attacktar, hastar, playertar         = deadtar or UnitIsDeadOrGhost("target"), attacktar or UnitCanAttack("target", "player"), hastar or GetObjectExists("target"), UnitIsPlayer("target")
        local debuff                                        = br.player.debuff
        local enemies                                       = enemies or {}
        local falling, swimming, flying, moving             = getFallTime(), IsSwimming(), IsFlying(), GetUnitSpeed("player")>0
        local friendly                                      = friendly or UnitIsFriend("target", "player")
        local gcd                                           = br.player.gcd
        local hasMouse                                      = GetObjectExists("mouseover")
        local healPot                                       = getHealthPot()
        local heirloomNeck                                  = 122667 or 122668
        local inCombat                                      = br.player.inCombat
        local inInstance                                    = br.player.instance=="party"
        local inRaid                                        = br.player.instance=="raid"
        local level                                         = br.player.level
        local lootDelay                                     = getOptionValue("LootDelay")
        local lowestHP                                      = br.friend[1].unit
        local mode                                          = br.player.mode
        local perk                                          = br.player.perk
        local php                                           = br.player.health
        local playerMouse                                   = UnitIsPlayer("mouseover")
        local power, powerDeficit, powerMax, powerGen       = br.player.power.amount.rage, br.player.power.rage.deficit, br.player.power.rage.max, br.player.power.regen
        local pullTimer                                     = br.DBM:getPulltimer()
        local race                                          = br.player.race
        local racial                                        = br.player.getRacial()
        local recharge                                      = br.player.recharge
        local rage                                          = br.player.power.amount.rage
        local solo                                          = br.player.instance=="none"
        local spell                                         = br.player.spell
        local talent                                        = br.player.talent
        local thp                                           = getHP(br.player.units(5))
        local ttd                                           = getTTD
        local ttm                                           = br.player.power.ttm
        local units                                         = units or {}

        units.dyn5 = br.player.units(5)
        units.dyn8 = br.player.units(8)
        enemies.yards5 = br.player.enemies(5)
        enemies.yards8 = br.player.enemies(8)
        enemies.yards40 = br.player.enemies(40)

        if leftCombat == nil then leftCombat = GetTime() end
        if profileStop == nil then profileStop = false end
        if focusTimer == nil then focusTimer = 0 end

        if useAvatar == nil then useAvatar = false end
        if cd.warbreaker <= 3 then usedWarbreaker = false end
        if getOptionValue("战吼") == 3 or (getOptionValue("战吼") == 2 and not useCDs()) then ignoreBattleCry = true else ignoreBattleCry = false end

        -- ChatOverlay(tostring(isInstanceBoss("target")))

        -- Heroic Leap for Charge (Credit: TitoBR)
        local function heroicLeapCharge()
            local thisUnit = units.dyn5
            local sX, sY, sZ = GetObjectPosition(thisUnit)
            local hitBoxCompensation = UnitCombatReach(thisUnit) / GetDistanceBetweenObjects("player",thisUnit)
            local yards = getOptionValue("英勇飞跃距离") + hitBoxCompensation
            for deg = 0, 360, 45 do
                local dX, dY, dZ = GetPositionFromPosition(sX, sY, sZ, yards, deg, 0)
                if TraceLine(sX, sY, sZ + 2.25, dX, dY, dZ + 2.25, 0x10) == nil and cd.heroicLeap == 0 and charges.charge > 0 then
                    if not IsAoEPending() then
                        CastSpellByName(GetSpellInfo(spell.heroicLeap))
                        -- cast.heroicLeap("player")
                    end
                    if IsAoEPending() then
                        ClickPosition(dX,dY,dZ)
                        break
                    end
                end
            end
        end

--------------------
--- Action Lists ---
--------------------
    -- Action list - Extras
        function actionList_Extra()
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
            -- Berserker Rage
            if isChecked("狂暴之怒") and hasNoControl(spell.berserkerRage) then
                if cast.berserkerRage() then return end
            end
        end -- End Action List - Extra
    -- Action List - Defensive
        function actionList_Defensive()
            if useDefensive() then
            -- Healthstone/Health Potion
                if isChecked("药水/治疗石") and php <= getOptionValue("药水/治疗石")
                    and inCombat and (hasHealthPot() or hasItem(5512))
                then
                    if canUse(5512) then
                        useItem(5512)
                    elseif canUse(getHealthPot()) then
                        useItem(getHealthPot())
                    end
                end
            -- Heirloom Neck
                if isChecked("传家宝项链") and php <= getOptionValue("传家宝项链") then
                    if hasEquiped(heirloomNeck) then
                        if canUse(heirloomNeck) then
                            useItem(heirloomNeck)
                        end
                    end
                end
            -- Gift of the Naaru
                if isChecked("纳鲁的赐福") and php <= getOptionValue("纳鲁的赐福") and br.player.race=="Draenei" and cd.giftOfTheNaaru == 0 then
                    if castSpell("player",racial,false,false,false) then return end
                end
            -- Commanding Shout
                if isChecked("命令怒吼") and inCombat and php <= getOptionValue("命令怒吼") then
                    if cast.commandingShout() then return end
                end
            -- Defensive Stance
                if isChecked("防御姿态") then
                    if php <= getOptionValue("防御姿态") and not buff.defensiveStance.exists() then
                        if cast.defensiveStance() then return end
                    elseif buff.defensiveStance.exists() then
                        if cast.defensiveStance() then return end
                    end
                end
            -- Die By The Sword
                if isChecked("剑在人在") and inCombat and php <= getOptionValue("剑在人在") then
                    if cast.dieByTheSword() then return end
                end
            -- Intimidating Shout
                if isChecked("破胆怒吼") and inCombat and php <= getOptionValue("破胆怒吼") then
                    if cast.intimidatingShout() then return end
                end
            -- Shockwave
                if inCombat and ((isChecked("震荡波 - HP") and php <= getOptionValue("震荡波 - HP")) or (isChecked("震荡波 - 数量") and #enemies.yards8 >= getOptionValue("震荡波 - 数量"))) then
                    if cast.shockwave() then return end
                end
            -- Storm Bolt
                if inCombat and isChecked("风暴之锤") and php <= getOptionValue("风暴之锤") then
                    if cast.stormBolt() then return end
                end
            -- Victory Rush
                if inCombat and isChecked("乘胜追击") and php <= getOptionValue("乘胜追击") and buff.victorious.exists() then
                    if cast.victoryRush() then return end
                end
            end -- End Defensive Check
        end -- End Action List - Defensive
    -- Action List - Interrupts
        function actionList_Interrupts()
            if useInterrupts() then
                for i=1, #enemies.yards40 do
                    thisUnit = enemies.yards40[i]
                    unitDist = getDistance(thisUnit)
                    targetMe = UnitIsUnit("player",thisUnit) or false
                    if canInterrupt(thisUnit,getOptionValue("打断")) then
                    -- Pummel
                        if isChecked("拳击") and unitDist < 5 then
                            if cast.pummel(thisUnit) then return end
                        end
                    -- Intimidating Shout
                        if isChecked("破胆怒吼") and unitDist < 8 then
                            if cast.intimidatingShout() then return end
                        end
                    -- Shockwave
                        if isChecked("震荡波") and unitDist < 10 then
                            if cast.shockwave() then return end
                        end
                    -- Storm Bolt
                        if isChecked("风暴之锤") and unitDist < 20 then
                            if cast.stormBolt() then return end
                        end
                    end
                end
            end
        end -- End Action List - Interrupts
    -- Action List - Cooldowns
        function actionList_Cooldowns()
            if getDistance(units.dyn5) < 5 then
            -- Ring of Collapsing Futures
                if buff.battleCry.exists() or ignoreBattleCry then
                    if isChecked("黑暗前途指环") and hasEquiped(142173) and canUse(142173) and select(2,IsInInstance()) ~= "pvp"  then
                        useItem(142173)
                        return true
                    end
                end
            -- Draught of Souls
                --draught_of_souls,if=equipped.draught_of_souls&((prev_gcd.1.mortal_strike|cooldown.mortal_strike.remains>=3)&buff.battle_cry.remains>=3&debuff.colossus_smash.up&buff.avatar.remains>=3)
                if hasEquiped(140808) and ((lastCast == spell.mortalStrike or cd.mortalStrike >= 3) and buff.battleCry.remain() >= 3 and debuff.colossusSmash.exists(units.dyn5) and buff.avatar.remain() >= 3) then
                    useItem(140808)
                    return true
                end
            -- Potion
                -- potion,name=old_war,if=buff.avatar.up&buff.battle_cry.up&debuff.colossus_smash.up|target.time_to_die<=26
                -- if useCDs() and canUse(strPot) and inRaid and isChecked("爆发药水") then
                --     if (buff.avatar.exists() and buff.battleCry.exists() and debuff.colossusSmash[units.dyn5].exists()) or ttd(units.dyn5) <= 26 then
                --         useItem(strPot)
                --     end
                -- end
            -- Racials
                -- blood_fury,if=buff.battle_cry.up|target.time_to_die<=16
                -- berserking,if=buff.battle_cry.up|target.time_to_die<=11
                -- arcane_torrent,if=buff.battle_cry_deadly_calm.down&rage.deficit>40
                if useCDs() and isChecked("种族技能") and getSpellCD(racial) == 0 and ((br.player.race == "Orc" and (buff.battleCry.exists() or ignoreBattleCry or ttd(units.dyn5) <= 16))
                    or (br.player.race == "Troll" and (buff.battleCry.exists() or ignoreBattleCry or ttd(units.dyn5) <= 11))
                    or (br.player.race == "BloodElf" and (not buff.battleCry.exists() and powerDeficit > 40)))
                then
                    if castSpell("player",racial,false,false,false) then return end
                end
            -- Touch of the Void
                if useCDs() and isChecked("虚空之触") then
                    if hasEquiped(128318) then
                        if GetItemCooldown(128318)==0 then
                            useItem(128318)
                        end
                    end
                end
            -- Trinkets
                if useCDs() and getOptionValue("饰品") ~= 4 then
                    if (getOptionValue("饰品") == 1 or getOptionValue("饰品") == 3) and canUse(13) then
                        useItem(13)
                    end
                    if (getOptionValue("饰品") == 2 or getOptionValue("饰品") == 3) and canUse(14) then
                        useItem(14)
                    end
                end
            end
        end -- End Action List - Cooldowns
    -- Action List - Pre-Combat
        function actionList_PreCombat()
        -- Flask
            -- flask,type=greater_draenic_strength_flask
            if isChecked("力量药水") then
                if inRaid and canFlask and flaskBuff==0 and not UnitBuffID("player",176151) then
                    useItem(br.player.flask.wod.strengthBig)
                    return true
                end
                if flaskBuff==0 then
                    if br.player.useCrystal() then return end
                end
            end
            -- food,type=sleeper_sushi
            -- snapshot_stats
            -- potion,name=draenic_strength
            -- if useCDs() and inRaid and isChecked("力量药水") and isChecked("Pre-Pull Timer") and pullTimer <= getOptionValue("Pre-Pull Timer") then
            --     if canUse(109219) then
            --         useItem(109219)
            --     end
            -- end
        end  -- End Action List - Pre-Combat
    -- Action List - Movement
        function actionList_Movement()
            if mode.mover == 1 and isValidUnit("target") then
        -- Heroic Leap
                -- -- heroic_leap
                if isChecked("英勇飞跃") and (getOptionValue("英勇飞跃")==6 or (SpecificToggle("英勇飞跃") and not GetCurrentKeyBoardFocus())) then
                    -- Best Location
                    if getOptionValue("英勇飞跃 - 目标") == 1 then
                        if cast.heroicLeap("best",nil,1,8) then return end
                    end
                    -- Target
                    if getOptionValue("英勇飞跃 - 目标") == 2 then
                        if cast.heroicLeap("target","ground") then return end
                    end
                end
        -- Charge
                -- charge
                if isChecked("冲锋") then
                    if (cd.heroicLeap > 0 and cd.heroicLeap < 29) or not isChecked("英勇飞跃") or level < 26 then
                        if cast.charge("target") then return end
                    end
                end
        -- Storm Bolt
                -- storm_bolt
                if cast.stormBolt("target") then return end
        -- Heroic Throw
                -- heroic_throw
                if lastSpell == spell.charge or charges.charge == 0 or not isChecked("冲锋") then
                    if cast.heroicThrow("target") then return end
                end
            end
        end
    -- Action List - MortalCry
        function actionList_MortalCry()
            if cd.mortalStrike == 0 then
                if talent.focusedRage then
                    if cast.focusedRage() then end
                end
                if cd.battleCry == 0 then
                    if cast.battleCry() then bcCast = GetTime(); end
                end
                if cast.mortalStrike() then msCast = GetTime(); end
            end
            return
        end
    -- Action List - Bladestorm
        function actionList_Bladestorm()
            -- if cd.bladestorm > gcd or level < 65 then return end
            if isChecked("剑刃风暴") and getDistance(units.dyn5) < 5 then
                if #enemies.yards8 >= getOptionValue("剑刃风暴") then
                    if artifact.warbreaker then
                        if cast.warbreaker("player") then usedWarbreaker = true; end
                    end
                    if cd.warbreaker > 3 or not artifact.warbreaker then
                        if cast.bladestorm() then return end
                    end
                end
                if (cd.warbreaker > 3 or not artifact.warbreaker) and #enemies.yards8 >= getOptionValue("AoE阈值") then
                    if cast.bladestorm() then return end
                end
            end
        end
    -- Action List - Execute
        function actionList_Execute()
        -- Action List - Bladestorm
            if actionList_Bladestorm() then return end
            for i = 1, #enemies.yards8 do
                local executeUnit = enemies.yards8[i]
                if getDistance(executeUnit) < 5 and getFacing("player",executeUnit) then
                    if getHP(executeUnit) <= 20 then
                        -- if IsCurrentSpell(6603) and not UnitIsUnit(units.dyn5,executeUnit) then
                        --     StopAttack()
                        -- else
                        --     StartAttack(executeUnit)
                        -- end
        -- Focused Rage
                        if (buff.focusedRage.stack() < 3 and (buff.battleCry.exists() or ignoreBattleCry)) or powerDeficit < 25 or (buff.focusedRage.remain() < 3 and buff.focusedRage.stack() > 0) then
                            if cast.focusedRage(executeUnit) then return end
                        end
        -- Battle Cry
                        if (getOptionValue("战吼") == 1 or (getOptionValue("战吼") == 2 and useCDs())) then
                            if cd.battleCry == 0 and cd.mortalStrike == 0 and cd.colossusSmash > 2 and getDistance(units.dyn5) < 5 and lastSpell ~= spell.charge and lastSpell ~= spell.heroicThrow then
                                -- if cast.battleCry() then return end
                                if actionList_MortalCry() then return end
                            end
                        end
        -- Mortal Strike
                        -- mortal_strike,if=cooldown_react&buff.battle_cry.up&buff.focused_rage.stack()=3
                        if ((buff.battleCry.exists() or ignoreBattleCry) and buff.focusedRage.stack() == 3) or ((buff.focusedRage.remain() < cd.battleCry and cd.battleCry < 5) or (buff.focusedRage.remain() < 5 and ignoreBattleCry)) then
                            if cast.mortalStrike(executeUnit) then return end
                        end
        -- Heroic Charge
                        -- heroic_charge,if=rage.deficit>=40&(!cooldown.heroic_leap.remain()s|swing.mh.remain()s>1.2)
                        if mode.heroic == 1 and powerDeficit >= 40 and (cd.heroicLeap == 0 or swingTimer > 1.2) and getDistance(units.dyn5) < 5 then
                            heroicLeapCharge()
                        end
        -- Execute
                        -- execute,if=buff.battle_cry_deadly_calm.up
                        if (debuff.colossusSmash.exists(units.dyn5) or (cd.colossusSmash ~= 0 and (cd.warbreaker ~= 0 or not artifact.warbreaker
                            or (getOptionValue("神器技能") == 2 and not useCDs()) or getOptionValue("神器技能") == 3))) and buff.shatteredDefenses.exists()
                            and ((buff.battleCry.exists() or ignoreBattleCry) and talent.deadlyCalm)
                        then
                            if cast.execute(executeUnit) then return end
                        end
        -- Warbreaker
                        -- warbreaker,if=debuff.colossus_smash.remain()s<gcd
                        if getOptionValue("神器技能") == 1 or (getOptionValue("神器技能") == 2 and useCDs()) then
                            if not buff.shatteredDefenses.exists() and cd.colossusSmash > gcd and getDistance(units.dyn5) < 5 then
                                if cast.warbreaker("player") then usedWarbreaker = true; return end
                            end
                        end
        -- Colossus Smash
                        -- colossus_smash,if=cooldown_react&buff.shattered_defenses.down
                        if debuff.colossusSmash.remain(units.dyn5) < gcd or not buff.shatteredDefenses.exists() then
                            if cast.colossusSmash(executeUnit) then return end
                        end
        -- Avatar
                        -- avatar,if=gcd.remain()s<0.25&(buff.battle_cry.up|cooldown.battle_cry.remain()s<15)|target.time_to_die<=20
                        if (getOptionValue("天神下凡") == 1 or (getOptionValue("天神下凡") == 2 and useCDs())) then
                            if (buff.battleCry.exists() or cd.battleCry < 15) and lastSpell ~= spell.charge and lastSpell ~= spell.heroicThrow then
                                if cast.avatar() then return end
                            end
                        end
        -- Execute
                        -- execute,if=buff.shattered_defenses.up&(rage>=17.6|buff.stone_heart.react)
                        if (debuff.colossusSmash.exists(units.dyn5) or (cd.colossusSmash ~= 0 and (cd.warbreaker ~= 0 or not artifact.warbreaker
                            or (getOptionValue("神器技能") == 2 and not useCDs()) or getOptionValue("神器技能") == 3))) and buff.shatteredDefenses.exists()
                            and (rage >= 17.6 or buff.stoneHeart.exists())
                        then
                            if cast.execute(executeUnit) then return end
                        end
        -- Mortal Strike
                        -- mortal_strike,if=cooldown_react&equipped.archavons_heavy_hand&rage<60
                        if hasEquiped(137060) and rage < 60 then
                            if cast.mortalStrike(executeUnit) then return end
                        end
        -- Execute
                        -- execute,if=buff.shattered_defenses.down
                        if (debuff.colossusSmash.exists(units.dyn5) or (cd.colossusSmash ~= 0 and (cd.warbreaker ~= 0 or not artifact.warbreaker
                            or (getOptionValue("神器技能") == 2 and not useCDs()) or getOptionValue("神器技能") == 3))) and not buff.shatteredDefenses.exists()
                        then
                            if cast.execute(executeUnit) then return end
                        end
                    else
                        return
                    end
                end
            end
        end -- End Action List - Execute
    -- Action List - Single
        function actionList_Single()
        -- Action List - Bladestorm
            if actionList_Bladestorm() then return end
        -- Warbreaker
            -- warbreaker,if=debuff.colossus_smash.remain()s<gcd
            if getOptionValue("神器技能") == 1 or (getOptionValue("神器技能") == 2 and useCDs()) then
                if not buff.shatteredDefenses.exists() and cd.colossusSmash > gcd and getDistance(units.dyn5) < 5 then
                    if cast.warbreaker("player") then usedWarbreaker = true; return end
                end
            end
        -- Colossus Smash
            -- colossus_smash,if=cooldown_react&buff.shattered_defenses.down&(buff.battle_cry.down|buff.battle_cry.up&buff.battle_cry.remain()s>=gcd)
            if debuff.colossusSmash.remain(units.dyn5) < gcd or (not buff.shatteredDefenses.exists() and (not buff.battleCry.exists() or (buff.battleCry.exists() and buff.battleCry.remain() >= gcd))) then
                if cast.colossusSmash() then return end
            end
        -- Heroic Charge
            -- heroic_charge,if=rage.deficit>=40&(!cooldown.heroic_leap.remain()s|swing.mh.remain()s>1.2)
            if mode.heroic == 1 and powerDeficit >= 40 and (cd.heroicLeap == 0 or swingTimer > 1.2) and getDistance(units.dyn5) < 5 then
                heroicLeapCharge()
            end
        -- Avatar
            -- avatar,if=gcd.remain()s<0.25&(buff.battle_cry.up|cooldown.battle_cry.remain()s<15)|target.time_to_die<=20
            if (getOptionValue("天神下凡") == 1 or (getOptionValue("天神下凡") == 2 and useCDs())) then
                if (buff.battleCry.exists() or cd.battleCry < 15) and lastSpell ~= spell.charge and lastSpell ~= spell.heroicThrow then
                    if cast.avatar() then return end
                end
            end
        -- Focused Rage
            -- focused_rage,if=!buff.battle_cry_deadly_calm.up&buff.focused_rage.stack<3&!cooldown.colossus_smash.up&(rage>=50|debuff.colossus_smash.down|cooldown.battle_cry.remains<=8)
            if ((buff.battleCry.remain() > cd.focusedRage or ignoreBattleCry) and (buff.focusedRage.stack() < 3 or cd.mortalStrike > 0))
                or (not ((buff.battleCry.exists() or ignoreBattleCry) and talent.deadlyCalm) and buff.focusedRage.stack() < 3 and cd.colossusSmash > 0
                    and (rage >= 50 or not debuff.colossusSmash.exists(units.dyn5) or cd.battleCry <= 8))
            then
                -- if cast.focusedRage() then return end
                cast.focusedRage()
            end
        -- Battle Cry
            if (getOptionValue("战吼") == 1 or (getOptionValue("战吼") == 2 and useCDs())) then
                if cd.battleCry == 0 and cd.mortalStrike == 0 --[[and cd.colossusSmash > 2]] and getDistance(units.dyn5) < 5 and lastSpell ~= spell.charge and lastSpell ~= spell.heroicThrow then
                    -- if cast.battleCry() then return end
                    if actionList_MortalCry() then return end
                end
            end
        -- Mortal Strike
            if cd.battleCry > gcd or ignoreBattleCry then
                if cast.mortalStrike() then return end
            end
        -- Execute
            -- execute,if=buff.stone_heart.react
            if buff.stoneHeart.exists() then
                if cast.execute() then return end
            end
            if (cd.mortalStrike > gcd and cd.colossusSmash > gcd) or level < 20 then
                if ((mode.rotation == 1 and #enemies.yards8 > 1) or mode.rotation == 2) and level >= 40 then
        -- Cleave
                    if cast.cleave() then return end
        -- Whirlwind
                    if cast.whirlwind() then return end
                elseif ((mode.rotation == 1 and #enemies.yards8 == 1) or mode.rotation == 3) or level < 40 then
        -- Slam
                    if rage > 32 or ((buff.battleCry.exists() or ignoreBattleCry) and talent.deadlyCalm) then
                        if cast.slam() then return end
                    end
                end
            end
        -- Focused Rage
            -- focused_rage,if=equipped.archavons_heavy_hand&buff.focused_rage.stack<3
            if hasEquiped(137060) and buff.focusedRage.stack() < 3 then
                if cast.focusedRage() then return end
            end
        end -- End Action List - Single
    -- Action List - MultiTarget
        function actionList_MultiTarget()
        -- Action List - Bladestorm
            if actionList_Bladestorm() then return end
        -- Avatar
            if (getOptionValue("天神下凡") == 1 or (getOptionValue("天神下凡") == 2 and useCDs())) then
                if lastSpell ~= spell.charge and lastSpell ~= spell.heroicThrow then
                    if cast.avatar() then return end
                end
            end
        -- Warbreaker
            -- warbreaker,if=buff.shattered_defenses.down
            if getOptionValue("神器技能") == 1 or (getOptionValue("神器技能") == 2 and useCDs()) and getDistance(units.dyn5) < 5 then
                if cast.warbreaker("player") then usedWarbreaker = true; return end
            end
        -- Battle Cry
            if (getOptionValue("战吼") == 1 or (getOptionValue("战吼") == 2 and useCDs())) then
                if (usedWarbreaker and cd.bladestorm == 0) or cd.bladestorm > 2 then
                    if cast.battleCry() then return end
                end
            end
        -- Cleave
            -- cleave
            if cast.cleave() then return end
        -- Whirlwind
            -- whirlwind,if=rage>=40
            if rage >= 40 and level >= 40 then
                if cast.whirlwind() then return end
            end
        -- Single/Execute
            if rage < 20 or level < 40 then
                -- run_action_list,name=execute,target_if=target.health.pct<=20&spell_targets.whirlwind<5
                if level >= 8 then
                    if actionList_Execute() then return end
                end
                -- run_action_list,name=single,if=target.health.pct>20
                if getHP(units.dyn5) > 20 or level < 8 then
                    if actionList_Single() then return end
                end
            end
        end -- End Action List - MultiTarget
-----------------
--- Rotations ---
-----------------
        if actionList_Extra() then return end
        if actionList_Defensive() then return end
        -- Pause
        if pause() or (GetUnitExists("target") and (UnitIsDeadOrGhost("target") or not UnitCanAttack("target", "player"))) or mode.rotation == 4 then
            return true
        else
---------------------------------
--- Out Of Combat - Rotations ---
---------------------------------
            if not inCombat and isValidUnit("target") then
                if actionList_PreCombat() then return end
                if getDistance(units.dyn5)<5 then
                    if not IsCurrentSpell(6603) then
                        StartAttack(units.dyn5)
                    end
                else
            -- Action List - Movement
                    -- run_action_list,name=movement,if=movement.getDistance(units.dyn5)>5
                    -- if getDistance("target") >= 8 then
                        if actionList_Movement() then return end
                    -- end
                end
            end
-----------------------------
--- In Combat - Rotations ---
-----------------------------
            if inCombat and isValidUnit(units.dyn5) then
            -- Auto Attack
                --auto_attack
                -- if IsCurrentSpell(6603) and not UnitIsUnit(units.dyn5,"target") then
                --     StopAttack()
                -- else
                --     StartAttack(units.dyn5)
                -- end
                if not IsCurrentSpell(6603) then
                    StartAttack(units.dyn5)
                end
            -- Action List - Movement
                -- run_action_list,name=movement,if=movement.getDistance(units.dyn5)>5
                -- if getDistance(units.dyn8) > 8 then
                    if actionList_Movement() then return end
                -- end
            -- Action List - Interrupts
                if actionList_Interrupts() then return end
            -- Action List - Cooldowns
                if actionList_Cooldowns() then return end
            -- Rend
                -- rend,if=remains<gcd
                if debuff.rend.remain(units.dyn5) < gcd then
                    if cast.rend() then return end
                end
            -- Ravager
                -- ravager
                if useCDs() and isChecked("破坏者") then
                    -- Best Location
                    if getOptionValue("破坏者") == 1 then
                        if cast.ravager("best",nil,1,8) then return end
                    end
                    -- Target
                    if getOptionValue("破坏者") == 2 then
                        if cast.ravager("target","ground") then return end
                    end
                end
            -- Overpower
                -- overpower,if=buff.overpower.react
                if buff.overpower.exists() then
                    if cast.overpower() then return end
                end
            -- Action List - Bladestorm
                if actionList_Bladestorm() then return end
            -- Action List - Multitarget
                -- run_action_list,name=aoe,if=spell_targets.whirlwind>=5&!talent.sweeping_strikes.enabled
                if ((mode.rotation == 1 and #enemies.yards8 >= getOptionValue("AoE阈值")) or mode.rotation == 2) then
                    if actionList_MultiTarget() then return end
                end
                if #enemies.yards5 > 0 and ((mode.rotation == 1 and #enemies.yards5 < getOptionValue("AoE阈值")) or mode.rotation == 3) then
            -- Action List - Single/Execute
                    -- run_action_list,name=execute,target_if=target.health.pct<=20&spell_targets.whirlwind<5
                    if level >= 8 then
                        if actionList_Execute() then return end
                    end
                    -- run_action_list,name=single,if=target.health.pct>20
                    if getHP(units.dyn5) > 20 or level < 8 then
                        if actionList_Single() then return end
                    end
                end
            end -- End Combat Rotation
        end -- Pause
    end -- End Timer
end -- runRotation
local id = 71
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})
