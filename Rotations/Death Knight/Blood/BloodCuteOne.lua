local rotationName = "CuteOne"

---------------
--- Toggles ---
---------------
local function createToggles()
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "基于范围内的目标数,在单目标和多目标自动切换输出方式.", highlight = 1, icon = br.player.spell.bloodBoil },
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "使用多目标方式输出.", highlight = 0, icon = br.player.spell.bloodBoil },
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "使用单目标方式输出.", highlight = 0, icon = br.player.spell.heartStrike },
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "禁用DPS输出", highlight = 0, icon = br.player.spell.deathStrike}
    };
    CreateButton("Rotation",1,0)
-- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "自动使用大技能 - 只在BOSS.", highlight = 1, icon = br.player.spell.bonestorm },
        [2] = { mode = "On", value = 1 , overlay = "Cooldowns Enabled", tip = "不管任何目标都使用大技能.", highlight = 0, icon = br.player.spell.bonestorm },
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "不使用大技能.", highlight = 0, icon = br.player.spell.bonestorm }
    };
    CreateButton("Cooldown",2,0)
-- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "使用保命技能.", highlight = 1, icon = br.player.spell.vampiricBlood },
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "不使用保命技能.", highlight = 0, icon = br.player.spell.vampiricBlood }
    };
    CreateButton("Defensive",3,0)
-- Interrupt Button
    InterruptModes = {
        [1] = { mode = "On", value = 1 , overlay = "Interrupts Enabled", tip = "使用打断.", highlight = 1, icon = br.player.spell.asphyxiate },
        [2] = { mode = "Off", value = 2 , overlay = "Interrupts Disabled", tip = "不使用打断.", highlight = 0, icon = br.player.spell.asphyxiate }
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
            br.ui:createDropdownWithout(section, "APL模式", {"|cffFFFFFFIcy-Veins","|cffFFFFFFAMR","|cffFFFFFFVilt"}, 3, "|cffFFFFFF选择输出循环.")
        -- Dummy DPS Test
            br.ui:createSpinner(section, "DPS测试",  5,  5,  60,  5,  "|cffFFFFFF设置为所需的测试的时间（分钟）. 最小: 5 / 最大: 60 / 间隔: 5")
        -- Pre-Pull Timer
            br.ui:createSpinner(section, "Pre-Pull Timer",  5,  1,  10,  1,  "|cffFFFFFF设置为所需的启动时间 Pre-Pull (必须有DBM). 最小: 1 / 最大: 10 / 间隔: 1")
        -- Artifact
            br.ui:createDropdownWithout(section, "神器技能", {"|cff00FF00任何时候","|cffFFFF00冷却技能","|cffFF0000决不"}, 1, "|cffFFFFFF何时使用神器技能.")
            br.ui:createSpinner(section, "神器技能 血量",  60,  0,  100,  5,  "|cffFFFFFF血量低于百分几使用神器技能")			
        -- Dark Command
            br.ui:createCheckbox(section,"黑暗命令","|cffFFFFFF自动嘲讽")
        br.ui:checkSectionState(section)
    -- Cooldown Options
        section = br.ui:createSection(br.ui.window.profile, "冷却技能")
        -- Agi Pot
            br.ui:createCheckbox(section, "爆发药水")
        -- Flask / Crystal
            br.ui:createCheckbox(section, "奥拉留斯的低语水晶")
        -- Racial
            br.ui:createCheckbox(section, "种族技能")
        -- Trinkets
            br.ui:createSpinner(section, "饰品 血量",  70,  0,  100,  5,  "多少血量百分比使用")		
            br.ui:createDropdownWithout(section, "饰品", {"|cff00FF00只用第一个","|cff00FF00只用第二个","|cffFFFF00两个都用","|cffFF0000不用"}, 1, "|cffFFFFFF选择饰品使用.")
        -- Dancing Rune Weapon
            br.ui:createCheckbox(section, "符文刃舞")
        br.ui:checkSectionState(section)
    -- Vilt Rotation Options
    section = br.ui:createSection(br.ui.window.profile, "输出设置")
        -- Death and Decay Target Amount
            br.ui:createSpinner(section, "枯萎凋零", 3, 0, 10, 1, "|cffFFBB00多少个目标使用.")
        -- Use Bonestorm
            br.ui:createCheckbox(section,"白骨风暴")
        -- Bonestorm Target Amount
            br.ui:createSpinnerWithout(section, "白骨风暴 目标", 3, 0, 10, 1, "|cffFFBB00目标数量")
        -- Bonestorm RP Amount
            br.ui:createSpinnerWithout(section, "白骨风暴 能量", 90, 0, 125, 5, "|cffFFBB00多少能量才使用")
        -- DS High prio
            br.ui:createSpinnerWithout(section, "灵界打击 高优先", 35, 0, 100, 1, "|cffFFBB00多少血量高优先使用灵界打击")
        -- DS Low prio
            br.ui:createSpinnerWithout(section, "灵界打击 低优先", 75, 0, 100, 1, "|cffFFBB00多少血量低优先使用灵界打击")
        -- Consumption with Vampiric Blood up
            br.ui:createSpinner(section, "吸血鬼之血 消费", 85, 0, 100, 1, "|cffFFBB00多少血量使用吸血鬼之血作为高优先级，吸血鬼在CD时候用灵界打击去刷新吸血鬼之血的CD")
        -- high prio blood boil for more dps
            br.ui:createCheckbox(section,"血液沸腾 高优先", "|cffFFBB00使用会有较低的生存能力,较高的DPS")
        br.ui:checkSectionState(section)
    -- Defensive Options
        section = br.ui:createSection(br.ui.window.profile, "保命")
        -- Healthstone
            br.ui:createSpinner(section, "药水/治疗石",  30,  0,  100,  5,  "|cffFFFFFF血量低于百分几使用")
        -- Heirloom Neck
            br.ui:createSpinner(section, "传家宝项链",  60,  0,  100,  5,  "|cffFFBB00血量低于百分几使用");
        -- Anti-Magic Shell
            br.ui:createSpinner(section, "反魔法护罩",  50,  0,  100,  5,  "|cffFFBB00血量低于百分几使用");
        -- Vampiric Blood
            br.ui:createSpinner(section, "吸血鬼之血",  40,  0,  100,  5,  "|cffFFBB00血量低于百分几使用");
        -- Icebound Fortitude
            br.ui:createSpinner(section, "冰封之韧",  50,  0,  100,  5,  "|cffFFBB00血量低于百分几使用")
        -- Raise Ally
            br.ui:createCheckbox(section,"复活盟友")
            br.ui:createDropdownWithout(section, "复活盟友 - 目标", {"|cff00FF00目标","|cffFF0000鼠标位置"}, 1, "|cffFFFFFF选择目标使用")
        br.ui:checkSectionState(section)
    -- Interrupt Options
        section = br.ui:createSection(br.ui.window.profile, "打断")
        -- Asphyxiate
            br.ui:createCheckbox(section,"窒息")
        -- Death Grip
            br.ui:createCheckbox(section,"死亡之握")
        -- Mind Freeze
            br.ui:createCheckbox(section,"心灵冰冻")
        -- Interrupt Percentage
            br.ui:createSpinner(section, "打断",  0,  0,  95,  5,  "|cffFFFFFF读条百分几打断")
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
    if br.timer:useTimer("debugBlood", math.random(0.15,0.3)) then
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
        local canFlask                                      = canUse(br.player.flask.wod.staminaBig)
        local cast                                          = br.player.cast
        local combatTime                                    = getCombatTime()
        local cd                                            = br.player.cd
        local charges                                       = br.player.charges
        local deadMouse                                     = UnitIsDeadOrGhost("mouseover")
        local deadtar, attacktar, hastar, playertar         = deadtar or UnitIsDeadOrGhost("target"), attacktar or UnitCanAttack("target", "player"), hastar or GetObjectExists("target"), UnitIsPlayer("target")
        local debuff                                        = br.player.debuff
        local enemies                                       = enemies or {}
        local falling, swimming, flying, moving             = getFallTime(), IsSwimming(), IsFlying(), GetUnitSpeed("player")>0
        local fatality                                      = false
        local flaskBuff                                     = getBuffRemain("player",br.player.flask.wod.buff.staminaBig)
        local friendly                                      = friendly or UnitIsFriend("target", "player")
        local gcd                                           = br.player.gcd
        local hasMouse                                      = GetObjectExists("mouseover")
        local healPot                                       = getHealthPot()
        local inCombat                                      = br.player.inCombat
        local inInstance                                    = br.player.instance=="party"
        local inRaid                                        = br.player.instance=="raid"
        local level                                         = br.player.level
        local lootDelay                                     = getOptionValue("LootDelay")
        local lowestHP                                      = br.friend[1].unit
        local mode                                          = br.player.mode
        local multidot                                      = (br.player.mode.cleave == 1 or br.player.mode.rotation == 2) and br.player.mode.rotation ~= 3
        local perk                                          = br.player.perk
        local php                                           = br.player.health
        local playerMouse                                   = UnitIsPlayer("mouseover")
        local potion                                        = br.player.potion
        local power, powmax, powgen                         = br.player.power.amount.runicPower , br.player.power.runicPower.max, br.player.power.regen
        local pullTimer                                     = br.DBM:getPulltimer()
        local racial                                        = br.player.getRacial()
        local recharge                                      = br.player.recharge
        local runes                                         = br.player.power.runes.frac
        local runicPower                                    = br.player.power.amount.runicPower
        local solo                                          = #br.friend < 2
        local friendsInRange                                = friendsInRange
        local spell                                         = br.player.spell
        local stealth                                       = br.player.stealth
        local talent                                        = br.player.talent
        local trinketProc                                   = false
        local ttd                                           = getTTD
        local ttm                                           = br.player.power.ttm
        local units                                         = units or {}

        units.dyn5 = br.player.units(5)
        units.dyn30AoE = br.player.units(30,true)
        enemies.yards8 = br.player.enemies(8)
        enemies.yards30 = br.player.enemies(30)
        enemies.yards40 = br.player.enemies(40)

        if leftCombat == nil then leftCombat = GetTime() end
        if profileStop == nil then profileStop = false end

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
            -- Dark Command
            if isChecked("黑暗命令") then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if not isAggroed(thisUnit) and hasThreat(thisUnit) then
                        if cast.darkCommand(thisUnit) then return end
                    end
                end
            end
        end -- End Action List - Extras
    -- Action List - Defensive
        local function actionList_Defensive()
            if useDefensive() and not stealth and not flight then
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
        -- Anti-Magic Shell
                if isChecked("反魔法护罩") and php <= getOptionValue("反魔法护罩") then
                    if cast.antiMagicShell() then return end
                end
        -- Icebound Fortitude
                if isChecked("冰封之韧") and php <= getOptionValue("冰封之韧") then
                    if cast.iceboundFortitude() then return end
                end
        -- Vampiric Blood
                if isChecked("吸血鬼之血") and php <= getOptionValue("吸血鬼之血") then
                    if cast.vampiricBlood() then return end
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
            end
        end -- End Action List - Defensive
    -- Action List - Interrupts
        local function actionList_Interrupts()
            if useInterrupts() then
                for i=1, #enemies.yards30 do
                    thisUnit = enemies.yards30[i]
                    if canInterrupt(thisUnit,getOptionValue("打断")) then
        -- Death Grip
                        if isChecked("死亡之握") and getDistance(thisUnit) > 8 then
                            if cast.deathGrip(thisUnit) then return end
                        end
        -- Asphyxiate
                        if isChecked("窒息") and getDistance(thisUnit) < 20 then
                            if cast.asphyxiate(thisUnit) then return end
                        end
        -- Mind Freeze
                        if isChecked("心灵冰冻") and getDistance(thisUnit) < 15 then
                            if cast.mindFreeze(thisUnit) then return end
                        end
                    end
                end
            end -- End useInterrupts check
        end -- End Action List - Interrupts
    -- Action List - Cooldowns
        local function actionList_Cooldowns()
            if useCDs() and getDistance(units.dyn5) < 5 then
        -- Trinkets
                if isChecked("饰品 血量") and php <= getOptionValue("饰品 血量") and getDistance("target") < 5 then
                    if (getOptionValue("饰品") == 1 or getOptionValue("饰品") == 3) and canUse(13) then
                        useItem(13)
                    end
		            if (getOptionValue("饰品") == 2 or getOptionValue("饰品") == 3) and canUse(14) then
                        useItem(14)
                    end
                end
        -- Racial: Orc Blood Fury | Troll Berserking | Blood Elf Arcane Torrent
                -- blood_fury,buff.tigers_fury | berserking,buff.tigers_fury | arcane_torrent,buff.tigers_fury
                if isChecked("种族技能") and (br.player.race == "Orc" or br.player.race == "Troll" or br.player.race == "BloodElf") then
                    if castSpell("player",racial,false,false,false) then return end
                end
        -- Dancing Rune Weapon
                if isChecked("符文刃舞") then
                    if cast.dancingRuneWeapon() then return end
                end
            end -- End useCooldowns check
        end -- End Action List - Cooldowns
    -- Action List - PreCombat
        local function actionList_PreCombat()
            if not inCombat and not (IsFlying() or IsMounted()) then
                if not stealth then
        -- Flask / Crystal
                    -- flask,type=flask_of_Ten_Thousand_Scars
                    if isChecked("奥拉留斯的低语水晶") and not stealth then
                        if inRaid and canFlask and flaskBuff==0 and not (UnitBuffID("player",188035) or UnitBuffID("player",188034)) then
                            useItem(br.player.flask.wod.staminaBig)
                            return true
                        end
                        if flaskBuff==0 then
                            if not UnitBuffID("player",188033) and canUse(118922) then --Draenor Insanity Crystal
                                useItem(118922)
                                return true
                            end
                        end
                    end
        -- auto_attack
                    if canAttack() and not UnitIsDeadOrGhost("target") and getDistance("target") <= 5 then
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
                if getDistance("target") < 5 then
                    StartAttack()
                end
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
        -- Marrowrend
                    if buff.boneShield.remain() < 3 or #enemies.yards8 == 0 then
                        if cast.marrowrend() then return end
                    end
        -- Blood Boil
                    for i = 1, #enemies.yards8 do
                        local thisUnit = enemies.yards8[i]
                        if not debuff.bloodPlague.exists(thisUnit) then
                            if cast.bloodBoil("player") then return end
                        end
                    end
        -- Death and Decay
                    if (buff.crimsonScourge.exists() or level < 63) and (#enemies.yards8 > 1 or (#enemies.yards8 == 1 and talent.rapidDecomposition)) then
                        if cast.deathAndDecay("best",false,#enemies.yards8,8) then return end
                    end
        -- Death Strike
                    if ttm <= 20 or php < 75 then
                        if cast.deathStrike() then return end
                    end
        -- Marrowrend
                    if buff.boneShield.stack() <= 6 then
                        if cast.marrowrend() then return end
                    end
        -- Death and Decay
                    if (#enemies.yards8 == 1 and runes >= 3) or #enemies.yards8 >= 3 then
                        if cast.deathAndDecay("best",false,#enemies.yards8,8) then return end
                    end
        -- Heart Strike
                    if runes >= 3 or ((not talent.ossuary or buff.boneShield.stack() < 5) and power < 45) or (talent.ossuary and buff.boneShield.stack() >= 5 and power < 40) then
                        if cast.heartStrike() then return end
                    end
        -- Consumption
		        if php <= getOptionValue("神器技能 血量") then
                    if cast.consumption() then return end
				end	
        -- Blood Boil
                    if cast.bloodBoil("player") then return end
                end -- End SimC APL
    ------------------------
    --- Ask Mr Robot APL ---
    ------------------------
                if getOptionValue("APL模式") == 2 then
        -- Soulgorge
                     --if DotRemainingSec(BloodPlague) < 3 and HasDot(BloodPlague)
                    if debuff.bloodPlague.exists(units.dyn30AoE) and debuff.bloodPlague.remain(units.dyn30AoE) < 3 then
                        if cast.soulgorge() then return end
                    end
        -- Bonestorm
                     --if TargetsInRadius(Bonestorm) > 2 and AlternatePower >= 80
                    if #enemies.yards8 > 2 and runicPower >= 80 then
                        if cast.bonestorm() then return end
                   end
        -- Death Strike
                     --if HealthPercent < 0.75 or AlternatePowerToMax <= 20
                    if php < 75 or ttm <= 20 then
                        if cast.deathStrike() then return end
                    end
        -- Death's Caress
                     --if not HasDot(BloodPlague) and HasTalent(Soulgorge)
                    if not debuff.bloodPlague.exists(units.dyn30AoE) and talent.soulGorge then
                        if cast.deathsCaress() then return end
                    end
        -- Blood Tap
                     --if Power < 2 and BuffStack(BoneShield) <= BuffMaxStack(BoneShield) - 3
                    if runes < 2 and buff.boneshield.stack() <= 7 then
                        if cast.bloodTap() then return end
                    end
        -- Marrowrend
                     --if (BuffStack(BoneShield) <= BuffMaxStack(BoneShield) - 3 and (ArtifactTraitRank(MouthOfHell) = 0 or not HasBuff(DancingRuneWeapon))) or
                     --(BuffStack(BoneShield) <= BuffMaxStack(BoneShield) - 4 and ArtifactTraitRank(MouthOfHell) > 0 and HasBuff(DancingRuneWeapon))
                    if (buff.boneShield.stack() <= 7 and (artifact.mouthOfHell or not buff.dancingRuneWeapon.exists())) or (buff.boneShield.stack() <= 6 and artifact.mouthOfHell and buff.dancingRuneWeapon.exists()) then
                        if cast.marrowrend() then return end
                    end
        -- Blooddrinker
                     --if HealthPercent < 0.75
                    if php < 75 then
                        if cast.blooddrinker() then return end
                    end
        -- Blood Boil
                    if cast.bloodBoil("player") then return end
        -- Death and Decay
                     --if HasBuff(CrimsonScourge) or HasTalent(RapidDecomposition)
                    if buff.crimsonScourge.exists() or talent.rapidDecomposition then
                        if cast.deathAndDecay("best",false,#enemies.yards8,8) then return end
                    end
        -- Heart Strike
                    if cast.heartStrike() then return end
        -- Mark of Blood
                     --if not HasBuff(MarkOfBlood)
                    if not buff.markOfBlood.exists() then 
                        if cast.markOfBlood() then return end
                    end
                end

    ---------------------------
    --- Vilt APL ---
    ---------------------------
                if getOptionValue("APL模式") == 3 then
                    if --[[((buff.crimsonScourge.exists() and talent.rapidDecomposition) or]] #enemies.yards8 >= getOptionValue("枯萎凋零") and isChecked("枯萎凋零") then
                        if cast.deathAndDecay("best",false,#enemies.yards8,8) then return end
                    end
                    --dump rp with deathstrike
                    if ((talent.bonestorm and cd.bonestorm > 3) or (talent.bonestorm and #enemies.yards8 < getOptionValue("白骨风暴 目标")) or (not talent.bonestorm or not isChecked("白骨风暴"))) and br.player.power.runicPower.deficit <= 30 then
                        if cast.deathStrike() then return end
                    end
                    if (talent.ossuary and buff.boneShield.stack() <=4) or (not talent.ossuary and buff.boneShield.stack() <=2) or buff.boneShield.remain() < 4 or not buff.boneShield.exists() then
                        if cast.marrowrend() then return end
                    end
                    --#high prio heal
                    --I'll just use flat hp numbers defined by the user for simplicity and tends to work a little bit better anyway
                    if php < getOptionValue("灵界打击 高优先") then
                        if cast.deathStrike() then return end
                    end
                    if talent.bonestorm and isChecked("白骨风暴") and #enemies.yards8 >= getOptionValue("白骨风暴 目标") and runicPower >= getOptionValue("白骨风暴 能量") then
                        if cast.bonestorm("Player") then return end
                    end
                    --#soulgorge/deathcaressmultidot NEEDS TO BE FIXED, SOON™
                    --#actions+=/soulgorge,if=talent.soulgorge.enabled&target_if=min:target.debuff.blood_plague,if=target.debuff.blood_plague.remain()ing<=2&spell_targets.soulgorge>=3
                    --#actions+=/deaths_caress,cycle_targets=1,if=talent.soulgorge.enabled&spell_targets.soulgorge<3&(debuff.blood_plague.refresh()able|!debuff.blood_plague.up)
                    --Not gonna bother with this because worthless talent anyway, might add later.
                    --actions+=/blood_boil,if=!talent.soulgorge.enabled&(debuff.blood_plague.refresh()able|!debuff.blood_plague.up)
                    --borrowing your blood boil code
                    if not talent.soulgorge then
                        for i = 1, #enemies.yards8 do
                            local thisUnit = enemies.yards8[i]
                            if not debuff.bloodPlague.exists(thisUnit) then
                                if cast.bloodBoil("player") then return end
                            end
                        end
                    end
                    if isChecked("血液沸腾 高优先") and (charges.frac.bloodBoil >= 1.75 and getDistance("target") <= 8) then
                        if cast.bloodBoil("player") then return end
                    end
                    if talent.bloodTap and runes < 3 then
                        if cast.bloodTap() then return end
                    end
                    if php <= getOptionValue("神器技能 血量") and (getOptionValue("神器技能") == 1 or (getOptionValue("神器技能") == 2 and useCDs()) and isChecked("吸血鬼之血 消费")) then
                        if buff.vampiricBlood.exists() and php < getOptionValue("吸血鬼之血 消费") and getEnemiesInCone(5,105) >= 1 then
                            if cast.consumption() then return end
                        end
                    end
                    --#low prio heal
                    if php < getOptionValue("灵界打击 低优先") then
                        if cast.deathStrike() then return end
                    end
                    if runes >= 2.5 and talent.ossuary and buff.boneShield.stack() <=6 then
                        if cast.marrowrend() then return end
                    end
                    if runes >= 2.5 then
                        if cast.heartStrike() then return end
                    end
                    if php <= getOptionValue("神器技能 血量") and (getOptionValue("神器技能") == 1 or (getOptionValue("神器技能") == 2 and useCDs())) then
                        if getEnemiesInCone(5,105) >= 1 then
                            if cast.consumption() then return end
                        end
                    end
                    if getDistance("target") <= 8 then
                        if cast.bloodBoil("player") then return end
                    end
                end -- End Vilt APL
            end --End In Combat
        end --End Rotation Logic
    end -- End Timer
end -- End runRotation
local id = 250
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})
