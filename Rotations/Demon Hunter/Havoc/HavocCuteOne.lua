local rotationName = "CuteOne"

---------------
--- Toggles ---
---------------
local function createToggles()
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "基于范围内的目标数,在单目标和多目标自动切换输出方式.", highlight = 1, icon = br.player.spell.bladeDance},
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "使用多目标方式输出.", highlight = 0, icon = br.player.spell.bladeDance},
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "使用单目标方式输出.", highlight = 0, icon = br.player.spell.chaosStrike},
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "禁用DPS输出", highlight = 0, icon = br.player.spell.spectralSight}
    };
    CreateButton("Rotation",1,0)
-- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "自动使用大技能 - 只在BOSS.", highlight = 1, icon = br.player.spell.metamorphosis},
        [2] = { mode = "On", value = 2 , overlay = "Cooldowns Enabled", tip = "不管任何目标都使用大技能.", highlight = 0, icon = br.player.spell.metamorphosis},
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "不使用大技能.", highlight = 0, icon = br.player.spell.metamorphosis}
    };
   	CreateButton("Cooldown",2,0)
-- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "使用保命技能.", highlight = 1, icon = br.player.spell.darkness},
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "不使用保命技能.", highlight = 0, icon = br.player.spell.darkness}
    };
    CreateButton("Defensive",3,0)
-- Interrupt Button
    InterruptModes = {
        [1] = { mode = "On", value = 1 , overlay = "Interrupts Enabled", tip = "使用打断.", highlight = 1, icon = br.player.spell.consumeMagic},
        [2] = { mode = "Off", value = 2 , overlay = "Interrupts Disabled", tip = "不使用打断.", highlight = 0, icon = br.player.spell.consumeMagic}
    };
    CreateButton("Interrupt",4,0)
-- Mover
    MoverModes = {
        [1] = { mode = "AC", value = 1 , overlay = "Movement Animation Cancel Enabled", tip = "使用原地邪能冲撞.", highlight = 1, icon = br.player.spell.felRush},
        [2] = { mode = "On", value = 2 , overlay = "Auto Movement Enabled", tip = "不使用原地邪能冲撞.", highlight = 0, icon = br.player.spell.felRush},
        [3] = { mode = "Off", value = 3 , overlay = "Auto Movement Disabled", tip = "禁用邪能冲撞", highlight = 0, icon = br.player.spell.felRush}
    };
    CreateButton("Mover",5,0)
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
            br.ui:createDropdownWithout(section, "APL模式", {"|cffFFFFFFSimC","|cffFFFFFFAMR","|cffFFFFFFWH"}, 1, "|cffFFFFFF选择输出循环.")
        -- Dummy DPS Test
            br.ui:createSpinner(section, "DPS测试",  5,  5,  60,  5,  "|cffFFFFFF设置为所需的测试的时间（分钟）. 最小: 5 / 最大: 60 / 间隔: 5")
        -- Pre-Pull Timer
            br.ui:createSpinner(section, "Pre-Pull Timer",  5,  1,  10,  1,  "|cffFFFFFF设置为所需的启动时间 Pre-Pull (必须有DBM). 最小: 1 / 最大: 10 / 间隔: 1")
        -- Eye Beam Targets
            br.ui:createDropdownWithout(section,"眼棱用法",{"|cff00FF00任何时候","|cffFFFF00仅限AoE","|cffFF0000决不"}, 1, "|cffFFFFFF什么时候使用眼棱")
            br.ui:createSpinnerWithout(section, "AOE目标数量", 3, 1, 10, 1, "|cffFFBB00多少敌人时使用AOE技能")
		-- 投掷利刃
			br.ui:createCheckbox(section,"投掷利刃")
		-- 复仇回避
			br.ui:createCheckbox(section,"复仇回避")		
        -- Fel Rush Charge Hold
            br.ui:createSpinnerWithout(section, "保持邪能冲锋", 1, 0, 2, 1, "|cffFFBB00保持你邪能冲锋多少层");
        -- Glide Fall Time
            br.ui:createSpinner(section, "滑翔", 2, 0, 10, 1, "|cffFFBB00下降多少秒自动使用滑翔")
        -- Artifact
            br.ui:createDropdownWithout(section,"神器技能", {"|cff00FF00任何时候","|cffFFFF00冷却技能","|cffFF0000决不"}, 1, "|cffFFFFFF什么时候使用神器技能")
        br.ui:checkSectionState(section)
    -- Cooldown Options
        section = br.ui:createSection(br.ui.window.profile, "冷却技能")
        -- Potion
            br.ui:createCheckbox(section,"上古战神药水")
        -- Flask / Crystal
            br.ui:createCheckbox(section,"奥拉留斯的低语水晶")
        -- Legendary Ring
            br.ui:createCheckbox(section,"传奇戒指")
        -- Racial
            br.ui:createCheckbox(section,"种族技能")
        -- Trinkets
            br.ui:createDropdownWithout(section, "饰品", {"|cff00FF00只用第一个","|cff00FF00只用第二个","|cffFFFF00两个都用","|cffFF0000不用"}, 1, "|cffFFFFFF选择饰品使用.")
        -- Metamorphosis
            br.ui:createCheckbox(section,"恶魔变形")
        -- Draught of Souls
            br.ui:createCheckbox(section, "灵魂之引")
        br.ui:checkSectionState(section)
    -- Defensive Options
        section = br.ui:createSection(br.ui.window.profile, "保命")
        -- Healthstone
            br.ui:createSpinner(section, "药水/治疗石",  60,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用")
        -- Heirloom Neck
            br.ui:createSpinner(section, "传家宝项链",  60,  0,  100,  5,  "|cffFFBB00多少血量百分比使用");
        -- Blur
            br.ui:createSpinner(section, "疾影", 50, 0, 100, 5, "|cffFFBB00多少血量百分比使用")
        -- Darkness
            br.ui:createSpinner(section, "幻影打击", 30, 0, 100, 5, "|cffFFBB00多少血量百分比使用")
        -- Chaos Nova
            br.ui:createSpinner(section, "混乱新星 - HP", 30, 0, 100, 5, "|cffFFBB00多少血量百分比使用")
            br.ui:createSpinner(section, "混乱新星 - AoE", 3, 1, 10, 1, "|cffFFBB00多少敌人时使用")
        br.ui:checkSectionState(section)
    -- Interrupt Options
        section = br.ui:createSection(br.ui.window.profile, "打断")
        -- Consume Magic
            br.ui:createCheckbox(section, "吞噬魔法")
        -- Chaos Nova
            br.ui:createCheckbox(section, "混乱新星")
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
        -- Mover Key Toggle
            br.ui:createDropdown(section, "移动模式", br.dropOptions.Toggle,  6)
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
    if br.timer:useTimer("debugHavoc", math.random(0.15,0.3)) then
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
        local lastSpell                                     = lastSpellCast
        local level                                         = br.player.level
        local lootDelay                                     = getOptionValue("LootDelay")
        local lowestHP                                      = br.friend[1].unit
        local mode                                          = br.player.mode
        local moveIn                                        = 999
        -- local multidot                                      = (useCleave() or br.player.mode.rotation ~= 3)
        local perk                                          = br.player.perk
        local php                                           = br.player.health
        local playerMouse                                   = UnitIsPlayer("mouseover")
        local power, powmax, powgen, powerDeficit           = br.player.power.amount.fury, br.player.power.fury.max, br.player.power.regen, br.player.power.fury.deficit
        local pullTimer                                     = br.DBM:getPulltimer()
        local racial                                        = br.player.getRacial()
        local recharge                                      = br.player.recharge
        local solo                                          = br.player.instance=="none"
        local spell                                         = br.player.spell
        local talent                                        = br.player.talent
        local t19_4pc                                       = TierScan("T19") >= 4
        local t20_2pc                                       = false -- TODO: Add T20
        local ttd                                           = getTTD
        local ttm                                           = br.player.power.ttm
        local units                                         = units or {}

        units.dyn5 = br.player.units(5)
        units.dyn8 = br.player.units(8)
        enemies.yards5 = br.player.enemies(5)
        enemies.yards8 = br.player.enemies(8)
        enemies.yards8r = getEnemiesInRect(10,20,false) or 0
        enemies.yards10t = br.player.enemies(10,br.player.units(10,true))
        enemies.yards20 = br.player.enemies(20)
        enemies.yards30 = br.player.enemies(30)
        enemies.yards50 = br.player.enemies(50)

        if leftCombat == nil then leftCombat = GetTime() end
        if profileStop == nil then profileStop = false end
        if talent.chaosCleave then chaleave = 1 else chaleave = 0 end
        if buff.prepared.exists() then prepared = 1 else prepared = 0 end
        if talent.firstBlood then flood = 1 else flood = 0 end
        if lastSpell == spell.vengefulRetreat then vaulted = true else vaulted = false end
        if lastSpell == spell.eyeBeam and buff.metamorphosis.exists() then metaExtended = true elseif not buff.metamorphosis.exists() then metaExtended = false end

    -- Wait for Nemesis
        -- waiting_for_nemesis,value=!(!talent.nemesis.enabled|cooldown.nemesis.ready|cooldown.nemesis.remains>target.time_to_die|cooldown.nemesis.remains>60)
        local waitForNemesis = not (not talent.nemesis or cd.nemesis == 0 or cd.nemesis > ttd(units.dyn5) or cd.nemesis > 60)
    -- Wait for Chaos Blades
        -- waiting_for_chaos_blades,value=!(!talent.chaos_blades.enabled|cooldown.chaos_blades.ready|cooldown.chaos_blades.remains>target.time_to_die|cooldown.chaos_blades.remains>60)
        local waitForChaosBlades = not (not talent.chaosBlades or cd.chaosBlades == 0 or cd.chaosBlades > ttd(units.dyn5) or cd.chaosBlades > 60)
    -- Pool for Meta Variable
        -- pooling_for_meta,value=!talent.demonic.enabled&cooldown.metamorphosis.remains<6&fury.deficit>30&(!variable.waiting_for_nemesis|cooldown.nemesis.remains<10)&(!variable.waiting_for_chaos_blades|cooldown.chaos_blades.remains<6)
        if isChecked("恶魔变形") and useCDs() 
            and not talent.demonic and cd.metamorphosis < 6 and powerDeficit > 30 and (not waitForNemesis or cd.nemesis < 10) and (not waitForChaosBlades or cd.chaosBlades < 6)
        then
            poolForMeta = true
        else
            poolForMeta = false
        end
    -- Blade Dance Variable
        -- blade_dance,value=talent.first_blood.enabled|set_bonus.tier20_2pc|spell_targets.blade_dance1>=3+(talent.chaos_cleave.enabled*2)
        if talent.firstBlood or t20_2pc or ((mode.rotation == 1 and #enemies.yards8 >= getOptionValue("AOE目标数量")) or mode.rotation == 2) then
            bladeDanceVar = true
        else
            bladeDanceVar = false
        end
    -- Pool for Blade Dance Var
        -- pooling_for_blade_dance,value=variable.blade_dance&fury-40<35-talent.first_blood.enabled*20&(spell_targets.blade_dance1>=3+(talent.chaos_cleave.enabled*2))
        -- if bladeDanceVar and power - 40 < 35 - flood * 20 and ((mode.rotation == 1 and #enemies.yards8 >= getOptionValue("Units To AoE")) or mode.rotation == 2) then --power - 40 < 35 - flood * 20
        --     poolForBladeDance = true
        -- else
            poolForBladeDance = false
        -- end
    -- Pool for Chaos Strike
        -- pooling_for_chaos_strike,value=talent.chaos_cleave.enabled&fury.deficit>40&!raid_event.adds.up&raid_event.adds.in<2*gcd
        if talent.chaosCleave and power < 40 then --and not addsExist and addsIn < 2 * gcd then
            poolForChaosStrike = true
        else
            poolForChaosStrike = false
        end
    -- Check for Eye Beam During Metamorphosis
        if talent.demonic and buff.metamorphosis.duration() > 10 and lastSpell == spell.eyeBeam then metaEyeBeam = true end
        if metaEyeBeam == nil or (metaEyeBeam == true and not buff.metamorphosis.exists()) then metaEyeBeam = false end


    -- Custom Functions
        local function cancelRushAnimation()
            if castable.felRush and GetUnitSpeed("player") == 0 then
                MoveBackwardStart()
                JumpOrAscendStart()
                cast.felRush()
                MoveBackwardStop()
                AscendStop()
            end
            return
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
        -- Glide
            if isChecked("滑翔") and not buff.glide.exists() then
                if falling >= getOptionValue("滑翔") then
                    if cast.glide("player") then return end
                end
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
                    elseif canUse(129196) then --Legion Healthstone
                        useItem(129196)
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
        -- Blur
                if isChecked("疾影") and php <= getOptionValue("疾影") and inCombat then
                    if cast.blur() then return end
                end
        -- Darkness
                if isChecked("幻影打击") and php <= getOptionValue("幻影打击") and inCombat then
                    if cast.darkness() then return end
                end
        -- Chaos Nova
                if isChecked("混乱新星 - HP") and php <= getValue("混乱新星 - HP") and inCombat and #enemies.yards5 > 0 then
                    if cast.chaosNova() then return end
                end
                if isChecked("混乱新星 - AoE") and #enemies.yards5 >= getValue("混乱新星 - AoE") then
                    if cast.chaosNova() then return end
                end
    		end -- End Defensive Toggle
		end -- End Action List - Defensive
	-- Action List - Interrupts
		local function actionList_Interrupts()
			if useInterrupts() then
        -- Consume Magic
                if isChecked("吞噬魔法") then
                    for i=1, #enemies.yards20 do
                        thisUnit = enemies.yards20[i]
                        if canInterrupt(thisUnit,getOptionValue("打断")) then
                            if cast.consumeMagic(thisUnit) then return end
                        end
                    end
                end
        -- Chaos Nova
                if isChecked("混乱新星") then
                    for i=1, #enemies.yards5 do
                        thisUnit = enemies.yards5[i]
                        if canInterrupt(thisUnit,getOptionValue("打断")) then
                            if cast.chaosNova(thisUnit) then return end
                        end
                    end
                end
		 	end -- End useInterrupts check
		end -- End Action List - Interrupts
	-- Action List - Cooldowns
		local function actionList_Cooldowns()
			if useCDs() and getDistance(units.dyn5) < 5 then                
        -- Racial: Orc Blood Fury | Troll Berserking | Blood Elf Arcane Torrent
                if isChecked("种族技能") and (br.player.race == "Orc" or br.player.race == "Troll" or br.player.race == "BloodElf") then
                    if castSpell("player",racial,false,false,false) then return end
                end
                if getOptionValue("APL模式") == 1 then -- SimC
        -- Metamorphosis
                    if isChecked("恶魔变形") then
                        -- metamorphosis,if=!(talent.demonic.enabled|variable.pooling_for_meta|variable.waiting_for_nemesis|variable.waiting_for_chaos_blades)|target.time_to_die<25
                        if not (talent.demonic or poolForMeta or waitForNemesis or waitForChaosBlades) or ttd(units.dyn5) < 25 then
                            -- if cast.metamorphosis("best",false,1,8) then return end
                            if cast.metamorphosis("player") then return end
                        end
                        -- metamorphosis,if=talent.demonic.enabled&buff.metamorphosis.up&fury<40
                        if talent.demonic and buff.metamorphosis.exists() and power < 40 then
                            if cast.metamorphosis("player") then return end
                        end
                    end
        -- Nemesis
                    -- nemesis,target_if=min:target.time_to_die,if=raid_event.adds.exists&debuff.nemesis.down&(active_enemies>desired_targets|raid_event.adds.in>60)
                    -- nemesis,if=!raid_event.adds.exists&(buff.chaos_blades.up|buff.metamorphosis.up|cooldown.metamorphosis.adjusted_remains<20|target.time_to_die<=60)
                    if buff.chaosBlades.exists() or buff.metamorphosis.exists() or cd.metamorphosis < 20 or ttd(units.dyn5) <= 60 then
                        if isDummy("target") then 
                            lowestUnit = "target"
                        else 
                            for i = 1, #enemies.yards50 do
                                local thisUnit = enemies.yards50[i]
                                local lowestTTD = lowestTTD or 999
                                if ttd(thisUnit) < lowestTTD then 
                                    lowestTTD = ttd(thisUnit)
                                    lowestUnit = thisUnit
                                end
                            end
                        end
                        if cast.nemesis(lowestUnit) then return end
                    end
        -- Chaos Blades
                    -- chaos_blades,if=buff.metamorphosis.up|cooldown.metamorphosis.adjusted_remains>60|target.time_to_die<=12
                    if (buff.metamorphosis.exists() or cd.metamorphosis > 60 or ttd(units.dyn5) <= 12) and getDistance(units.dyn5) < 5 then
                        if cast.chaosBlades() then return end
                    end
        -- Trinkets
                    -- Draught of Souls
                    if isChecked("灵魂之引") then
                        if hasEquiped(140808) and canUse(140808) then
                            if not buff.metamorphosis.exists() and (not talent.firstBlood or cd.bladeDance > 3) and (not talent.nemesis or cd.nemesis > 30 or ttd("target") < cd.nemesis + 3) then
                                useItem(140808)
                            end
                        end
                    end
                    -- use_item,slot=trinket2,if=!buff.metamorphosis.up&(!talent.first_blood.enabled|!cooldown.blade_dance.ready)&(!talent.nemesis.enabled|cooldown.nemesis.remains>30|target.time_to_die<cooldown.nemesis.remains+3)
                    if isChecked("饰品") then
                        if not buff.metamorphosis.exists() and (not talent.firstBlood or cd.bladeDance ~= 0) and (not talent.nemesis or cd.nemesis > 30 or ttd(units.dyn5) < cd.nemesis + 3) then
                            if (getOptionValue("饰品") == 1 or getOptionValue("饰品") == 3) and canUse(13) then
                                useItem(13)
                            end
                            if (getOptionValue("饰品") == 2 or getOptionValue("饰品") == 3) and canUse(14) then
                                useItem(14)
                            end
                        end
                    end
        -- Potion
                    -- potion,name=old_war,if=buff.metamorphosis.remains>25|target.time_to_die<30
                    if isChecked("上古战神药水") and canUse(127844) and inRaid then
                        if buff.metamorphosis.remain() > 25 or ttd(units.dyn5) < 30 then
                            useItem(127844)
                        end
                    end
                end
                if getOptionValue("APL模式") == 2 then -- AMR

                end
            end -- End useCDs check
        end -- End Action List - Cooldowns
    -- Action List - Demonic
        local function actionList_Demonic()
        -- Pick Up Fragments
            -- pick_up_fragment,if=fury.deficit>=35&cooldown.eye_beam.remains>5
            if talent.demonicAppetite and powerDeficit >= 35 and cd.eyeBeam > 5 then
                ChatOverlay("Low Fury - Collect Fragments!")
            end
        -- Vengeful Retreat
            -- vengeful_retreat,if=(talent.prepared.enabled|talent.momentum.enabled)&buff.prepared.down&buff.momentum.down
            if isChecked("复仇回避") and (talent.prepared or talent.momentum) and not buff.prepared.exists() and not buff.momentum.exists() and getDistance(units.dyn5) < 5 then
                if cast.vengefulRetreat() then return end
            end
        -- Fel Rush
            -- fel_rush,if=(talent.momentum.enabled|talent.fel_mastery.enabled)&(!talent.momentum.enabled|(charges=2|cooldown.vengeful_retreat.remains>4)&buff.momentum.down)&(charges=2|(raid_event.movement.in>10&raid_event.adds.in>10))
            if getFacing("player","target",10)
                and (talent.momentum or talent.felMastery) and (not talent.momentum or ((charges.felRush > getOptionValue("保持邪能冲锋") or cd.vengefulRetreat > 4) 
                and not buff.momentum.exists()) and (charges.felRush > getOptionValue("保持邪能冲锋")))
            then
                if mode.mover == 1 and getDistance("target") < 8 then
                    cancelRushAnimation()
                elseif mode.mover == 2 or (getDistance("target") >= 8 and mode.mover ~= 3) then
                    if cast.felRush() then return end
                end
            end
        -- Throw Glaive
            -- throw_glaive,if=talent.bloodlet.enabled&(!talent.momentum.enabled|buff.momentum.up)&charges=2
            if isChecked("投掷利刃") and talent.bloodlet and (not talent.momentum or buff.momentum.exists()) and charges.throwGlaive == 2 then
                if cast.throwGlaive(units.dyn5) then return end
            end
        -- Death Sweep
            -- death_sweep,if=variable.blade_dance
            if buff.metamorphosis.exists() and bladeDanceVar then
                if cast.bladeDance() then return end
            end
        -- Fel Eruption
            if cast.felEruption() then return end
        -- Fury of the Illidari
            -- fury_of_the_illidari,if=(active_enemies>desired_targets|raid_event.adds.in>55)&(!talent.momentum.enabled|buff.momentum.up)
            if (getOptionValue("神器技能") == 1 or (getOptionValue("神器技能") == 2 and useCDs())) and getDistance("target") < 5 then
                if ((mode.rotation == 1 and #enemies.yards8 >= getOptionValue("AOE目标数量")) or mode.rotation == 2) --[[or addsIn > 55]] and (not talent.momentum or buff.momentum.exists()) 
                    and (not talent.chaosBlades or buff.chaosBlades or cd.chaosBlades > 30 or ttd(units.dyn5) < cd.chaosBlades)
                then
                    if cast.furyOfTheIllidari() then return end
                end
            end
        -- Blade Dance
            -- blade_dance,if=variable.blade_dance&cooldown.eye_beam.remains>5&!cooldown.metamorphosis.ready
            if not buff.metamorphosis.exists() and bladeDanceVar and (cd.eyeBeam > 5 or getOptionValue("眼棱用法") == 3 or (getOptionValue("眼棱用法") == 2 and enemies.yards8r < getOptionValue("AOE目标数量"))) 
                and (cd.metamorphosis ~= 0 or not isChecked("恶魔变形") or not useCDs() or not isBoss()) 
            then
                if cast.bladeDance() then return end
            end
        -- Throw Glaive
            -- throw_glaive,if=talent.bloodlet.enabled&spell_targets>=2&(!talent.master_of_the_glaive.enabled|!talent.momentum.enabled|buff.momentum.up)&(spell_targets>=3|raid_event.adds.in>recharge_time+cooldown)
            if --[[talent.bloodlet and ]]((mode.rotation == 1 and #enemies.yards10t >= 2) or mode.rotation == 2) and (not talent.masterOfTheGlaive or not talent.momentum or buff.momentum.exists()) then
                if cast.throwGlaive(units.dyn10t) then return end
            end
        -- Eye Beam
            -- eye_beam,if=spell_targets.eye_beam_tick>desired_targets|!buff.metamorphosis.extended_by_demonic
            if ((getOptionValue("眼棱用法") == 1 and enemies.yards8r > 0 and (((mode.rotation == 1 and enemies.yards8r >= getOptionValue("AOE目标数量")) or mode.rotation == 2) or not metaExtended))
                or (getOptionValue("眼棱用法") == 2 and ((mode.rotation == 1 and enemies.yards8r >= getOptionValue("AOE目标数量")) or (mode.rotation == 2 and enemies.yards8r > 0))))
                and not moving
            then
                if cast.eyeBeam(units.dyn5) then return end
            end
        -- Annihilation
            -- annihilation,if=(!talent.momentum.enabled|buff.momentum.up|fury.deficit<30+buff.prepared.up*8|buff.metamorphosis.remains<5)&!variable.pooling_for_blade_dance
            if buff.metamorphosis.exists() and (not talent.momentum or buff.momentum.exists() or buff.metamorphosis.remain() < 5 or power > 40) --(powerDeficit < 30 + (prepared * 8) + (artifact.rank.containedFury * 10))) 
                and not poolForBladeDance 
            then
                if cast.chaosStrike() then return end
            end
        -- Throw Glaive
            -- throw_glaive,if=talent.bloodlet.enabled&(!talent.master_of_the_glaive.enabled|!talent.momentum.enabled|buff.momentum.up)&raid_event.adds.in>recharge_time+cooldown
            if isChecked("投掷利刃") and talent.bloodlet and (not talent.masterOfTheGlaive or not talent.momentum or buff.momentum.exists()) then
                if cast.throwGlaive(units.dyn5) then return end
            end
        -- Chaos Strike
            -- chaos_strike,if=(!talent.momentum.enabled|buff.momentum.up|fury.deficit<30+buff.prepared.up*8)&!variable.pooling_for_chaos_strike&!variable.pooling_for_meta&!variable.pooling_for_blade_dance
            if not buff.metamorphosis.exists() and (not talent.momentum or buff.momentum.exists() or power > 40) --(powerDeficit < 30 + (prepared * 8) + (artifact.rank.containedFury * 10))) 
                and not poolForChaosStrike and not poolForMeta and not poolForBladeDance 
            then
                if cast.chaosStrike() then return end
            end
        -- Fel Rush
            -- fel_rush,if=!talent.momentum.enabled&buff.metamorphosis.down&(charges=2|(raid_event.movement.in>10&raid_event.adds.in>10))
            if getFacing("player","target",10) and not talent.momentum and not buff.metamorphosis.exists() and charges.felRush == 2 and getOptionValue("保持邪能冲锋") ~= 2 then
               if mode.mover == 1 and getDistance("target") < 8 then
                    cancelRushAnimation()
                elseif mode.mover == 2 or (getDistance("target") >= 8 and mode.mover ~= 3) then
                    if cast.felRush() then return end
                end
            end
        -- Demon's Bite
            -- demons_bite
            if cast.demonsBite() then return end
        -- Throw Glaive
            -- throw_glaive,if=buff.out_of_range.up
            if isChecked("投掷利刃") and getDistance(units.dyn5) > 8 then
                if cast.throwGlaive(units.dyn5) then return end
            end
        -- Fel Rush
            -- fel_rush,if=movement.distance>15|(buff.out_of_range.up&!talent.momentum.enabled)
            if mode.mover ~= 3 and charges.felRush > getOptionValue("保持邪能冲锋") and (getDistance("target") > 15 or (getDistance("target") > 8 and not talent.momentum)) then
                if cast.felRush() then return end
            end
        -- -- Vengeful Retreat
        --     -- vengeful_retreat,if=movement.distance>15
        --     if mode.mover ~= 3 and not getFacing("player","target",170) and getDistance("target") > 15 then
        --         if cast.vengefulRetreat() then return end
        --     end
        end -- End Action List - Demonic
    -- Action List - Normal
        local function actionList_Normal()
        -- Pick Up Fragments
            -- pick_up_fragment,if=talent.demonic_appetite.enabled&fury.deficit>=35
            if talent.demonicAppetite and powerDeficit >= 35 then
                ChatOverlay("Low Fury - Collect Fragments!")
            end
        -- Vengeful Retreat
            -- vengeful_retreat,if=(talent.prepared.enabled|talent.momentum.enabled)&buff.prepared.down&buff.momentum.down
            if isChecked("复仇回避") and (talent.prepared or talent.momentum) and not buff.prepared.exists() and not buff.momentum.exists() and getDistance(units.dyn5) < 5 then
                if cast.vengefulRetreat() then return end
            end
        -- Fel Rush
            -- fel_rush,if=(talent.momentum.enabled|talent.fel_mastery.enabled)&(!talent.momentum.enabled|(charges=2|cooldown.vengeful_retreat.remains>4)&buff.momentum.down)&(!talent.fel_mastery.enabled|fury.deficit>=25)&(charges=2|(raid_event.movement.in>10&raid_event.adds.in>10))
            if getFacing("player","target",10)
                and (talent.momentum or talent.felMastery) and (not talent.momentum or ((charges.felRush > getOptionValue("保持邪能冲锋") or cd.vengefulRetreat > 4) 
                and not buff.momentum.exists()) and (not talent.felMastery or powerDeficit >= 25) and (charges.felRush > getOptionValue("保持邪能冲锋")))
            then
                if mode.mover == 1 and getDistance("target") < 8 then
                    cancelRushAnimation()
                elseif mode.mover == 2 or (getDistance("target") >= 8 and mode.mover ~= 3) then
                    if cast.felRush() then return end
                end
            end
        -- Fel Barrage
            -- fel_barrage,if=charges>=5&(buff.momentum.up|!talent.momentum.enabled)&(active_enemies>desired_targets|raid_event.adds.in>30)
            if charges.felBarrage >= 5 and (buff.momentum.exists() or not talent.momentum) and (((mode.rotation == 1 and #enemies.yards8 >= getOptionValue("AOE目标数量")) or mode.rotation == 2)) then
                if cast.felBarrage() then return end
            end
        -- Throw Glaive
            -- throw_glaive,if=talent.bloodlet.enabled&(!talent.momentum.enabled|buff.momentum.up)&charges=2
            if isChecked("投掷利刃") and talent.bloodlet and (not talent.momentum or buff.momentum.exists()) and charges.throwGlaive == 2 then
                if cast.throwGlaive() then return end
            end
        -- Felblade
            -- felblade,if=fury<15&(cooldown.death_sweep.remains<2*gcd|cooldown.blade_dance.remains<2*gcd)
            if power < 15 and (cd.deathSweep < 2 * gcd or cd.bladeDance < 2 * gcd) then
                if cast.felblade() then return end
            end
        -- Death Sweep
            -- death_sweep,if=variable.blade_dance
            if buff.metamorphosis.exists() and bladeDanceVar then
                if cast.bladeDance() then return end
            end
        -- Fel Rush
            -- fel_rush,if=charges=2&!talent.momentum.enabled&!talent.fel_mastery.enabled
            if getFacing("player","target",10) and getOptionValue("保持邪能冲锋") ~= 2 and charges == 2 and not talent.momentum and not talent.felMastery then
                if mode.mover == 1 and getDistance("target") < 8 then
                    cancelRushAnimation()
                elseif mode.mover == 2 or (getDistance("target") >= 8 and mode.mover ~= 3) then
                    if cast.felRush() then return end
                end
            end
        -- Fel Eruption
            -- fel_eruption
            if cast.felEruption() then return end
        -- Fury of the Illidari
            -- fury_of_the_illidari,if=(active_enemies>desired_targets|raid_event.adds.in>55)&(!talent.momentum.enabled|buff.momentum.up)&(!talent.chaos_blades.enabled|buff.chaos_blades.up|cooldown.chaos_blades.remains>30|target.time_to_die<cooldown.chaos_blades.remains)
            if (getOptionValue("神器技能") == 1 or (getOptionValue("神器技能") == 2 and useCDs())) and getDistance("target") < 5 then
                if ((mode.rotation == 1 and #enemies.yards8 >= getOptionValue("AOE目标数量")) or mode.rotation == 2) and (not talent.momentum or buff.momentum.exists()) 
                    and (not talent.chaosBlades or buff.chaosBlades.exists() or cd.chaosBlades > 30 or ttd(units.dyn5) < cd.chaosBlades)
                then
                    if cast.furyOfTheIllidari() then return end
                end
            end
        -- Blade Dance
            -- blade_dance,if=variable.blade_dance&(!cooldown.metamorphosis.ready)
            if not buff.metamorphosis.exists() and bladeDanceVar and (cd.metamorphosis ~= 0 or not isChecked("恶魔变形") or not useCDs() or not isBoss()) then
                if cast.bladeDance() then return end
            end
        -- Throw Glaive
            -- throw_glaive,if=talent.bloodlet.enabled&spell_targets>=2&(!talent.master_of_the_glaive.enabled|!talent.momentum.enabled|buff.momentum.up)&(spell_targets>=3|raid_event.adds.in>recharge_time+cooldown)
            if isChecked("投掷利刃") and talent.bloodlet and ((mode.rotation == 1 and #enemies.yards10t >= 2) or mode.rotation == 2) and (not talent.masterOfTheGlaive or not talent.momentum or buff.momentum.exists()) then
                if cast.throwGlaive(units.dyn10t) then return end
            end
        -- Felblade
            -- felblade,if=fury.deficit>=30+buff.prepared.up*8
            if powerDeficit >= 30 + prepared * 8 then
                if cast.felblade() then return end
            end
        -- Eye Beam
            -- eye_beam,if=talent.blind_fury.enabled&(spell_targets.eye_beam_tick>desired_targets|fury.deficit>=35)
            if ((getOptionValue("眼棱用法") == 1 and talent.blindFury and enemies.yards8r > 0 
                and (((mode.rotation == 1 and enemies.yards8r >= getOptionValue("AOE目标数量")) or mode.rotation == 2) or powerDeficit >= 35)) 
                or (getOptionValue("眼棱用法") == 2 and ((mode.rotation == 1 and enemies.yards8r >= getOptionValue("AOE目标数量")) or (mode.rotation == 2 and enemies.yards8r > 0))))
                and not moving
            then
                if cast.eyeBeam() then return end
            end
        -- Annihilation
            -- annihilation,if=(talent.demon_blades.enabled|!talent.momentum.enabled|buff.momentum.up|fury.deficit<30+buff.prepared.up*8|buff.metamorphosis.remains<5)&!variable.pooling_for_blade_dance
            if buff.metamorphosis.exists() and (talent.demonBlades or not talent.momentum or buff.momentum.exists or (powerDeficit < 30 + perpared * 8) or buff.metamorphosis.remain() < 5) and not poolForBladeDance then
                if cast.chaosStrike() then return end
            end
        -- Throw Glaive
            -- throw_glaive,if=talent.bloodlet.enabled&(!talent.master_of_the_glaive.enabled|!talent.momentum.enabled|buff.momentum.up)&raid_event.adds.in>recharge_time+cooldown
            if isChecked("投掷利刃") and talent.bloodlet and (not talent.masterOfTheGlaive or not talent.momentum or buff.momentum.exists()) then
                if cast.throwGlaive() then return end
            end
        -- Eye Beam
            -- eye_beam,if=!talent.blind_fury.enabled&(spell_targets.eye_beam_tick>desired_targets|(!set_bonus.tier19_4pc&raid_event.adds.in>45&!variable.pooling_for_meta&buff.metamorphosis.down&(artifact.anguish_of_the_deceiver.enabled|active_enemies>1)&!talent.chaos_cleave.enabled)) 
            if ((getOptionValue("眼棱用法") == 1 and not talent.blindFury and enemies.yards8r > 0 and ((mode.rotation == 1 and (enemies.yards8r >= getOptionValue("AOE目标数量")) or mode.rotation == 2)
                or (not tier19_4pc and not poolForMeta and not buff.metamorphosis.exists() and (artifact.anguishOfTheDeceiver or enemies.yards8r > 1) 
                    and not talent.chaosCleave)))
                or (getOptionValue("眼棱用法") == 2 and ((mode.rotation == 1 and enemies.yards8r >= getOptionValue("AOE目标数量")) or (mode.rotation == 2 and enemies.yards8r > 0))))
                and not moving
            then 
                if cast.eyeBeam() then return end
            end
        -- Throw Glaive
            -- throw_glaive,if=buff.metamorphosis.down&spell_targets>=2
            if isChecked("投掷利刃") and not buff.metamorphosis.exists() and ((mode.rotation == 1 and #enemies.yards10t >= 2) or mode.rotation == 2) then
                if cast.throwGlaive(units.dyn10t) then return end
            end
        -- Chaos Strike
            -- chaos_strike,if=(talent.demon_blades.enabled|!talent.momentum.enabled|buff.momentum.up|fury.deficit<30+buff.prepared.up*8)&!variable.pooling_for_chaos_strike&!variable.pooling_for_meta&!variable.pooling_for_blade_dance
            if not buff.metamorphosis.exists() and (talent.demonBlades or not talent.momentum or buff.momentum.exists() or powerDeficit < 30 + prepared * 8) 
                and not poolForChaosStrike and not poolForMeta and not poolForBladeDance 
            then
                if cast.chaosStrike() then return end
            end
        -- Fel Barrage
            -- fel_barrage,if=charges=4&buff.metamorphosis.down&(buff.momentum.up|!talent.momentum.enabled)&(active_enemies>desired_targets|raid_event.adds.in>30)
            if charges.felBarrage == 4 and not buff.metamorphosis.exists() and (buff.momentum.exists() or not talent.momentum) 
                and ((mode.rotation == 1 and #enemies.yards8 >= getOptionValue("AOE目标数量")) or mode.rotation ==2)
            then
                if cast.felBarrage() then return end
            end
        -- Fel Rush
            -- fel_rush,if=!talent.momentum.enabled&raid_event.movement.in>charges*10&(talent.demon_blades.enabled|buff.metamorphosis.down)
            if getFacing("player","target",10) and not talent.momentum and (talent.demonBlades or not buff.metamorphosis.exists()) then
                if mode.mover == 1 and getDistance("target") < 8 then
                    cancelRushAnimation()
                elseif mode.mover == 2 or (getDistance("target") >= 8 and mode.mover ~= 3) then
                    if cast.felRush() then return end
                end
            end
        -- Demon's Bite
            -- demons_bite
            if cast.demonsBite() then return end
        -- Throw Glaive
            -- throw_glaive,if=buff.out_of_range.up
            if isChecked("投掷利刃") and getDistance(units.dyn5) > 8 then
                if cast.throwGlaive(units.dyn5) then return end
            end
        -- Felblade
            -- felblade,if=movement.distance|buff.out_of_range.up
            if getDistance("target") > 8 then
                if cast.felblade("target") then return end
            end
        -- Fel Rush
            -- fel_rush,if=movement.distance>15|(buff.out_of_range.up&!talent.momentum.enabled)
            if mode.mover ~= 3 and charges.felRush > getOptionValue("保持邪能冲锋") and (getDistance("target") > 15 or (getDistance("target") > 8 and not talent.momentum)) then
                if cast.felRush() then return end
            end
        -- -- Vengeful Retreat
        --     -- vengeful_retreat,if=movement.distance>15
        --     if isChecked("复仇回避") and mode.mover ~= 3 and not getFacing("player","target",170) and getDistance("target") > 15 then
        --         if cast.vengefulRetreat() then return end
        --     end
        -- Throw Glaive
            -- throw_glaive,if=!talent.bloodlet.enabled
            if isChecked("投掷利刃") and not talent.bloodlet and ((talent.demonBlades and swingTimer > 0) or power < 20) then
                if cast.throwGlaive("target") then return end
            end
        end -- End Action List - Normal
    -- Action List - PreCombat
        local function actionList_PreCombat()
            if not inCombat and not (IsFlying() or IsMounted()) then
            -- Flask / Crystal
                -- flask,type=flask_of_the_seventh_demon
                if isChecked("奥拉留斯的低语水晶") then
                    if inRaid and canFlask and flaskBuff==0 and not UnitBuffID("player",188033) and not UnitBuffID("player",156064) then
                        useItem(br.player.flask.wod.agilityBig)
                        return true
                    end
                    if flaskBuff==0 then
                        if not UnitBuffID("player",188033) and not UnitBuffID("player",156064) and canUse(118922) then --Draenor Insanity Crystal
                            useItem(118922)
                            return true
                        end
                        if not UnitBuffID("player",193456) and not UnitBuffID("player",188033) and not UnitBuffID("player",156064) and canUse(129192) then -- Gaze of the Legion
                            useItem(129192)
                            return true
                        end
                    end
                end
                if isChecked("Pre-Pull Timer") and pullTimer <= getOptionValue("Pre-Pull Timer") then

                end -- End Pre-Pull
            -- Start Attack
                -- auto_attack
                if isValidUnit("target") and getDistance("target") < 5 then
                    StartAttack()
                end
            end -- End No Combat
        end -- End Action List - PreCombat
---------------------
--- Begin Profile ---
---------------------
    -- Profile Stop | Pause
        if not inCombat and not IsMounted() and not hastar and profileStop==true then
            profileStop = false
        elseif (inCombat and profileStop==true) or (IsMounted() or IsFlying()) or pause() or mode.rotation==4 or isCastingSpell(spell.eyeBeam) == true then
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
            -- print(tostring(isCastingSpell(spell.eyeBeam)))
            if inCombat and not IsMounted() and profileStop==false and isValidUnit(units.dyn5) then
    ------------------------------
    --- In Combat - Interrupts ---
    ------------------------------
                if actionList_Interrupts() then return end
    ---------------------------
    --- SimulationCraft APL ---
    ---------------------------
                if getOptionValue("APL模式") == 1 then
            -- Start Attack
                    if getDistance(units.dyn5) < 5 then
                        StartAttack()
                    end
            -- Cooldowns
                    -- call_action_list,name=cooldown,if=gcd.remains=0
                    if cd.global == 0 then
                        if actionList_Cooldowns() then return end
                    end
            -- Call Action List - Demonic
                    -- run_action_list,name=demonic,if=talent.demonic.enabled&talent.demonic_appetite.enabled&talent.blind_fury.enabled
                    if talent.demonic and talent.blindFury then
                        if actionList_Demonic() then return end
                    else
            -- Call Action List - Normal
                        -- run_action_list,name=normal
                        if actionList_Normal() then return end
                    end
                end -- End SimC APL
    ----------------------
    --- AskMrRobot APL ---
    ----------------------
                if getOptionValue("APL模式") == 2 then
            -- Vengeful Retreat
                    -- if HasTalent(Prepared) or HasTalent(Momentum) and not HasBuff(Momentum)
                    if isChecked("复仇回避") and castable.vengefulRetreat and (talent.prepared or talent.momentum) and not buff.momentum.exists() and getDistance(units.dyn5) < 5 then
                        if cast.vengefulRetreat() then return end
                    end
            -- Fel Rush
                    -- if HasTalent(Momentum) and not HasBuff(Momentum) and CooldownSecRemaining(VengefulRetreat) > BuffDurationSec(Momentum)
                    if castable.felRush and talent.momentum and not buff.momentum.exists() and cd.vengefulRetreat > buff.momentum.duration() then
                        if mode.mover == 1 and getDistance("target") < 5 then
                            cancelRushAnimation()
                        elseif mode.mover == 2 or (getDistance("target") >= 5 and mode.mover ~= 3) then
                            cast.felRush()
                        end
                    end
            -- Fury of the Illidari
                    if (getOptionValue("神器技能") == 1 or (getOptionValue("神器技能") == 2 and useCDs())) and castable.furyOfTheIllidari and getDistance("target") < 5 then
                        cast.furyOfTheIllidari()
                    end
            -- Begin AoE Rotation
                    if ((mode.rotation == 1 and #enemies.yards8 > 1) or mode.rotation == 2) then
            -- Death Sweep
                        if castable.deathSweep and buff.metamorphosis.exists() then
                            cast.bladeDance()
                        end
            -- Fel Barrage
                        -- if ChargesRemaining(FelBarrage) = SpellCharges(FelBarrage)
                        if castable.felBarrage and charges.felBarrage == 5 then
                            cast.felBarrage()
                        end
            -- Eye Beam
                        if castable.eyeBeam and (((mode.rotation == 1 and enemies.yards8r >= getOptionValue("眼棱目标") and getOptionValue("眼棱用法") == 1) or mode.rotation == 2) and getOptionValue("眼棱用法") ~= 3) then
                            cast.eyeBeam()
                        end
            -- Fel Rush
                        if castable.felRush then
                            cast.felRush()
                        end
            -- Blade Dance
                        -- if CooldownSecRemaining(EyeBeam) > 0
                        if castable.bladeDance and not buff.metamorphosis.exists() and cd.eyeBeam > 0 then
                            cast.bladeDance()
                        end
            -- Throw Glaive
                        if isChecked("投掷利刃") and castable.throwGlaive then
                            cast.throwGlaive()
                        end 
            -- Annihilation
                        -- if HasTalent(ChaosCleave)
                        if castable.annihilation and talent.chaosCleave then
                            cast.chaosStrike()
                        end
            -- Chaos Strike
                        -- if HasTalent(ChaosCleave)
                        if castable.chaosStrike and talent.chaosCleave then
                            cast.chaosStrike()
                        end
            -- Chaos Nova
                        -- if CooldownSecRemaining(EyeBeam) > 0 or HasTalent(UnleashedPower)
                        if castable.chaosNova and (cd.eyeBeam > 0 or talent.unleashedPower) then
                            cast.chaosNova()
                        end
                    end
            -- Begin Single Rotation
            -- Fel Eruption
                    if castable.felEruption then
                        cast.felEruption()
                    end
            -- Death Sweep
                    -- if HasTalent(FirstBlood) 
                    if castable.deathSweep and talent.firstBlood and buff.metamorphosis.exists() then
                        cast.bladeDance()
                    end
            -- Annihilation
                    -- if not HasTalent(Momentum) or (HasBuff(Momentum) or PowerToMax <= 30 + TimerSecRemaining(PreparedTimer) * 8)
                    if castable.annihilation and (not talent.momentum or (buff.momentum.exists() or ttm <= 30 + buff.prepared.remain() * 8)) then
                        cast.chaosStrike()
                    end
            -- Fel Barrage
                    -- if ChargesRemaining(FelBarrage) = SpellCharges(FelBarrage) and (not HasTalent(Momentum) or HasBuff(Momentum))
                    if ((mode.rotation == 1 and #enemies.yards8 >= 2) or mode.rotation == 2) and castable.felBarrage and charges.felBarrage == 5 and (not talent.momentum or buff.momentum.exists()) then
                        cast.felBarrage()
                    end
            -- Throw Glaive
                    -- if HasTalent(Bloodlet)
                    if isChecked("投掷利刃") and castable.throwGlaive and talent.bloodlet then
                        cast.throwGlaive()
                    end
            -- Eye Beam
                    -- if not HasBuff(Metamorphosis) and (not HasTalent(Momentum) or HasBuff(Momentum))
                    if (((mode.rotation == 1 and enemies.yards8r >= getOptionValue("眼棱目标") and getOptionValue("眼棱用法") == 1) or mode.rotation == 2) and getOptionValue("眼棱用法") ~= 3) 
                        and castable.eyeBeam and not buff.metamorphosis.exists() and (not talent.momentum or buff.momentum.exists()) 
                    then
                        cast.eyeBeam()
                    end
            -- Blade Dance
                    -- if CooldownSecRemaining(EyeBeam) > 0 and HasTalent(FirstBlood)
                    if castable.bladeDance and cd.eyeBeam > 0 and talent.firstBlood then
                        cast.bladeDance()
                    end
            -- Chaos Strike
                    -- if CooldownSecRemaining(EyeBeam) > 0 or (HasBuff(Momentum) or PowerToMax <= 30 + TimerSecRemaining(PreparedTimer) * 8)
                    if castable.chaosStrike and (cd.eyeBeam > 0 or (buff.momentum.exists() or ttm <= 30 + buff.prepared.remain() * 8)) then
                        cast.chaosStrike()
                    end
            -- Felblade
                    if castable.felBlade then
                        cast.felblade()
                    end
            -- Fel Rush
                    -- if not HasTalent(Momentum)
                    if castable.felRush and not talent.momentum then
                        if mode.mover == 1 and getDistance("target") < 5 then
                            cancelRushAnimation()
                        elseif mode.mover == 2 or (getDistance("target") >= 5 and mode.mover ~= 3) then
                            cast.felRush()
                        end
                    end
            -- Demon's Bite
                    if castable.demonsBite then
                        cast.demonsBite()
                    end
            -- Throw Glaive
                    if isChecked("投掷利刃") and castable.throwGlaive then
                        cast.throwGlaive()
                    end    
                end
    -------------------
    --- WoWHead APL ---
    -------------------
                if getOptionValue("APL模式") == 3 then
            -- Fel Rush
                    if charges.felRush > getOptionValue("保持邪能冲锋") and (not talent.felMastery or (talent.felMastery and powerDeficit > 30)) 
                        and (not talent.momentum or (talent.momentum and not buff.momentum.exists())) 
                    then
                        if mode.mover == 1 and getDistance("target") < 5 then
                            cancelRushAnimation()
                        elseif mode.mover == 2 or (getDistance("target") >= 5 and mode.mover ~= 3) then
                            if cast.felRush() then return end
                        end
                    end
            -- Vengeful Retreat
                    if isChecked("复仇回避") and (talent.prepared or (talent.momentum and not buff.momentum.exists())) and getDistance(units.dyn5) < 5 then
                         if cast.vengefulRetreat() then return end
                    end
            -- Fel Barrage
                    if charges.felBarrage >= 5 and (not talent.momentum or (talent.momentum and not buff.momentum.exists())) then
                        if cast.felBarrage() then return end
                    end
            -- Throw Glaive
                    if isChecked("投掷利刃") and talent.bloodlet and talent.masterOfTheGlaive and (not talent.momentum or (talent.momentum and not buff.momentum.exists())) then
                        if cast.throwGlaive() then return end
                    end
            -- Fel Eruption
                    if cast.felEruption() then return end
            -- Fury of the Illidari
                    if (getOptionValue("神器技能") == 1 or (getOptionValue("神器技能") == 2 and useCDs())) and getDistance("target") < 5 then
                        if not talent.momentum or (talent.momentum and buff.momentum.exists()) then
                            if cast.furyOfTheIllidari() then return end
                        end
                    end
            -- Eye Beam
                    if talent.demonic --and getDistance(units.dyn8) < 8 and getFacing("player",units.dyn5,45) 
                        and (((mode.rotation == 1 and enemies.yards8r >= getOptionValue("眼棱目标") and getOptionValue("眼棱用法") == 1) or mode.rotation == 2) and getOptionValue("眼棱用法") ~= 3)
                    then
                        if cast.eyeBeam() then return end
                    end
            -- Blade Dance / Death Sweep
                    if talent.firstBlood or (mode.rotation == 1 and #enemies.yards8 >= 3 + chaleave) or mode.rotation == 2 then
                        if buff.metamorphosis.exists() then
                            if cast.bladeDance() then return end
                        else
                            if cast.bladeDance() then return end
                        end
                    end
            -- Throw Glaive
                    if isChecked("投掷利刃") and talent.bloodlet and ((mode.rotation == 1 and #enemies.yards8 >= 2) or mode.rotation == 2) and (not talent.momentum or (talent.momentum and buff.momentum.exists())) then
                        if cast.throwGlaive() then return end
                    end
            -- Felblade
                    if powerDeficit > 30 then
                        if cast.felblade() then return end
                    end
            -- Annihilation
                    if buff.metamorphosis.exists() and (powerDeficit < 40 or (talent.momentum and buff.momentum.exists())) then
                        -- print("Trying to Annihilate")
                        if cast.chaosStrike() then return end
                    end
            -- Throw Glaive
                    if isChecked("投掷利刃") and talent.bloodlet and (not talent.momentum or (talent.momentum and buff.momentum.exists())) then
                        if cast.throwGlaive() then return end
                    end
            -- Eye Beam
                    if not buff.metamorphosis.exists() and not talent.blindFury and not talent.chaosCleave and not talent.demonic 
                        and (((mode.rotation == 1 and enemies.yards8r >= getOptionValue("眼棱目标") and artifact.anguishOfTheDeceiver and getOptionValue("眼棱用法") == 1) or mode.rotation == 2) 
                        and getOptionValue("眼棱用法") ~= 3) 
                    then
                        if cast.eyeBeam() then return end
                    end
            -- Throw Glaive
                    if isChecked("投掷利刃") and not buff.metamorphosis.exists() and ((mode.rotation == 1 and #enemies.yards8 >= 2) or mode.rotation == 2) then
                        if cast.throwGlaive() then return end
                    end
            -- Chaos Strike
                    if not buff.metamorphosis.exists() and (powerDeficit < 40 or (talent.momentum and buff.momentum.exists())) then
                        if cast.chaosStrike() then return end
                    end
            -- Fel Barrage
                    if charges.felBarrage >= 4 and (not talent.momentum or (talent.momentum and not buff.momentum.exists())) then
                        if cast.felBarrage() then return end
                    end
            -- Demon's Bite
                    if powerDeficit >= 40 then
                        if cast.demonsBite() then return end
                    end
            -- Throw Glaive
                    if isChecked("投掷利刃") and not talent.bloodlet and talent.demonBlades then
                        if cast.throwGlaive() then return end
                    end
                end
			end --End In Combat
		end --End Rotation Logic
    end -- End Timer
end -- End runRotation
local id = 577
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})
