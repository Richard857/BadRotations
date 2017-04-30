local rotationName = "Cpoworks"

---------------
--- Toggles ---
---------------
local function createToggles()
    -- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "基于范围内的目标数,在单目标和多目标自动切换方式.", highlight = 1, icon = br.player.spell.mindFlay },
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "使用多目标方式.", highlight = 0, icon = br.player.spell.mindFlay },
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "使用单目标方式.", highlight = 0, icon = br.player.spell.mindFlay },
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "禁用DPS输出", highlight = 0, icon = br.player.spell.shadowMend}
    };
    CreateButton("Rotation",1,0)
    -- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "自动使用大技能 - 只在BOSS.", highlight = 1, icon = br.player.spell.mindBlast },
        [2] = { mode = "On", value = 1 , overlay = "Cooldowns Enabled", tip = "不管任何目标都使用大技能.", highlight = 0, icon = br.player.spell.mindBlast },
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "不使用大技能.", highlight = 0, icon = br.player.spell.mindBlast }
    };
   	CreateButton("Cooldown",2,0)
    -- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "使用保命技能.", highlight = 1, icon = br.player.spell.dispersion },
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "不使用保命技能.", highlight = 0, icon = br.player.spell.dispersion }
    };
    CreateButton("Defensive",3,0)
    -- Void Form Button
    VoidFormModes = {
        [1] = { mode = "On", value = 1 , overlay = "Void Form Enabled", tip = "输出将改变到虚空形态.", highlight = 1, icon = br.player.spell.voidEruption },
        [2] = { mode = "Off", value = 2 , overlay = "Void Form Disabled", tip = "输出不改变到虚空形态.", highlight = 0, icon = br.player.spell.voidEruption }
    };
    CreateButton("VoidForm",4,0)
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
        -- Dummy DPS Test
            br.ui:createSpinner(section, "DPS测试",  5,  5,  60,  5,  "|cffFFFFFF设置为所需的测试的时间（分钟）. 最小: 5 / 最大: 60 / 间隔: 5")
        -- Pre-Pull Timer
            br.ui:createSpinner(section, "Pre-Pull Timer",  5,  1,  10,  1,  "|cffFFFFFF设置为所需的启动时间 Pre-Pull (必须有DBM). 最小: 1 / 最大: 10 / 间隔: 1")
            -- Body and Soul
            br.ui:createCheckbox(section,"身心合一")
            -- Mouseover Dotting
            br.ui:createCheckbox(section,"鼠标位置上DOT")
            -- SWP Max Targets
            br.ui:createSpinnerWithout(section, "暗言术：痛 最大目标",  3,  1,  10,  1)
            -- VT Max Targets
            br.ui:createSpinnerWithout(section, "吸血鬼之触 最大目标",  3,  1,  10,  1)
            br.ui:createSpinnerWithout(section, "吸血鬼之触 HP 限制", 5, 0, 10, 1, "|cffFFFFFFHP Limit that VT will be cast/refreshed on.")
        br.ui:checkSectionState(section)
        -- Cooldown Options
        section = br.ui:createSection(br.ui.window.profile, "冷却技能")
            -- Int Pot
            br.ui:createCheckbox(section,"爆发药水")
            -- Flask / Crystal
            br.ui:createCheckbox(section,"奥拉留斯的低语水晶")
            -- Trinkets
            br.ui:createCheckbox(section,"饰品")
            -- Touch of the Void
            if hasEquiped(128318) then
                br.ui:createCheckbox(section,"虚空之触")
            end
            -- Shadowfiend
            br.ui:createCheckbox(section,"暗影魔/摧心魔")
            br.ui:createSpinnerWithout(section, "暗影魔 层数", 10, 5, 100, 5, "|cffFFFFFFSet to desired Void Form stacks to use at.")
            -- Surrender To Madness
            br.ui:createCheckbox(section,"疯入膏肓")
            -- Power Infusion
            br.ui:createCheckbox(section,"能量灌注")
            br.ui:createSpinnerWithout(section, "能量灌注 层数", 10, 5, 100, 5, "|cffFFFFFFSet to desired Void Form stacks to use at.")
            -- Void Torrent
            br.ui:createCheckbox(section,"虚空洪流")
        br.ui:checkSectionState(section)
        -- Defensive Options
        section = br.ui:createSection(br.ui.window.profile, "保命")
            -- Healthstone
            br.ui:createSpinner(section, "治疗石",  40,  0,  100,  5,  "|cffFFBB00多少血量百分比使用.")
            -- Gift of The Naaru
            if br.player.race == "Draenei" then
                br.ui:createSpinner(section, "纳鲁的赐福",  50,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用")
            end
            -- Dispel Magic
            br.ui:createCheckbox(section,"驱散魔法")
            -- Dispersion
            br.ui:createSpinner(section, "消散",  20,  0,  100,  5,  "|cffFFBB00多少血量百分比使用.")
            -- Fade
            br.ui:createCheckbox(section, "渐隐术")
            -- Power Word: Shield
            br.ui:createSpinner(section, "真言术：盾",  60,  0,  100,  5,  "|cffFFBB00多少血量百分比使用.")
        br.ui:checkSectionState(section)
        -- Toggle Key Options
        section = br.ui:createSection(br.ui.window.profile, "切换快捷键")
            -- Single/Multi Toggle
            br.ui:createDropdown(section, "Rotation Mode", br.dropOptions.Toggle,  4)
            -- Cooldown Key Toggle
            br.ui:createDropdown(section, "Cooldown Mode", br.dropOptions.Toggle,  3)
            -- Void Form
            br.ui:createDropdown(section, "Void Form Mode", br.dropOptions.Toggle,  6)
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
    if br.timer:useTimer("debugShadow", 0.1) then
        --Print("Running: "..rotationName)

---------------
--- Toggles ---
---------------
        UpdateToggle("Rotation",0.25)
        UpdateToggle("Cooldown",0.25)
        UpdateToggle("Defensive",0.25)
        UpdateToggle("VoidEruption",0.25)
        UpdateToggle("VoidForm",0.25)
        br.player.mode.voidForm = br.data.settings[br.selectedSpec].toggles["VoidForm"]
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
        local lastCast                                      = lastCast
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
        local power, powmax, powgen, powerDeficit           = br.player.power.insanity.amount, br.player.power.insanity.max, br.player.power.regen, br.player.power.insanity.deficit
        local pullTimer                                     = br.DBM:getPulltimer()
        local racial                                        = br.player.getRacial()
        local recharge                                      = br.player.recharge
        local solo                                          = #br.friend < 2
        local spell                                         = br.player.spell
        local t18_2pc                                       = TierScan("T18")>=2
        local t19_2pc                                       = TierScan("T19")>=2
        local t19_4pc                                       = TierScan("T19")>=4
        local talent                                        = br.player.talent
        local thp                                           = getHP(br.player.units(40))
        local ttd                                           = getTTD
        local ttm                                           = br.player.power.ttm
        local units                                         = units or {}

        local SWPmaxTargets                                 = getOptionValue("暗言术：痛 最大目标")
        local VTmaxTargets                                  = getOptionValue("吸血鬼之触 最大目标")
        local mindFlayChannel                               = 3 / (1 + GetHaste()/100)

        units.dyn5 = br.player.units(5)
        units.dyn40 = br.player.units(40)
        enemies.yards40 = br.player.enemies(40)

        if useMindBlast == nil then useMindBlast = false end
        if leftCombat == nil then leftCombat = GetTime() end
        if profileStop == nil then profileStop = false end
        if IsHackEnabled("NoKnockback") ~= nil then SetHackEnabled("NoKnockback", false) end
        if t19_2pc then t19pc2 = 1 else t19pc2 = 0 end
        if hasBloodLust() then lusting = 1 else lusting = 0 end
        if talent.sanlayn then sanlayn = 1 else sanlayn = 0 end
        if talent.reaperOfSouls then reaperOfSouls = 1 else reaperOfSouls = 0 end
        if isBoss() then vtHPLimit = getOptionValue("吸血鬼之触 HP 限制")/10 else vtHPLimit = getOptionValue("吸血鬼之触 HP 限制") end

        -- Insanity Stacks
        if buff.voidForm.stack() == 0 then drainStacks = 0 end
        if inCombat and buff.voidForm.stack() > 0 and not (buff.dispersion.exists() or buff.voidTorrent.exists()) then
            if br.timer:useTimer("drainStacker", 1) then
                drainStacks = drainStacks + 1
            end
        end

        -- Mind Flay Ticks
        local mfTick
        if mfTick == nil or not inCombat or not isCastingSpell(spell.mindFlay) then mfTick = 0 end
        if br.timer:useTimer("Mind Flay Ticks", 0.75) and isCastingSpell(spell.mindFlay) then
            mfTick = mfTick + 1
        end

        -- Insanity Drain
        insanityDrain = 6 + (2 / 3 * (drainStacks)) 
        -- insanityDrain = 9 + ((drainStacks - 1) / 2)

        -- Variable: s2mBeltCheck
        -- variable,op=set,name=s2mbeltcheck,value=cooldown.mind_blast.charges>=2
        if charges.mindBlast >= 2 then s2mBeltCheck = 1 else s2mBeltCheck = 0 end

        -- Void Bolt
        -- void_bolt
        if isValidUnit(units.dyn40) and inCombat and buff.voidForm.exists() and (cd.voidBolt == 0 or buff.void.exists()) and not isCastingSpell(spell.voidTorrent) then
            if cast.voidBolt(units.dyn40,"known") then return end
        end

        -- ChatOverlay(tostring(cd.voidBolt))

--------------------
--- Action Lists ---
--------------------
        -- Action list - Extras
        function actionList_Extra()
            -- Dispel Magic
            if isChecked("驱散魔法") and canDispel("target",spell.dispelMagic) and not isBoss() and GetObjectExists("target") then
                if cast.dispelMagic() then return end
            end
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
        end -- End Action List - Extra
        -- Action List - Defensive
        function actionList_Defensive()
            if useDefensive() and getHP("player")>0 then
                -- Gift of the Naaru
                if isChecked("纳鲁的赐福") and php <= getOptionValue("纳鲁的赐福") and php > 0 and br.player.race=="Draenei" then
                    if castSpell("player",racial,false,false,false) then return end
                end
                -- Dispersion
                if isChecked("消散") and php <= getOptionValue("消散") then
                    if cast.dispersion("player") then return end
                end
                -- Fade
                if isChecked("渐隐术") then
                    for i = 1, #enemies.yards40 do
                        local thisUnit = enemies.yards40[i]
                        if not solo and hasThreat(thisUnit) then
                            if cast.fade("player") then return end
                        end
                    end
                end
                -- Power Word: Shield
                if isChecked("真言术：盾") and php <= getOptionValue("真言术：盾") and not buff.powerWordShield.exists() then
                    if cast.powerWordShield("player") then return end
                end
            end -- End Defensive Check
        end -- End Action List - Defensive
        -- Action List - Interrupts
        function actionList_Interrupts()

        end -- End Action List - Interrupts
        -- Action List - Cooldowns
        function actionList_Cooldowns()
            if useCDs() then
                -- Racials
                -- blood_fury
                -- arcane_torrent
                -- berserking
                if (br.player.race == "Orc" or br.player.race == "Troll" or br.player.race == "BloodElf") then
                    if br.player.castRacial() then return end
                end
                -- Touch of the Void
                if isChecked("虚空之触") and getDistance(br.player.units.dyn5)<5 then
                    if hasEquiped(128318) then
                        if GetItemCooldown(128318)==0 then
                            useItem(128318)
                        end
                    end
                end
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
            end
        end -- End Action List - Cooldowns
        -- Action List - Pre-Combat
        function actionList_PreCombat()
        -- Shadow Form
            -- shadowform,if=!buff.shadowform.up
            if not buff.shadowform.exists() then
                cast.shadowform()
            end
        -- Mind Blast
            if isValidUnit("target") then
                if not moving and br.timer:useTimer("mbRecast", gcd) then
                    if cast.mindBlast("target") then return end
                -- else
                --     if cast.shadowWordPain("target") then return end
                end
            end
            -- Power Word: Shield Body and Soul
            if isChecked("身心合一") and talent.bodyAndSoul and isMoving("player") and not IsMounted() then
                if cast.powerWordShield("player") then return end
            end
        end  -- End Action List - Pre-Combat
        -- Action List - Check
        function actionList_Check()
            -- variable,op=set,name=s2mbeltcheck,value=cooldown.mind_blast.charges>=2
            if charges.mindBlast >= 2 then s2mBeltCheck = 1 else s2mBeltCheck = 0 end
            -- variable,op=set,name=actors_fight_time_mod,value=0
            actorsFightTimeMod = 0
            -- variable,op=set,name=actors_fight_time_mod,value=-((-(450)+(time+target.time_to_die))%10),if=time+target.time_to_die>450&time+target.time_to_die<600
            if combatTime + ttd(units.dyn40) > 420 and combatTime + ttd(units.dyn40) < 600 then
                actorsFightTimeMod = - (( - (450) + (combatTime + ttd(units.dyn40))) / 10)
            end
            -- variable,op=set,name=actors_fight_time_mod,value=((450-(time+target.time_to_die))%5),if=time+target.time_to_die<=450
            if combatTime + ttd(units.dyn40) <= 450 then
                actorsFightTimeMod = ((450 - (combatTime + ttd(units.dyn40))) / 5)
            end
            -- variable,op=set,name=s2mcheck,value=(0.8*(83-(5*talent.sanlayn.enabled)+(33*talent.reaper_of_souls.enabled)+set_bonus.tier19_2pc*4+8*variable.s2mbeltcheck+((raw_haste_pct*10))*(2+(0.8*set_bonus.tier19_2pc)+(1*talent.reaper_of_souls.enabled)+(2*artifact.mass_hysteria.rank)-(1*talent.sanlayn.enabled))))-(variable.actors_fight_time_mod*nonexecute_actors_pct)
            s2mCheck = (0.8 * (83 - (5 * sanlayn) + (33 * reaperOfSouls) + t19pc2 * 4 + 8 * s2mBeltCheck + ((UnitSpellHaste("player") * 10)) * (2 + (0.8 * t19pc2) + (1 * reaperOfSouls) + (2 * artifact.rank.massHysteria) - (1 * sanlayn)))) - (actorsFightTimeMod * 1)
            -- variable,op=min,name=s2mcheck,value=180
            if s2mCheck < 180 then s2mCheck = 180 end
        end
        -- Action List - Main
        function actionList_Main()
        --Mouseover Dotting
            if isChecked("鼠标位置上DOT") and hasMouse and isValidTarget("mouseover") and not buff.void.exists() then
                if getDebuffRemain("mouseover",spell.shadowWordPain,"player") <= 1 then
                    if cast.shadowWordPain("mouseover") then return end
                end
            end
        -- Surrender To Madness
            -- surrender_to_madness,if=talent.surrender_to_madness.enabled&target.time_to_die<=variable.s2mcheck
            if isChecked("疯入膏肓") and useCDs() then
                if talent.surrenderToMadness and ttd(units.dyn40) <= s2mCheck then
                    if cast.surrenderToMadness() then return end
                end
            end
        -- Mindbender
            -- mindbender,if=talent.mindbender.enabled&((talent.surrender_to_madness.enabled&target.time_to_die>variable.s2mcheck+60)|!talent.surrender_to_madness.enabled)
            if isChecked("暗影魔/摧心魔") and useCDs() and not buff.void.exists() then
                if talent.mindbender and ((talent.surrenderToMadness and ttd(units.dyn40) > s2mCheck + 60) or not talent.surrenderToMadness) then
                    if cast.mindbender() then return end
                end
            end
        -- Shadow Word: Pain
            -- shadow_word_pain,if=talent.misery.enabled&dot.shadow_word_pain.remains<gcd.max,moving=1,cycle_targets=1
            if moving and talent.misery and debuff.shadowWordPain.count() < getOptionValue("暗言术：痛 最大目标") and not buff.void.exists() then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if debuff.shadowWordPain.remain(thisUnit) < gcd then
                        if cast.shadowWordPain(thisUnit,"aoe") then return end
                    end
                end
            end
        -- Vampiric Touch
            -- vampiric_touch,if=talent.misery.enabled&(dot.vampiric_touch.remains<3*gcd.max|dot.shadow_word_pain.remains<3*gcd.max),cycle_targets=1
            if talent.misery and debuff.vampiricTouch.count() < getOptionValue("吸血鬼之触 最大目标") and lastCast ~= spell.vampiricTouch and not buff.void.exists() and br.timer:useTimer("vtRecast", gcd) and not moving then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if (getHP(thisUnit) > vtHPLimit or IsInInstance()) and ((debuff.vampiricTouch.remain(thisUnit) < 3 * gcd or debuff.shadowWordPain.remain(thisUnit) < 3 * gcd)) then
                        if cast.vampiricTouch(thisUnit,"aoe") then return end
                    end
                end
            end
        -- Shadow Word: Pain
            -- shadow_word_pain,if=!talent.misery.enabled&dot.shadow_word_pain.remains<(3+(4%3))*gcd
            if not talent.misery and debuff.shadowWordPain.remain(units.dyn40) < (3 + (4 / 3)) * gcd and not buff.void.exists() then
                if cast.shadowWordPain() then return end
            end
        -- Vampiric Touch
            -- vampiric_touch,if=!talent.misery.enabled&dot.vampiric_touch.remains<(4+(4%3))*gcd
            if not talent.misery and debuff.vampiricTouch.remain(units.dyn40) < (3 + (4 / 3)) * gcd and lastCast ~= spell.vampiricTouch and not buff.void.exists() and br.timer:useTimer("vtRecast", gcd) and not moving then
                if cast.vampiricTouch() then return end
            end
        -- Void Eruption
            -- void_eruption,if=insanity>=70|(talent.auspicious_spirits.enabled&insanity>=(65-shadowy_apparitions_in_flight*3))|set_bonus.tier19_4pc
            if mode.voidForm == 1 and (power >= 70 or (talent.auspiciousSpirits and power >= (65 - 3)) or t19_4pc) then -- TODO: Track Auspicious Spirits In Flight
                if cast.voidEruption("player") then return end
            end
        -- Shadow Crash
            -- shadow_crash,if=talent.shadow_crash.enabled
            if talent.shadowCrash and not buff.void.exists() then
                if cast.shadowCrash("best",nil,1,8) then return end
            end
        -- Mindbender
            -- mindbender,if=talent.mindbender.enabled&set_bonus.tier18_2pc
            if isChecked("暗影魔/摧心魔") and useCDs() and not buff.void.exists() then
                if talent.mindbender and tier18_2pc then
                    if cast.mindbender() then return end
                end
            end
        -- Shadow Word: Pain
            -- shadow_word_pain,if=!talent.misery.enabled&!ticking&talent.legacy_of_the_void.enabled&insanity>=70,cycle_targets=1
            if not talent.misery and talent.legacyOfTheVoid and power >= 70 and debuff.shadowWordPain.count() < getOptionValue("暗言术：痛 最大目标") and not buff.void.exists() then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if not debuff.shadowWordPain.exists(thisUnit) then
                        if cast.shadowWordPain(thisUnit,"aoe") then return end
                    end
                end
            end
        -- Vampiric Touch
            -- vampiric_touch,if=!talent.misery.enabled&!ticking&talent.legacy_of_the_void.enabled&insanity>=70,cycle_targets=1
            if not talent.misery and talent.legacyOfTheVoid and power >= 70 and debuff.vampiricTouch.count() < getOptionValue("吸血鬼之触 最大目标") 
                and lastCast ~= spell.vampiricTouch and not buff.void.exists() and br.timer:useTimer("vtRecast", gcd) and not moving 
            then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if (getHP(thisUnit) > vtHPLimit or IsInInstance()) and not debuff.vampiricTouch.exists(thisUnit) then
                        if cast.vampiricTouch(thisUnit,"aoe") then return end
                    end
                end
            end
        -- Shadow Word: Death
            -- shadow_word_death,if=(active_enemies<=4|(talent.reaper_of_souls.enabled&active_enemies<=2))&cooldown.shadow_word_death.charges=2&insanity<=(85-15*talent.reaper_of_souls.enabled)
            if (((mode.rotation == 1 and #enemies.yards40 <= 4) or mode.rotation == 3) or (talent.reaperOfSouls and ((mode.rotation == 1 and #enemies.yards40 <= 4) or mode.rotation == 2)))
                and charges.shadowWordDeath == 2 and power <= (85 - 15 * reaperOfSouls)
                and not buff.void.exists() 
            then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if getHP(thisUnit) < 20 then
                        if cast.shadowWordDeath(thisUnit) then return end
                    end
                end
            end
        -- Mind Blast
            -- mind_blast,if=active_enemies<=4&talent.legacy_of_the_void.enabled&(insanity<=81|(insanity<=75.2&talent.fortress_of_the_mind.enabled))
            if ((mode.rotation == 1 and #enemies.yards40 <= 4) or mode.rotation == 3) and lastCast ~= spell.voidEruption and br.timer:useTimer("mbRecast", gcd)
                and talent.legacyOfTheVoid and (power <= 81 or (power <= 75.2 and talent.fortressOfTheMind)) and not buff.void.exists() and not moving
            then
                if cast.mindBlast() then return end
            end
        -- Mind Blast
            -- mind_blast,if=active_enemies<=4&!talent.legacy_of_the_void.enabled|(insanity<=96|(insanity<=95.2&talent.fortress_of_the_mind.enabled))
            if ((mode.rotation == 1 and #enemies.yards40 <= 4) or mode.rotation == 3) and lastCast ~= spell.mindBlast and not moving
                and not talent.legacyOfTheVoid and (power <= 96 or (power <= 95.2 and talent.fortressOfTheMind)) and not buff.void.exists() 
            then
                if cast.mindBlast() then return end
            end
        -- Shadow Word: Pain
            -- shadow_word_pain,if=!talent.misery.enabled&!ticking&target.time_to_die>10&(active_enemies<5&(talent.auspicious_spirits.enabled|talent.shadowy_insight.enabled)),cycle_targets=1
            if not talent.mistery and ((mode.rotation == 1 and #enemies.yards40 < 5) or mode.rotation == 3)
                and (talent.auspiciousSpirits or talent.shadowyInsight) and debuff.shadowWordPain.count() < getOptionValue("暗言术：痛 最大目标")
                and not buff.void.exists() 
            then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if not debuff.shadowWordPain.exists(thisUnit) and ttd(thisUnit) > 10 then
                        if cast.shadowWordPain(thisUnit,"aoe") then return end
                    end
                end
            end
        -- Vampiric Touch
            -- vampiric_touch,if=!talent.misery.enabled&!ticking&target.time_to_die>10&(active_enemies<4|talent.sanlayn.enabled|(talent.auspicious_spirits.enabled&artifact.unleash_the_shadows.rank)),cycle_targets=1
            if not talent.mistery and (((mode.rotation == 1 and #enemies.yards40 < 4) or mode.rotation == 3) or talent.sanlayn or (talent.auspiciousSpirits and artifact.unleashTheShadows))
                and debuff.vampiricTouch.count() < getOptionValue("吸血鬼之触 最大目标") and lastCast ~= spell.vampiricTouch and br.timer:useTimer("vtRecast", gcd)
                and not buff.void.exists()
                and not moving 
            then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if (getHP(thisUnit) > vtHPLimit or IsInInstance()) and not debuff.vampiricTouch.exists(thisUnit) and ttd(thisUnit) > 10 then
                        if cast.vampiricTouch(thisUnit,"aoe") then return end
                    end
                end
            end
        -- Shadow Word: Pain
            -- shadow_word_pain,if=!talent.misery.enabled&!ticking&target.time_to_die>10&(active_enemies<5&artifact.sphere_of_insanity.rank),cycle_targets=1
            if not talent.misery and ((mode.rotation == 1 and #enemies.yards40 < 5) or mode.rotation == 3)
                and artifact.sphereOfInsanity and debuff.shadowWordPain.count() < getOptionValue("暗言术：痛 最大目标")
                and not buff.void.exists() 
            then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if not debuff.shadowWordPain.exists(thisUnit) and ttd(thisUnit) > 10 then
                        if cast.shadowWordPain(thisUnit,"aoe") then return end
                    end
                end
            end
        -- Shadow Word: Void
            -- shadow_word_void,if=talent.shadow_word_void.enabled&(insanity<=70&talent.legacy_of_the_void.enabled)|(insanity<=85&!talent.legacy_of_the_void.enabled)
            if talent.shadowWordVoid and ((power <= 70 and talent.legacyOfTheVoid) or (power <= 85 and not talent.legacyOfTheVoid)) and not buff.void.exists() then
                if cast.shadowWordVoid() then return end
            end
        -- Mind Flay
            if not moving then
                if talent.mindSpike and not buff.void.exists() then
                    if cast.mindSpike() then return end
                elseif not isCastingSpell(spell.mindFlay) and (lastCast ~= spell.mindFlay or (lastCast == spell.mindFlay and br.timer:useTimer("mindFlayRecast", mindFlayChannel + gcd))) and not buff.void.exists() then
                    if cast.mindFlay() then return end
                end
            end
        -- Shadow Word: Pain
            if not debuff.shadowWordPain.exists(units.dyn40) or moving then
                if cast.shadowWordPain() then return end
            end
        end
        -- Action List - Surrender To Madness
        function actionList_SurrenderToMadness() -- Provided by Cyberking07
        --Void Bolt
            -- void_bolt,if=buff.insanity_drain_stacks.stack<6&set_bonus.tier19_4pc
            if insanityDrain < 6 and t19_4pc then
                if cast.voidBolt(units.dyn40,"known") then return end
            end
        --Shadow Crash
            --shadow_crash,if=talent.shadow_crash.enabled
            if talent.shadowCrash and not buff.void.exists() then
                if cast.shadowCrash("best",nil,1,8) then return end
            end
        --Mind Bender
            --mindbender,if=talent.mindbender.enabled
            if isChecked("暗影魔/摧心魔") and useCDs() and buff.voidForm.stack() >= getOptionValue("暗影魔 层数") and not buff.void.exists() then
                if talent.mindbender then
                    if cast.mindbender() then return end
                end
            end
        --Void Torrent
            --void_torrent,if=dot.shadow_word_pain.remains>5.5&dot.vampiric_touch.remains>5.5&!buff.power_infusion.up
            if isChecked("虚空洪流") and useCDs() and not buff.void.exists() then
                if not buff.void.exists() and debuff.shadowWordPain.remain(units.dyn40) > 5.5 and debuff.vampiricTouch.remain(units.dyn40) > 5.5
                    and not buff.powerInfusion.exists()
                then
                    if cast.voidTorrent() then return end
                end
            end
        --Berserking
            --berserking,if=buff.voidform.stack>=65
            if br.player.race == "Troll" and getSpellCD(racial) == 0 and buff.voidForm.stack() >= 65 and not buff.void.exists() then
                if castSpell("player",racial,false,false,false) then return end
            end
        --Shadow Word Death
            --shadow_word_death,if=current_insanity_drain*gcd.max>insanity&!buff.power_infusion.up&(insanity-(current_insanity_drain*gcd.max)+(30+30*talent.reaper_of_souls.enabled)<100)
            if insanityDrain * gcd > power and not buff.powerInfusion.exists() and (power - (insanityDrain * gcd) + (30 + 30 * talent.reaperOfSouls) < 100) and not buff.void.exists() then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if getHP(thisUnit) < 20 then
                        if cast.shadowWordDeath(thisUnit) then return end
                    end
                end
            end
        --Power Infusion
            --power_infusion,if=cooldown.shadow_word_death.charges=0&cooldown.shadow_word_death.remains>3*gcd.max&buff.voidform.stack>50
            if isChecked("能量灌注") and useCDs() and not buff.void.exists() then
                if charges.shadowWordDeath == 0 and cd.shadowWordDeath > 3 * gcd and buff.voidForm.stack() >= getOptionValue("能量灌注 层数") then
                    if cast.powerInfusion() then return end
                end
            end
        --Void Bolt 
            --void_bolt
            if cast.voidBolt(units.dyn40,"known") then return end
        --Shadow Word Death 
            --shadow_word_death,if=(active_enemies<=4|(talent.reaper_of_souls.enabled&active_enemies<=2))&current_insanity_drain*gcd.max>insanity&(insanity-(current_insanity_drain*gcd.max)+(30+30*talent.reaper_of_souls.enabled))<100
            if (#enemies.yards40 <= 4 or (talent.reaperOfSouls and #enemies <= 2))
                and insanityDrain * gcd > power and (power - (insanityDrain * gcd) + (30 + 30 * talent.reaperOfSouls)) < 100
                and not buff.void.exists() 
            then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if getHP(thisUnit) < 20 then
                        if cast.shadowWordDeath(thisUnit) then return end
                    end
                end
            end
        --Wait for Void Bolt    
            -- wait,sec=action.void_bolt.usable_in,if=action.void_bolt.usable_in<gcd.max*0.28
            if cd.voidBolt < gcd * 0.28 then
                return true
            end
        --Dispersion
            --dispersion,if=current_insanity_drain*gcd.max>insanity-5&!buff.power_infusion.up
            if insanityDrain * gcd > power - 5 and not buff.powerInfusion.exists() and not buff.void.exists() then
                if cast.dispersion("player") then return end
            end
        --Mind Blast    
            --mind_blast,if=active_enemies<=5
            if ((mode.rotation == 1 and #enemies.yards40 <= 5) or mode.rotation == 3) and not buff.void.exists() then
                if cast.mindBlast() then return end
            end
        --Wait for Mind Blast   
            -- wait,sec=action.mind_blast.usable_in,if=action.mind_blast.usable_in<gcd.max*0.28&active_enemies<=5
            if ((mode.rotation == 1 and #enemies.yards40 <= 5) or mode.rotation == 3) and cd.mindBlast < gcd * 0.28 and not buff.void.exists() then
                return true
            end
        --Shadow Word Death 
            --shadow_word_death,if=(active_enemies<=4|(talent.reaper_of_souls.enabled&active_enemies<=2))&cooldown.shadow_word_death.charges=2
            if (enemies.yards40 <= 4 or (talent.reaperOfSouls and enemies.yards40 <= 2)) and charges.shadowWordDeath == 2 and not buff.void.exists() then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if getHP(thisUnit) < 20 then
                        if cast.shadowWordDeath(thisUnit) then return end
                    end
                end
            end
        --Shadow Fiend  
            --shadowfiend,if=!talent.mindbender.enabled,if=buff.voidform.stack>15
            if isChecked("暗影魔/摧心魔") and useCDs() and not buff.void.exists() then
                if not talent.mindbender and buff.voidForm.stack() >= getOptionValue("暗影魔 层数") then
                    if cast.shadowfiend() then return end
                end
            end
        --Shadow Word Void  
            --shadow_word_void,if=talent.shadow_word_void.enabled&(insanity-(current_insanity_drain*gcd.max)+50)<100
            if talent.shadowWordVoid and (power - (insanityDrain * gcd) + 50) < 100 and not buff.void.exists() then
                if cast.shadowWordVoid() then return end
            end
        --Shadow Word Pain  
            --shadow_word_pain,if=talent.misery.enabled&dot.shadow_word_pain.remains<gcd,moving=1,cycle_targets=1
            if talent.misery and moving and debuff.shadowWordPain.count() < getOptionValue("暗言术：痛 最大目标") and not buff.void.exists() then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if debuff.shadowWordPain.remain(thisUnit) < gcd then
                        if cast.shadowWordPain(thisUnit,"aoe") then return end
                    end
                end
            end
        --Vampiric Touch    
            --vampiric_touch,if=talent.misery.enabled&(dot.vampiric_touch.remains<3*gcd.max|dot.shadow_word_pain.remains<3*gcd.max),cycle_targets=1
            if talent.misery and debuff.vampiricTouch.count() < getOptionValue("吸血鬼之触 最大目标") and lastCast ~= spell.vampiricTouch and not buff.void.exists() and br.timer:useTimer("vtRecast", gcd) then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if (getHP(thisUnit) > vtHPLimit or IsInInstance()) and (debuff.vampiricTouch.remain(thisUnit) < 3 * gcd or debuff.shadowWordPain.remain(thisUnit) < 3 * gcd) then
                        if cast.vampiricTouch(thisUnit,"aoe") then return end
                    end
                end
            end
        --Shadow Word Pain  
            --shadow_word_pain,if=!talent.misery.enabled&!ticking&(active_enemies<5|talent.auspicious_spirits.enabled|talent.shadowy_insight.enabled|artifact.sphere_of_insanity.rank)
            if not talent.misery and not debuff.shadowWordPain.exists()
                and (((mode.rotation == 1 and #enemies.yards40 < 5) or mode.rotation == 3) or talent.auspiciousSpirits or talent.shadowyInsight or artifact.sphereOfInsanity)
                and not buff.void.exists() 
            then
                if cast.shadowWordPain() then return end
            end
        --Vampiric Touch    
            --vampiric_touch,if=!talent.misery.enabled&!ticking&(active_enemies<4|talent.sanlayn.enabled|(talent.auspicious_spirits.enabled&artifact.unleash_the_shadows.rank))
            if not talent.misery and not debuff.vampiricTouch.exists() and lastCast ~= spell.vampiricTouch and br.timer:useTimer("vtRecast", gcd)
                and (((mode.rotation == 1 and #enemies.yards40 < 4) or mode.rotation == 3) or talent.sanlayn or (talent.auspiciousSpirits and artifact.unleashTheShadows))
                and not buff.void.exists()
            then
                if cast.vampiricTouch() then return end
            end
        --Shadow Word Pain
            --shadow_word_pain,if=!talent.misery.enabled&!ticking&target.time_to_die>10&(active_enemies<5&(talent.auspicious_spirits.enabled|talent.shadowy_insight.enabled)),cycle_targets=1
            if not talent.misery and (((mode.rotation == 1 and #enemies.yards40 < 5) or mode.rotation == 3)
                and (talent.auspiciousSpirits or talent.shadowyInsight or artifact.sphereOfInsanity)) and debuff.shadowWordPain.count() < getOptionValue("暗言术：痛 最大目标")
                and not buff.void.exists() 
            then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if not debuff.shadowWordPain.exists(thisUnit) and ttd(thisUnit) > 10 then
                        if cast.shadowWordPain(thisUnit,"aoe") then return end
                    end
                end
            end
        --Vampiric Touch    
            --vampiric_touch,if=!talent.misery.enabled&!ticking&target.time_to_die>10&(active_enemies<4|talent.sanlayn.enabled|(talent.auspicious_spirits.enabled&artifact.unleash_the_shadows.rank)),cycle_targets=1
            if not talent.misery and (((mode.rotation == 1 and #enemies.yards40 < 4) or mode.rotation == 3) or talent.sanlayn or (talent.auspiciousSpirits and artifact.unleashTheShadows))
                and debuff.vampiricTouch.count() < getOptionValue("吸血鬼之触 最大目标") and lastCast ~= spell.vampiricTouch and br.timer:useTimer("vtRecast", gcd)
                and not buff.void.exists()
            then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if (getHP(thisUnit) > vtHPLimit or IsInInstance()) and not debuff.vampiricTouch.exists(thisUnit) and ttd(thisUnit) > 10 then
                        if cast.vampiricTouch(thisUnit,"aoe") then return end
                    end
                end
            end
        --Shadow Word Pain  
            --shadow_word_pain,if=!talent.misery.enabled&!ticking&target.time_to_die>10&(active_enemies<5&artifact.sphere_of_insanity.rank),cycle_targets=1
            if not talent.misery and (((mode.rotation == 1 and #enemies.yards40 < 5) or mode.rotation == 3)
                and artifact.sphereOfInsanity) and debuff.shadowWordPain.count() < getOptionValue("暗言术：痛 最大目标")
                and not buff.void.exists() 
            then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if not debuff.shadowWordPain.exists(thisUnit) and ttd(thisUnit) > 10 then
                        if cast.shadowWordPain(thisUnit,"aoe") then return end
                    end
                end
            end
        --Mind Flay 
            --mind_flay,chain=1,interrupt_immediate=1,interrupt_if=ticks>=2&(action.void_bolt.usable|(current_insanity_drain*gcd.max>insanity&(insanity-(current_insanity_drain*gcd.max)+60)<100&cooldown.shadow_word_death.charges>=1))
            if mfTick >= 2 and (cd.voidBolt == 0 or (insanityDrain * gcd > power and (power - (insanityDrain * gcd) + 60) < 100 and charges.shadowWordDeath >= 1)) 
                and (lastCast ~= spell.mindFlay or (lastCast == spell.mindFlay and br.timer:useTimer("mindFlayRecast", mindFlayChannel + gcd))) and (lastCast ~= spell.voidEruption or not t19_4pc)
            then
                return true
            elseif not buff.void.exists() then
                if cast.mindFlay() then return end
            end
        end -- End Action List - Surrender To Madness
    -- Action List - VoidForm
        function actionList_VoidForm()
        --Mouseover Dotting
            if isChecked("鼠标位置上DOT") and hasMouse and isValidTarget("mouseover") then
                if getDebuffRemain("mouseover",spell.shadowWordPain,"player") <= 1 then
                    if cast.shadowWordPain("mouseover") then return end
                end
            end
        -- Surrender to Madness
            -- surrender_to_madness,if=talent.surrender_to_madness.enabled&insanity>=25&(cooldown.void_bolt.up|cooldown.void_torrent.up|cooldown.shadow_word_death.up|buff.shadowy_insight.up)&target.time_to_die<=variable.s2mcheck-(buff.insanity_drain_stacks.stack)
            if isChecked("疯入膏肓") and useCDs() then
                if talent.surrenderToMadness and power >= 25 and (cd.voidBolt == 0 or cd.voidTorrent == 0 or cd.shadowWordDeath == 0 or buff.shadowyInsight.exists())
                    and ttd(units.dyn40) <= s2mCheck - (drainStacks)
                then
                    if cast.surrenderToMadness() then return end
                end
            end
        -- Void Bolt
            -- void_bolt
            if cd.voidBolt == 0 or buff.void.exists() then
                if cast.voidBolt(units.dyn40,"known") then return end
            end
        -- Shadow Crash
            -- shadow_crash,if=talent.shadow_crash.enabled
            if talent.shadowCrash and not buff.void.exists() then
                if cast.shadowCrash("best",nil,1,8) then return end
            end
        -- Void Torrent
            -- void_torrent,if=dot.shadow_word_pain.remains>5.5&dot.vampiric_touch.remains>5.5&(!talent.surrender_to_madness.enabled|(talent.surrender_to_madness.enabled&target.time_to_die>variable.s2mcheck-(buff.insanity_drain_stacks.stack)+60))
            if isChecked("虚空洪流") and useCDs() and artifact.voidTorrent then
                if not buff.void.exists() and debuff.shadowWordPain.remain(units.dyn40) > 5.5 and debuff.vampiricTouch.remain(units.dyn40) > 5.5
                    and (not talent.surrenderToMadness or (talent.surrenderToMadness and ttd(units.dyn40) > s2mCheck - (drainStacks) + 60))
                then
                    if cast.voidTorrent() then return end
                end
            end
        -- Mindbender
            -- mindbender,if=talent.mindbender.enabled&(!talent.surrender_to_madness.enabled|(talent.surrender_to_madness.enabled&target.time_to_die>variable.s2mcheck-(buff.insanity_drain_stacks.stack)+30))
            if isChecked("暗影魔/摧心魔") and useCDs() and buff.voidForm.stack() >= getOptionValue("暗影魔 层数") and not buff.void.exists() then 
                if talent.mindbender and (not talent.surrenderToMadness or (talent.surrenderToMadness and ttd(units.dyn40) > s2mCheck - (drainStacks) + 30)) then
                    if cast.mindbender() then return end
                end
            end
        -- Power Infusion
            -- power_infusion,if=buff.insanity_drain_stacks.stack>=(10+2*set_bonus.tier19_2pc+5*buff.bloodlust.up+5*variable.s2mbeltcheck)&(!talent.surrender_to_madness.enabled|(talent.surrender_to_madness.enabled&target.time_to_die>variable.s2mcheck-(buff.insanity_drain_stacks.stack)+61))
            if isChecked("能量灌注") and useCDs() and buff.voidForm.stack() >= getOptionValue("能量灌注 层数") and not buff.void.exists() then 
                if drainStacks >= (10 + 2 * t19pc2 + 5 * lusting + 5 * s2mBeltCheck)
                    and (not talent.surrenderToMadness or (talent.surrenderToMadness and ttd(units.dyn40) > s2mCheck - (drainStacks) + 61))
                then
                    if cast.powerInfusion("player") then return end
                end
            end
        -- Berserking
            -- berserking,if=buff.voidform.stack>=10&buff.insanity_drain_stacks.stack<=20&(!talent.surrender_to_madness.enabled|(talent.surrender_to_madness.enabled&target.time_to_die>variable.s2mcheck-(buff.insanity_drain_stacks.stack)+60))
            if br.player.race == "Troll" and getSpellCD(racial) == 0 and buff.voidForm.stack() >= 10 and drainStacks <= 20
                and (not talent.surrenderToMadness or (talent.surrenderToMadness and ttd(units.dyn40) > s2mCheck - (drainStacks) + 60))
                and not buff.void.exists() 
            then
                if castSpell("player",racial,false,false,false) then return end
            end
        -- Void Bolt
            -- void_bolt
            if cd.voidBolt == 0 or buff.void.exists() then
                if cast.voidBolt(units.dyn40,"known") then return end
            end
        -- Shadow Word - Death
            -- shadow_word_death,if=(active_enemies<=4|(talent.reaper_of_souls.enabled&active_enemies<=2))&current_insanity_drain*gcd.max>insanity&(insanity-(current_insanity_drain*gcd.max)+(15+15*talent.reaper_of_souls.enabled))<100
            if ((mode.rotation == 1 and (#enemies.yards40 <= 4 or (talent.reaperOfSouls and #enemies <= 2))) or mode.rotation == 3)
                and insanityDrain * gcd > power and (power - (insanityDrain * gcd) + (15 + 15 * reaperOfSouls)) < 100
                and not buff.void.exists() 
            then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if getHP(thisUnit) < 20 then
                        if cast.shadowWordDeath(thisUnit) then return end
                    end
                end
            end
        -- Wait For Void Bolt
            -- wait,sec=action.void_bolt.usable_in,if=action.void_bolt.usable_in<gcd.max*0.28
            if cd.voidBolt < gcd * 0.28 then
                return true
            end
        -- Mind Blast
            -- mind_blast,if=active_enemies<=4
            if ((mode.rotation == 1 and #enemies.yards40 <= 4) or mode.rotation == 3) and not buff.void.exists() and lastCast ~= spell.voidEruption and not moving then
                if cast.mindBlast() then return end
            end
        -- Wait For Mind Blast
            -- wait,sec=action.mind_blast.usable_in,if=action.mind_blast.usable_in<gcd.max*0.28&active_enemies<=4
            if ((mode.rotation == 1 and #enemies.yards40 <= 4) or mode.rotation == 3) and cd.mindBlast < gcd * 0.28 and not moving then
                return true
            end
        -- Shadow Word - Death
            -- shadow_word_death,if=(active_enemies<=4|(talent.reaper_of_souls.enabled&active_enemies<=2))&cooldown.shadow_word_death.charges=2
            if ((mode.rotation == 1 and (#enemies.yards40 <= 4 or (talent.reaperOfSouls and #enemies <= 2))) or mode.rotation == 3) and charges.shadowWordDeath == 2 and not buff.void.exists() then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if getHP(thisUnit) < 20 then
                        if cast.shadowWordDeath(thisUnit) then return end
                    end
                end
            end
        -- Shadowfiend
            -- shadowfiend,if=!talent.mindbender.enabled,if=buff.voidform.stack>15
            if isChecked("暗影魔/摧心魔") and useCDs() and not buff.void.exists() then
                if not talent.mindbender and buff.voidForm.stack() >= getOptionValue("暗影魔 层数") then
                    if cast.shadowfiend() then return end
                end
            end
        -- Shadow Word - Void
            -- shadow_word_void,if=talent.shadow_word_void.enabled&(insanity-(current_insanity_drain*gcd.max)+25)<100
            if talent.shadowWordVoid and (power - (insanityDrain * gcd) + 25) < 100 and not buff.void.exists() then
                if cast.shadowWordVoid() then return end
            end
        -- Shadow Word - Pain
            -- shadow_word_pain,if=talent.misery.enabled&dot.shadow_word_pain.remains<gcd,moving=1,cycle_targets=1
            if talent.misery and moving and debuff.shadowWordPain.count() < getOptionValue("暗言术：痛 最大目标") and not buff.void.exists() then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if debuff.shadowWordPain.remain(thisUnit) < gcd then
                        if cast.shadowWordPain(thisUnit,"aoe") then return end
                    end
                end
            end
        -- Vampiric Touch
            -- vampiric_touch,if=talent.misery.enabled&(dot.vampiric_touch.remains<3*gcd.max|dot.shadow_word_pain.remains<3*gcd.max),cycle_targets=1
            if talent.misery and debuff.vampiricTouch.count() < getOptionValue("吸血鬼之触 最大目标") and lastCast ~= spell.vampiricTouch and not buff.void.exists() and br.timer:useTimer("vtRecast", gcd) and not moving then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if (getHP(thisUnit) > vtHPLimit or IsInInstance()) and (debuff.vampiricTouch.remain(thisUnit) < 3 * gcd or debuff.shadowWordPain.remain(thisUnit) < 3 * gcd) then
                        if cast.vampiricTouch(thisUnit,"aoe") then return end
                    end
                end
            end
        -- Shadow Word - Pain
            -- shadow_word_pain,if=!talent.misery.enabled&!ticking&(active_enemies<5|talent.auspicious_spirits.enabled|talent.shadowy_insight.enabled|artifact.sphere_of_insanity.rank)
            if not talent.misery and not debuff.shadowWordPain.exists()
                and (((mode.rotation == 1 and #enemies.yards40 < 5) or mode.rotation == 3) or talent.auspiciousSpirits or talent.shadowyInsight or artifact.sphereOfInsanity)
                and not buff.void.exists() 
            then
                if cast.shadowWordPain() then return end
            end
        -- Vampiric Touch
            -- vampiric_touch,if=!talent.misery.enabled&!ticking&(active_enemies<4|talent.sanlayn.enabled|(talent.auspicious_spirits.enabled&artifact.unleash_the_shadows.rank))
            if not talent.misery and not debuff.vampiricTouch.exists() and lastCast ~= spell.vampiricTouch and br.timer:useTimer("vtRecast", gcd)
                and (((mode.rotation == 1 and #enemies.yards40 < 4) or mode.rotation == 3) or talent.sanlayn or (talent.auspiciousSpirits and artifact.unleashTheShadows))
                and not buff.void.exists() and not moving
            then
                if cast.vampiricTouch() then return end
            end
        -- Shadow Word - Pain
            -- shadow_word_pain,if=!talent.misery.enabled&!ticking&target.time_to_die>10&(active_enemies<5&(talent.auspicious_spirits.enabled|talent.shadowy_insight.enabled)),cycle_targets=1
            if not talent.misery and (((mode.rotation == 1 and #enemies.yards40 < 5) or mode.rotation == 3)
                and (talent.auspiciousSpirits or talent.shadowyInsight or artifact.sphereOfInsanity)) and debuff.shadowWordPain.count() < getOptionValue("暗言术：痛 最大目标")
                and not buff.void.exists() 
            then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if not debuff.shadowWordPain.exists(thisUnit) and ttd(thisUnit) > 10 then
                        if cast.shadowWordPain(thisUnit,"aoe") then return end
                    end
                end
            end
        -- Vampiric Touch
            -- vampiric_touch,if=!talent.misery.enabled&!ticking&target.time_to_die>10&(active_enemies<4|talent.sanlayn.enabled|(talent.auspicious_spirits.enabled&artifact.unleash_the_shadows.rank)),cycle_targets=1
            if not talent.misery and (((mode.rotation == 1 and #enemies.yards40 < 4) or mode.rotation == 3) or talent.sanlayn or (talent.auspiciousSpirits and artifact.unleashTheShadows))
                and debuff.vampiricTouch.count() < getOptionValue("吸血鬼之触 最大目标") and lastCast ~= spell.vampiricTouch and br.timer:useTimer("vtRecast", gcd)
                and not buff.void.exists() and not moving 
            then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if (getHP(thisUnit) > vtHPLimit or IsInInstance()) and not debuff.vampiricTouch.exists(thisUnit) and ttd(thisUnit) > 10 then
                        if cast.vampiricTouch(thisUnit,"aoe") then return end
                    end
                end
            end
        -- Shadow Word - Pain
            -- shadow_word_pain,if=!talent.misery.enabled&!ticking&target.time_to_die>10&(active_enemies<5&artifact.sphere_of_insanity.rank),cycle_targets=1
            if not talent.misery and (((mode.rotation == 1 and #enemies.yards40 < 5) or mode.rotation == 3)
                and artifact.sphereOfInsanity) and debuff.shadowWordPain.count() < getOptionValue("暗言术：痛 最大目标")
                and not buff.void.exists() 
            then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if not debuff.shadowWordPain.exists(thisUnit) and ttd(thisUnit) > 10 then
                        if cast.shadowWordPain(thisUnit,"aoe") then return end
                    end
                end
            end
        -- Mind Flay
            -- mind_flay,chain=1,interrupt_immediate=1,interrupt_if=ticks>=2&(action.void_bolt.usable|(current_insanity_drain*gcd.max>insanity&(insanity-(current_insanity_drain*gcd.max)+30)<100&cooldown.shadow_word_death.charges>=1))
            if mfTick >= 2 and (cd.voidBolt == 0 or (insanityDrain * gcd > power and (power - (insanityDrain * gcd) + 30) < 100 and charges.shadowWordDeath >= 1)) and not moving then
                return true
            elseif (lastCast ~= spell.mindFlay or (lastCast == spell.mindFlay and br.timer:useTimer("mindFlayRecast", mindFlayChannel + gcd))) and not buff.void.exists() and not moving then
                if cast.mindFlay() then return end
            end
        -- Shadow Word - Pain
            -- shadow_word_pain
            if not buff.void.exists() then
                if cast.shadowWordPain() then return end
            end
        end -- End Action List - VoidForm
---------------------
--- Begin Profile ---
---------------------
    -- Profile Stop | Pause
        if not inCombat and not hastar and profileStop==true then
            profileStop = false
        elseif (inCombat and profileStop==true) or IsMounted() or IsFlying() or pause(true) or mode.rotation==4 or buff.void.exists() then
            return true
        else
-----------------
--- Rotations ---
-----------------
            if actionList_Extra() then return end
            if actionList_Defensive() then return end
---------------------------------
--- Out Of Combat - Rotations ---
---------------------------------
            if not inCombat then --  and GetObjectExists("target") and not UnitIsDeadOrGhost("target") and UnitCanAttack("target", "player")
                if actionList_PreCombat() then return end
            end
-----------------------------
--- In Combat - Rotations ---
-----------------------------
            if inCombat and not IsMounted() and isValidUnit(units.dyn40) and getDistance(units.dyn40) < 40 and not isCastingSpell(spell.voidTorrent) and not isCastingSpell(spell.mindBlast) then
            -- Action List - Check
                -- call_action_list,name=check,if=talent.surrender_to_madness.enabled&!buff.surrender_to_madness.up
                if talent.surrenderToMadness and not buff.surrenderToMadness then
                    if actionList_Check() then return end
                end
                actionList_Cooldowns()
            -- Action List - Void Form
                -- run_action_list,name=vf,if=buff.voidform.up
                if mode.voidForm == 1 and buff.voidForm.exists() then
                    if actionList_VoidForm() then return end
                end
            -- Action List - Main
                -- run_action_list,name=main
                if not buff.voidForm.exists() or mode.voidForm == 2 then
                    if actionList_Main() then return end
                end
            end -- End Combat Rotation
        end
    end -- End Timer
end -- Run Rotation

local id = 258
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})
