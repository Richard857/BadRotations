local rotationName = "CuteOne"
---------------
--- Toggles ---
---------------
local function createToggles()
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "基于范围内的目标数,在单目标和多目标自动切换输出方式.", highlight = 1, icon = br.player.spell.divineStorm },
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "使用多目标方式输出.", highlight = 0, icon = br.player.spell.divineStorm },
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "使用单目标方式输出.", highlight = 0, icon = br.player.spell.crusaderStrike },
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "禁用DPS输出", highlight = 0, icon = br.player.spell.flashOfLight }
    }
    CreateButton("Rotation",1,0)
-- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "自动使用大技能 - 只在BOSS.", highlight = 1, icon = br.player.spell.avengingWrath },
        [2] = { mode = "On", value = 1 , overlay = "Cooldowns Enabled", tip = "不管任何目标都使用大技能.", highlight = 0, icon = br.player.spell.avengingWrath },
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "不使用大技能.", highlight = 0, icon = br.player.spell.avengingWrath }
    };
    CreateButton("Cooldown",2,0)
-- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "使用保命技能.", highlight = 1, icon = br.player.spell.flashOfLight },
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "不使用保命技能.", highlight = 0, icon = br.player.spell.flashOfLight }
    };
    CreateButton("Defensive",3,0)
-- Interrupt Button
    InterruptModes = {
        [1] = { mode = "On", value = 1 , overlay = "Interrupts Enabled", tip = "使用打断.", highlight = 1, icon = br.player.spell.hammerOfJustice },
        [2] = { mode = "Off", value = 2 , overlay = "Interrupts Disabled", tip = "不使用打断.", highlight = 0, icon = br.player.spell.hammerOfJustice }
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
            br.ui:createDropdownWithout(section, "APL模式", {"|cffFFFFFFSimC","|cffFFFFFFAMR"}, 1, "|cffFFFFFF选择输出循环.")
            -- Dummy DPS Test
            br.ui:createSpinner(section, "DPS测试",  5,  5,  60,  5,  "|cffFFFFFF设置为所需的测试的时间（分钟）. 最小: 5 / 最大: 60 / 间隔: 5")
            -- Opener
            br.ui:createCheckbox(section, "Opener")
            -- Greater Blessing of Might
            -- br.ui:createCheckbox(section, "Greater Blessing of Might")
            -- Hand of Freedom
            br.ui:createCheckbox(section, "自由祝福")
            -- Hand of Hindeance
            br.ui:createCheckbox(section, "妨害之手")
            -- Divine Storm Units
            br.ui:createSpinner(section, "神圣风暴 数量",  2,  2,  3,  1,  "|cffFFBB00使用神风暴的单位.如果你有神恩风暴和正义之刃神的神器特质请设置为2，如果你没有这些特质设置为3.")
            -- Artifact
            br.ui:createDropdownWithout(section,"神器技能", {"|cff00FF00任何时候","|cffFFFF00冷却技能","|cffFF0000决不"}, 1, "|cffFFFFFF何时使用神器技能.")
        br.ui:checkSectionState(section)
        ------------------------
        --- COOLDOWN OPTIONS ---
        ------------------------
        section = br.ui:createSection(br.ui.window.profile,  "冷却技能")
            -- Racial
            br.ui:createCheckbox(section,"种族技能")
            -- Trinkets
            br.ui:createCheckbox(section,"饰品")
            -- Holy Wrath
            br.ui:createCheckbox(section,"神圣愤怒")
            -- Avenging Wrath
            br.ui:createCheckbox(section,"复仇之怒")
            -- Shield of Vengeance
            br.ui:createCheckbox(section,"复仇之盾")
            -- Cruusade
            br.ui:createCheckbox(section,"征伐")
        br.ui:checkSectionState(section)
        -------------------------
        --- DEFENSIVE OPTIONS ---
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, "保命")
            -- Healthstone
            br.ui:createSpinner(section, "药水/治疗石",  60,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用")
            -- Heirloom Neck
            br.ui:createSpinner(section, "传家宝项链",  60,  0,  100,  5,  "|cffFFBB00多少血量百分比使用");
            -- Gift of The Naaru
            if br.player.race == "Draenei" then
                br.ui:createSpinner(section, "纳鲁的赐福",  50,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用")
            end
            -- Blessing of Protection
            br.ui:createSpinner(section, "保护祝福", 20, 0, 100, 5, "多少血量百分比使用")
            br.ui:createDropdownWithout(section, "保护祝福 目标", {"|cffFFFFFF所有","|cffFFFFFF坦克", "|cffFFFFFF自己"}, 1, "|cffFFFFFF使用保护祝福的目标")	
            -- Blinding Light
            br.ui:createSpinner(section, "盲目之光 - HP", 50, 0, 100, 5, "|cffFFFFFF多少血量百分比使用")
            br.ui:createSpinner(section, "盲目之光 - AoE", 3, 0, 10, 1, "|cffFFFFFF投5码的单位数量")
            -- Cleanse Toxin
            br.ui:createDropdown(section, "清毒术", {"|cff00FF00自己","|cffFFFF00所选的目标","|cffFF0000鼠标位置目标"}, 1, "|ccfFFFFFF选择目标")
            -- Divine Shield
            br.ui:createSpinner(section, "圣盾术",  50,  0,  100,  5,  "|cffFFBB00多少血量百分比使用")
            -- Eye for an Eye
            br.ui:createSpinner(section, "以眼还眼", 50, 0 , 100, 5, "|cffFFBB00多少血量百分比使用")
            -- Flash of Light
            br.ui:createSpinner(section, "圣光闪现",  50,  0,  100,  5,  "|cffFFBB00多少血量百分比使用")
            -- Hammer of Justice
            br.ui:createSpinner(section, "制裁之锤  - HP",  50,  0,  100,  5,  "|cffFFBB00多少血量百分比使用")
            -- Justicar's Vengeance
            br.ui:createSpinner(section, "审判官复仇",  50,  0,  100,  5,  "|cffFFBB00多少血量百分比使用")
            -- Lay On Hands
            br.ui:createSpinner(section, "圣疗术",  50,  0,  100,  5,  "|cffFFBB00多少血量百分比使用")
            br.ui:createDropdownWithout(section, "圣疗术 目标", {"|cffFFFFFF所有","|cffFFFFFF坦克", "|cffFFFFFF自己"}, 1, "|cffFFFFFF选择目标")
            -- Redemption
            br.ui:createDropdown(section, "救赎", {"|cffFFFF00所选的目标","|cffFF0000鼠标位置目标"}, 1, "|ccfFFFFFF选择目标")
        br.ui:checkSectionState(section)
        -------------------------
        --- INTERRUPT OPTIONS ---
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, "打断")
            -- Blinding Light
            br.ui:createCheckbox(section, "盲目之光")
            -- Hammer of Justice
            br.ui:createCheckbox(section, "制裁之锤")
            -- Rebuke
            br.ui:createCheckbox(section, "责难")
            -- Interrupt Percentage
            br.ui:createSpinner(section,  "打断",  0,  0,  95,  5,  "|cffFFBB00读条百分几打断")
        br.ui:checkSectionState(section)
        ----------------------
        --- TOGGLE OPTIONS ---
        ----------------------
        section = br.ui:createSection(br.ui.window.profile,  "切换快捷键")
            -- Single/Multi Toggle
            br.ui:createDropdown(section,  "运行模式", br.dropOptions.Toggle,  4)
            --Cooldown Key Toggle
            br.ui:createDropdown(section,  "冷却技能模式", br.dropOptions.Toggle,  3)
            --Defensive Key Toggle
            br.ui:createDropdown(section,  "保命模式", br.dropOptions.Toggle,  6)
            -- Interrupts Key Toggle
            br.ui:createDropdown(section,  "打断模式", br.dropOptions.Toggle,  6)
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
    if br.timer:useTimer("debugRetribution", math.random(0.15,0.3)) then -- Change debugSpec tp name of Spec IE: debugFeral or debugWindwalker
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
        local artifact      = br.player.artifact
        local buff          = br.player.buff
        local cast          = br.player.cast
        local cd            = br.player.cd
        local charges       = br.player.charges
        local combatTime    = getCombatTime()
        local debuff        = br.player.debuff
        local enemies       = enemies or {}
        local gcd           = br.player.gcd
        local hastar        = GetObjectExists("target")
        local healPot       = getHealthPot()
        local holyPower     = br.player.power.amount.holyPower
        local holyPowerMax  = br.player.power.holyPower.max
        local inCombat      = br.player.inCombat
        local level         = br.player.level
        local mode          = br.player.mode
        local php           = br.player.health
        local race          = br.player.race
        local racial        = br.player.getRacial()
        local resable       = UnitIsPlayer("target") and UnitIsDeadOrGhost("target") and UnitIsFriend("target","player")
        local solo          = GetNumGroupMembers() == 0
        local spell         = br.player.spell
        local talent        = br.player.talent
        local ttd           = getTTD(br.player.units(5))
        local units         = units or {}

        units.dyn5 = br.player.units(5)
        enemies.yards5 = br.player.enemies(5)
        enemies.yards8 = br.player.enemies(8)
        enemies.yards10 = br.player.enemies(10)

        if profileStop == nil then profileStop = false end
        if opener == nil then opener = false end
        if not inCombat and not GetObjectExists("target") then
            opener = false
            JUD1 = false
            BOJ1 = false
            CRU1 = false
            EXE1 = false
            TMV1 = false
            WOA1 = false
            TMV2 = false
            ARC1 = false
            TMV3 = false
            CRS1 = false
            TMV4 = false
        end
        judgmentExists = debuff.judgment.exists(units.dyn5)
        judgmentRemain = debuff.judgment.remain(units.dyn5)
        if debuff.judgment.exists(units.dyn5) or level < 42 or (cd.judgment > 2 and not debuff.judgment.exists(units.dyn5)) then
            judgmentVar = true
        else
            judgmentVar = false
        end
        local greaterBuff
        greaterBuff = 0
        local lowestUnit
        lowestUnit = "player"
        for i = 1, #br.friend do
            local thisUnit = br.friend[i].unit
            local thisHP = getHP(thisUnit)
            local lowestHP = getHP(lowestUnit)
            if thisHP < lowestHP then
                lowestUnit = thisUnit
            end
            -- if UnitBuffID(thisUnit,spell.buffs.greaterBlessingOfMight) ~= nil then
            --     greaterBuff = greaterBuff + 1
            -- end
        end

--------------------
--- Action Lists ---
--------------------
    -- Action List - Extras
        local function actionList_Extras()
        -- Hand of Freedom
            if isChecked("自由祝福") and hasNoControl("player") then
                if cast.blessingOfFreedom("player") then return end
            end
        -- Hand of Hinderance
            if isChecked("妨害之手") and isMoving("target") and not getFacing("target","player") and getDistance("target") > 8 then
                if cast.handOfHinderance("target") then return end
            end
        -- Greater Blessing of Might
            -- if isChecked("Greater Blessing of Might") and greaterBuff < 3 then
            --     for i = 1, #br.friend do
            --         local thisUnit = br.friend[i].unit
            --         local unitRole = UnitGroupRolesAssigned(thisUnit)
            --         if UnitBuffID(thisUnit,spell.buffs.greaterBlessingOfMight) == nil and (unitRole == "DAMAGER" or solo) then
            --             if cast.greaterBlessingOfMight(thisUnit) then return end
            --         end
            --     end
            -- end
        end -- End Action List - Extras
    -- Action List - Defensives
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
                    if hasEquiped(122667) then
                        if GetItemCooldown(122667)==0 then
                            useItem(122667)
                        end
                    end
                end
        -- Gift of the Naaru
                if isChecked("纳鲁的赐福") and php <= getOptionValue("纳鲁的赐福") and php > 0 and race == "Draenei" then
                    if castSpell("player",racial,false,false,false) then return end
                end
        -- Blessing of Protection
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
                        if php <= getValue("保护祝福") and not debuff.forbearance.exists("player") then
                            if cast.blessingOfProtection("player") then return end
                        end
                    end
                end
        -- Blinding Light
                if isChecked("盲目之光 - HP") and php <= getOptionValue("盲目之光 - HP") and inCombat and #enemies.yards10 > 0 then
                    if cast.blindingLight() then return end
                end
                if isChecked("盲目之光 - AoE") and #enemies.yards5 >= getOptionValue("盲目之光 - AoE") and inCombat then
                    if cast.blindingLight() then return end
                end
        -- Cleanse Toxins
                if isChecked("清毒术") then
                    if getOptionValue("清毒术")==1 and canDispel("player",spell.cleanseToxins) then
                        if cast.cleanseToxins("player") then return end
                    end
                    if getOptionValue("清毒术")==2 and canDispel("target",spell.cleanseToxins) then
                        if cast.cleanseToxins("target") then return end
                    end
                    if getOptionValue("清毒术")==3 and canDispel("mouseover",spell.cleanseToxins) then
                        if cast.cleanseToxins("mouseover") then return end
                    end
                end	
        -- Divine Shield
                if isChecked("圣盾术") then
                    if php <= getOptionValue("圣盾术") and inCombat then
                        if cast.divineShield() then return end
                    end
                end
        -- Eye for an Eye
                if isChecked("以眼还眼") then
                    if php <= getOptionValue("以眼还眼") and inCombat then
                        if cast.eyeForAnEye() then return end
                    end
                end
        -- Flash of Light
                if isChecked("圣光闪现") then
                    if (forceHeal or (inCombat and php <= getOptionValue("圣光闪现") / 2) or (not inCombat and php <= getOptionValue("圣光闪现"))) and not isMoving("player") then
                        if cast.flashOfLight() then return end
                    end
                end
        -- Hammer of Justice
                if isChecked("制裁之锤  - HP") and php <= getOptionValue("制裁之锤  - HP") and inCombat then
                    if cast.hammerOfJustice() then return end
                end
        -- Lay On Hands
                if isChecked("圣疗术") then
                    -- if getHP(lowestUnit) < getOptionValue("圣疗术") and inCombat then
                    --     if cast.layOnHands(lowestUnit) then return end
                    -- end
                    if getOptionValue("圣疗术 目标") == 1 then
                        for i = 1, #br.friend do
                            if br.friend[i].hp <= getValue ("圣疗术") then
                                if cast.layOnHands(br.friend[i].unit) then return end
                            end
                        end
                    elseif getOptionValue("圣疗术 目标") == 2 then
                        for i = 1, #br.friend do
                            if br.friend[i].hp <= getValue ("圣疗术") and UnitGroupRolesAssigned(br.friend[i].unit) == "TANK" then
                                if cast.layOnHands(br.friend[i].unit) then return end
                            end
                        end
                    elseif getOptionValue("圣疗术 目标") == 3 then
                        if php <= getValue("圣疗术") then
                            if cast.layOnHands("player") then return end
                        end
                    end
                end
        -- Redemption
                if isChecked("救赎") then
                    if getOptionValue("救赎")==1 and not isMoving("player") and resable then
                        if cast.redemption("target","dead") then return end
                    end
                    if getOptionValue("救赎")==2 and not isMoving("player") and resable then
                        if cast.redemption("mouseover","dead") then return end
                    end
                end
            end
        end -- End Action List - Defensive
    -- Action List - Interrupts
        local function actionList_Interrupts()
            if useInterrupts() then
                for i = 1, #enemies.yards10 do
                    local thisUnit = enemies.yards10[i]
                    local distance = getDistance(thisUnit)
                    if canInterrupt(thisUnit,getOptionValue("打断")) then
        -- Hammer of Justice
                        if isChecked("制裁之锤") and distance < 10 then
                            if cast.hammerOfJustice(thisUnit) then return end
                        end
        -- Rebuke
                        if isChecked("责难") and distance < 5 then
                            if cast.rebuke(thisUnit) then return end
                        end
        -- Blinding Light
                        if isChecked("盲目之光") and distance < 10 then
                            if cast.blindingLight() then return end
                        end
                    end
                end
            end
        end -- End Action List - Interrupts
    -- Action List - Cooldowns
        local function actionList_Cooldowns()
            if useCDs() or burst then
            -- Trinkets
                if isChecked("饰品") and getDistance(units.dyn5) < 5 then
                    if canUse(13) then
                        useItem(13)
                    end
                    if canUse(14) then
                        useItem(14)
                    end
                end
                if getOptionValue("APL模式") == 1 then

                end
                if getOptionValue("APL模式") == 2 then
            -- Crusade
                    if isChecked("征伐") and talent.crusade then
                        if cast.avengingWrath() then return end
                    end
            -- Avenging Wrath
                    if isChecked("复仇之怒") and not talent.crusade then
                        if cast.avengingWrath() then return end
                    end
                end
            end -- End Cooldown Usage Check
        end -- End Action List - Cooldowns
    -- Action List - PreCombat
        local function actionList_PreCombat()
            if isValidUnit("target") and (not isBoss("target") or not isChecked("Opener")) then
        -- Divine Hammer
                if cast.divineHammer() then return end
        -- Judgment
                if cast.judgment("target") then return end
        -- Start Attack
                if getDistance("target") < 5 then StartAttack() end
            end
        end -- End Action List - PreCombat
    -- Action List - Opener
        local function actionList_Opener()
            if isValidUnit("target") and getDistance("target") < 5 then
                if isChecked("Opener") and isBoss("target") and opener == false then
                    if not JUD1 then
                        Print("Starting Opener")
            -- Divine Hammer
                        cast.divineHammer()
            -- Judgment
                        if castOpener("judgment","JUD1",1) then return end
                    elseif JUD1 and not BOJ1 then
            -- Blade of Justice
                        if talent.bladeOfWrath then
                            if castOpener("bladeOfJustice","BOJ1",2) then return end
                        else
                            if castOpener("divineHammer","BOJ1",2) then return end
                        end
                    elseif BOJ1 and not CRU1 then
            -- Crusade
                        if castOpener("avengingWrath","CRU1",3) then return end
                    elseif CRU1 and not EXE1 then
            -- Execution Sentence / Templar's Verdict
                        if talent.executionSentence then
                            if castOpener("executionSentence","EXE1",4) then return end
                        else
                            if castOpener("templarsVerdict","EXE1",4) then return end
                        end
                    elseif EXE1 and not WOA1 then
            -- Wake of Ashes
                        if castOpener("wakeOfAshes","WOA1",5) then return end
                    elseif WOA1 and not TMV1 then
            -- Templar's Verdict 
                        if castOpener("templarsVerdict","TMV1",6) then return end
                    elseif TMV1 and not ARC1 then
                        if br.player.race == "BloodElf" then
            -- Arcane Torrent
                            castSpell("player",racial,false,false,false)
                            if castOpener("templarsVerdict","ARC1",7) then return end
                        else
                            if castOpener("crusaderStrike","ARC1",7) then return end
                        end
                    elseif ARC1 and not TMV2 then
                        if castOpener("templarsVerdict","TMV2",8) then return end
                    elseif TMV2 then
                        opener = true;
                        Print("Opener Complete")
                        return
                    end
                else
                    opener = true
                end
            end
        end -- End Action List - Opener
---------------------
--- Begin Profile ---
---------------------
    --Profile Stop | Pause
        if not inCombat and not hastar and profileStop == true then
            profileStop = false
        elseif (inCombat and profileStop == true) or ((IsMounted() or IsFlying()) and not UnitBuffID("player",220507) and not buff.divineSteed.exists()) or pause() or mode.rotation == 4 then
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
----------------------------
--- Out of Combat Opener ---
----------------------------
            if actionList_Opener() then return end
--------------------------
--- In Combat Rotation ---
--------------------------
            if inCombat and profileStop==false then
------------------------------
--- In Combat - Interrupts ---
------------------------------
                if actionList_Interrupts() then return end
-----------------------------
--- In Combat - Cooldowns ---
-----------------------------
                if actionList_Cooldowns() then return end
----------------------------------
--- In Combat - Begin Rotation ---
----------------------------------
--------------------------------
--- In Combat - SimCraft APL ---
--------------------------------
                if getOptionValue("APL模式") == 1 then
            -- Opener
                    if actionList_Opener() then return end
            -- Start Attack
                    if getDistance(units.dyn5) < 5 then
                        if not IsCurrentSpell(6603) then
                            StartAttack(units.dyn5)
                        end
                    end
            -- Racials
                    -- blood_fury
                    -- berserking
                    -- arcane_torrent,if=holy_power<5
                    if isChecked("种族技能") and useCDs() then
                        if race == "Orc" or race == "Troll" or (race == "BloodElf" and holyPower < 5 and (buff.crusade.exists() or buff.avengingWrath.exists() or combatTime < 2)) and getSpellCD(racial) == 0 then
                            if castSpell("player",racial,false,false,false) then return end
                        end
                    end
            -- Combat Time less than 2 secs
                    if combatTime < 2 then
            -- Judgement
                        -- judgment,if=time<2
                        if cast.judgment() then return end
            -- Blade of Justice
                        -- blade_of_justice,if=time<2&(equipped.137048|race.blood_elf)
                        if not talent.divineHammer and (hasEquiped(137048) or race == "BloodElf") then
                            if cast.bladeOfJustice() then return end
                        end
            -- Divine Hammer
                        -- divine_hammer,if=time<2&(equipped.137048|race.blood_elf)
                        if talent.divineHammer and (hasEquiped(137048) or race == "BloodElf") then
                            if cast.divineHammer() then return end
                        end
            -- Wake of Ashes
                        -- wake_of_ashes,if=holy_power<=1&time<2
                        if getOptionValue("神器技能") == 1 or (getOptionValue("神器技能") == 2 and useCDs()) then
                            if getDistance(units.dyn5) < 5 and holyPower <= 1 then
                                if cast.wakeOfAshes() then return end
                            end
                        end
                    end
                    if useCDs() then
            -- Holy Wrath
                        -- holy_wrath
                        if isChecked("神圣愤怒") then
                            if cast.holyWrath() then return end
                        end
            -- Avenging Wrath
                        -- avenging_wrath
                        if isChecked("复仇之怒") and not talent.crusade and getDistance(units.dyn5) < 5 then
                            if cast.avengingWrath() then return end
                        end
            -- Shield of Vengeance
                        -- shield_of_vengeance
                        if isChecked("复仇之盾") then
                            if cast.shieldOfVengeance() then return end
                        end
            -- Crusade
                        -- crusade,if=holy_power>=5&!equipped.137048|((equipped.137048|race.blood_elf)&time<2|time>2&holy_power>=4)
                        if isChecked("征伐") and talent.crusade and getDistance(units.dyn5) < 5 then
                            if (holyPower >= 5 and not hasEquiped(137048)) or ((hasEquiped(137048) or race == "BloodElf") and combatTime < 2 or combatTime > 2 and holyPower >= 4) then
                                if cast.avengingWrath() then return end
                            end
                        end
                    end
            -- Execution Sentence
                    -- execution_sentence,if=spell_targets.divine_storm<=3&(cooldown.judgment.remain()s<gcd*4.5|debuff.judgment.remain()s>gcd*4.67)&(!talent.crusade.enabled|cooldown.crusade.remain()s>gcd*2)
                    if #enemies.yards8 <= 3 and (cd.judgment < gcd * 4.5 or judgmentRemain > gcd * 4.67) and (not talent.crusade or cd.crusade > gcd *2 or not isChecked("征伐") or not useCDs()) and ttd > 6 then
                        if cast.executionSentence() then return end
                    end
            -- Divine Storm
                    -- divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.divine_purpose.up&buff.divine_purpose.remain()s<gcd*2
                    -- divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=5&buff.divine_purpose.react
                    -- divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=3&buff.crusade.up&(buff.crusade.stack()<15|buff.bloodlust.up)
                    -- divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&holy_power>=5&(!talent.crusade.enabled|cooldown.crusade.remain()s>gcd*3)
                    if not isChecked("审判官复仇") or (isChecked("审判官复仇") and php >= getOptionValue("审判官复仇")) then
                        if judgmentVar and ((mode.rotation == 1 and #enemies.yards8 >= getOptionValue("神圣风暴 数量")) or mode.rotation == 2) 
                            and ((buff.divinePurpose.exists() and buff.divinePurpose.remain() < gcd * 2)
                            or (holyPower >= 5 and buff.divinePurpose.exists())
                            or (holyPower >= 3 and buff.crusade.exists() and (buff.crusade.stack() < 15 or hasBloodLust()))
                            or (holyPower >= 5 and (not talent.crusade or cd.crusade > gcd * 3 or not isChecked("征伐") or not useCDs())))
                        then
                            if cast.divineStorm() then return end
                        end
                    end
            -- Justicar's Vengeance
                    -- justicars_vengeance,if=debuff.judgment.up&buff.divine_purpose.up&buff.divine_purpose.remain()s<gcd*2&!equipped.whisper_of_the_nathrezim
                    -- justicars_vengeance,if=debuff.judgment.up&holy_power>=5&buff.divine_purpose.react&!equipped.whisper_of_the_nathrezim
                    if isChecked("审判官复仇") and php < getOptionValue("审判官复仇") then
                        if judgmentVar and ((buff.divinePurpose.exists() and buff.divinePurpose.remain() < gcd * 2 and not hasEquiped(137020))
                            or holyPower >= 5 )
                        then
                            if cast.justicarsVengeance() then return end
                        end
                    end
            -- Templar's Verdict
                    -- templars_verdict,if=debuff.judgment.up&buff.divine_purpose.up&buff.divine_purpose.remain()s<gcd*2
                    -- templars_verdict,if=debuff.judgment.up&holy_power>=5&buff.divine_purpose.react
                    -- templars_verdict,if=debuff.judgment.up&holy_power>=3&buff.crusade.up&(buff.crusade.stack()<15|buff.bloodlust.up)
                    -- templars_verdict,if=debuff.judgment.up&holy_power>=5&(!talent.crusade.enabled|cooldown.crusade.remain()s>gcd*3)
                    if not isChecked("审判官复仇") or (isChecked("审判官复仇") and php >= getOptionValue("审判官复仇")) then
                        if judgmentVar and ((mode.rotation == 1 and #enemies.yards8 < getOptionValue("神圣风暴 数量")) or mode.rotation == 3)
                            and ((buff.divinePurpose.exists() and buff.divinePurpose.remain() < gcd * 2)
                            or (holyPower >= 5 and buff.divinePurpose.exists())
                            or (holyPower >= 3 and buff.crusade.exists() and (buff.crusade.stack() < 15 or hasBloodLust()))
                            or (holyPower >= 5 and (not talent.crusade or cd.crusade > gcd * 3 or not isChecked("征伐") or not useCDs())))
                        then
                            if cast.templarsVerdict() then return end
                        end
                    end
            -- Divine Storm
                    -- divine_storm,if=debuff.judgment.up&holy_power>=3&spell_targets.divine_storm>=2&(cooldown.wake_of_ashes.remain()s<gcd*2&artifact.wake_of_ashes.enabled|buff.whisper_of_the_nathrezim.up&buff.whisper_of_the_nathrezim.remain()s<gcd)&(!talent.crusade.enabled|cooldown.crusade.remain()s>gcd*4)
                    if not isChecked("审判官复仇") or (isChecked("审判官复仇") and php >= getOptionValue("审判官复仇")) then
                        if judgmentVar and holyPower >= 3 and ((mode.rotation == 1 and #enemies.yards8 >= getOptionValue("神圣风暴 数量")) or mode.rotation == 2)
                            and ((cd.wakeOfAshes < gcd * 2 and artifact.wakeOfAshes) or (buff.whisperOfTheNathrezim.exists() and buff.whisperOfTheNathrezim.remain() < gcd) or not artifact.wakeOfAshes)
                            and (not talent.crusade or cd.crusade > gcd * 4 or not isChecked("征伐") or not useCDs())
                        then
                            if cast.divineStorm() then return end
                        end
                    end
            -- Justicar's Vengeance
                    -- justicars_vengeance,if=debuff.judgment.up&holy_power>=3&buff.divine_purpose.up&cooldown.wake_of_ashes.remain()s<gcd*2&artifact.wake_of_ashes.enabled&!equipped.whisper_of_the_nathrezim
                    if isChecked("审判官复仇") and php < getOptionValue("审判官复仇") then
                        if judgmentVar and holyPower >= 3 and buff.divinePurpose.exists() and ((cd.wakeOfAshes < gcd * 2 and artifact.wakeOfAshes) or not artifact.wakeOfAshes) and not hasEquiped(137020) then
                            if cast.justicarsVengeance() then return end
                        end
                    end
            -- Templar's Verdict
                    -- templars_verdict,if=debuff.judgment.up&holy_power>=3&(cooldown.wake_of_ashes.remain()s<gcd*2&artifact.wake_of_ashes.enabled|buff.whisper_of_the_nathrezim.up&buff.whisper_of_the_nathrezim.remain()s<gcd)&(!talent.crusade.enabled|cooldown.crusade.remain()s>gcd*4)
                    if not isChecked("审判官复仇") or (isChecked("审判官复仇") and php >= getOptionValue("审判官复仇")) then
                        if judgmentVar and holyPower >= 3 and ((mode.rotation == 1 and #enemies.yards8 < getOptionValue("神圣风暴 数量")) or mode.rotation == 3)
                            and ((cd.wakeOfAshes < gcd * 2 and artifact.wakeOfAshes) or (buff.whisperOfTheNathrezim.exists() and buff.whisperOfTheNathrezim.remain() < gcd) or not artifact.wakeOfAshes)
                            and (not talent.crusade or cd.crusade < gcd * 4 or not isChecked("征伐") or not useCDs())
                        then
                            if cast.templarsVerdict() then return end
                        end
                    end
            -- Wake of Ashes
                    -- wake_of_ashes,if=holy_power=0|holy_power=1&(cooldown.blade_of_justice.remain()s>gcd|cooldown.divine_hammer.remain()s>gcd)|holy_power=2&(cooldown.zeal.charges_fractional<=0.65|cooldown.crusader_strike.charges_fractional<=0.65)
                    if getOptionValue("神器技能") == 1 or (getOptionValue("神器技能") == 2 and useCDs()) then
                        if holyPower == 0 or (holyPower == 1 and (cd.bladeOfJustice > gcd or cd.divineHammer > gcd)) or (holyPower == 2 and (charges.frac.zeal <= 0.65 or charges.frac.crusaderStrike <= 0.65)) and getDistance(units.dyn5) < 5 then
                            if cast.wakeOfAshes() then return end
                        end
                    end
            -- Blade of Justice
                    -- blade_of_justice,if=holy_power<=3&buff.whisper_of_the_nathrezim.up&buff.whisper_of_the_nathrezim.remain()s>gcd&buff.whisper_of_the_nathrezim.remain()s<gcd*3&debuff.judgment.up&debuff.judgment.remain()s>gcd*2
                    if not talent.divineHammer and holyPower <= 3 and buff.whisperOfTheNathrezim.exists() and buff.whisperOfTheNathrezim.remain() > gcd and buff.whisperOfTheNathrezim.remain() < gcd * 3 and judgmentVar and debuff.judgment.remain(units.dyn5) > gcd * 2 then
                        if cast.bladeOfJustice() then return end
                    end
            -- Divine Hammer
                    -- divine_hammer,if=holy_power<=3&buff.whisper_of_the_nathrezim.up&buff.whisper_of_the_nathrezim.remain()s>gcd&buff.whisper_of_the_nathrezim.remain()s<gcd*3&debuff.judgment.up&debuff.judgment.remain()s>gcd*2
                    -- if ((mode.rotation == 1 and #enemies.yards8 >= getOptionValue("神圣风暴 数量")) or mode.rotation == 2) then
                        if talent.divineHammer and holyPower <= 3 and buff.whisperOfTheNathrezim.exists() and buff.whisperOfTheNathrezim.remain() > gcd and buff.whisperOfTheNathrezim.remain() < gcd * 3 and judgmentVar and debuff.judgment.remain(units.dyn5) > gcd * 2 then
                            if cast.divineHammer() then return end
                        end
                    -- end
            -- Blade of Justice
                    -- blade_of_justice,if=talent.blade_of_wrath.enabled&holy_power<=3
                    if talent.bladeOfWrath and holyPower <= 3 then
                        if cast.bladeOfJustice() then return end
                    end
            -- Zeal
                    -- zeal,if=charges=2&holy_power<=4
                    if talent.zeal and charges.zeal == 2 and holyPower <= 4 then
                        if cast.zeal() then return end
                    end
            -- Crusader Strike
                    -- crusader_strike,if=charges=2&holy_power<=4
                    if not talent.zeal and charges.crusaderStrike == 2 and holyPower <= 4 then
                        if cast.crusaderStrike() then return end
                    end
            -- Blade of Justice
                    -- blade_of_justice,if=holy_power<=2|(holy_power<=3&(cooldown.zeal.charges_fractional<=1.34|cooldown.crusader_strike.charges_fractional<=1.34))
                    if not talent.divineHammer and (holyPower <= 2 or (holyPower <= 3 and (charges.frac.zeal <= 1.34 or charges.frac.crusaderStrike <= 1.34))) then
                        if cast.bladeOfJustice() then return end
                    end
            -- Divine Hammer
                    -- divine_hammer,if=holy_power<=2|(holy_power<=3&(cooldown.zeal.charges_fractional<=1.34|cooldown.crusader_strike.charges_fractional<=1.34))
                    -- if ((mode.rotation == 1 and #enemies.yards8 >= getOptionValue("神圣风暴 数量")) or mode.rotation == 2) then
                        if talent.divineHammer and holyPower <= 2 or (holyPower <= 3 and (charges.frac.zeal <= 1.34 or charges.frac.crusaderStrike <= 1.34)) then
                            if cast.divineHammer() then return end
                        end
                    -- end
            -- Judgement
                    -- judgment,if=holy_power>=3|((cooldown.zeal.charges_fractional<=1.67|cooldown.crusader_strike.charges_fractional<=1.67)&(cooldown.divine_hammer.remain()s>gcd|cooldown.blade_of_justice.remain()s>gcd))|(talent.greater_judgment.enabled&target.health.pct>50)
                    if holyPower >= 3 or ((charges.frac.zeal <= 1.67 or charges.frac.crusaderStrike <= 1.67) and (cd.divineHammer > gcd or cd.bladeOfJustice > gcd))
                        or (talent.greaterJudgement and thp > 50)
                    then
                        if cast.judgment() then return end
                    end
            -- Consecration
                    -- consecration
                    if #enemies.yards8 >= 1 then
                        if cast.consecration() then return end
                    end
            -- Divine Storm
                    -- divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.divine_purpose.react
                    -- divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&buff.the_fires_of_justice.react&(!talent.crusade.enabled|cooldown.crusade.remain()s>gcd*3)
                    -- divine_storm,if=debuff.judgment.up&spell_targets.divine_storm>=2&(holy_power>=4|((cooldown.zeal.charges_fractional<=1.34|cooldown.crusader_strike.charges_fractional<=1.34)&(cooldown.divine_hammer.remain()s>gcd|cooldown.blade_of_justice.remain()s>gcd)))&(!talent.crusade.enabled|cooldown.crusade.remain()s>gcd*4)
                    if not isChecked("审判官复仇") or (isChecked("审判官复仇") and php >= getOptionValue("审判官复仇")) then
                        if judgmentVar and ((mode.rotation == 1 and #enemies.yards8 >= getOptionValue("神圣风暴 数量")) or mode.rotation == 2)
                            and (buff.divinePurpose.exists()
                            or (buff.theFiresOfJustice.exists() and (not talent.crusade or cd.crusade > gcd * 3 or not isChecked("征伐") or not useCDs()))
                            or (holyPower >= 4 or ((charges.frac.zeal <= 1.34 or charges.frac.crusaderStrike <= 1.34) and (cd.divineHammer > gcd or cd.bladeOfJustice > gcd)) and (not talent.crusade or cd.crusade > gcd * 4 or not isChecked("征伐") or not useCDs())))
                        then
                            if cast.divineStorm() then return end
                        end
                    end
            -- Justicar's Vengeance
                    -- justicars_vengeance,if=debuff.judgment.up&buff.divine_purpose.react&!equipped.whisper_of_the_nathrezim
                    if isChecked("审判官复仇") and php < getOptionValue("审判官复仇") then
                        if judgmentVar and buff.divinePurpose.exists() and not hasEquiped(137020) then
                            if cast.justicarsVengeance() then return end
                        end
                    end
            -- Templar's Verdict
                    -- templars_verdict,if=debuff.judgment.up&buff.divine_purpose.react
                    -- templars_verdict,if=debuff.judgment.up&buff.the_fires_of_justice.react&(!talent.crusade.enabled|cooldown.crusade.remain()s>gcd*3)
                    -- templars_verdict,if=debuff.judgment.up&(holy_power>=4|((cooldown.zeal.charges_fractional<=1.34|cooldown.crusader_strike.charges_fractional<=1.34)&(cooldown.divine_hammer.remain()s>gcd|cooldown.blade_of_justice.remain()s>gcd)))&(!talent.crusade.enabled|cooldown.crusade.remain()s>gcd*4)
                    if not isChecked("审判官复仇") or (isChecked("审判官复仇") and php >= getOptionValue("审判官复仇")) then
                        if judgmentVar
                            and ((mode.rotation == 1 and #enemies.yards8 < getOptionValue("神圣风暴 数量")) or mode.rotation == 3)
                            and (buff.divinePurpose.exists()
                            or (buff.theFiresOfJustice.exists() and (not talent.crusade or cd.crusade > gcd * 3 or not isChecked("征伐") or not useCDs()))
                            or (holyPower >= 4 or ((charges.frac.zeal <= 1.34 or charges.frac.crusaderStrike <= 1.34) and (cd.divineHammer > gcd or cd.bladeOfJustice > gcd)) and (not talent.crusade or cd.crusade > gcd * 4 or not isChecked("征伐") or not useCDs())))
                        then
                            if cast.templarsVerdict() then return end
                        end
                    end
            -- Zeal
                    -- zeal,if=holy_power<=4
                    if talent.zeal and holyPower <= 4 then
                        if cast.zeal() then return end
                    end
            -- Crusader Strike
                    -- crusader_strike,if=holy_power<=4
                    if not talent.zeal and holyPower <= 4 then
                        if cast.crusaderStrike() then return end
                    end
            -- Divine Storm
                    -- divine_storm,if=debuff.judgment.up&holy_power>=3&spell_targets.divine_storm>=2&(!talent.crusade.enabled|cooldown.crusade.remain()s>gcd*5)
                    if judgmentVar and holyPower >= 3 and ((mode.rotation == 1 and #enemies.yards8 >= getOptionValue("神圣风暴 数量")) or mode.rotation == 2) and (not talent.crusade or cd.crusade > gcd * 5 or not isChecked("征伐") or not useCDs()) then
                        if cast.divineStorm() then return end
                    end
            -- Templar's Verdict
                    -- templars_verdict,if=debuff.judgment.up&holy_power>=3&(!talent.crusade.enabled|cooldown.crusade.remain()s>gcd*5)
                    if judgmentVar and holyPower >= 3 and ((mode.rotation == 1 and #enemies.yards8 < getOptionValue("神圣风暴 数量")) or mode.rotation == 3) and (not talent.crusade or cd.crusade > gcd * 5 or not isChecked("征伐") or not useCDs()) then
                        if cast.templarsVerdict() then return end
                    end
                end -- End SimC APL
----------------------------------
--- In Combat - AskMrRobot APL ---
----------------------------------
                if getOptionValue("APL模式") == 2 then
        -- Execution Sentence
                    -- if CooldownSecRemaining(Judgment) <= GlobalCooldownSec * 3
                    if cd.judgment <= gcd * 3 then
                        if cast.executionSentence(units.dyn5) then return end
                    end
        -- Judgment
                    if cast.judgment("target") then return end
        -- Consecration
                    -- if not HasBuff(Judgment)
                    if not judgmentExists and #enemies.yards8 >= 3 then
                        if cast.consecration() then return end
                    end
        -- Justicar's Vengeance
                    -- if HasBuff(DivinePurpose) and TargetsInRadius(DivineStorm) <= 3
                    if isChecked("审判官复仇") and php < getOptionValue("审判官复仇") then
                        if buff.divinePurpose.exists() and #enemies.yards8 <= 3 then
                            if cast.justicarsVengeance(units.dyn5) then return end
                        end
                    end
        -- Divine Storm
                    -- if (AlternatePower >= 4 or HasBuff(DivinePurpose) or HasBuff(Judgment)) and TargetsInRadius(DivineStorm) > 2
                    if not isChecked("审判官复仇") or php >= getOptionValue("审判官复仇") then
                        if (holyPower >= 3 or buff.divinePurpose.exists() or judgmentExists) and #enemies.yards8 > 2 then
                            if cast.divineStorm() then return end
                        end
                    end
        -- Templar's Verdict
                    -- if (AlternatePower >= 4 or HasBuff(DivinePurpose) or HasBuff(Judgment))
                    if not isChecked("审判官复仇") or php >= getOptionValue("审判官复仇") then
                        if (holyPower >= 3 or buff.divinePurpose.exists() or judgmentExists) then
                            if cast.templarsVerdict(units.dyn5) then return end
                        end
                    end
        -- Wake of Ashes
                    -- if AlternatePowerToMax >= 4
                    if getOptionValue("神器技能") == 1 or (getOptionValue("神器技能") == 2 and useCDs()) then
                        if holyPowerMax - holyPower >= 4 and getDistance(units.dyn5) < 5 then
                            if cast.wakeOfAshes(units.dyn5) then return end
                        end
                    end
        -- Blade of Justice
                    -- if AlternatePowerToMax >= 2
                    if holyPowerMax - holyPower >= 2 then
                        if cast.bladeOfJustice(units.dyn5) then return end
                    end
        -- Blade of Wrath
                    -- if AlternatePowerToMax >= 2
                    if holyPowerMax - holyPower >= 2 then
                        if cast.bladeOfWrath(units.dyn5) then return end
                    end
        -- Divine Hammer
                    -- if AlternatePowerToMax >= 2
                    if holyPowerMax - holyPower >= 2 then
                        if cast.divineHammer(units.dyn5) then return end
                    end
        -- Hammer of Justice
                    -- if HasItem(JusticeGaze) and TargetHealthPercent > 0.75 and not HasBuff(Judgment)
                    -- TODO
        -- Crusader Strike
                    if cast.crusaderStrike(units.dyn5) then return end
        -- Zeal
                    if cast.zeal(units.dyn5) then return end
                end -- End AMR APL
            end -- End In Combat
        end -- End Profile
    end -- Timer
end -- runRotation
local id = 70
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})
