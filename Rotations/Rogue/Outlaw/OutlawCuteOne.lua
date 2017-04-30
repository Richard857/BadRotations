local rotationName = "CuteOne"

---------------
--- Toggles ---
---------------
local function createToggles()
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "基于范围内的目标数,在单目标和多目标自动切换输出方式.", highlight = 1, icon = br.player.spell.bladeFlurry },
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "使用多目标方式输出.", highlight = 0, icon = br.player.spell.bladeFlurry },
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "使用单目标方式输出.", highlight = 0, icon = br.player.spell.saberSlash },
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "禁用DPS输出", highlight = 0, icon = br.player.spell.crimsonVial }
    };
    CreateButton("Rotation",1,0)
-- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "自动使用大技能 - 只在BOSS.", highlight = 1, icon = br.player.spell.adrenalineRush },
        [2] = { mode = "On", value = 1 , overlay = "Cooldowns Enabled", tip = "不管任何目标都使用大技能.", highlight = 0, icon = br.player.spell.adrenalineRush },
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "不使用大技能.", highlight = 0, icon = br.player.spell.adrenalineRush }
    };
    CreateButton("Cooldown",2,0)
-- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "使用保命技能.", highlight = 1, icon = br.player.spell.riposte },
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "不使用保命技能.", highlight = 0, icon = br.player.spell.riposte }
    };
    CreateButton("Defensive",3,0)
-- Interrupt Button
    InterruptModes = {
        [1] = { mode = "On", value = 1 , overlay = "Interrupts Enabled", tip = "使用打断.", highlight = 1, icon = br.player.spell.kick },
        [2] = { mode = "Off", value = 2 , overlay = "Interrupts Disabled", tip = "不使用打断.", highlight = 0, icon = br.player.spell.kick }
    };
    CreateButton("Interrupt",4,0)
-- Cleave Button
    CleaveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Cleaving Enabled", tip = "Rotation will cleave targets.", highlight = 1, icon = br.player.spell.bladeFlurry },
        [2] = { mode = "Off", value = 2 , overlay = "Cleaving Disabled", tip = "Rotation will not cleave targets", highlight = 0, icon = br.player.spell.saberSlash }
    };
    CreateButton("Cleave",5,0)
-- Pick Pocket Button
    PickerModes = {
      [1] = { mode = "Auto", value = 2 , overlay = "Auto Pick Pocket Enabled", tip = "在战斗前自动使用搜索.", highlight = 1, icon = br.player.spell.pickPocket},
      [2] = { mode = "Only", value = 1 , overlay = "Only Pick Pocket Enabled", tip = "只使用搜索而不进战斗.", highlight = 0, icon = br.player.spell.pickPocket},
      [3] = { mode = "Off", value = 3, overlay = "Pick Pocket Disabled", tip = "不使用搜索.", highlight = 0, icon = br.player.spell.pickPocket}
    };
    CreateButton("Picker",6,0)
                     -- MfD Button
    MfDModes = {
        [1] = { mode = "On", value = 1 , overlay = "MfD Reset Enabled", tip = "Rotation will reset MfD.", highlight = 1, icon = br.player.spell.markedForDeath },
        [2] = { mode = "Off", value = 2 , overlay = "MfD Reset Disabled", tip = "Rotation will not reset MfD.", highlight = 0, icon = br.player.spell.markedForDeath }
    };
    CreateButton("MfD",7,0)

              -- RerollTB Button
    RerollTBModes = {
        [1] = { mode = "On", value = 1 , overlay = "RerollTB Enabled", tip = "Rotation will Roll for TB.", highlight = 1, icon = br.player.spell.rollTheBones },
        [2] = { mode = "Off", value = 2 , overlay = "RerollTB Disabled", tip = "Rotation will Roll for TB.", highlight = 0, icon = br.player.spell.rollTheBones }
    };
    CreateButton("RerollTB",8,0)
              -- Roll for one Button
    RollForOneModes = {
        [1] = { mode = "On", value = 1 , overlay = "Roll for one Enabled", tip = "Rotation will Roll for only one buff.", highlight = 1, icon = br.player.spell.pistolShot },
        [2] = { mode = "Off", value = 2 , overlay = "Roll for one Disabled", tip = "Rotation will Roll for only one buff.", highlight = 0, icon = br.player.spell.pistolShot }
    };
    CreateButton("RollForOne",9,0)
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
            -- Bribe
            br.ui:createCheckbox(section, "贿赂")
            -- Dummy DPS Test
            br.ui:createSpinner(section, "DPS测试",  5,  5,  60,  5,  "|cffFFFFFF设置为所需的测试的时间（分钟）. 最小: 5 / 最大: 60 / 间隔: 5")
            -- Grappling Hook
            br.ui:createCheckbox(section, "抓钩")
        -- SPrint with Boots
            br.ui:createCheckbox(section, "疾跑和橙鞋")
            -- Pistol Shot OOR
            br.ui:createSpinner(section, "手枪射击 - 超出范围", 85,  5,  100,  5,  "|cffFFFFFF检查使用手枪射程超出范围和能量使用。")
            -- Opening Attack
            br.ui:createDropdown(section, "Opener", {"伏击", "偷袭"},  1, "|cffFFFFFF选择攻击来打破隐身")
            br.ui:createCheckbox(section, "死亡标记 - 战斗前")
            -- Pre-Pull Timer
            br.ui:createSpinner(section, "Pre-Pull Timer",  5,  1,  10,  1,  "|cffFFFFFF设置为所需的启动时间 Pre-Pull (必须有DBM). 最小: 1 / 最大: 10 / 间隔: 1")
            -- Stealth
            br.ui:createDropdown(section, "潜行", {"|cff00FF00总是", "|cffFFDD00PrePot", "|cffFF000020码"},  1, "使用潜行方式.")
            -- Artifact
            br.ui:createDropdownWithout(section,"神器技能", {"|cff00FF00任何时候","|cffFFFF00技能冷却","|cffFF0000决不"}, 1, "|cffFFFFFF何时使用神器技能.")
        br.ui:checkSectionState(section)
        ------------------------
        --- COOLDOWN OPTIONS ---
        ------------------------
        section = br.ui:createSection(br.ui.window.profile,  "冷却技能")
            -- Agi Pot
            br.ui:createCheckbox(section, "敏捷药水")
            -- Legendary Ring
            br.ui:createCheckbox(section, "传奇戒指")
            -- Marked For Death
            br.ui:createDropdown(section, "死亡标记", {"|cff00FF00目标", "|cffFFDD00最低"}, 1, "|cffFFBB00多少百分比血量使用")
            -- Vanish
            br.ui:createCheckbox(section,  "消失")
        br.ui:checkSectionState(section)
        -------------------------
        --- DEFENSIVE OPTIONS ---
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, "保命")
            -- Healthstone
            br.ui:createSpinner(section, "药水/治疗石",  60,  0,  100,  5,  "|cffFFBB00多少百分比血量使用")
            -- Heirloom Neck
            br.ui:createSpinner(section, "传家宝项链",  60,  0,  100,  5,  "|cffFFBB00多少百分比血量使用")
            -- Cloak of Shadows
            br.ui:createCheckbox(section, "暗影斗篷")
            -- Crimson Vial
            br.ui:createSpinner(section, "猩红之瓶",  50,  0,  100,  5,  "|cffFFBB00多少百分比血量使用")
            -- Feint
            br.ui:createSpinner(section, "佯攻", 75, 0, 100, 5, "|cffFFBB00多少百分比血量使用")
            -- Riposte
            br.ui:createSpinner(section, "还击",  50,  0,  100,  5,  "|cffFFBB00多少百分比血量使用")
        br.ui:checkSectionState(section)
        -------------------------
        --- INTERRUPT OPTIONS ---
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, "打断")
            -- Kick
            br.ui:createCheckbox(section, "脚踢")
            -- Gouge
            br.ui:createCheckbox(section, "凿击")
            -- Blind
            br.ui:createCheckbox(section, "致盲")
            -- Parley
            br.ui:createCheckbox(section, "谈判")
            -- Between the Eyes
            br.ui:createCheckbox(section, "正中眉心")
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
            -- Cleave Toggle
            br.ui:createDropdown(section,  "输出模式", br.dropOptions.Toggle,  6)
            -- Pick Pocket Toggle
            br.ui:createDropdown(section,  "搜索模式", br.dropOptions.Toggle,  6)
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
    if br.timer:useTimer("debugOutlaw", math.random(0.15,0.3)) then
        --Print("Running: "..rotationName)

---------------
--- Toggles ---
---------------
        UpdateToggle("Rotation",0.25)
        UpdateToggle("Cooldown",0.25)
        UpdateToggle("Defensive",0.25)
        UpdateToggle("Interrupt",0.25)
        UpdateToggle("Cleave",0.25)
        br.player.mode.cleave = br.data.settings[br.selectedSpec].toggles["Cleave"]
        UpdateToggle("Picker",0.25)
        br.player.mode.pickPocket = br.data.settings[br.selectedSpec].toggles["Picker"]
		UpdateToggle("MfD",0.25)
        br.player.mode.MfD = br.data.settings[br.selectedSpec].toggles["MfD"]
		UpdateToggle("RerollTB",0.25)
        br.player.mode.RerollTB = br.data.settings[br.selectedSpec].toggles["RerollTB"]
		UpdateToggle("RollForOne",0.25)
        br.player.mode.RollForOne = br.data.settings[br.selectedSpec].toggles["RollForOne"]

--------------
--- Locals ---
--------------
        if profileStop == nil then profileStop = false end
        local addsIn                                        = 999
        local artifact                                      = br.player.artifact
        local attacktar                                     = UnitCanAttack("target","player")
        local buff                                          = br.player.buff
        local cast                                          = br.player.cast
        local castable                                      = br.player.cast.debug
        local cd                                            = br.player.cd
        local charge                                        = br.player.charges
        local combo, comboDeficit, comboMax                 = br.player.power.amount.comboPoints, br.player.power.comboPoints.deficit, br.player.power.comboPoints.max
        local cTime                                         = getCombatTime()
        local deadtar                                       = UnitIsDeadOrGhost("target")
        local debuff                                        = br.player.debuff
        local enemies                                       = enemies or {}
        local flaskBuff, canFlask                           = getBuffRemain("player",br.player.flask.wod.buff.agilityBig), canUse(br.player.flask.wod.agilityBig)
        local gcd                                           = br.player.gcd
        local glyph                                         = br.player.glyph
        local hastar                                        = GetObjectExists("target")
        local healPot                                       = getHealthPot()
        local inCombat                                      = br.player.inCombat
        local lastSpell                                     = lastSpellCast
        local level                                         = br.player.level
        local mode                                          = br.player.mode
        local multidot                                      = (br.player.mode.cleave == 1 or br.player.mode.rotation ~= 3)
        local perk                                          = br.player.perk
        local php                                           = br.player.health
        local power, powerDeficit, powerRegen               = br.player.power.amount.energy, br.player.power.energy.deficit, br.player.power.regen
        local pullTimer                                     = br.DBM:getPulltimer()
        local rtbCount                                      = br.rtbCount
        local solo                                          = #br.friend < 2
        local spell                                         = br.player.spell
        local stealth                                       = br.player.buff.stealth.exists()
        local stealthing                                    = br.player.buff.stealth.exists() or br.player.buff.vanish.exists() or br.player.buff.shadowmeld.exists()
        local t18_4pc                                       = br.player.eq.t18_4pc
        local talent                                        = br.player.talent
        local time                                          = getCombatTime()
        local ttd                                           = getTTD
        local ttm                                           = br.player.power.ttm
        local units                                         = units or {}

        units.dyn5 = br.player.units(5)
        units.dyn30 = br.player.units(30)
        enemies.yards20 = br.player.enemies(20)
        enemies.yards30 = br.player.enemies(30)
        enemies.yards35 = br.player.enemies(35)

        if talent.deeperStrategem then dStrat = 1 else dStrat = 0 end
        if talent.quickDraw then qDraw = 1 else qDraw = 0 end
        if talent.ghostlyStrike and not debuff.ghostlyStrike.exists(units.dyn5) then gsBuff = 1 else gsBuff = 0 end
        if buff.broadsides.exists() then broadUp = 1 else broadUp = 0 end
        if buff.broadsides.exists() and buff.jollyRoger.exists() then broadRoger = 1 else broadRoger = 0 end
        if talent.alacrity and buff.alacrity.stack() <= 4 then lowAlacrity = 1 else lowAlacrity = 0 end
        if talent.anticipation then antital = 1 else antital = 0 end
        if cd.deathFromAbove == 0 then dfaCooldown = 1 else dfaCooldown = 0 end
        if vanishTime == nil then vanishTime = GetTime() end
        if buff.sharkInfestedWaters.exists() then rtbBuff5 = true else rtbBuff5 = false end
        if buff.trueBearing.exists() then rtbBuff6 = true else rtbBuff6 = false end
        -- if buff.broadsides.exists() or buff.buriedTreasure.exists() or buff.grandMelee.exists() or buff.jollyRoger.exists() or buff.sharkInfestedWaters.exists() then rtbBuff5 = true else rtbBuff5 = false end
        -- if buff.broadsides.exists() or buff.buriedTreasure.exists() or buff.grandMelee.exists() or buff.jollyRoger.exists() or buff.sharkInfestedWaters.exists() or buff.trueBearing.exists() then rtbBuff6 = true else rtbBuff6 = false end

        if buff.rollTheBones == nil then buff.rollTheBones = {} end
        buff.rollTheBones.count    = 0
        buff.rollTheBones.duration = 0
        buff.rollTheBones.remain   = 0
        for k,v in pairs(spell.buffs.rollTheBones) do
            if UnitBuffID("player",v) ~= nil then
                buff.rollTheBones.count    = buff.rollTheBones.count + 1
                buff.rollTheBones.duration = getBuffDuration("player",v)
                buff.rollTheBones.remain   = getBuffRemain("player",v)
            end
        end

        -- rtb_reroll,value=!talent.slice_and_dice.enabled&(rtb_buffs<=1&!rtb_list.any.6&((!buff.curse_of_the_dreadblades.up&!buff.adrenaline_rush.up)|!rtb_list.any.5))
		if not talent.sliceAndDice and (buff.rollTheBones.count >= 2  or buff.trueBearing.exists() or (useRollForOne() and buff.rollTheBones.count >= 1) or
			   ( buff.sharkInfestedWaters.exists() and (buff.adrenalineRush.exists()  or debuff.curseOfTheDreadblades.exists("player") or cd.curseOfTheDreadblades < 15 or cd.adrenalineRush < 15 )))then
			rtbReroll = false
		else
			rtbReroll = true
		end

        -- ss_useable,value=(talent.anticipation.enabled&combo_points<4)|(!talent.anticipation.enabled&((variable.rtb_reroll&combo_points<4+talent.deeper_stratagem.enabled)|(!variable.rtb_reroll&variable.ss_useable_noreroll)))
        if (talent.anticipation and combo <= 4) or (not talent.anticipation and combo < 5) then
            ssUsable = true
        else
            ssUsable = false
        end

        -- Custom Functions
        local function usePickPocket()
            if (mode.pickPocket == 1 or mode.pickPocket == 2) and buff.stealth.exists() then
                return true
            else
                return false
            end
        end

        local function isPicked(thisUnit)   --  Pick Pocket Testing
            if thisUnit == nil then thisUnit = "target" end
            if GetObjectExists(thisUnit) then
                if myTarget ~= UnitGUID(thisUnit) then
                    canPickpocket = true
                    myTarget = UnitGUID(thisUnit)
                end
            end
            if (canPickpocket == false or mode.pickPocket == 3 or GetNumLootItems()>0) and not isDummy() then
                return true
            else
                return false
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
                        ChatOverlay(tonumber(getOptionValue("DPS测试")) .." Minute Dummy Test Concluded - Profile Stopped")
                        profileStop = true
                    end
                end
            end
    -- Pick Pocket
            if usePickPocket() then
                if UnitCanAttack(units.dyn5,"player") and (GetUnitExists("target") or mode.pickPocket == 2) and mode.pickPocket ~= 3 then
                    if not isPicked(units.dyn5) and not isDummy(units.dyn5) then
                        if debuff.sap.remain(units.dyn5) < 1 and mode.pickPocket ~= 1 then
                            if cast.sap(units.dyn5) then return end
                        end
                        if cast.pickPocket() then return end
                    end
                end
            end
    -- Bribe
            if isChecked("贿赂") and UnitCreatureType(units.dyn30) == "Humanoid" and not isDummy(units.dyn30) and UnitIsEnemy(units.dyn30,"player") then
                if cast.bribe(units.dyn30) then return end
            end
    -- Grappling Hook
            if isChecked("抓钩") and isValidUnit("target") then
                if cast.grapplingHook("target") then return end
            end
    -- Pistol Shot
            if isChecked("手枪射击 - 超出范围") and isValidUnit("target") and power >= getOptionValue("手枪射击 - 超出范围") and (not inCombat or getDistance("target") > 8) and not stealthing then
                if cast.pistolShot("target") then return end
            end
        end -- End Action List - Extras
    -- Action List - Defensives
        local function actionList_Defensive()
            if useDefensive() and not stealth then
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
            -- Cloak of Shadows
                if isChecked("暗影斗篷") and canDispel("player",spell.cloakOfShadows) then
                    if cast.cloakOfShadows() then return end
                end
            -- Crimson Vial
                if isChecked("猩红之瓶") and php < getOptionValue("猩红之瓶") then
                    if cast.crimsonVial() then return end
                end
            -- Feint
                if isChecked("佯攻") and php <= getOptionValue("佯攻") and inCombat and not buff.feint then
                    if cast.feint() then return end
                end
            -- Riposte
                if isChecked("还击") and php <= getOptionValue("还击") and inCombat then
                    if cast.riposte() then return end
                end
            end
        end -- End Action List - Defensive
    -- Action List - Interrupts
        local function actionList_Interrupts()
            if useInterrupts() and not stealth then
                for i = 1, #enemies.yards20 do
                    local thisUnit = enemies.yards20[i]
                    local distance = getDistance(thisUnit)
                    if canInterrupt(thisUnit,getOptionValue("打断")) and hasThreat(thisUnit) then
                        if distance < 5 then
        -- Kick
                            -- kick
                            if isChecked("脚踢") then
                                if cast.kick(thisUnit) then return end
                            end
                            if cd.kick ~= 0 then
        -- Gouge
                                if isChecked("凿击") and getFacing(thisUnit,"player") then
                                    if cast.gouge(thisUnit) then return end
                                end
                            end
                        end
                        if (cd.kick ~= 0 and cd.gouge ~= 0) or (distance >= 5 and distance < 15) then
        -- Blind
                            if isChecked("致盲") then
                                if cast.blind(thisUnit) then return end
                            end
                            if isChecked("谈判") then
                                if cast.parley(thisUnit) then return end
                            end
                        end
        -- Between the Eyes
                        if ((cd.kick ~= 0 and cd.gouge ~= 0) or distance >= 5) and (cd.blind ~= 0 or level < 38 or distance >= 15) then
                            if isChecked("正中眉心") then
                                if cast.betweenTheEyes(thisUnit) then return end
                            end
                        end
                    end
                end
            end -- End Interrupt and No Stealth Check
        end -- End Action List - Interrupts
    -- Action List - Blade Flurry
        local function actionList_BladeFlurry()
        -- Blade Flurry
            -- cancel_buff,name=blade_flurry,if=equipped.shivarran_symmetry&cooldown.blade_flurry.up&buff.blade_flurry.up&spell_targets.blade_flurry>=2|spell_targets.blade_flurry<2&buff.blade_flurry.up
            if not useAoE() and buff.bladeFlurry.exists() then
                -- if cast.bladeFlurry() then return end
                if not delayBladeFlurry or delayBladeFlurry == 0 then
                    delayBladeFlurry = GetTime() + 3
                elseif delayBladeFlurry < GetTime() then
                    CastSpellByName(GetSpellInfo(spell.bladeFlurry),"player");
                end
            end
            if ((useAoE() and buff.bladeFlurry.exists()) or (not useAoE() and not buff.bladeFlurry.exists())) and delayBladeFlurry then
                delayBladeFlurry = 0
            end
            -- blade_flurry,if=spell_targets.blade_flurry>=2&!buff.blade_flurry.up
            if useAoE() and not buff.bladeFlurry.exists() and getDistance(units.dyn5) < 5 then
                CastSpellByName(GetSpellInfo(spell.bladeFlurry),"player");
            end
        end
    -- Action List - Cooldowns
        local function actionList_Cooldowns()
            if useCDs() and getDistance(units.dyn5) < 5 then
        -- Cannonball Barrage
                -- cannonball_barrage,if=spell_targets.cannonball_barrage>=1
                if #enemies.yards35 >= 1 then
                    if cast.cannonballBarrage() then return end
                end
        -- Adrenaline Rush
                -- adrenaline_rush,if=!buff.adrenaline_rush.up&energy.deficit>0
                if not buff.adrenalineRush.exists() and powerDeficit > 20 and (cd.curseOfTheDreadblades > 15 or cd.curseOfTheDreadblades == 0) then
                    if cast.adrenalineRush() then return end
                end
        -- -- Marked For Death
        --         if isChecked("死亡标记") then
        --             if getOptionValue("死亡标记") == 1 then
        --                 -- marked_for_death,if=combo_points.deficit>=4+talent.deeper_strategem.enabled+talent.anticipation.enabled
        --                 if comboDeficit >= 4 + dStrat + antital then
        --                     if cast.markedForDeath() then return end
        --                 end
        --             end
        --             if getOptionValue("死亡标记") == 2 then
        --                 -- marked_for_death,if=target.time_to_die<combo_points.deficit
        --                 for i = 1, #enemies.yards30 do
        --                     local thisUnit = enemies.yards30[i]
        --                     if (multidot or (UnitIsUnit(thisUnit,units.dyn5) and not multidot)) then
        --                         if ttd(thisUnit) < comboDeficit then
        --                             if cast.markedForDeath(thisUnit) then return end
        --                         end
        --                     end
        --                 end
        --             end
        --         end
        -- SPrint
                -- sPrint,if=equipped.thraxis_tricksy_treads&!variable.ss_useable
                if isChecked("疾跑和橙鞋") and hasEquiped(137031) and not ssUsable then
                    if cast.sPrint() then return end
                end
        -- Curse of the Dreadblades
                -- curse_of_the_dreadblades,if=combo_points.deficit>=4&(!talent.ghostly_strike.enabled|debuff.ghostly_strike.up)
  					if ((getOptionValue("神器技能") == 1 or (getOptionValue("神器技能") == 2 and useCDs())) and cd.curseOfTheDreadblades == 0 and
						 comboDeficit >= 4 and inCombat and (not talent.ghostlyStrike or debuff.ghostlyStrike.remain(units.dyn5) < 14)) and (buff.adrenalineRush.exists() or cd.adrenalineRush > 15) then
                            if ttm > 2 then
                                return true
                            else if ttm < 2 or buff.adrenalineRush.exists() then
							if cast.curseOfTheDreadblades() then return end
						    end
                                end

					end
            end -- End Cooldown Usage Check
        end -- End Action List - Cooldowns
    -- Action List - PreCombat
        local function actionList_PreCombat()
        -- Stealth
            -- stealth
            if isChecked("潜行") and (not IsResting() or isDummy("target")) then
                if getOptionValue("潜行") == 1 then
                    if cast.stealth() then return end
                end
                if getOptionValue("潜行") == 2 then
                    for i=1, #enemies.yards20 do
                        local thisUnit = enemies.yards20
                        if getDistance(thisUnit) < 20 then
                            if GetObjectExists(thisUnit) and UnitCanAttack(thisUnit,"player") and GetTime()-leftCombat > lootDelay then
                                if cast.stealth() then return end
                            end
                        end
                    end
                end
            end
        -- Marked for Death
            -- marked_for_death
            -- if isChecked("死亡标记 - 战斗前") and getDistance("target") < 30 and isValidUnit("target") then
            --     if cast.markedForDeath("target") then return end
            -- end
        -- Roll The Bones
            -- roll_the_bones,if=!talent.slice_and_dice.enabled
            if not talent.sliceAndDice and not buff.rollTheBones.count == 0 and isValidUnit("target") and getDistance("target") < 5 then
                if cast.rollTheBones() then return end
            end
        end -- End Action List - PreCombat
    -- Action List - Finishers
        local function actionList_Finishers()
        -- Between the Eyes
            -- between_the_eyes,if=equipped.greenskins_waterlogged_wristcuffs&!buff.greenskins_waterlogged_wristcuffs.up
            if hasEquiped(137099) and not buff.greenskinsWaterloggedWristcuffs.exists() then
                if cast.betweenTheEyes() then return end
            end
        -- Run Through
            -- run_through,if=!talent.death_from_above.enabled|energy.time_to_max<cooldown.death_from_above.remain()s+3.5
            if not talent.deathFromAbove or ttm < cd.deathFromAbove + 3.5 then
                if cast.runThrough() then return end
            end
        end -- End Action List - Finishers
    -- Action List - Generators
        local function actionList_Generators()
        -- Ghostly Strike
            -- ghostly_strike,if=combo_points.deficit>=1+buff.broadsides.up&!buff.curse_of_the_dreadblades.up&(debuff.ghostly_strike.remain()s<debuff.ghostly_strike.duration()*0.3|(cooldown.curse_of_the_dreadblades.remain()s<3&debuff.ghostly_strike.remain()s<14))&(combo_points>=3|(variable.rtb_reroll&time>=10))
            if comboDeficit >= 1 + broadUp and not debuff.curseOfTheDreadblades.exists("player") and ((not debuff.ghostlyStrike.exists(units.dyn5) or debuff.ghostlyStrike.refresh(units.dyn5))
                or (cd.curseOfTheDreadblades < 3 and debuff.ghostlyStrike.remain(units.dyn5) < 14)) and (combo >= 3 or (rtbReroll and cTime >= 10))
            then
                if cast.ghostlyStrike() then return end
            end
        -- Pistol Shot
            -- pistol_shot,if=combo_points.deficit>=1+buff.broadsides.up&buff.opportunity.up&(energy.time_to_max>2-talent.quick_draw.enabled|(buff.blunderbuss.up&buff.greenskins_waterlogged_wristcuffs.up))
            if comboDeficit >= 1 + broadUp and buff.opportunity.exists() and (ttm > 2 - qDraw or (castable.blunderbuss and buff.greenskinsWaterloggedWristcuffs.exists())) and not stealthing then
                if cast.pistolShot() then return end
            end
        -- Saber Slash
            -- saber_slash
            if ssUsable then
                if cast.saberSlash() then return end
            end
        end -- End Action List - Generators
    -- Action List - Stealth
        local function actionList_Stealth()
            -- stealth_condition,value=(combo_points.deficit>=2+2*(talent.ghostly_strike.enabled&!debuff.ghostly_strike.up)+buff.broadsides.up&energy>60&!buff.jolly_roger.up&!buff.hidden_blade.up&!buff.curse_of_the_dreadblades.up)
            if ((comboDeficit >= 2 + 2 * gsBuff + broadUp) and power > 60 and not buff.jollyRoger.exists() and not buff.hiddenBlade.exists() and not debuff.curseOfTheDreadblades.exists("player")) and not buff.stealth.exists() and not solo then
                stealthable = true
            else
                stealthable = false
            end
        -- Ambush/Cheap Shot
            -- ambush
            if isChecked("Opener") and isValidUnit("target") and getDistance("target") < 5 and stealthing then
                if getOptionValue("Opener") == 1 then
                    if power <= 60 then
                        return true
                    else
                        if cast.ambush() then return end
                    end
                else
                    if power <= 40 then
                        return true
                    else
                        if cast.cheapShot() then return end
                    end
                end
            end
        -- Vanish
            -- vanish,if=variable.stealth_condition
            if useCDs() and isChecked("消失") and stealthable and isValidUnit(units.dyn5) and getDistance(units.dyn5) < 5 then
                if cast.vanish() then vanishTime = GetTime(); return end
            end
        -- Shadowmeld
            -- shadowmeld,if=variable.stealth_condition
            if useCDs() and isChecked("种族技能") and br.player.race == "NightElf" and stealthable and inCombat and isValidUnit(units.dyn5)
                and getDistance(units.dyn5) < 5 and not buff.vanish.exists() and cd.vanish ~= 0 and not moving
            then
                if cast.shadowmeld() then return end
            end
        end
---------------------
--- Begin Profile ---
---------------------
    --Profile Stop | Pause
        if not inCombat and not hastar and profileStop == true then
            profileStop = false
        elseif (inCombat and profileStop == true) or pause() or (IsMounted() or IsFlying()) or mode.rotation == 4 then
            if inCombat and mode.rotation == 4 then StopAttack() end
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
            if (not inCombat or buff.stealth.exists()) then
                if actionList_PreCombat() then return end
            end
--------------------------
--- In Combat Rotation ---
--------------------------
            if profileStop==false then
                if UnitIsDeadOrGhost("target") then ClearTarget(); end
                if not stealthing or level < 5 then
------------------------------
--- In Combat - Interrupts ---
------------------------------
                    if actionList_Interrupts() then return end
--------------------------------
--- In Combat - Blade Flurry ---
--------------------------------
                    if actionList_BladeFlurry() then return end
-----------------------------
--- In Combat - Cooldowns ---
-----------------------------
                    if actionList_Cooldowns() then return end
                end
---------------------------
--- In Combat - Stealth ---
---------------------------
                if getDistance(units.dyn5) < 5 and isValidUnit(units.dyn5) then
                    -- call_action_list,name=stealth,if=stealthed|cooldown.vanish.up|cooldown.shadowmeld.up
                    if stealthing or cd.vanish == 0 or cd.shadowmeld == 0 then
                        if actionList_Stealth() then return end
                    end
----------------------------------
--- In Combat - Begin Rotation ---
----------------------------------
                    -- if not buff.stealth and not buff.vanish and not buff.shadowmeld and GetTime() > vanishTime + 2 and getDistance(units.dyn5) < 5 then
                    if not stealthing and inCombat then
                        StartAttack()

                     -- MfD toggle
                    if br.data.settings[br.selectedSpec].toggles['MfD'] == 1 then

                            if getOptionValue("死亡标记") == 1 then
                                -- marked_for_death,if=combo_points.deficit>=4+talent.deeper_strategem.enabled+talent.anticipation.enabled
                                if comboDeficit >= 4 + dStrat + antital and not debuff.curseOfTheDreadblades.exists("player") then
                                    if cast.markedForDeath() then return end
                                end
                            end
                            if getOptionValue("死亡标记") == 2 then
                                -- marked_for_death,if=target.time_to_die<combo_points.deficit
                                for i = 1, #enemies.yards30 do
                                    local thisUnit = enemies.yards30[i]
                                    if (multidot or (UnitIsUnit(thisUnit,units.dyn5) and not multidot)) then
                                        if ttd(thisUnit) < comboDeficit then
                                            if cast.markedForDeath(thisUnit) then return end
                                        end
                                    end
                                end
                            end
                    end
        -- Death from Above
                        -- death_from_above,if=energy.time_to_max>2&!variable.ss_useable_noreroll
                        if ttm > 2 and not ssUsable then
                            if cast.deathFromAbove() then return end
                        end
        -- Slice and Dice
                        -- slice_and_dice,if=!variable.ss_useable&buff.slice_and_dice.remain()s<target.time_to_die&buff.slice_and_dice.remain()s<(1+combo_points)*1.8
                        if not ssUsable and buff.sliceAndDice.remain() < ttd(units.dyn5) and buff.sliceAndDice.remain() < (1 + combo) * 1.8 then
                            if cast.sliceAndDice() then return end
                        end
        -- Roll the Bones
                        -- roll_the_bones,if=combo_points>=5&buff.roll_the_bones.remain()s<target.time_to_die&(buff.roll_the_bones.remain()s<=3|rtb_buffs<=1)
                        -- roll_the_bones,if=!variable.ss_useable&buff.roll_the_bones.remain()s<target.time_to_die&(buff.roll_the_bones.remain()s<=3|variable.rtb_reroll)
						if not ssUsable and ((buff.rollTheBones.remain <= 10 and buff.rollTheBones.count < 2) or (buff.rollTheBones.count >= 2 and buff.rollTheBones.remain <= 5) or (useRollForTB() and not buff.trueBearing.exists()) or rtbReroll) then
							if cast.rollTheBones() then return end
						end
        -- Killing Spree
                        -- killing_spree,if=energy.time_to_max>5|energy<15
                        if useCDs() and (ttm > 5 or power < 15) then
                            if cast.killingSpree() then return end
                        end
        -- Generators
                        -- call_action_list,name=build
                        if GetTime() > vanishTime + 1 then
                            if actionList_Generators() then return end
                        end
        -- Finishers
                        -- call_action_list,name=finish,if=!variable.ss_useable
                        if not ssUsable then
                            if actionList_Finishers() then return end
                        end
        -- Gouge
                        -- gouge,if=talent.dirty_tricks.enabled&combo_points.deficit>=1
                        if talent.dirtyTricks and comboDeficit >= 1 and getFacing(thisUnit,"player") then
                            if cast.gouge() then return end
                        end
                    end
                end
            end -- End In Combat
        end -- End Profile
    end -- Timer
end -- runRotation
local id = 260
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})
