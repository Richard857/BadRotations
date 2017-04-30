local rotationName = "CuteOne"

---------------
--- Toggles ---
---------------
local function createToggles()
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "基于范围内的目标数,在单目标和多目标自动切换输出方式.", highlight = 1, icon = br.player.spell.soulCleave},
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "使用多目标方式输出.", highlight = 0, icon = br.player.spell.soulCleave},
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "使用单目标方式输出.", highlight = 0, icon = br.player.spell.shear},
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "禁用DPS输出", highlight = 0, icon = br.player.spell.spectralSight}
    };
    CreateButton("Rotation",1,0)
-- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "自动使用大技能 - 只在BOSS.", highlight = 1, icon = br.player.spell.metamorphosis},
        [2] = { mode = "On", value = 1 , overlay = "Cooldowns Enabled", tip = "不管任何目标都使用大技能.", highlight = 0, icon = br.player.spell.metamorphosis},
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "不使用大技能.", highlight = 0, icon = br.player.spell.metamorphosis}
    };
   	CreateButton("Cooldown",2,0)
-- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "使用保命技能.", highlight = 1, icon = br.player.spell.demonSpikes},
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "不使用保命技能.", highlight = 0, icon = br.player.spell.demonSpikes}
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
        [1] = { mode = "On", value = 2 , overlay = "Auto Movement Enabled", tip = "启用地狱火撞击.", highlight = 1, icon = br.player.spell.infernalStrike},
        [2] = { mode = "Off", value = 1 , overlay = "Auto Movement Disabled", tip = "禁用地狱火撞击", highlight = 0, icon = br.player.spell.infernalStrike}
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
            br.ui:createDropdownWithout(section, "APL模式", {"|cffFFFFFFSimC"}, 1, "|cffFFFFFF选择输出循环.")
        -- Dummy DPS Test
            br.ui:createSpinner(section, "DPS测试",  5,  5,  60,  5,  "|cffFFFFFF设置为所需的测试的时间（分钟）. 最小: 5 / 最大: 60 / 间隔: 5")
        -- Pre-Pull Timer
            br.ui:createSpinner(section, "Pre-Pull Timer",  5,  1,  10,  1,  "|cffFFFFFF设置为所需的启动时间 Pre-Pull (必须有DBM). 最小: 1 / 最大: 10 / 间隔: 1")
        -- Fiery Brand
            br.ui:createCheckbox(section,"烈火烙印")
        -- Immolation Aura
            br.ui:createCheckbox(section,"献祭光环")
        -- Sigil of Flames
            br.ui:createCheckbox(section,"烈焰咒符")
        -- Torment
            br.ui:createCheckbox(section,"折磨")
        br.ui:checkSectionState(section)
    -- Cooldown Options
        section = br.ui:createSection(br.ui.window.profile, "冷却技能")
        -- Agi Pot
            br.ui:createCheckbox(section,"爆发药水")
        -- Flask / Crystal
            br.ui:createCheckbox(section,"奥拉留斯的低语水晶")
        -- Legendary Ring
            br.ui:createCheckbox(section,"传奇戒指")
        -- Racial
            br.ui:createCheckbox(section,"种族技能")
        -- Trinkets
            br.ui:createSpinner(section, "饰品 血量",  70,  0,  100,  5,  "多少血量百分比使用")		
            br.ui:createDropdownWithout(section, "饰品", {"|cff00FF00只用第一个","|cff00FF00只用第二个","|cffFFFF00两个都用","|cffFF0000不用"}, 1, "|cffFFFFFF选择饰品使用.")		
        br.ui:checkSectionState(section)
    -- Defensive Options
        section = br.ui:createSection(br.ui.window.profile, "保命")
        -- Healthstone
            br.ui:createSpinner(section, "药水/治疗石",  60,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用")
        -- Heirloom Neck
            br.ui:createSpinner(section, "传家宝项链",  60,  0,  100,  5,  "|cffFFBB00多少血量百分比使用.");
        -- Demon Spikes
            br.ui:createSpinner(section, "恶魔尖刺",  50,  0,  100,  5,  "|cffFFBB00多少血量百分比使用.");
            br.ui:createSpinnerWithout(section, "保留恶魔尖刺次数", 1, 0, 2, 1, "|cffFFBB00使用脚本保留恶魔尖刺的次数.");
        -- Empower Wards
            br.ui:createCheckbox(section, "强化结界")
        -- Fel Devastation
            br.ui:createSpinner(section, "邪能毁灭",  50,  0,  100,  5,  "|cffFFBB00多少血量百分比使用.");
        -- Metamorphosis
            br.ui:createSpinner(section, "恶魔变形",  50,  0,  100,  5,  "|cffFFBB00多少血量百分比使用.");
        -- Sigil of Misery
            br.ui:createSpinner(section, "悲苦咒符 - HP",  50,  0,  100,  5,  "|cffFFBB00多少血量百分比使用.");
            br.ui:createSpinner(section, "悲苦咒符 - AoE", 3, 0, 10, 1, "|cffFFFFFF多少敌人在8码内使用")
        -- Soul Barrier
            br.ui:createSpinner(section, "恶魔灌注",  50,  0,  100,  5,  "|cffFFBB00多少血量百分比使用.");
        -- Soul Cleave
            br.ui:createSpinner(section, "灵魂劈裂",  50,  0,  100,  5,  "|cffFFBB00多少血量百分比使用.");
        br.ui:checkSectionState(section)
    -- Interrupt Options
        section = br.ui:createSection(br.ui.window.profile, "打断")
        -- Consume Magic
            br.ui:createCheckbox(section, "吞噬魔法")
        -- Sigil of Silence
            br.ui:createCheckbox(section, "沉默咒符")
        -- Sigil of Misery
            br.ui:createCheckbox(section, "悲苦咒符")
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
    if br.timer:useTimer("debugVengeance", math.random(0.15,0.3)) then
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
        local pain                                          = br.player.power.amount.pain
        local perk                                          = br.player.perk
        local php                                           = br.player.health
        local playerMouse                                   = UnitIsPlayer("mouseover")
        local power, powmax, powgen, powerDeficit           = br.player.power.amount.pain, br.player.power.pain.max, br.player.power.regen, br.player.power.pain.deficit
        local pullTimer                                     = br.DBM:getPulltimer()
        local racial                                        = br.player.getRacial()
        local recharge                                      = br.player.recharge
        local solo                                          = br.player.instance=="none"
        local spell                                         = br.player.spell
        local talent                                        = br.player.talent
        local ttd                                           = getTTD
        local ttm                                           = br.player.power.ttm
        local units                                         = units or {}

        units.dyn5 = br.player.units(5)
        units.dyn8AoE = br.player.units(8,true)
        units.dyn20 = br.player.units(20)
        enemies.yards8 = br.player.enemies(8)
        enemies.yards30 = br.player.enemies(30)


   		if leftCombat == nil then leftCombat = GetTime() end
		if profileStop == nil then profileStop = false end
        if talent.chaosCleave then chaleave = 1 else chaleave = 0 end
        if talent.prepared then prepared = 1 else prepared = 0 end
        if lastSpell == spell.vengefulRetreat then vaulted = true else vaulted = false end
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
        -- Torment
            if isChecked("折磨") then
                for i = 1, #enemies.yards30 do
                    local thisUnit = enemies.yards30[i]
                    if not isAggroed(thisUnit) and hasThreat(thisUnit) then
                        if cast.torment(thisUnit) then return end
                    end
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
        -- Demon Spikes
                if isChecked("恶魔尖刺") and php <= getOptionValue("恶魔尖刺") and charges.demonSpikes > getOptionValue("保留恶魔尖刺次数") and inCombat then
                    if cast.demonSpikes() then return end
                end
        -- Sigil of Misery
                if isChecked("悲苦咒符 - HP") and php <= getOptionValue("悲苦咒符 - HP") and inCombat and #enemies.yards8 > 0 then
                    if cast.sigilOfMisery("player","ground") then return end
                end
                if isChecked("悲苦咒符 - AoE") and #enemies.yards8 >= getOptionValue("悲苦咒符 - AoE") and inCombat then
                    if cast.sigilOfMisery("best",false,getOptionValue("悲苦咒符 - AoE"),8) then return end
                end
    		end -- End Defensive Toggle
		end -- End Action List - Defensive
	-- Action List - Interrupts
		local function actionList_Interrupts()
			if useInterrupts() then
                for i=1, #enemies.yards30 do
                    thisUnit = enemies.yards30[i]
                    if canInterrupt(thisUnit,getOptionValue("打断")) then
        -- Consume Magic
                        if isChecked("吞噬魔法") and getDistance(thisUnit) < 20 then
                            if cast.consumeMagic(thisUnit) then return end
                        end
        -- Sigil of Silence
                        if isChecked("沉默咒符") and cd.consumeMagic > 0 then
                            if cast.sigilOfSilence(thisUnit,"ground") then return end
                        end
        -- Sigil of Misery
                        if isChecked("悲苦咒符") and cd.consumeMagic > 0 and cd.sigilOfSilence > 0 and cd.sigilOfSilence < 45 then
                            if cast.sigilOfMisery(thisUnit,"ground") then return end
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
            end -- End useCDs check
        end -- End Action List - Cooldowns
    -- Action List - PreCombat
        local function actionList_PreCombat()
            if not inCombat and not (IsFlying() or IsMounted()) then
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
                        if not UnitBuffID("player",193456) and not UnitBuffID("player",188033) and canUse(129192) then -- Gaze of the Legion
                            useItem(129192)
                            return true
                        end
                    end
                end
                if isChecked("Pre-Pull Timer") and pullTimer <= getOptionValue("Pre-Pull Timer") then

                end -- End Pre-Pull
                if GetObjectExists("target") and not UnitIsDeadOrGhost("target") and UnitCanAttack("target", "player") and getDistance("target") < 5 then
            -- Start Attack
                    StartAttack()
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
            if inCombat and profileStop==false and isValidUnit(units.dyn5) and not (IsMounted() or IsFlying()) then
    ------------------------------
    --- In Combat - Interrupts ---
    ------------------------------
                if actionList_Interrupts() then return end
    ---------------------------
    --- SimulationCraft APL ---
    ---------------------------
    -- Start Attack
                -- actions=auto_attack
                if getDistance(units.dyn5) < 5 then
                    StartAttack()
                end
    -- Soul Carver
                if cast.soulCarver() then return end
    -- Fiery Brand
                -- actions+=/fiery_brand,if=buff.demon_spikes.down&buff.metamorphosis.down
                if isChecked("烈火烙印") then
                    if not buff.demonSpikes.exists() and not buff.metamorphosis.exists() then
                        if cast.fieryBrand() then return end
                    end
                end
    -- Demon Spikes
                -- actions+=/demon_spikes,if=charges=2|buff.demon_spikes.down&!dot.fiery_brand.ticking&buff.metamorphosis.down
                if isChecked("恶魔尖刺") and charges.demonSpikes > getOptionValue("保留恶魔尖刺次数") then
                    if (charges.demonSpikes == 2 or not buff.demonSpikes.exists()) and not debuff.fieryBrand.exists(units.dyn5) and not buff.metamorphosis.exists() then
                        if cast.demonSpikes() then return end
                    end
                end
    -- Empower Wards
                -- actions+=/empower_wards,if=debuff.casting.up
                if useDefensive() and isChecked("强化结界") then
                    for i=1, #enemies.yards30 do
                        thisUnit = enemies.yards30[i]
                        if cd.consumeMagic > 0 and castingUnit(thisUnit) then
                            if cast.empowerWards() then return end
                        end
                    end
                end
    -- Infernal Strike
                -- actions+=/infernal_strike,if=!sigil_placed&!in_flight&remains-travel_time-delay<0.3*duration&artifact.fiery_demise.enabled&dot.fiery_brand.ticking
                -- actions+=/infernal_strike,if=!sigil_placed&!in_flight&remains-travel_time-delay<0.3*duration&(!artifact.fiery_demise.enabled|(max_charges-charges_fractional)*recharge_time<cooldown.fiery_brand.remain()s+5)&(cooldown.sigil_of_flame.remain()s>7|charges=2)
                if mode.mover == 1 and getDistance(units.dyn5) < 5 and charges.infernalStrike > 1 then
                    if (artifact.fieryDemise and debuff.fieryBrand.exists(units.dyn5))
                        or (not artifact.fieryDemise or (charges.max.infernalStrike - charges.frac.infernalStrike) * recharge.infernalStrike < cd.fieryBrand + 5)
                        and (cd.sigilOfFlame > 7 or charges.infernalStrike == 2)
                    then
                        -- if cast.infernalStrike("best",false,1,6) then return end
                        if cast.infernalStrike("player","ground") then return end
                    end
                end
    -- Spirit Bomb
                -- actions+=/spirit_bomb,if=debuff.frailty.down
                if not debuff.frailty.exists(units.dyn5) then
                    if cast.spiritBomb() then return end
                end
    -- Immolation Aura
                -- actions+=/immolation_aura,if=pain<=80
                if isChecked("献祭光环") then
                    if pain <= 80 and getDistance(units.dyn8AoE) < 8 then
                        if cast.immolationAura() then return end
                    end
                end
    -- Felblade
                -- actions+=/felblade,if=pain<=70
                if pain <= 70 then
                    if cast.felblade() then return end
                end
                if useDefensive() then
    -- Soul Barrier
                    -- actions+=/soul_barrier
                    if isChecked("恶魔灌注") and php < getOptionValue("恶魔灌注") then
                        if cast.soulBarrier() then return end
                    end
    -- Soul Cleave
                    -- actions+=/soul_cleave,if=soul_fragments=5
                    if isChecked("灵魂劈裂") and buff.soulFragments.stack() == 5 then
                        if cast.soulCleave() then return end
                    end
    -- Metamorphosis
                    -- actions+=/metamorphosis,if=buff.demon_spikes.down&!dot.fiery_brand.ticking&buff.metamorphosis.down&incoming_damage_5s>health.max*0.70
                    if isChecked("恶魔变形") and not buff.demonSpikes.exists() and not debuff.fieryBrand.exists(units.dyn5)
                        and not buff.metamorphosis.exists() and php < getOptionValue("恶魔变形")
                    then
                        if cast.metamorphosis() then return end
                    end
    -- Fel Devastation
                    -- actions+=/fel_devastation,if=incoming_damage_5s>health.max*0.70
                    if isChecked("邪能毁灭") and php < getOptionValue("邪能毁灭") and getDistance(units.dyn20) < 20 then
                        if cast.felDevastation() then return end
                    end
    -- Soul Cleave
                    -- actions+=/soul_cleave,if=incoming_damage_5s>=health.max*0.70
                    if isChecked("灵魂劈裂") and php < getOptionValue("灵魂劈裂") then
                        if cast.soulCleave() then return end
                    end
                end
    -- Fel Eruption
                -- actions+=/fel_eruption
                if cast.felEruption() then return end
    -- Sigil of Flame
                -- actions+=/sigil_of_flame,if=remains-delay<=0.3*duration
                if isChecked("烈焰咒符") and not isMoving(units.dyn5) and getDistance(units.dyn5) < 5 then
                    if cast.sigilOfFlame("best",false,1,8) then return end
                end
    -- Fracture
                -- actions+=/fracture,if=pain>=80&soul_fragments<4&incoming_damage_4s<=health.max*0.20
                if pain >= 80 and buff.soulFragments.stack() < 4 then
                    if cast.fracture() then return end
                end
    -- Soul Cleave
                -- actions+=/soul_cleave,if=pain>=80
                if useDefensive() and isChecked("灵魂劈裂") and pain >= 80 then
                    if cast.soulCleave() then return end
                end
	-- 撕裂
                if buff.metamorphosis.exists() and pain < 80 or not useDefensive() or (useDefensive() and not isChecked("灵魂劈裂")) then
                    if cast.sever() then return end
                end	
    -- Shear
                -- actions+=/shear
                if pain < 80 or not useDefensive() or (useDefensive() and not isChecked("灵魂劈裂")) then
                    if cast.shear() then return end
                end
    -- Throw Glaive
                if getDistance(units.dyn5) > 5 then
                    if cast.throwGlaive() then return end
                end
			end --End In Combat
		end --End Rotation Logic
    end -- End Timer
end -- End runRotation
local id = 581
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})
