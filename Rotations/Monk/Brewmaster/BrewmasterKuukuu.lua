local rotationName = "Kuukuu"

---------------
--- Toggles ---
---------------
local function createToggles()
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "基于范围内的目标数,在单目标和多目标自动切换输出方式.", highlight = 1, icon = br.player.spell.blackoutStrike },
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "使用多目标方式输出.", highlight = 0, icon = br.player.spell.breathOfFire },
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "使用单目标方式输出.", highlight = 0, icon = br.player.spell.tigerPalm },
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "禁用DPS输出", highlight = 0, icon = br.player.spell.effuse}
    };
    CreateButton("Rotation",1,0)
-- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "自动使用大技能 - 只在BOSS.", highlight = 1, icon = br.player.spell.fortifyingBrew },
        [2] = { mode = "On", value = 1 , overlay = "Cooldowns Enabled", tip = "不管任何目标都使用大技能.", highlight = 0, icon = br.player.spell.fortifyingBrew },
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "不使用大技能.", highlight = 0, icon = br.player.spell.fortifyingBrew }
    };
    CreateButton("Cooldown",2,0)
-- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "使用保命技能.", highlight = 1, icon = br.player.spell.dampenHarm },
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "不使用保命技能.", highlight = 0, icon = br.player.spell.dampenHarm }
    };
    CreateButton("Defensive",3,0)
-- Interrupt Button
    InterruptModes = {
        [1] = { mode = "On", value = 1 , overlay = "Interrupts Enabled", tip = "使用打断.", highlight = 1, icon = br.player.spell.spearHandStrike },
        [2] = { mode = "Off", value = 2 , overlay = "Interrupts Disabled", tip = "不使用打断.", highlight = 0, icon = br.player.spell.spearHandStrike }
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
        --    br.ui:createDropdownWithout(section, "APL模式", {"|cffFFFFFFSimC","|cffFFFFFFAMR"}, 1, "|cffFFFFFF选择输出循环.")
        -- Dummy DPS Test
            br.ui:createSpinner(section, "DPS测试",  5,  5,  60,  5,  "|cffFFFFFF设置为所需的测试的时间（分钟）. 最小: 5 / 最大: 60 / 间隔: 5")
        -- Provoke
            br.ui:createCheckbox(section, "嚎镇八方","|cffFFFFFF自动使用嚎镇八方.")
        -- Opener
            br.ui:createCheckbox(section, "Opener","|cffFFFFFFBest Ironskin Uptime at Start.")            
        -- Pre-Pull Timer
        --    br.ui:createSpinner(section, "Pre-Pull Timer",  5,  1,  10,  1,  "|cffFFFFFF设置为所需的启动时间 Pre-Pull (必须有DBM). 最小: 1 / 最大: 10 / 间隔: 1")
        -- Purifying Brew
            br.ui:createDropdown(section, "活血酒",  {"|cff00FF00Both","|cffFF0000Heavy Only"}, 1, "|cffFFFFFF施放技能")
        -- Resuscitate
            br.ui:createDropdown(section, "轮回转世", {"|cff00FF00目标","|cffFF0000鼠标位置"}, 1, "|cffFFFFFF施放技能")
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
            br.ui:createSpinner(section, "饰品 血量",  70,  0,  100,  5,  "多少血量百分比使用")		
            br.ui:createDropdownWithout(section, "饰品", {"|cff00FF00只用第一个","|cff00FF00只用第二个","|cffFFFF00两个都用","|cffFF0000不用"}, 1, "|cffFFFFFF选择饰品使用.") 
        -- Touch of the Void
            br.ui:createCheckbox(section,"虚空之触")
        -- Chi Burst
        	br.ui:createSpinnerWithout(section, "真气爆裂 目标",  1,  1,  10,  1)
        -- Artifact
            br.ui:createDropdownWithout(section,"神器技能", {"|cff00FF00任何时候","|cffFFFF00冷却技能","|cffFF0000决不"}, 1, "|cffFFFFFF什么时候使用神器技能.")
        -- Exploding Keg Targets
        	br.ui:createSpinnerWithout(section, "爆炸酒桶 目标",  2,  1,  10,  1,  "|cffFFFFFF需要使用爆炸酒桶的目标数量.")        
        -- Breath of Fire
        	br.ui:createSpinnerWithout(section, "火焰之息 目标",  1,  1,  10,  1)
        -- Keg Smash
        	br.ui:createSpinnerWithout(section, "醉酿投 目标",  1,  1,  10,  1)
        br.ui:checkSectionState(section)
        -------------------------
        --- DEFENSIVE OPTIONS ---
        -------------------------
         section = br.ui:createSection(br.ui.window.profile, "保命")
        -- Healthstone
            br.ui:createSpinner(section, "治疗石",  60,  0,  100,  5,  "|cffFFBB00百分几血量使用")
        -- Heirloom Neck
            br.ui:createSpinner(section, "传家宝项链",  60,  0,  100,  5,  "|cffFFBB00百分几血量使用")
        -- Effuse
            br.ui:createSpinner(section, "真气贯通",  50,  0,  100,  5,  "|cffFFFFFF百分几血量使用")
        -- Detox
            br.ui:createCheckbox(section,"清创生血")
        -- Healing Elixir
            br.ui:createSpinner(section, "金创药", 50, 0, 100, 5, "|cffFFFFFF百分几血量使用")
        -- Leg Sweep
            br.ui:createSpinner(section, "扫堂腿 - HP", 50, 0, 100, 5, "|cffFFFFFF百分几血量使用")
            br.ui:createSpinner(section, "扫堂腿 - AoE", 5, 0, 10, 1, "|cffFFFFFF投放5码的单位数")
        -- Fortifying Brew
            br.ui:createSpinner(section, "壮胆酒",  50,  0,  100,  5,  "|cffFFFFFF百分几血量使用")
        -- Dampen Harm
            br.ui:createSpinner(section, "躯不坏",  50,  0,  100,  5,  "|cffFFFFFF百分几血量使用")
        -- Expel Harm
            br.ui:createSpinner(section, "移花接木",  50,  0,  100,  5,  "|cffFFFFFF百分几血量使用")
        -- Expel Harm Orbs
        	br.ui:createSpinnerWithout(section, "移花接木 球体",  3,  0,  15,  1,  "|cffFFFFFFMin amount of Gift of the Ox Orbs to cast.")
        br.ui:checkSectionState(section)
        -------------------------
        --- INTERRUPT OPTIONS ---
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, "打断")
        --Quaking Palm
            br.ui:createCheckbox(section, "震山掌")
        -- Spear Hand Strike
            br.ui:createCheckbox(section, "切喉手")
        -- Paralysis
            br.ui:createCheckbox(section, "分筋错骨")
        -- Leg Sweep
            br.ui:createCheckbox(section, "扫堂腿")
        -- Interrupt Percentage
            br.ui:createSpinner(section,  "打断",  0,  0,  95,  5,  "|cffFFBB00读条百分几打断")
        br.ui:checkSectionState(section)
        ----------------------
        --- TOGGLE OPTIONS ---
        ----------------------
        section = br.ui:createSection(br.ui.window.profile,  "切换快捷键")
        -- Single/Multi Toggle
            br.ui:createDropdown(section,  "Rotation Mode", br.dropOptions.Toggle,  4)
        --Cooldown Key Toggle
            br.ui:createDropdown(section,  "Cooldown Mode", br.dropOptions.Toggle,  3)
        --Defensive Key Toggle
            br.ui:createDropdown(section,  "Defensive Mode", br.dropOptions.Toggle,  6)
        -- Interrupts Key Toggle
            br.ui:createDropdown(section,  "Interrupt Mode", br.dropOptions.Toggle,  6)
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
    if br.timer:useTimer("debugBrewmaster", math.random(0.15,0.3)) then
        --Print("Running: "..rotationName)

---------------
--- Toggles ---
---------------
        UpdateToggle("Rotation",0.25)
        UpdateToggle("Cooldown",0.25)
        UpdateToggle("Defensive",0.25)
        UpdateToggle("Interrupt",0.25)
        BurstToggle("burstKey", 0.25)

--------------
--- Locals ---
--------------
        local agility           = UnitStat("player", 2)
        local artifact          = br.player.artifact
        local baseAgility       = 0
        local baseMultistrike   = 0
        local buff              = br.player.buff
        local canFlask          = canUse(br.player.flask.wod.agilityBig)
        local cast              = br.player.cast
        local castable          = br.player.cast.debug
        local cd                = br.player.cd
        local charges           = br.player.charges
        local combatTime        = getCombatTime()
        local debuff            = br.player.debuff
        local deadtar, attacktar, hastar, playertar         = deadtar or UnitIsDeadOrGhost("target"), attacktar or UnitCanAttack("target", "player"), hastar or GetObjectExists("target"), UnitIsPlayer("target")
        local enemies           = enemies or {}
        local flaskBuff         = getBuffRemain("player",br.player.flask.wod.buff.agilityBig) or 0
        local gcd               = br.player.gcd
        local glyph             = br.player.glyph
        local healthPot         = getHealthPot() or 0
        local inCombat          = br.player.inCombat
        local inRaid            = select(2,IsInInstance())=="raid"
        local inInstance        = br.player.instance=="party"
        local level             = br.player.level
        local mode              = br.player.mode
        local php               = br.player.health
        local power             = br.player.power.amount.energy
        local powgen			= br.player.power.regen
        local powerMax          = br.player.power.energy.max
        local pullTimer         = br.DBM:getPulltimer()
        local queue             = br.player.queue
        local race              = br.player.race
        local racial            = br.player.getRacial()
        local recharge          = br.player.recharge
        local regen             = br.player.power.regen
        local solo              = select(2,IsInInstance())=="none"
        local spell             = br.player.spell
        local t17_2pc           = br.player.eq.t17_2pc
        local t18_2pc           = br.player.eq.t18_2pc
        local t18_4pc           = br.player.eq.t18_4pc
        local talent            = br.player.talent
        local thp               = getHP(br.player.units(5))
        local trinketProc       = false --br.player.hasTrinketProc()
        local ttd               = getTTD(br.player.units(5))
        local ttm               = br.player.power.ttm
        local units             = units or {}
        if leftCombat == nil then leftCombat = GetTime() end
        if profileStop == nil then profileStop = false end

        units.dyn5 = br.player.units(5)
        enemies.yards5 = br.player.enemies(5)
        enemies.yards8 = br.player.enemies(8)
        enemies.yards8t = br.player.enemies(8,br.player.units(8,true))
        enemies.yards30 = br.player.enemies(30)


        if opener == nil then opener = false end

        if not inCombat and not GetObjectExists("target") then
            iB1 = false
            KG = false
            iB2 = false
            iB3 = false
            bOB = false
            iB4 = false
            opener = false
            openerStarted = false
        end

--------------------
--- Action Lists ---
--------------------
    -- Action List - Extras
        function actionList_Extras()
        -- Tiger's Lust
            if hasNoControl() or (inCombat and getDistance("target") > 10 and isValidUnit("target")) then
                if cast.tigersLust() then return end
            end
        -- Resuscitate
            if isChecked("轮回转世") then
                if getOptionValue("轮回转世") == 1
                    and UnitIsPlayer("target") and UnitIsDeadOrGhost("target") and UnitIsFriend("target","player")
                then
                    if cast.resuscitate("target") then return end
                end
                if getOptionValue("轮回转世") == 2
                    and UnitIsPlayer("mouseover") and UnitIsDeadOrGhost("mouseover") and UnitIsFriend("mouseover","player")
                then
                    if cast.resuscitate("mouseover") then return end
                end
            end
        -- Roll
            if isChecked("滚地翻") and getDistance("target") > 10 and isValidUnit("target") and getFacingDistance() < 5 and getFacing("player","target",10) then
                if cast.roll() then return end
            end
        -- Dummy Test
            if isChecked("DPS测试") then
                if GetObjectExists("target") then
                    if combatTime >= (tonumber(getValue("DPS测试"))*60) and isDummy() then
                        StopAttack()
                        ClearTarget()
                        StopAttack()
                        ClearTarget()
                        Print(tonumber(getValue("DPS测试")) .." Minute Dummy Test Concluded - Profile Stopped")
                    end
                end
            end
        -- Touch of the Void
            if (useCDs() or useAoE()) and isChecked("虚空之触") and inCombat and getDistance(units.dyn5)<5 then
                if hasEquiped(128318) then
                    if GetItemCooldown(128318)==0 then
                        useItem(128318)
                    end
                end
            end
        end -- End Action List - Extras
    -- Action List - Defensive
        function actionList_Defensive()
            if useDefensive() then
        -- Purifying Brew
                if isChecked("活血酒") then
                    if getOptionValue("活血酒") == 1 then
                        if (debuff.moderateStagger.exists("player") or debuff.heavyStagger.exists("player")) then
                            if cast.purifyingBrew() then return end
                        end
                    end
                    if getOptionValue("活血酒") == 2 then
                        if debuff.heavyStagger.exists("player") then
                            if cast.purifyingBrew() then return end
                        end
                    end
                end
        --Expel Harm
                if isChecked("移花接木") and php <= getValue("移花接木") and inCombat and GetSpellCount(115072) >= getOptionValue("移花接木 球体") then
                    if cast.expelHarm() then return end
                end
        -- Pot/Stoned
                if isChecked("治疗石") and getHP("player") <= getValue("治疗石") and inCombat then
                    if canUse(5512) then
                        useItem(5512)
                    elseif canUse(healthPot) then
                        useItem(healthPot)
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
        -- Dampen Harm
                if isChecked("躯不坏") and php <= getValue("躯不坏") and inCombat then
                    if cast.dampenHarm() then return end
                end
        -- Diffuse Magic
                --[[if isChecked("散魔功") and ((php <= getValue("Diffuse Magic") and inCombat) or canDispel("player",br.player.spell.diffuseMagic)) then
                    if cast.diffuseMagic() then return end
                end]]
        -- Detox
                if isChecked("清创生血") then
                    if canDispel("player",spell.detox) then
                        if cast.detox("player") then return end
                    end
                    if UnitIsPlayer("mouseover") and not UnitIsDeadOrGhost("mouseover") then
                        if canDispel("mouseover",spell.detox) then
                            if cast.detox("mouseover") then return end
                        end
                    end
                end
        -- Effuse
                if isChecked("真气贯通") and ((not inCombat and php <= getOptionValue("真气贯通")) --[[or (inCombat and php <= getOptionValue("真气贯通") / 2)]]) then
                    if cast.effuse() then return end
                end
        -- Healing Elixir
                if isChecked("金创药") and php <= getValue("金创药") and charges.healingElixir > 1 then
                    if cast.healingElixir() then return end
                end
        -- Leg Sweep
                if isChecked("扫堂腿 - HP") and php <= getValue("扫堂腿 - HP") and inCombat and #enemies.yards5 > 0 then
                    if cast.legSweep() then return end
                end
                if isChecked("扫堂腿 - AoE") and #enemies.yards5 >= getValue("扫堂腿 - AoE") then
                    if cast.legSweep() then return end
                end
        -- Fortifying Brew
                if isChecked("壮胆酒") and php <= getValue("壮胆酒") and inCombat then
                    if cast.fortifyingBrew() then return end
                end
        --Expel Harm
                if isChecked("移花接木") and php <= getValue("移花接木") and inCombat and GetSpellCount(115072) >= getOptionValue("移花接木 球体") then
                    if cast.expelHarm() then return end
                end
            end -- End Defensive Check
        end -- End Action List - Defensive
    -- Action List - Interrupts
        function actionList_Interrupts()
            if useInterrupts() then
                for i=1, #getEnemies("player",20) do
                    thisUnit = getEnemies("player",20)[i]
                    distance = getDistance(thisUnit)
                    if canInterrupt(thisUnit,getOptionValue("打断")) then
                        if distance <= 5 then
        -- Quaking Palm
                            if isChecked("震山掌") then
                                if cast.quakingPalm(thisUnit) then return end
                            end
        -- Spear Hand Strike
                            if isChecked("切喉手") then
                                if cast.spearHandStrike(thisUnit) then return end
                            end
        -- Leg Sweep
                            if isChecked("扫堂腿") then
                                if cast.legSweep(thisUnit) then return end
                            end
                        end
        -- Paralysis
                        if isChecked("分筋错骨") then
                            if cast.paralysis(thisUnit) then return end
                        end
                    end
                end
            end -- End Interrupt Check
        end -- End Action List - Interrupts
    -- Action List - Cooldowns
        function actionList_Cooldown()
            if useCDs() and getDistance(units.dyn5) < 5 then
        -- Trinkets
                if isChecked("饰品 血量") and php <= getOptionValue("饰品 血量") then
						if (getOptionValue("饰品") == 1 or getOptionValue("饰品") == 3) and canUse(13) then
							useItem(13)
						end
						if (getOptionValue("饰品") == 2 or getOptionValue("饰品") == 3) and canUse(14) then
							useItem(14)
						end
                end
        -- Racial - Blood Fury / Berserking
                -- blood_fury
                -- berserking
                if isChecked("种族技能") and (race == "Orc" or race == "Troll") then
                    if castSpell("player",racial,false,false,false) then return end
                end
       
            end
        end -- End Cooldown - Action List
    -- Action List - Opener
        function actionList_Opener()
            if opener == false then
                openerStarted = true
                --Ironskin Brew
                if not iB1 == true then
                    if cast.ironskinBrew() then
                        iB1 = true 
                    end
                -- Keg Smash
                elseif iB1 == true and not KG and getDistance("target") < 5 then
                    if cast.kegSmash("target") then
                        KG = true
                    end
                -- Ironskin Brew
                elseif KG == true and not iB2 then
                    if cast.ironskinBrew() then 
                        iB2 = true
                    end
                -- Ironskin Brew
                elseif iB2 == true and not iB3 then
                    if cast.ironskinBrew() then 
                        iB3 = true
                    end
                -- Black Ox Brew
                elseif iB3 == true and not bOB then
                    if cast.blackoxBrew() then 
                        bOB = true
                    end
                --Iron Skin Brew
                elseif bOB == true and not iB4 then
                    if cast.ironskinBrew() then
                        iB4 = true
                        opener = true
                        print("Opener Complete")
                    end
                end
            end
        end
    -- Action List - Black Out Combo
        function actionList_BlackOutCombo()
        -- Racial - Arcane Torrent
            if ttm >= 0.5 and isChecked("种族技能") and race == "BloodElf" and getDistance("target") < 5 then
                if castSpell("player",racial,false,false,false) then return end
            end
        -- Keg Smash
            if buff.blackoutCombo.exists() and #enemies.yards8t >= getOptionValue("醉酿投 目标") then
                if cast.kegSmash() then return end
            end
        --[[ Breath of Fire
        	if buff.blackoutCombo.exists() and #getEnemies("player",12) >= getOptionValue("火焰之息 目标") then
        		if cast.breathOfFire() then return end
        	end]]        
        -- Breath of Fire
            if buff.blackoutCombo.exists() and not hasEquiped(137016) and #getEnemies("player",12) >= getOptionValue("火焰之息 目标") and debuff.kegSmash.exists(units.dyn5) then
                if cast.breathOfFire() then return end
            end
        -- Breath of Fire (Legendary Chest)
            if not buff.blackoutCombo.exists() and hasEquiped(137016) and #getEnemies("player",12) >= getOptionValue("火焰之息 目标") and debuff.kegSmash.exists(units.dyn5) then
                if cast.breathOfFire() then return end
            end
        -- Blackout Strike
            if cast.blackoutStrike() then return end
        -- Exploding Keg
            if getOptionValue("神器技能") == 1 or (getOptionValue("神器技能") == 2 and useCDs()) and #getEnemies("player",12) >= getOptionValue("爆炸酒桶 目标") then
                if cast.explodingKeg() then return end
            end
        -- RJW AoE
            if ((mode.rotation == 1 and #enemies.yards8 >= 3) or mode.rotation == 2) then
                if cast.rushingJadeWind() then return end
            end
        -- TP AoE
            if ((mode.rotation == 1 and #enemies.yards8 >= 3) or mode.rotation == 2) and cd.kegSmash >= gcd and (power+(powgen*cd.kegSmash)) >= 80 then
                if cast.tigerPalm() then return end
            end
        -- Tiger Palm ST
            if ((mode.rotation == 1 and #enemies.yards8 < 3) or mode.rotation == 3) and (power + (powgen*cd.kegSmash)) >= 40 then
                if cast.tigerPalm() then return end
            end
        --Chi Burst
            --Width/Range values from LyloLoq
            if talent.chiBurst and getEnemiesInRect(7,47) >= getOptionValue("真气爆裂 目标") then
            	if cast.chiBurst() then return end
            end
        -- Chi Wave
        	if talent.chiWave then
            	if cast.chiWave() then return end
            end
        -- Rushing Jade Wind ST
            if ((mode.rotation == 1 and #enemies.yards8 < 3) or mode.rotation == 3) and #enemies.yards8 >= 1 then
                if cast.rushingJadeWind() then return end
            end
        -- Breath of Fire
        	--[[if #getEnemies("player",12) >= getOptionValue("火焰之息 目标") and debuff.kegSmash.exists(units.dyn5) then
        		if cast.breathOfFire() then return end
        	end]]        
        -- Expel Harm
            --[[if isChecked("移花接木") and php <= getValue("移花接木") and inCombat and GetSpellCount(115072) >= getOptionValue("移花接木 球体") then
                if cast.expelHarm() then return end
            end]]
        end


    -- Action List - Single Target
        function actionList_SingleTarget()
        -- Action List - Cooldown
            -- call_action_list,name=cd
        -- Racial - Arcane Torrent
            if ttm >= 0.5 and isChecked("种族技能") and race == "BloodElf" and getDistance("target") < 5 then
                if castSpell("player",racial,false,false,false) then return end
            end        
        -- Keg Smash
           -- actions.st=keg_smash
            if #enemies.yards8t >= getOptionValue("醉酿投 目标") then
                if cast.kegSmash() then return end
            end
        --Breath of Fire
            --actions.st+=/breath_of_fire
            if #getEnemies("player",12) >= getOptionValue("火焰之息 目标") and debuff.kegSmash.exists(units.dyn5) then
            	if cast.breathOfFire() then return end
            end
        -- Blackout Strike
            --actions.st+=/blackout_strike
            if cast.blackoutStrike() then return end
        --Tiger Palm
            --actions.st+=/tiger_palm
            if (power + (powgen*cd.kegSmash)) >= 40 then
                if cast.tigerPalm() then return end
            end
        --Exploding Keg
            --actions.st+=/exploding_keg
            if getOptionValue("神器技能") == 1 or (getOptionValue("神器技能") == 2 and useCDs()) and #getEnemies("player",12) >= getOptionValue("爆炸酒桶 目标") then
                if cast.explodingKeg() then return end
            end
        --Chi Burst
            --actions.st+=/chi_burst
            --Width/Range values from LyloLoq
            if talent.chiBurst and getEnemiesInRect(7,47) >= getOptionValue("真气爆裂 目标") then
                if cast.chiBurst() then return end
            end
        -- Chi Wave
            --actions.st+=/chi_wave
            if talent.chiWave then
            	if cast.chiWave() then return end
            end
        --  Rushing Jade Wind
            --actions.st+=/rushing_jade_wind
            if talent.rushingJadeWind and #enemies.yards8 >= 1 then
            	if cast.rushingJadeWind() then return end
            end
        -- Expel Harm
            --[[if isChecked("移花接木") and php <= getValue("移花接木") and inCombat and GetSpellCount(115072) >= getOptionValue("移花接木 球体") then
                if cast.expelHarm() then return end
            end]]
        end -- End Action List - Single Target
    --Action List AoE
        function actionList_MultiTarget()
        -- Racial - Arcane Torrent
            -- arcane_torrent,if=chiMax-chi>=1&energy.time_to_max>=0.
            if ttm >= 0.5 and isChecked("种族技能") and race == "BloodElf" and getDistance("target") < 5 then
                if castSpell("player",racial,false,false,false) then return end
            end        
        --Exploding Keg
            --actions.st+=/exploding_keg
            if getOptionValue("神器技能") == 1 or (getOptionValue("神器技能") == 2 and useCDs()) and #getEnemies("player",12) >= getOptionValue("爆炸酒桶 目标") then
                if cast.explodingKeg() then return end
            end
        -- Keg Smash
           -- actions.st=keg_smash
            if #enemies.yards8t >= getOptionValue("醉酿投 目标") then
                if cast.kegSmash() then return end
            end
        --Chi Burst
            --actions.st+=/chi_burst
            --Width/Range values from LyloLoq
            if talent.chiBurst and getEnemiesInRect(7,47) >= getOptionValue("真气爆裂 目标") then
                if cast.chiBurst() then return end
            end
        -- Chi Wave
            --actions.st+=/chi_wave
            if talent.chiWave then
            	if cast.chiWave() then return end
            end
        --Breath of Fire
            --actions.st+=/breath_of_fire
            if #getEnemies("player",12) >= getOptionValue("火焰之息 目标") and debuff.kegSmash.exists(units.dyn5) then
            	if cast.breathOfFire() then return end
            end
        --Rushing Jade Wind
            --actions.st+=/rushing_jade_wind
            if talent.rushingJadeWind and #enemies.yards8 >= 1 then
            	if cast.rushingJadeWind() then return end
            end        
        --Tiger Palm
            --actions.st+=/tiger_palm
            if cd.kegSmash >= gcd and (power+(powgen*cd.kegSmash)) >= 80 then
            	if cast.tigerPalm() then return end
            end
        -- Blackout Strike
            --actions.st+=/blackout_strike
            if cast.blackoutStrike() then return end
        end -- End Action List - Single Target
    -- Action List - Pre-Combat
        function actionList_PreCombat()
            if not inCombat then
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
                -- auto_attack
                if isValidUnit("target") and getDistance("target") < 5 then
                    StartAttack()
                end
            end -- End No Combat Check
        end --End Action List - Pre-Combat

---------------------
--- Begin Profile ---
---------------------
    -- Profile Stop | Pause
        if not inCombat and not hastar and profileStop==true then
            profileStop = false
        elseif (inCombat and profileStop==true) or pause() or (IsMounted() or IsFlying()) and getBuffRemain("player", 192002 ) < 10 or mode.rotation==4 then
            return true
        else
-----------------------
--- Extras Rotation ---
-----------------------
 --           if actionList_Extras() then return end
--------------------------
--- Defensive Rotation ---
--------------------------
            if actionList_Defensive() then return end
------------------------------
--- Pre-Combat Rotation ---
------------------------------
            if actionList_PreCombat() then return end
--------------------------
--- In Combat Rotation ---
--------------------------
            if isChecked("Opener") then
                if opener == false and hastar and UnitReaction("target","player") == 2 and isBoss("target") and getDistance("target") < 10 and (charges.purifyingBrew == 3 or openerStarted == true) then
                    if actionList_Opener() then return end
                elseif opener == false and openerStarted == false and hastar and charges.purifyingBrew < 3 then
                    opener = true
                elseif opener == false and hastar and not isBoss("target") then
                    opener = true
                end
            else
                opener = true
            end
        -- FIGHT!
            if inCombat and not IsMounted() and profileStop==false and isValidUnit(units.dyn5) and opener == true then
    ------------------
    --- Interrupts ---
    ------------------
        -- Run Action List - Interrupts
                if actionList_Interrupts() then return end
    ----------------------
    --- Start Rotation ---
    ----------------------
        -- Auto Attack
                -- auto_attack
                if getDistance(units.dyn5) < 5 then
                    StartAttack()
                end
    ---------------------------------
    --- APL Mode: SimulationCraft ---
    ---------------------------------
        -- Potion
                    -- potion,name=old_war,if=buff.serenity.up|buff.storm_earth_and_fire.up|(!talent.serenity.enabled&trinket.proc.agility.react)|buff.bloodlust.react|target.time_to_die<=60
                    -- TODO: Agility Proc
                    if isChecked("嚎镇八方") and (inRaid or inInstance) then
		                for i = 1, #enemies.yards30 do
		                   local thisUnit = enemies.yards30[i]
		                   local enemyTarget = UnitTarget(thisUnit)
		                   
		                   -- if not isAggroed(thisUnit) and hasThreat(thisUnit) then
		                   if enemyTarget ~= nil and UnitGroupRolesAssigned(enemyTarget) ~= "TANK" and UnitIsFriend(enemyTarget,"player") then
		                        if cast.provoke(thisUnit) then return end
		                    end
		                end
		            end
		        -- Black Ox Brew
		            if charges.purifyingBrew == 0 then
		                if cast.blackoxBrew() then return end
		            end
		        -- Ironskin Brew
		            if ((charges.purifyingBrew > 1 and not buff.ironskinBrew.exists()) or charges.purifyingBrew == 3) and not buff.blackoutCombo.exists() then
		                if cast.ironskinBrew() then return end
		            end
                -- Potion
                    if canUse(127844) and inRaid and isChecked("爆发药水") and getDistance("target") < 5 then
                        useItem(127844)
                    end
                    --[[if ((mode.rotation == 1 and #enemies.yards8 >= 3) or mode.rotation == 2) then
                        if actionList_MultiTarget() then return end
                    end]]  
        -- Blackout Combo APL
                    if talent.blackoutCombo then
                        if actionList_BlackOutCombo() then return end
                    end                                      
        -- Non-Blackout Combo APL
                    if not talent.blackoutCombo and ((mode.rotation == 1 and #enemies.yards8 >= 3) or mode.rotation == 2) then
                        if actionList_MultiTarget() then return end
                    end
                    if not talent.blackoutCombo then
                        if actionList_SingleTarget() then return end
                    end
            end -- End Combat Check
        end -- End Pause
    end -- End Timer
end -- End runRotation
local id = 268
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})
