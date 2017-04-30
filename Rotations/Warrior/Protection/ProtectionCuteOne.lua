local rotationName = "CuteOne"

---------------
--- Toggles ---
---------------
local function createToggles()
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "基于范围内的目标数,在单目标和多目标自动切换输出方式.", highlight = 1, icon = br.player.spell.thunderClap },
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "使用多目标方式输出.", highlight = 0, icon = br.player.spell.thunderClap },
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "使用单目标方式输出.", highlight = 0, icon = br.player.spell.devastate },
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "禁用DPS输出", highlight = 0, icon = br.player.spell.enragedRegeneration}
    };
    CreateButton("Rotation",1,0)
-- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "自动使用大技能 - 只在BOSS.", highlight = 1, icon = br.player.spell.battleCry },
        [2] = { mode = "On", value = 2 , overlay = "Cooldowns Enabled", tip = "不管任何目标都使用大技能.", highlight = 0, icon = br.player.spell.battleCry },
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "不使用大技能.", highlight = 0, icon = br.player.spell.battleCry }
    };
    CreateButton("Cooldown",2,0)
-- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "使用保命技能.", highlight = 1, icon = br.player.spell.shieldWall },
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "不使用保命技能.", highlight = 0, icon = br.player.spell.shieldWall }
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
            -- Berserker Rage
            br.ui:createCheckbox(section,"狂暴之怒", "选中使用狂暴之怒")
            -- Heroic Leap
            br.ui:createDropdown(section,"英勇飞跃", br.dropOptions.Toggle, 6, "设置自动使用（无热键）或所需的热键以使用英雄飞跃.")
            br.ui:createDropdownWithout(section,"英勇飞跃 - 目标",{"最好","目标"},1,"期望的英雄飞跃目标")
            -- Pre-Pull Timer
            br.ui:createSpinner(section, "Pre-Pull Timer",  5,  1,  10,  1,  "|cffFFFFFF设置为所需的启动时间 Pre-Pull (必须有DBM). 最小: 1 / 最大: 10 / 间隔: 1")
            -- Artifact
            br.ui:createDropdownWithout(section,"神器技能", {"|cff00FF00任何时候","|cffFFFF00保命","|cffFF0000决不"}, 1, "|cffFFFFFF何时使用神器技能.")
            br.ui:createSpinner(section, "神器技能 HP",  60,  0,  100,  5,  "|cffFFBB00多少血量百分几使用")
        br.ui:checkSectionState(section)
        ------------------------
        --- COOLDOWN OPTIONS ---
        ------------------------
        section = br.ui:createSection(br.ui.window.profile,  "冷却技能")
            -- Agi Pot
            br.ui:createCheckbox(section,"爆发药水")
            -- Legendary Ring
            br.ui:createCheckbox(section, "传奇戒指", "启用或禁用使用传奇戒指.")
            -- Flask / Crystal
            br.ui:createCheckbox(section,"奥拉留斯的低语水晶")
            -- Racials
            br.ui:createCheckbox(section,"种族技能")
            -- Trinkets
            br.ui:createSpinner(section, "饰品 血量",  70,  0,  100,  5,  "多少血量百分比使用")		
            br.ui:createDropdownWithout(section, "饰品", {"|cff00FF00只用第一个","|cff00FF00只用第二个","|cffFFFF00两个都用","|cffFF0000不用"}, 1, "|cffFFFFFF选择饰品使用.") 
            -- Touch of the Void
            br.ui:createCheckbox(section,"虚空之触")
            -- Avatar
            br.ui:createCheckbox(section,"天神下凡")
            -- Battle Cry
            br.ui:createCheckbox(section,"战吼")
            -- Demoralizing Shout
            br.ui:createCheckbox(section,"挫志怒吼")
            -- Ravager
            br.ui:createCheckbox(section,"破坏者")
            -- Shockwave
            br.ui:createCheckbox(section,"震荡波")
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
            -- Demoralizing Shout
            br.ui:createSpinner(section, "挫志怒吼",  60,  0,  100,  5,  "|cffFFBB00多少血量百分几使用")
            -- Last Stand
            br.ui:createSpinner(section, "破釜沉舟",  60,  0,  100,  5,  "|cffFFBB00多少血量百分几使用")
            -- Shield Wall
            br.ui:createSpinner(section, "盾墙",  60,  0,  100,  5,  "|cffFFBB00多少血量百分几使用")
            -- Shockwave
            br.ui:createSpinner(section, "震荡波 - HP", 60, 0, 100, 5, "|cffFFBB00多少血量百分几使用")
            br.ui:createSpinner(section, "震荡波 - 数量", 3, 1, 10, 1, "|cffFFBB00最小多少人使用.")
            -- Spell Reflection
            br.ui:createSpinner(section, "法术反射",  60,  0,  100,  5,  "|cffFFBB00多少血量百分几使用")
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
            br.ui:createDropdown(section,  "运行模式", br.dropOptions.Toggle,  4)
            --Cooldown Key Toggle
            br.ui:createDropdown(section,  "冷却技能模式", br.dropOptions.Toggle,  3)
            --Defensive Key Toggle
            br.ui:createDropdown(section,  "保命模式", br.dropOptions.Toggle,  6)
            -- Interrupts Key Toggle
            br.ui:createDropdown(section,  "打断模式", br.dropOptions.Toggle,  6)
            -- Mover Toggle
            br.ui:createDropdown(section,  "移动模式", br.dropOptions.Toggle,  6)
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
    if br.timer:useTimer("debugProtection", 0.1) then
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
        local power, powerMax, powerGen                     = br.player.power.amount.rage, br.player.power.rage.max, br.player.power.regen
        local pullTimer                                     = br.DBM:getPulltimer()
        local race                                          = br.player.race
        local racial                                        = br.player.getRacial()
        local rage                                          = br.player.power.amount.rage
        local recharge                                      = br.player.recharge
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

        -- ChatOverlay(round2(getDistance2("target"),2)..", "..round2(getDistance3("target"),2)..", "..round2(getDistance4("target"),2)..", "..round2(getDistance("target"),2))

--------------------
--- Action Lists ---
--------------------
    -- Action list - Extras
        function actionList_Extra()
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
                if isChecked("纳鲁的赐福") and php <= getOptionValue("纳鲁的赐福") and php > 0 and cd.giftOfTheNaaru==0 then
                    if cast.giftOfTheNaaru() then return end
                end
            -- Demoralizing Shout
                -- demoralizing_shout,if=incoming_damage_2500ms>health.max*0.20
                if inCombat and isChecked("挫志怒吼") and php <= getOptionValue("挫志怒吼") then
                    if cast.demoralizingShout() then return end
                end
            -- Last Stand
                -- last_stand,if=incoming_damage_2500ms>health.max*0.50
                if inCombat and isChecked("破釜沉舟") and php <= getOptionValue("破釜沉舟") then
                    if cast.lastStand() then return end
                end
            -- Shield Wall
                -- shield_wall,if=incoming_damage_2500ms>health.max*0.50&!cooldown.last_stand.remain()s=0
                if inCombat and isChecked("盾墙") and php <= getOptionValue("盾墙") and cd.lastStand > 0 then
                    if cast.shieldWall() then return end
                end
            -- Shockwave
                if inCombat and ((isChecked("震荡波 - HP") and php <= getOptionValue("震荡波 - HP")) or (isChecked("震荡波 - 数量") and #enemies.yards8 >= getOptionValue("震荡波 - 数量"))) then
                    if cast.shockwave() then return end
                end
            -- Spell Reflection
                -- spell_reflection,if=incoming_damage_2500ms>health.max*0.20
                if inCombat and isChecked("法术反射") and php <= getOptionValue("法术反射") then
                    if cast.spellReflection() then return end
                end
            -- Storm Bolt
                if inCombat and isChecked("风暴之锤") and php <= getOptionValue("风暴之锤") then
                    if cast.stormBolt() then return end
                end
            -- Victory Rush
                if inCombat and isChecked("乘胜追击") and talent.impendingVictory and php <= getOptionValue("乘胜追击") and buff.victorious.exists() then
                    if cast.impendingVictory() then return end
                end				
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
            if useCDs() and getDistance("target") < 5 then
        -- Touch of the Void
                if isChecked("虚空之触") then
                    if hasEquiped(128318) then
                        if GetItemCooldown(128318)==0 then
                            useItem(128318)
                        end
                    end
                end
        -- Trinkets
                if isChecked("饰品 血量") and php <= getOptionValue("饰品 血量") then
						if (getOptionValue("饰品") == 1 or getOptionValue("饰品") == 3) and canUse(13) then
							useItem(13)
						end
						if (getOptionValue("饰品") == 2 or getOptionValue("饰品") == 3) and canUse(14) then
							useItem(14)
						end
                end
        -- Draught of Souls
                -- use_item,name=draught_of_souls,if=(spell_targets.whirlwind>1|!raid_event.adds.exists())&((talent.bladestorm.enabled&cooldown.bladestorm.remain()s=0)|buff.battle_cry.up|target.time_to_die<25)
        -- Potions
                -- potion,name=old_war,if=(target.health.pct<20&buff.battle_cry.up)|target.time_to_die<30
        -- Avatar
                -- avatar,if=buff.battle_cry.up|(target.time_to_die<(cooldown.battle_cry.remain()s+10))
                if isChecked("天神下凡") then
                    if buff.battleCry.exists() or (ttd(units.dyn5) < (cd.battleCry + 10)) then
                        if cast.avatar() then return end
                    end
                end
        -- Racials
                -- blood_fury,if=buff.battle_cry.up
                -- berserking,if=buff.battle_cry.up
                -- arcane_torrent,if=rage<rage.max-40
                if isChecked("种族技能") then
                    if ((race == "Orc" or race == "Troll") and buff.battleCry.exists()) or (race == "BloodElf" and power < powerMax - 40) then
                        if castSpell("target",racial,false,false,false) then return end
                    end
                end
            end
        end
    -- Action List - Pre-Combat
        function actionList_PreCombat()
        -- Flask
            -- flask,type=greater_draenic_strength_flask
            if isChecked("爆发药水") then
                if inRaid and canFlask and flaskBuff==0 and not UnitBuffID("player",176151) then
                    useItem(br.player.flask.wod.strengthBig)
                    return true
                end
                if flaskBuff==0 then
                    if br.player.useCrystal() then return end
                end
            end
            -- food,type=pickled_eel
            -- stance,choose=battle
            -- if not buff.battleStance and php > getOptionValue("防御姿态") then
            --     if br.player.castBattleStance() then return end
            -- end
            -- snapshot_stats
            -- potion,name=draenic_strength
            if useCDs() and inRaid and isChecked("爆发药水") and isChecked("Pre-Pull Timer") and pullTimer <= getOptionValue("Pre-Pull Timer") then
                if canUse(109219) then
                    useItem(109219)
                end
            end
        end  -- End Action List - Pre-Combat
    -- Action List - Movement
        function actionList_Movement()
            if mode.mover == 1 then
        -- Charge
                -- charge
                if (cd.heroicLeap > 0 and cd.heroicLeap < 43) or level < 26 then
                    if isValidUnit("target") or (UnitIsFriend("target") and level >= 28) then
                        if level < 28 then
                            if cast.charge("target") then return end
                        else
                            if cast.intercept("target") then return end
                        end
                    end
                end
                if isValidUnit("target") then
        -- Heroic Leap
                    -- heroic_leap
                    if isChecked("英勇飞跃") and (getOptionValue("英勇飞跃")==6 or (SpecificToggle("英勇飞跃") and not GetCurrentKeyBoardFocus())) then
                        -- Best Location
                        if getOptionValue("英勇飞跃 - 目标")==1 then
                            if cast.heroicLeap("best",false,1,8) then return end
                        end
                        -- Target
                        if getOptionValue("英勇飞跃 - 目标")==2 then
                            if cast.heroicLeap("target","ground") then return end
                        end
                    end
        -- Storm Bolt
                    -- storm_bolt
                    if cast.stormBolt("target") then return end
        -- Heroic Throw
                    -- heroic_throw
                    if ((lastSpell == spell.charge or charges.charge == 0) and level < 28) or ((lastSpell == spell.intercept or charges.intercept == 0) and level >= 28) then
                        if cast.heroicThrow("target") then return end
                    end
                end
            end
        end
    -- Action List - Main
        function actionList_Main()
        -- Touch of the Void
            if isChecked("虚空之触") and getDistance(units.dyn5) < 5 and ((mode.rotation == 1 and #enemies.yards8 >= 4) or mode.rotation == 2) then
                if hasEquiped(128318) then
                    if GetItemCooldown(128318)==0 then
                        useItem(128318)
                    end
                end
            end
        -- Shield Block
            -- shield_block,if=!buff.neltharions_fury.up&((cooldown.shield_slam.remain()s<6&!buff.shield_block.up)|(cooldown.shield_slam.remain()s<6+buff.shield_block.remain()s&buff.shield_block.up))
            if not buff.neltharionsFury.exists() and ((cd.shieldSlam < 6 and not buff.shieldBlock.exists()) or (cd.shieldSlam < 6 + buff.shieldBlock.remain() and buff.shieldBlock.exists())) then
                if cast.shieldBlock() then return end
            end
        -- Potion
            -- potion,name=unbending_potion,if=(incoming_damage_2500ms>health.max*0.15&!buff.potion.up)|target.time_to_die<=25
            -- TODO
        -- Battle Cry
            -- battle_cry,if=cooldown.shield_slam.remain()s=0
            if useCDs() and isChecked("战吼") then
                if cd.shieldSlam == 0 then
                    if cast.battleCry() then return end
                end
            end
        -- Demoralizing Shout
            -- demoralizing_shout,if=talent.booming_voice.enabled&buff.battle_cry.up
            if useCDs() and isChecked("挫志怒吼") then
                if talent.boomingVoice and buff.battleCry.exists() then
                    if cast.demoralizingShout() then return end
                end
            end
        -- Ravager
            -- ravager,if=talent.ravager.enabled&buff.battle_cry.up
            if useCDs() and isChecked("破坏者") then
                if talent.ravager and buff.battleCry.exists() then
                    if cast.ravager("best",false,1,8) then return end
                end
            end
        -- Neltharion's Fury
            -- neltharions_fury,if=!buff.shield_block.up&cooldown.shield_block.remain()s>3&cooldown.shield_slam.remain()s>3
            if getOptionValue("神器技能") == 1 or (getOptionValue("神器技能") == 2 and useDefensive()) then
                if php < getOptionValue("神器技能 HP") and inCombat and not buff.shieldBlock.exists() and cd.shieldBlock > 3 and cd.shieldSlam > 3 then
                    if cast.neltharionsFury("player") then return end
                end
            end
        -- Shield Block
            -- shield_block,if=!buff.neltharions_fury.up&(cooldown.shield_slam.remain()s=0|action.shield_block.charges=2)
            if not buff.neltharionsFury and (cd.shieldSlam == 0 or charges.shieldBlock == 2) then
                if cast.shieldBlock() then return end
            end
        -- Shield Slam
            -- shield_slam,if=!(cooldown.shield_block.remain()s<=gcd.max*2&!buff.shield_block.up&talent.heavy_repercussions.enabled)
            if not (cd.shieldBlock <= gcd * 2 and not buff.shieldBlock.exists() and talent.heavyRepercussions) then
                if cast.shieldSlam() then return end
            end
        -- Revenge
            -- revenge,if=cooldown.shield_slam.remain()s<=gcd.max*2
            -- revenge,if=cooldown.shield_slam.remain()s<=gcd.max*1.5|spell_targets.revenge>=2
            if cd.shieldSlam <= gcd * 1.5 or ((mode.rotation == 1 and #enemies.yards5 >= 1) or mode.rotation == 2) then
                if cast.revenge() then return end
            end
        -- Ignore Pain
            -- ignore_pain,if=(rage>=60&!talent.vengeance.enabled)|(buff.vengeance_ignore_pain.up&rage>=39)|(talent.vengeance.enabled&!buff.ultimatum.up&!buff.vengeance_ignore_pain.up&!buff.vengeance_focused_rage.up&rage<30)
            if (rage >= 60 and not talent.vengeance) or (buff.vengeanceIgnorePain.exists() and rage >= 39)
                or (talent.vengeance and not buff.ultimatum.exists() and not buff.vengeanceIgnorePain.exists() and not buff.vengeanceFocusedRage.exists() and rage < 30)
            then
                if cast.ignorePain() then return end
            end
        -- Thunder Clap
            -- thunder_clap,if=spell_targets.thunder_clap>=4
            if ((mode.rotation == 1 and #enemies.yards8 >= 1) or mode.rotation == 2) then
                if cast.thunderClap() then return end
            end
        -- Devastate
            -- devastate
            if cast.devastate() then return end
        end -- End Action List - Single
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
            if not inCombat and not IsMounted() and isValidUnit("target") then
                if actionList_PreCombat() then return end
                if getDistance(units.dyn5)<5 then
                    StartAttack()
                else
            -- Action List - Movement
                    -- run_action_list,name=movement,if=movement.getDistance(units.dyn5)>5
                    if getDistance("target") >= 8 then
                        if actionList_Movement() then return end
                    end
                end
            end
-----------------------------
--- In Combat - Rotations ---
-----------------------------
            if inCombat and not IsMounted() and isValidUnit(units.dyn5) then
            -- Auto Attack
                --auto_attack
                if getDistance(units.dyn5) < 5 then
                    StartAttack()
                end
            -- Action List - Movement
                -- run_action_list,name=movement,if=movement.getDistance(units.dyn5)>5
                if getDistance(units.dyn8) > 8 then
                    if actionList_Movement() then return end
                end
            -- Action List - Interrupts
                if actionList_Interrupts() then return end
            -- Action List - Cooldowns
                if actionList_Cooldowns() then return end
            -- Action List - Main
                if actionList_Main() then return end
            end -- End Combat Rotation
        end -- Pause
    end -- End Timer
end -- End runRotation
local id = 73
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})
