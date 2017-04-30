local rotationName = "CuteOne"

---------------
--- Toggles ---
---------------
local function createToggles()
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "基于范围内的目标数,在单目标和多目标自动切换输出方式.", highlight = 1, icon = br.player.spell.swipe },
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "使用多目标方式输出.", highlight = 0, icon = br.player.spell.swipe },
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "使用单目标方式输出.", highlight = 0, icon = br.player.spell.mangle },
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "禁用DPS输出", highlight = 0, icon = br.player.spell.regrowth}
    };
    CreateButton("Rotation",1,0)
-- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "自动使用大技能 - 只在BOSS.", highlight = 1, icon = br.player.spell.incarnationGuardianOfUrsoc },
        [2] = { mode = "On", value = 1 , overlay = "Cooldowns Enabled", tip = "不管任何目标都使用大技能.", highlight = 0, icon = br.player.spell.incarnationGuardianOfUrsoc },
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "不使用大技能.", highlight = 0, icon = br.player.spell.incarnationGuardianOfUrsoc }
    };
   	CreateButton("Cooldown",2,0)
-- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "使用保命技能.", highlight = 1, icon = br.player.spell.survivalInstincts },
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "不使用保命技能.", highlight = 0, icon = br.player.spell.survivalInstincts }
    };
    CreateButton("Defensive",3,0)
-- Interrupt Button
    InterruptModes = {
        [1] = { mode = "On", value = 1 , overlay = "Interrupts Enabled", tip = "使用打断.", highlight = 1, icon = br.player.spell.skullBash },
        [2] = { mode = "Off", value = 2 , overlay = "Interrupts Disabled", tip = "不使用打断.", highlight = 0, icon = br.player.spell.skullBash }
    };
    CreateButton("Interrupt",4,0)
-- Cleave Button
	CleaveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Cleaving Enabled", tip = "Rotation will cleave targets.", highlight = 1, icon = br.player.spell.thrash },
        [2] = { mode = "Off", value = 2 , overlay = "Cleaving Disabled", tip = "Rotation will not cleave targets", highlight = 0, icon = br.player.spell.thrash }
    };
    CreateButton("Cleave",5,0)
-- Prowl Button
	ProwlModes = {
        [1] = { mode = "On", value = 1 , overlay = "Prowl Enabled", tip = "Rotation will use Prowl", highlight = 1, icon = br.player.spell.prowl },
        [2] = { mode = "Off", value = 2 , overlay = "Prowl Disabled", tip = "Rotation will not use Prowl", highlight = 0, icon = br.player.spell.prowl }
    };
    CreateButton("Prowl",6,0)
-- Mark of Ursol
	markOfUrsolModes = {
        [1] = { mode = "Off", value = 1 , overlay = "markOfUrsol Enabled", tip = "不使用乌索尔的印记", highlight = 0, icon = br.player.spell.markOfUrsol },
        [2] = { mode = "On", value = 2 , overlay = "markOfUrsol Disabled", tip = "使用乌索尔的印记", highlight = 1, icon = br.player.spell.markOfUrsol }
    };
    CreateButton("markOfUrsol",7,0)	
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
            br.ui:createDropdownWithout(section, "APL模式", {"|cffFFFFFFSimC","|cffFFFFFFAMR"}, 1, "|cffFFFFFF选择输出循环.")
        -- Dummy DPS Test
            br.ui:createSpinner(section, "DPS测试",  5,  5,  60,  5,  "|cffFFFFFF设置为所需的测试的时间（分钟）. 最小: 5 / 最大: 60 / 间隔: 5")
        -- Pre-Pull Timer
            br.ui:createSpinner(section, "Pre-Pull Timer",  5,  1,  10,  1,  "|cffFFFFFF设置为所需的启动时间 Pre-Pull (必须有DBM). 最小: 1 / 最大: 10 / 间隔: 1")
        -- Travel Shapeshifts
            br.ui:createCheckbox(section,"自动变换形态","|cff15FF00启用|cffFFFFFF/|cffD60000禁用 |cffFFFFFF根据场所自动变换最好的形态.|cffFFBB00.")
        -- Break Crowd Control
            br.ui:createCheckbox(section,"自动解除控制","|cff15FF00启用|cffFFFFFF/|cffD60000禁用 |cffFFFFFF被定身时会自动变换形态解除控制.|cffFFBB00.")
        -- Growl
            br.ui:createCheckbox(section,"低吼","|cffFFFFFF自动嘲讽.")
		-- Lunar Beam
            br.ui:createSpinner(section, "月光普照", 3, 1, 10, 1, "|cffFFFFFF10码内最少有多少个敌人才使用月光普照(在BOSS战没有限制).")		
        br.ui:checkSectionState(section)
    -- Cooldown Options
        section = br.ui:createSection(br.ui.window.profile, "技能冷却")
        -- Flask / Crystal
            br.ui:createCheckbox(section,"奥拉留斯的低语水晶")
        -- Racial
            br.ui:createCheckbox(section,"种族技能")
        -- Incarnation: King of the Jungle
            br.ui:createCheckbox(section,"化身")
        -- Trinkets
            br.ui:createSpinner(section, "饰品 血量",  70,  0,  100,  5,  "多少血量百分比使用")		
            br.ui:createDropdownWithout(section, "饰品", {"|cff00FF00只用第一个","|cff00FF00只用第二个","|cffFFFF00两个都用","|cffFF0000不用"}, 1, "|cffFFFFFF选择饰品使用.")			
        br.ui:checkSectionState(section)
    -- Defensive Options
        section = br.ui:createSection(br.ui.window.profile, "保命")
        -- Healthstone
            br.ui:createSpinner(section, "药水/治疗石",  30,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用")
        -- Barkskin
            br.ui:createSpinner(section, "树皮术", 50, 0, 100, 5, "|cffFFBB00多少血量百分比使用")
        -- Frenzied Regeneration
            br.ui:createSpinner(section, "狂暴回复", 20, 0, 100, 5, "|cffFFBB005秒内损失多少血量使用")
        -- Ironfur
            br.ui:createSpinner(section, "铁鬃", 50, 0, 100, 5, "|cffFFBB00多少秒损失多少血量使用.")
        -- Mark of Ursol
            br.ui:createSpinner(section, "乌索尔的印记", 50, 0, 100, 5, "|cffFFBB00多少血量百分比使用")
        -- Rage of the Sleeper
            br.ui:createSpinner(section, "沉睡者之怒", 70, 0, 100, 5, "|cffFFBB00多少血量百分比使用")
        -- Rebirth
            br.ui:createCheckbox(section,"复生")
            br.ui:createDropdownWithout(section, "复生 - 目标", {"|cff00FF00目标","|cffFF0000鼠标位置"}, 1, "|cffFFFFFF选择目标")
        -- Regrowth
            br.ui:createSpinner(section, "愈合",  50,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用")
        -- Remove Corruption
            br.ui:createCheckbox(section,"清除腐蚀")
            br.ui:createDropdownWithout(section, "清除腐蚀 - 目标", {"|cff00FF00自己","|cffFFFF00目标","|cffFF0000鼠标位置"}, 1, "|cffFFFFFF选择目标")
        -- Revive
            br.ui:createCheckbox(section,"起死回生")
            br.ui:createDropdownWithout(section, "起死回生 - 目标", {"|cff00FF00目标","|cffFF0000鼠标位置"}, 1, "|cffFFFFFF选择目标")
        -- Survival Instincts
            br.ui:createSpinner(section, "生存本能",  40,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用")
        br.ui:checkSectionState(section)
    -- Interrupt Options
        section = br.ui:createSection(br.ui.window.profile, "打断")
        -- Skull Bash
            br.ui:createCheckbox(section,"迎头痛击")
        -- Mighty Bash
            br.ui:createCheckbox(section,"蛮力猛击")
        -- Incapacitating Roar
            br.ui:createCheckbox(section,"夺魂咆哮")
        -- Interrupt Percentage
            br.ui:createSpinner(section, "打断",  95,  0,  95,  5,  "|cffFFFFFF百分几打断")
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
        -- Cleave Toggle
            br.ui:createDropdown(section, "输出模式", br.dropOptions.Toggle,  6)
        -- Prowl Toggle
            br.ui:createDropdown(section, "潜行模式", br.dropOptions.Toggle,  6)
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
    if br.timer:useTimer("debugGuardian", math.random(0.15,0.3)) then
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
        UpdateToggle("Prowl",0.25)
        br.player.mode.prowl = br.data.settings[br.selectedSpec].toggles["Prowl"]
        UpdateToggle("markOfUrsol",0.25)
		br.player.mode.markOfUrsol = br.data.settings[br.selectedSpec].toggles["markOfUrsol"]
--------------
--- Locals ---
--------------
        local addsExist                                     = false
        local addsIn                                        = 999
        local artifact                                      = br.player.artifact
        local buff                                          = br.player.buff
        local canFlask                                      = canUse(br.player.flask.wod.agilityBig)
        local cast                                          = br.player.cast
        local combatTime                                    = getCombatTime()
        local cd                                            = br.player.cd
        local charges                                       = br.player.charges
        local deadMouse                                     = UnitIsDeadOrGhost("mouseover")
        local deadtar, attacktar, hastar, playertar         = deadtar or UnitIsDeadOrGhost("target"), attacktar or UnitCanAttack("target", "player"), hastar or GetObjectExists("target"), UnitIsPlayer("target")
        local debuff                                        = br.player.debuff
        local enemies                                       = enemies or {}
        local falling, swimming, flying, moving             = getFallTime(), IsSwimming(), IsFlying(), GetUnitSpeed("player")>0
        local flaskBuff                                     = getBuffRemain("player",br.player.flask.wod.buff.agilityBig)
        local friendly                                      = UnitIsFriend("target", "player")
        local gcd                                           = br.player.gcd
        local hasMouse                                      = GetObjectExists("mouseover")
        local healPot                                       = getHealthPot()
        local inCombat                                      = br.player.inCombat
        local inInstance                                    = br.player.instance=="party"
        local inRaid                                        = br.player.instance=="raid"
        local level                                         = br.player.level
        local lootDelay                                     = getOptionValue("LootDelay")
        local lossPercent                                   = getHPLossPercent("player",5)
        local lowestHP                                      = br.friend[1].unit
        local mfTick                                        = 20.0/(1+UnitSpellHaste("player")/100)/10
        local mode                                          = br.player.mode
        local multidot                                      = br.player.mode.cleave
        local php                                           = br.player.health
        local playerMouse                                   = UnitIsPlayer("mouseover")
        local potion                                        = br.player.potion
        local power, powmax, powgen, powerDeficit           = br.player.power.amount.rage, br.player.power.rage.max, br.player.power.regen, br.player.power.rage.deficit
        local pullTimer                                     = br.DBM:getPulltimer()
        local racial                                        = br.player.getRacial()
        local recharge                                      = br.player.recharge
        local solo                                          = br.player.instance=="none"
        local snapLossHP                                    = 0
        local spell                                         = br.player.spell
        local talent                                        = br.player.talent
        local travel, flight, bear, cat, noform             = br.player.buff.travelForm.exists(), br.player.buff.flightForm.exists(), br.player.buff.bearForm.exists(), buff.catForm.exists(), GetShapeshiftForm()==0
        local trinketProc                                   = false
        local ttd                                           = getTTD
        local ttm                                           = br.player.power.ttm
        local units                                         = units or {}

        units.dyn5 = br.player.units(5)
        if not talent.balanceAffinity then enemies.yards5 = br.player.enemies(5) end
        if not talent.balanceAffinity then enemies.yards8 = br.player.enemies(8) end
        if not talent.balanceAffinity then enemies.yards10 = br.player.enemies(10) end
        if not talent.balanceAffinity then enemies.yards13 = br.player.enemies(13) end
        if not talent.balanceAffinity then enemies.yards20 = br.player.enemies(20) end
        if not talent.balanceAffinity then enemies.yards30 = br.player.enemies(30) end
        if not talent.balanceAffinity then enemies.yards40 = br.player.enemies(40) end
		
        if talent.balanceAffinity and not hasEquiped(137015) then enemies.yards5 = br.player.enemies(10) end
        if talent.balanceAffinity and not hasEquiped(137015) then enemies.yards8 = br.player.enemies(13) end
        if talent.balanceAffinity and not hasEquiped(137015) then enemies.yards10 = br.player.enemies(15) end
        if talent.balanceAffinity and not hasEquiped(137015) then enemies.yards13 = br.player.enemies(18) end
        if talent.balanceAffinity and not hasEquiped(137015) then enemies.yards20 = br.player.enemies(25) end
        if talent.balanceAffinity and not hasEquiped(137015) then enemies.yards30 = br.player.enemies(35) end
        if talent.balanceAffinity and not hasEquiped(137015) then enemies.yards40 = br.player.enemies(45) end

        if talent.balanceAffinity and hasEquiped(137015) then enemies.yards5 = br.player.enemies(14) end
        if talent.balanceAffinity and hasEquiped(137015) then enemies.yards8 = br.player.enemies(17) end
        if talent.balanceAffinity and hasEquiped(137015) then enemies.yards10 = br.player.enemies(19) end
        if talent.balanceAffinity and hasEquiped(137015) then enemies.yards13 = br.player.enemies(22) end
        if talent.balanceAffinity and hasEquiped(137015) then enemies.yards20 = br.player.enemies(29) end
        if talent.balanceAffinity and hasEquiped(137015) then enemies.yards30 = br.player.enemies(39) end
        if talent.balanceAffinity and hasEquiped(137015) then enemies.yards40 = br.player.enemies(49) end
		
   		if leftCombat == nil then leftCombat = GetTime() end
		if profileStop == nil then profileStop = false end
		if lastSpellCast == nil then lastSpellCast = spell.bearForm end
        if lastForm == nil then lastForm = 0 end
        if lossPercent > snapLossHP or php > snapLossHP then snapLossHP = lossPercent end

        -- cast.catForm()

        -- ChatOverlay("Aggroed: "..tostring(isAggroed("target"))..", Threat "..tostring(hasThreat("target")))
        --             -- Growl
        --     if isChecked("低吼") then
        --         for i = 1, #enemies.yards30 do
        --             local thisUnit = enemies.yards30[i]
        --             if not isAggroed(thisUnit) and hasThreat(thisUnit) then
        --                 if cast.growl(thisUnit) then return end
        --             end
        --         end
        --     end
--------------------
--- Action Lists ---
--------------------
	-- Action List - Extras
		local function actionList_Extras()
        -- Growl
            if isChecked("低吼") then
                for i = 1, #enemies.yards30 do
                    local thisUnit = enemies.yards30[i]
                    if not isAggroed(thisUnit) and hasThreat(thisUnit) then
                        if cast.growl(thisUnit) then return end
                    end
                end
            end
		-- Shapeshift Form Management
			if isChecked("自动变换形态") and not UnitBuffID("player",202477) then
			-- Flight Form
				if IsFlyableArea() and ((not (isInDraenor() or isInLegion())) or isKnown(191633)) and not swimming and falling > 1 and level>=58 then
	                if cast.travelForm() then return end
		        end
			-- Aquatic Form
			    if swimming and not travel and not hastar and not deadtar then
				  	if cast.travelForm() then return end
				end
            -- Cat Form when not swimming or flying or stag and not in combat
                if not cat and not inCombat and moving and not swimming and not flying and not travel and (#enemies.yards20 == 0 or not bear) and not GetObjectExists("target") and not IsMounted() then
                    if cast.catForm() then return end
                end
            -- Bear Form
                if not bear then
                    -- Cat Form when not in combat and target selected and within 20yrds
                    if not inCombat and isValidTarget("target") and (UnitIsEnemy("target","player") or isDummy("target")) and not UnitIsDeadOrGhost("target") and getDistance("target") < 10 then
                        if cast.bearForm() then return end
                    end
                    --Cat Form when in combat and not flying
                    if inCombat and not flying and not travel then
                        if cast.bearForm() then return end
                    end
                end
            end -- End Shapeshift Form Management
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
            if useDefensive() and not buff.prowl.exists() and not flight then
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
        -- Barkskin
                if isChecked("树皮术") then
                    if php <= getOptionValue("树皮术") and inCombat then
                        if cast.barkskin() then return end
                    end
                end
        -- Frenzied Regeneration
                if isChecked("狂暴回复") then
                    if (snapLossHP >= getOptionValue("狂暴回复") or (snapLossHP > php and snapLossHP > 5)) and not buff.frenziedRegeneration.exists() then
                        if cast.frenziedRegeneration() then snapLossHP = 0; return end
                    end
                end
        -- Mark of Ursol
                if mode.markOfUrsol == 2 and inCombat then
                    if cast.markOfUrsol() then return end
                end
        -- Rage of the Sleeper
                if isChecked("沉睡者之怒") then
                    if php <= getOptionValue("沉睡者之怒") and inCombat then
                        if cast.rageOfTheSleeper("player") then return end
                    end
                end
        -- Regrowth
                if isChecked("愈合") then
                    if php <= getOptionValue("愈合") and not inCombat then
                        if cast.regrowth("player") then return end
                    end
                end
        -- Remove Corruption
                if isChecked("清除腐蚀") then
                    if getOptionValue("清除腐蚀 - 目标")==1 and canDispel("player",spell.removeCorruption) then
                        if cast.removeCorruption("player") then return end
                    end
                    if getOptionValue("清除腐蚀 - 目标")==2 and canDispel("target",spell.removeCorruption) then
                        if cast.removeCorruption("target") then return end
                    end
                    if getOptionValue("清除腐蚀 - 目标")==3 and canDispel("mouseover",spell.removeCorruption) then
                        if cast.removeCorruption("mouseover") then return end
                    end
                end
        --Revive/Rebirth
                if isChecked("复生") then
                    if getOptionValue("复生 - 目标")==1
                        and UnitIsPlayer("target") and UnitIsDeadOrGhost("target") and UnitIsFriend("target","player")
                    then
                        if cast.rebirth("target","dead") then return end
                    end
                    if getOptionValue("复生 - 目标")==2
                        and UnitIsPlayer("mouseover") and UnitIsDeadOrGhost("mouseover") and UnitIsFriend("mouseover","player")
                    then
                        if cast.rebirth("mouseover","dead") then return end
                    end
                end
                if isChecked("起死回生") then
                    if getOptionValue("起死回生 - 目标")==1
                        and UnitIsPlayer("target") and UnitIsDeadOrGhost("target") and UnitIsFriend("target","player")
                    then
                        if cast.revive("target","dead") then return end
                    end
                    if getOptionValue("起死回生 - 目标")==2
                        and UnitIsPlayer("mouseover") and UnitIsDeadOrGhost("mouseover") and UnitIsFriend("mouseover","player")
                    then
                        if cast.revive("mouseover","dead") then return end
                    end
                end
        -- Survival Instincts
                if isChecked("生存本能") then
                    if php <= getOptionValue("生存本能") and inCombat and not buff.survivalInstincts.exists() then
                        if cast.survivalInstincts() then return end
                    end
                end
        -- PowerShift - Breaks Crowd Control (R.I.P Powershifting)
                if isChecked("自动解除控制") then
                    if not hasNoControl() and lastForm ~= 0 then
                        CastShapeshiftForm(lastForm)
                        if GetShapeshiftForm() == lastForm then
                            lastForm = 0
                        end
                    elseif hasNoControl() then
                        if GetShapeshiftForm() == 0 then
                            cast.catForm()
                        else
                            for i=1, GetNumShapeshiftForms() do
                                if i == GetShapeshiftForm() then
                                    lastForm = i
                                    CastShapeshiftForm(i)
                                    return true
                                end
                            end
                        end
                    end
                end
    		end -- End Defensive Toggle
		end -- End Action List - Defensive
	-- Action List - Interrupts
		local function actionList_Interrupts()
			if useInterrupts() then
        -- Skull Bash
                if isChecked("迎头痛击") then
                    for i=1, #enemies.yards13 do
                        thisUnit = enemies.yards13[i]
                        if canInterrupt(thisUnit,getOptionValue("打断")) then
                            if cast.skullBash(thisUnit) then return end
                        end
                    end
                end
        -- Mighty Bash
                if isChecked("蛮力猛击") then
                    for i=1, #enemies.yards5 do
                        thisUnit = enemies.yards5[i]
                        if canInterrupt(thisUnit,getOptionValue("打断")) then
                            if cast.mightyBash(thisUnit) then return end
                        end
                    end
                end
        -- Incapacitating Roar
                if isChecked("夺魂咆哮") then
                    for i=1, #enemies.yards10 do
                        thisUnit = enemies.yards10[i]
                        if canInterrupt(thisUnit,getOptionValue("打断")) then
                            if cast.incapacitatingRoar("player") then return end
                        end
                    end
                end
		 	end -- End useInterrupts check
		end -- End Action List - Interrupts
	-- Action List - Cooldowns
		local function actionList_Cooldowns()
			if useCDs() and getDistance(units.dyn5) < 5 then
		-- Trinkets
                -- TODO: if=(buff.tigers_fury.up&(target.time_to_die>trinket.stat.any.cooldown|target.time_to_die<45))|buff.incarnation.remain()s>20
				if isChecked("饰品 血量") and php <= getOptionValue("饰品 血量") then
                    -- if (buff.tigersFury and (ttd(units.dyn5) > 60 or ttd(units.dyn5) < 45)) or buff.remain().incarnationKingOfTheJungle > 20 then
						if (getOptionValue("饰品") == 1 or getOptionValue("饰品") == 3) and canUse(13) then
							useItem(13)
						end
						if (getOptionValue("饰品") == 2 or getOptionValue("饰品") == 3) and canUse(14) then
							useItem(14)
						end
                    -- end
				end
        -- Agi-Pot
                -- -- if=((buff.berserk.remain()s>10|buff.incarnation.remain()s>20)&(target.time_to_die<180|(trinket.proc.all.react&target.health.pct<25)))|target.time_to_die<=40
                -- if useCDs() and isChecked("爆发药水") and canUse(0) and inRaid then
                --     if ((buff.remain().berserk > 10 or buff.remain().incarnationKingOfTheJungle > 20) and (ttd(units.dyn5) < 180 or (trinketProc and getHP(units.dyn5)<25))) or ttd(units.dyn5)<=40 then
                --         useItem(agiPot);
                --         return true
                --     end
                -- end
        -- Racial: Orc Blood Fury | Troll Berserking | Blood Elf Arcane Torrent
                -- blood_fury,buff.tigers_fury | berserking,buff.tigers_fury | arcane_torrent,buff.tigers_fury
                if isChecked("种族技能") and (br.player.race == "Orc" or br.player.race == "Troll" or br.player.race == "BloodElf") then
                    if castSpell("player",racial,false,false,false) then return end
                end
        -- Incarnation: Guardian of Ursoc
                if isChecked("化身") then
                    if cast.incarnationGuardianOfUrsoc() then return end
                end
            end -- End useCooldowns check
        end -- End Action List - Cooldowns
    -- Action List - PreCombat
        local function actionList_PreCombat()
            if not inCombat and not (IsFlying() or IsMounted()) then
                if not buff.prowl.exists() then
        -- Flask / Crystal
                    -- flask,type=flask_of_the_seventh_demon
                    if isChecked("奥拉留斯的低语水晶") and not stealth then
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
                end -- End No Stealth
                if getDistance("target") < 5 and isValidUnit("target") then
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
        -- Cat is 4 fyte!
            if inCombat and not bear and not (flight or travel or IsMounted() or IsFlying()) then
                -- if cast.catForm() then return end
            elseif inCombat and bear and profileStop==false and isValidUnit("target") then

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
        -- Bristling Fur
                    if buff.ironfur.remain() < 2 and power < 40 then
                        if cast.bristlingFur() then return end
                    end
        -- Ironfur
                    if isChecked("铁鬃") and php >= getOptionValue("铁鬃") and not buff.ironfur.exists() or powerDeficit < 25 or buff.ironfur.remain() < 2 then
                        if cast.ironfur() then return end
                    end
        -- Moonfire
                    if #enemies.yards40 < 4 then
                        for i = 1, #enemies.yards40 do
                            local thisUnit = enemies.yards40[i]
                            if debuff.moonfire.refresh(thisUnit) and buff.galacticGuardian.exists() and isValidUnit(thisUnit) then
                                if cast.moonfire(thisUnit) then return end
                            end
                        end
                    end
                    if buff.galacticGuardian.exists() and isValidUnit("target") then
                        if cast.moonfire("target") then return end
                    end
        -- Mangle
                    if ((mode.rotation == 1 and #enemies.yards8 == 1) or mode.rotation == 3) then
                        if cast.mangle() then return end
                    end
        -- Thrash
                    if (not talent.balanceAffinity and getDistance("target") < 8) or (talent.balanceAffinity and not hasEquiped(137015) and getDistance("target") < 13) or (talent.balanceAffinity and hasEquiped(137015) and getDistance("target") < 17) then
                        if cast.thrash() then return end
                    end
        -- Mangle
                    if ((mode.rotation == 1 and #enemies.yards8 > 1) or mode.rotation == 2) then
                        if cast.mangle() then return end
                    end
        -- Pulverize
                    if talent.pulverize then
                        for i = 1, #enemies.yards5 do
                            local thisUnit = enemies.yards5[i]
                            if debuff.thrash.stack(thisUnit) >= 2 then
                                if cast.pulverize(thisUnit) then return end
                            end
                        end
                    end
        -- Lunar Beam
		        if isChecked("月光普照") then
		            if (((mode.rotation == 1 and #enemies.yards10 >= getOptionValue("月光普照")) or mode.rotation == 2) or isBoss("target")) and getDistance("target") < 5 and getCombatTime() > 3 then
                        if cast.lunarBeam() then return end
				    end
			    end	
        -- Moonfire
                    if ((mode.rotation == 1 and #enemies.yards8 > 1) or mode.rotation == 2) then
                        if #enemies.yards40 < 4 then
                            for i = 1, #enemies.yards40 do
                                local thisUnit = enemies.yards40[i]
                                if isValidUnit(thisUnit) and (multidot or (UnitIsUnit(thisUnit,units.dyn5) and not multidot)) then
                                    if (debuff.moonfire.remain(thisUnit) == 0 or debuff.moonfire.remain(thisUnit) < 3.6 or debuff.moonfire.remain(thisUnit) < 7.2) then
                                        if cast.moonfire(thisUnit) then return end
                                    end
                                end
                            end
                        end
                    end
        -- Swipe
                    if #enemies.yards8 > 0 then
                        if cast.swipe() then return end
                    end
        -- Maul
                    if power > 90 then
                        if cast.maul() then return end
                    end
                end -- End SimC APL
    ------------------------
    --- Ask Mr Robot APL ---
    ------------------------
                if getOptionValue("APL模式") == 2 then

                end
			end --End In Combat
		end --End Rotation Logic
    end -- End Timer
end -- End runRotation
local id = 104
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})
