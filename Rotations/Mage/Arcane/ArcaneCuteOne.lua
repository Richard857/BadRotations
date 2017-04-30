local rotationName = "CuteOne"

---------------
--- Toggles ---
---------------
local function createToggles()
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "基于范围内的目标数,在单目标和多目标自动切换输出方式.", highlight = 1, icon = br.player.spell.arcaneMissles},
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "使用多目标方式输出.", highlight = 0, icon = br.player.spell.arcaneExplosion},
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "使用单目标方式输出.", highlight = 0, icon = br.player.spell.arcaneBlast},
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "禁用DPS输出", highlight = 0, icon = br.player.spell.iceBlock}
    };
    CreateButton("Rotation",1,0)
-- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "自动使用大技能 - 只在BOSS.", highlight = 1, icon = br.player.spell.arcanePower},
        [2] = { mode = "On", value = 1 , overlay = "Cooldowns Enabled", tip = "不管任何目标都使用大技能.", highlight = 0, icon = br.player.spell.arcanePower},
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "不使用大技能.", highlight = 0, icon = br.player.spell.arcanePower}
    };
    CreateButton("Cooldown",2,0)
-- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "使用保命技能.", highlight = 1, icon = br.player.spell.frostNova},
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "不使用保命技能.", highlight = 0, icon = br.player.spell.frostNova}
    };
    CreateButton("Defensive",3,0)
-- Interrupt Button
    InterruptModes = {
        [1] = { mode = "On", value = 1 , overlay = "Interrupts Enabled", tip = "使用打断.", highlight = 1, icon = br.player.spell.counterspell},
        [2] = { mode = "Off", value = 2 , overlay = "Interrupts Disabled", tip = "不使用打断.", highlight = 0, icon = br.player.spell.counterspell}
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
            br.ui:createDropdownWithout(section, "APL模式", {"|cffFFFFFFSimC"}, 1, "|cffFFFFFFSet APL Mode to use.")
        -- Dummy DPS Test
            br.ui:createSpinner(section, "DPS测试",  5,  5,  60,  5,  "|cffFFFFFF设置为所需的测试的时间（分钟）. 最小: 5 / 最大: 60 / 间隔: 5")
        -- Pre-Pull Timer
            br.ui:createSpinner(section, "Pre-Pull Timer",  5,  1,  10,  1,  "|cffFFFFFF设置为所需的启动时间 Pre-Pull (必须有DBM). 最小: 1 / 最大: 10 / 间隔: 1")
        -- Artifact
            br.ui:createDropdownWithout(section,"神器技能", {"|cff00FF00任何时候","|cffFFFF00冷却技能","|cffFF0000决不"}, 1, "|cffFFFFFF何时使用神器技能.")
        -- Arcane Explosion
            br.ui:createSpinnerWithout(section, "魔爆术", 5, 1, 10, 1, "|cffFFFFFF设置多少个敌人才使用魔爆术.")
        -- Burn Phase Debug
            br.ui:createCheckbox(section, "爆发阶段调试", "|cffFFFFFF显示爆发阶段状态和持续时间，需要启用“聊天覆盖”选项.")
        -- Burn Phase Start
         -- br.ui:createSpinnerWithout(section, "爆发阶段开启", 70, 0, 100, 5, "|cffFFFFFF设定为所需的法力值开启爆发阶段.")
        -- Burn Phase End
         -- br.ui:createSpinnerWithout(section, "爆发阶段结束", 35, 0, 100, 5, "|cffFFFFFF设定为所需的法力值结束爆发阶段.")
        -- Evocation
        --  br.ui:createSpinnerWithout(section, "唤醒", 40, 0, 100, 5, "|cffFFFFFF设置多少百分比法力使用唤醒.")
        br.ui:checkSectionState(section)
    -- Cooldown Options
        section = br.ui:createSection(br.ui.window.profile, "冷却技能")
        -- Potion
            br.ui:createCheckbox(section,"爆发药水")
        -- Racial
            br.ui:createCheckbox(section,"种族技能")
        -- Trinkets
            br.ui:createCheckbox(section,"饰品")
        -- Arcane Power
            br.ui:createCheckbox(section,"奥术强化")
        -- Mirror Image
            br.ui:createCheckbox(section,"镜像")
        -- Rune of Power
            br.ui:createCheckbox(section,"能量符文")
        br.ui:checkSectionState(section)
    -- Defensive Options
        section = br.ui:createSection(br.ui.window.profile, "保命")
        -- Healthstone
            br.ui:createSpinner(section, "药水/治疗石",  30,  0,  100,  5,  "|cffFFFFFF多少百分比血量使用")
        -- Heirloom Neck
            br.ui:createSpinner(section, "传家宝项链",  60,  0,  100,  5,  "|cffFFBB00多少百分比血量使用.");
        -- Gift of The Naaru
            if br.player.race == "Draenei" then
                br.ui:createSpinner(section, "纳鲁的赐福",  50,  0,  100,  5,  "|cffFFFFFF多少百分比血量使用")
            end
        -- Frost Nova
            br.ui:createSpinner(section, "冰霜新星",  50,  0,  100,  5,  "|cffFFBB00多少百分比血量使用.");
        br.ui:checkSectionState(section)
    -- Interrupt Options
        section = br.ui:createSection(br.ui.window.profile, "打断")
        -- Couterspell
            br.ui:createCheckbox(section, "法术反制")
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
            br.ui:createDropdown(section, "Pause Mode", br.dropOptions.Toggle,  6)
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
    if br.timer:useTimer("debugArcane", math.random(0.15,0.3)) then
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
        local arcaneCharges                                 = br.player.power.amount.arcaneCharges
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
        local hasMouse                                      = GetObjectExists("mouseover")
        local hasPet                                        = IsPetActive()
        local hasteAmount                                   = GetHaste()/100
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
        local perk                                          = br.player.perk
        local petInfo                                       = br.player.petInfo
        local php                                           = br.player.health
        local playerMouse                                   = UnitIsPlayer("mouseover")
        local power, powmax, powgen, powerDeficit           = br.player.power.amount.mana, br.player.power.mana.max, br.player.power.regen, br.player.power.mana.deficit
        local manaPercent                                   = br.player.power.mana.percent
        local pullTimer                                     = br.DBM:getPulltimer()
        local racial                                        = br.player.getRacial()
        local recharge                                      = br.player.recharge
        local solo                                          = br.player.instance=="none"
        local spell                                         = br.player.spell
        local talent                                        = br.player.talent
        local ttd                                           = getTTD
        local ttm                                           = br.player.power.ttm
        local units                                         = units or {}
        local dt                                            = date("%H:%M:%S")
        local debug                                         = false

        units.dyn40 = br.player.units(40)
        enemies.yards10 = br.player.enemies(10)
        enemies.yards12 = br.player.enemies(12)
        enemies.yards30 = br.player.enemies(30)

        if leftCombat == nil then leftCombat = GetTime() end
        if profileStop == nil then profileStop = false end
        if talent.overpowered or not buff.arcanePower.exists() then overArcaned = 1 else overArcaned = 0 end
        if burnPhaseDuration == nil then burnPhaseDuration = 0 end
        if burnPhase == nil or not inCombat then burnPhase = false end
        if not burnPhase then burnPhaseStart = 0; burnTimer = 0 end
        if burnPhase and burnPhaseStart == 0 then burnPhaseStart = GetTime(); end
        if burnPhase and burnPhaseStart ~= 0 then burnTimer = GetTime() - burnPhaseStart end

        if isChecked("爆发阶段调试") then
            ChatOverlay("Burn: "..tostring(burnPhase)..", Timer: "..round2(burnTimer,2)..", Duration: "..round2(burnPhaseDuration,2))
        end

        if lastSpell == spell.evocation and burnPhaseDuration == 0 then
            -- print("Evocated")
            burnPhaseDuration = burnTimer
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
                -- Frost Nova
                if isChecked("冰霜新星") and php <= getOptionValue("冰霜新星") and #enemies.yards12 > 0 then
                    if cast.frostNova() then return end
                end
            end -- End Defensive Toggle
        end -- End Action List - Defensive
    -- Action List - Interrupts
        local function actionList_Interrupts()
            if useInterrupts() then
                for i=1, #enemies.yards30 do
                    thisUnit = enemies.yards30[i]
                    if canInterrupt(thisUnit,getOptionValue("Interrupt At")) then
                        -- Counterspell
                        if isChecked("法术反制") then
                            if cast.counterspell(thisUnit) then return end
                        end
                    end
                end
            end -- End useInterrupts check
        end -- End Action List - Interrupts
    -- Action List - Cooldowns
        local function actionList_Cooldowns()
            if useCDs() and getDistance(units.dyn40) < 40 then
            -- Rune of Power
                -- rune_of_power,if=mana.pct>45&buff.arcane_power.down
                if isChecked("能量符文") then
                    if manaPercent > 45 and not buff.arcanePower.exists() then
                        if cast.runeOfPower("player") then return end
                    end
                end
            -- Arcane Power
                -- arcane_power
                if isChecked("奥术强化") and useCDs() then
                    if cast.arcanePower("player") then return end
                end
            -- Racial: Orc Blood Fury | Troll Berserking | Blood Elf Arcane Torrent
                -- blood_fury | berserking | arcane_torrent
                if isChecked("种族技能") and (br.player.race == "Orc" or br.player.race == "Troll" or br.player.race == "BloodElf") and getSpellCD(racial) == 0 then
                    if castSpell("player",racial,false,false,false) then return end
                end
            -- Potion
                -- potion,if=buff.arcane_power.up&(buff.berserking.up|buff.blood_fury.up)
                if isChecked("爆发药水") and canUse(127843) and inRaid then
                    if buff.arcanePower.exists() and (buff.berserking.exists() or buff.bloodFury.exists()) then
                        if useItem(127843) then return end
                    end
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
            end -- End useCDs check
        end -- End Action List - Cooldowns
    -- Action List - Build
        local function actionList_Build()
        -- Charged Up
            -- charged_up,if=buff.arcane_charge.stack<=1
            if arcaneCharges <= 1 then
                if cast.chargedUp("player") then return end
            end
        -- Arcane Missles
            -- arcane_missiles,if=buff.arcane_missiles.react=3
            if buff.arcaneMissles.stack() >= 2 then
                if cast.arcaneMissles() then return end
            end
        -- Arcane Orb
            -- arcane_orb
            if cast.arcaneOrb() then return end
        -- Arcane Explosion
            -- arcane_explosion,if=active_enemies>1
            if ((mode.rotation == 1 and #enemies.yards10 >= getOptionValue("魔爆术")) or (mode.rotation == 2 and #enemies.yards10 > 0)) then
                if cast.arcaneExplosion("player") then return end
            end
        -- Arcane Blast
            -- arcane_blast
            if cast.arcaneBlast() then return end
        end
    -- Action List - Burn
        local function actionList_Burn()
        -- Call Action List - Cooldowns
            -- call_action_list,name=cooldowns
            if actionList_Cooldowns() then return end
        -- Charged Up
            -- charged_up,if=(equipped.132451&buff.arcane_charge.stack<=1)
            if (hasEquiped(132451) and arcaneCharges <= 1) then
                if cast.chargedUp("player") then return end
            end
        -- Arcane Missles
            -- arcane_missiles,if=buff.arcane_missiles.react=3
            if buff.arcaneMissles.stack() >= 2 then
                if cast.arcaneMissles() then return end
            end
        -- Nether Tempest
            -- nether_tempest,if=dot.nether_tempest.remains<=2|!ticking
            if debuff.netherTempest.remain(units.dyn40) <= 2 or not debuff.netherTempest.exists(units.dyn40) then
                if cast.netherTempest() then return end
            end
        -- Arcane Explosion
            -- arcane_explosion,if=active_enemies>1&mana.pct%10*execute_time>target.time_to_die
            if ((mode.rotation == 1 and #enemies.yards10 >= getOptionValue("魔爆术")) or (mode.rotation == 2 and #enemies.yards10 > 0)) and manaPercent / 10 * gcd > ttd(units.dyn40) then
                if cast.arcaneExplosion("player") then return end
            end
        -- Presence of Mind
            -- presence_of_mind,if=buff.rune_of_power.remains<=2*action.arcane_blast.execute_time
            if buff.runeOfPower.remain() <= 2 * getCastTime(spell.arcaneBlast) then
                if cast.presenceOfMind("player") then return end
            end
        -- Arcane Missles
            -- arcane_missiles,if=buff.arcane_missiles.react>1
            if buff.arcaneMissles.stack() > 1 then
                if cast.arcaneMissles() then return end
            end
        -- Arcane Explosion
            -- arcane_explosion,if=active_enemies>1&buff.arcane_power.remains>cast_time
            if ((mode.rotation == 1 and #enemies.yards10 >= getOptionValue("魔爆术")) or (mode.rotation == 2 and #enemies.yards10 > 0)) and buff.arcanePower.remain() > gcd then
                if cast.arcaneExplosion("player") then return end
            end
        -- Arcane Blast
            -- arcane_blast,if=buff.presence_of_mind.up|buff.arcane_power.remains>cast_time
            if (buff.presenceOfMind.exists() or buff.arcanePower.remain() > getCastTime(spell.arcaneBlast)) and arcaneCharges < 4 then 
                if cast.arcaneBlast() then return end
            end 
        -- Supernova
            -- supernova,if=mana.pct<100
            if manaPercent < 100 and useCDs() then
                if cast.supernova("player") then return end
            end
        -- Arcane Missles
            -- arcane_missiles,if=mana.pct>10&(talent.overpowered.enabled|buff.arcane_power.down)
            if manaPercent > 10 and (talent.overpowered or not buff.arcanePower.exists()) and buff.arcaneMissles.stack() > 1 then
                if cast.arcaneMissles() then return end
            end
        -- Arcane Explosion
            -- arcane_explosion,if=active_enemies>1
            if ((mode.rotation == 1 and #enemies.yards10 >= getOptionValue("魔爆术")) or (mode.rotation == 2 and #enemies.yards10 > 0)) then
                if cast.arcaneExplosion("player") then return end
            end
        -- Arcane Barrage
            -- arcane_barrage,if=talent.charged_up.enabled&(equipped.132451&cooldown.charged_up.remains=0&mana.pct<(100-(buff.arcane_charge.stack*0.03)))
            if talent.chargedUp and (hasEquiped(132451) and cd.chargedUp and manaPercent < (100 - (arcaneCharges * 0.03))) then
                if cast.arcaneBarrage() then return end
            end
        -- Arcane Blast
            -- arcane_blast
            -- if arcaneCharges < 4 then
                if cast.arcaneBlast() then return end
            -- end
        -- Arcane Barrage
            -- if arcaneCharges == 4 then
            --     if cast.arcaneBarrage() then return end
            -- end
        -- Evocation
            -- evocation,interrupt_if=mana.pct>99
            if manaPercent < 50 then
                if cast.evocation() then return end
            end
        end
    -- Action List - Conserve
        local function actionList_Conserve()
        -- Arcane Missles
            -- arcane_missiles,if=buff.arcane_missiles.react=3
            if buff.arcaneMissles.stack() >= 2 then
                if cast.arcaneMissles() then return end
            end
        -- Arcane Blast
            -- arcane_blast,if=mana.pct>99
            if manaPercent > 99 then
                if cast.arcaneBlast() then return end
            end
        -- Nether Tempest
            -- nether_tempest,if=(refreshable|!ticking)
            if debuff.netherTempest.refresh(units.dyn40) or not debuff.netherTempest.exists(units.dyn40) then
                if cast.netherTempest() then return end
            end
        -- Arcane Blast
            -- arcane_blast,if=buff.rhonins_assaulting_armwraps.up&equipped.132413
            if buff.rhoninsAssaultingArmwraps.exists() and hasEquiped(132413) then
                if cast.arcaneBlast() then return end
            end
        -- Arcane Missles
            -- arcane_missles
            if buff.arcaneMissles.stack() > 1 then
                if cast.arcaneMissles() then return end
            end
        -- Supernova
            -- supernova,if=mana.pct<100
            if manaPercent < 100 and useCDs() then
                if cast.supernova("player") then return end
            end
        -- Arcane Explosion
            -- arcane_explosion,if=mana.pct>=82&equipped.132451&active_enemies>1
            if manaPercent >= 82 and hasEquiped(132451) and ((mode.rotation == 1 and #enemies.yards10 >= getOptionValue("魔爆术")) or (mode.rotation == 2 and #enemies.yards10 > 0)) then
                if cast.arcaneExplosion("player") then return end
            end
        -- Arcane Blast
            -- arcane_blast,if=mana.pct>=82&equipped.132451
            if manaPercent >= 82 and hasEquiped(132451) then
                if cast.arcaneBlast() then return end
            end
        -- Arcane Barrage
            -- arcane_barrage,if=mana.pct<100&cooldown.arcane_power.remains>5
            if manaPercent < 100 and cd.arcanePower > 5 and arcaneCharges == 4 then
                if cast.arcaneBarrage() then return end
            end
        -- Arcane Explosion
            -- arcane_explosion,if=active_enemies>1
            if ((mode.rotation == 1 and #enemies.yards10 >= getOptionValue("魔爆术")) or (mode.rotation == 2 and #enemies.yards10 > 0)) then
                if arcaneExplosion("player") then return end
            end
        -- Arcane Blast
            -- arcane_blast
            if arcaneCharges < 4 then
                if cast.arcaneBlast() then return end
            end
        -- Arcane Barrage
            if arcaneCharges == 4 then
                if cast.arcaneBarrage() then return end
            end
        end
    -- Action List - Init Burn
        local function actionList_InitBurn()
        -- Mark of Aluneth
            -- mark_of_aluneth
            if getOptionValue("神器技能") == 1 or (getOptionValue("神器技能") == 2 and useCDs()) and arcaneCharges >= 4 then
                if cast.markOfAluneth() then return end
            end
        -- Nether Tempest
            -- nether_tempest,if=dot.nether_tempest.remains<10&(prev_gcd.1.mark_of_aluneth|(talent.rune_of_power.enabled&cooldown.rune_of_power.remains<gcd.max))
            if debuff.netherTempest.remain(units.dyn40) < 10 and (lastSpellCastSucces == spell.markOfAluneth or (talent.runeOfPower and cd.runeOfPower < gcd)) then
                if cast.netherTempest() then return end
            end
        -- Rune of Power
            -- rune_of_power
            if isChecked("能量符文") and useCDs() then
                if cast.runeOfPower("player") then return end
            end
        -- Start Burn Phase
            -- start_burn_phase,if=((cooldown.evocation.remains-(2*burn_phase_duration))%2<burn_phase_duration)|cooldown.arcane_power.remains=0|target.time_to_die<55
            -- if manaPercent >= getOptionValue("Burn Phase Start") and ((cd.evocation < 30 and cd.arcanePower == 0) or (ttd(units.dyn40) < 55 and isBoss(units.dyn40))) then
            if useCDs() and not burnPhase and ((cd.evocation <= burnPhaseDuration and cd.arcanePower == 0)) then -- or (ttd(units.dyn40) < 55 and isBoss(units.dyn40))) then
                burnPhase = true;
                burnPhaseDuration = 0; 
            end
        end
    -- Action List - ROP Phase
        local function actionList_ROP()
        -- Arcane Missles
            -- arcane_missiles,if=buff.arcane_missiles.react=3
            if buff.arcaneMissles.stack() >= 2 then
                if cast.arcaneMissles() then return end
            end
        -- Nether Tempest
            -- nether_tempest,if=dot.nether_tempest.remains<=2|!ticking
            if debuff.netherTempest.remain(units.dyn40) <= 2 or not debuff.netherTempest.exists(units.dyn40) then
                if cast.netherTempest() then return end
            end
        -- Arcane Missles
            -- arcane_missiles,if=buff.arcane_charge.stack=4
            if arcaneCharges == 4 then
                if cast.arcaneMissles() then return end
            end
        -- Arcane Explosion
            -- arcane_explosion,if=active_enemies>1
            if ((mode.rotation == 1 and #enemies.yards10 >= getOptionValue("魔爆术")) or (mode.rotation == 2 and #enemies.yards10 > 0)) then
                if arcaneExplosion("player") then return end
            end
        -- Arcane Blast
            -- arcane_blast,if=mana.pct>45
            if manaPercent > 45 then
                if cast.arcaneBlast() then return end
            end
        -- Arcane Barrage
            -- arcane_barrage
            if arcaneCharges == 4 then
                if cast.arcaneBarrage() then return end
            end
        end
    -- Action List - PreCombat
        local function actionList_PreCombat()
            if not inCombat and not (IsFlying() or IsMounted()) then
                -- Arcane familiar
                if not buff.arcaneFamiliar.exists() then
                    -- Print("Familiar is DOWN Pre.")
                    if not hasPet then
                        -- print("we have no pet -- Pr Combat ")
                        CastSpellByName("Arcane Familiar", "")
                    end
                end
                if buff.arcaneFamiliar.exists() then
                    --Print("Familiar is UP Pre.")
                end
            -- Flask
                -- flask,type=flask_of_the_whispered_pact
                -- TODO
            -- Food
                -- food,type=azshari_salad
            -- Augmentation
                -- augmentation,type=defile
                if isChecked("Pre-Pull Timer") and pullTimer <= getOptionValue("Pre-Pull Timer") then

                end -- End Pre-Pull
                if isValidUnit("target") and getDistance("target") < 40 then
            -- Mirror Image
                    -- mirror_image
                    if isChecked("镜像") and useCDs() then
                        if cast.mirrorImage() then return end
                    end
            -- Potion
                    -- potion,name=deadly_grace
                    -- TODO
            -- Arcane Blast
                    -- Arcane blast
                    if br.timer:useTimer("delayAB", gcd) then
                        if cast.arcaneBlast("target") then return end
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
        elseif (inCombat and profileStop==true) or (IsMounted() or IsFlying()) or pause() or mode.rotation==4 then
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
            if actionList_PreCombat() then
                -- Arcane Familiar
                if not hasPet then
                    -- print("we have no pet Out of Combat ")
                    CastSpellByName("Arcane Familiar", "")
                end
            end
--------------------------
--- In Combat Rotation ---
--------------------------
            if inCombat and profileStop==false and isValidUnit(units.dyn40) and getDistance(units.dyn40) < 40 and not isCastingSpell(spell.arcaneMissles) then
    ------------------------------
    --- In Combat - Interrupts ---
    ------------------------------
                if actionList_Interrupts() then return end
    ---------------------------
    --- SimulationCraft APL ---
    ---------------------------
                if getOptionValue("APL模式") == 1 then
            -- Mirror Image
                    -- mirror_image,if=buff.arcane_power.down
                    if isChecked("镜像") and useCDs() and not buff.arcanePower.exists() then
                        if cast.mirrorImage("player") then return end
                    end
            -- Stop Burn Phase
                    -- stop_burn_phase,if=prev_gcd.1.evocation&burn_phase_duration>gcd.max
                    -- if manaPercent < getOptionValue("Burn Phase End") and burnPhaseDuration > gcd then
                    if lastSpell == spell.evocation and burnPhaseDuration > gcd then
                        burnPhase = false
                    end
            -- Mark of Aluneth
                    -- mark_of_aluneth,if=cooldown.arcane_power.remains>20
                    if getOptionValue("神器技能") == 1 or (getOptionValue("神器技能") == 2 and useCDs()) and cd.arcanePower > 20 and arcaneCharges >= 4 then
                        if cast.markOfAluneth() then return end
                    end
            -- Call Action List - Build
                    -- call_action_list,name=build,if=buff.arcane_charge.stack<4
                    if arcaneCharges < 4 then
                        if actionList_Build() then return end
                    end
            -- Call Action List - Init Burn
                    -- call_action_list,name=init_burn,if=buff.arcane_power.down&buff.arcane_charge.stack=4&(cooldown.mark_of_aluneth.remains=0|cooldown.mark_of_aluneth.remains>20)&(!talent.rune_of_power.enabled|(cooldown.arcane_power.remains<=action.rune_of_power.cast_time|action.rune_of_power.recharge_time<cooldown.arcane_power.remains))|target.time_to_die<45
                    if not buff.arcanePower.exists() and arcaneCharges == 4 and (cd.markOfAluneth == 0 or cd.markOfAluneth > 20) 
                        and (not talent.runeOfPower or (cd.arcanePower <= getCastTime(spell.runeOfPower) or recharge.runeOfPower < cd.arcanePower)) or ttd(units.dyn40) < 45 
                    then
                        if actionList_InitBurn() then return end
                    end
            -- Call Action List - Burn Phase
                    -- call_action_list,name=burn,if=burn_phase
                    if burnPhase then
                        if actionList_Burn() then return end
                    end
            -- Call Action List - ROP Phase
                    -- call_action_list,name=rop_phase,if=buff.rune_of_power.up&!burn_phase
                    if buff.runeOfPower.exists() and not burnPhase then
                        if actionList_ROP() then return end
                    end
            -- Call Action List - Conserve
                    -- call_action_list,name=conserve
                    if actionList_Conserve() then return end 
                end -- End SimC APL
         	end --End In Combat
        end --End Rotation Logic
    end -- End Timer
end -- End runRotation
local id = 62
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})
