local rotationName = "CuteOne"

---------------
--- Toggles ---
---------------
local function createToggles()
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "基于范围内的目标数,在单目标和多目标自动切换输出方式.", highlight = 1, icon = br.player.spell.swipe },
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "使用多目标方式输出.", highlight = 0, icon = br.player.spell.swipe },
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "使用单目标方式输出.", highlight = 0, icon = br.player.spell.shred },
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "禁用DPS输出", highlight = 0, icon = br.player.spell.regrowth}
    };
    CreateButton("Rotation",1,0)
-- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "自动使用大技能 - 只在BOSS.", highlight = 1, icon = br.player.spell.berserk },
        [2] = { mode = "On", value = 1 , overlay = "Cooldowns Enabled", tip = "不管任何目标都使用大技能.", highlight = 0, icon = br.player.spell.berserk },
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "不使用大技能.", highlight = 0, icon = br.player.spell.berserk }
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
        -- Death Cat
            br.ui:createCheckbox(section,"Death Cat Mode","|cff15FF00Enable|cffFFFFFF/|cffD60000Disable |cffFFFFFFthis mode when running through low level content where you 1 hit kill mobs.")
        -- Fire Cat
            br.ui:createCheckbox(section,"使用火猫","|cff15FF00Enable|cffFFFFFF/|cffD60000Disable |cffFFFFFFautomatic use of Fandrel's Seed Pouch or Burning Seeds.")
        -- Dummy DPS Test
            br.ui:createSpinner(section, "DPS测试",  5,  5,  60,  5,  "|cffFFFFFF设置为所需的测试的时间（分钟）. 最小: 5 / 最大: 60 / 间隔: 5")
		-- Opener
			br.ui:createCheckbox(section, "Opener")
        -- Pre-Pull Timer
            br.ui:createSpinner(section, "Pre-Pull Timer",  5,  1,  10,  1,  "|cffFFFFFF设置为所需的启动时间 Pre-Pull (必须有DBM). 最小: 1 / 最大: 10 / 间隔: 1")
        -- Travel Shapeshifts
            br.ui:createCheckbox(section,"自动变换形态","|cff15FF00启用|cffFFFFFF/|cffD60000禁用 |cffFFFFFF根据场所自动变换最好的形态.|cffFFBB00.")
        -- Break Crowd Control
            br.ui:createCheckbox(section,"自动解除控制","|cff15FF00启用|cffFFFFFF/|cffD60000禁用 |cffFFFFFF被定身时会自动变换形态解除控制.|cffFFBB00.")
        -- Wild Charge
            br.ui:createCheckbox(section,"野性冲锋","|cff15FF00启用|cffFFFFFF/|cffD60000禁用 |cffFFFFFF自动使用|cffFFBB00.")
        -- Brutal Slash Targets
            br.ui:createSpinner(section,"野蛮挥砍", 3, 1, 10, 1, "|cffFFFFFF多少敌人使用野蛮挥砍")
        -- Artifact
            br.ui:createDropdownWithout(section,"神器技能", {"|cff00FF00任何时候","|cffFFFF00技能冷却","|cffFF0000决不"}, 1, "|cffFFFFFF何时使用神器技能.")
        br.ui:checkSectionState(section)
    -- Cooldown Options
        section = br.ui:createSection(br.ui.window.profile, "技能冷却")
        -- Agi Pot
            br.ui:createCheckbox(section,"爆发药水")
        -- Flask / Crystal
            br.ui:createCheckbox(section,"奥拉留斯的低语水晶")
        -- Berserk
            br.ui:createCheckbox(section,"狂暴")
        -- Legendary Ring
            br.ui:createSpinner(section, "黑暗前途指环",  1,  1,  5,  1,  "|cffFFFFFF设置多少层. 最小: 1 / 最大: 5 / 间隔: 1")
        -- Racial
            br.ui:createCheckbox(section,"种族技能")
        -- Tiger's Fury
            br.ui:createCheckbox(section,"猛虎之怒")
        -- Incarnation: King of the Jungle
            br.ui:createCheckbox(section,"化身")
        -- Trinkets
            br.ui:createCheckbox(section,"饰品")
        br.ui:checkSectionState(section)
    -- Defensive Options
        section = br.ui:createSection(br.ui.window.profile, "保命")
        -- Rebirth
            br.ui:createCheckbox(section,"复生")
            br.ui:createDropdownWithout(section, "复生 - 目标", {"|cff00FF00目标","|cffFF0000鼠标位置"}, 1, "|cffFFFFFF施放目标")
        -- Revive
            br.ui:createCheckbox(section,"起死回生")
            br.ui:createDropdownWithout(section, "起死回生 - 目标", {"|cff00FF00目标","|cffFF0000鼠标位置"}, 1, "|cffFFFFFF施放目标")
        -- Remove Corruption
            br.ui:createCheckbox(section,"清除腐蚀")
            br.ui:createDropdownWithout(section, "清除腐蚀 - 目标", {"|cff00FF00自己","|cffFFFF00目标","|cffFF0000鼠标位置"}, 1, "|cffFFFFFF施放目标")
        -- Renewal
            br.ui:createSpinner(section, "新生",  75,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用")
        -- Healthstone
            br.ui:createSpinner(section, "药水/治疗石",  60,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用")
        -- Heirloom Neck
            br.ui:createSpinner(section, "传家宝项链",  60,  0,  100,  5,  "|cffFFBB00多少血量百分比使用");
        -- Engineering: Shield-o-tronic
            br.ui:createSpinner(section, "粒子护盾(工程物品)",  50,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用")
        -- Survival Instincts
            br.ui:createSpinner(section, "生存本能",  40,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用")
        -- Regrowth
            br.ui:createSpinner(section, "愈合",  50,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用")
        -- Dream of Cenarius Auto-Heal
            br.ui:createDropdown(section, "自动治疗", { "|cffFFDD11低血量的人", "|cffFFDD11自己"},  1,  "|cffFFFFFF选择目标自动治疗")
        br.ui:checkSectionState(section)
    -- Interrupt Options
        section = br.ui:createSection(br.ui.window.profile, "打断")
        -- Skull Bash
            br.ui:createCheckbox(section,"迎头痛击")
        -- Mighty Bash
            br.ui:createCheckbox(section,"蛮力猛击")
        -- Maim
            br.ui:createCheckbox(section,"割碎")
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
    -- if br.timer:useTimer("debugFeral", math.random(0.15,0.3)) then
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

--------------
--- Locals ---
--------------
        local addsExist                                     = false
        local addsIn                                        = 999
        local artifact                                      = br.player.artifact
        local buff                                          = br.player.buff
        local canFlask                                      = canUse(br.player.flask.wod.agilityBig)
        local cast                                          = br.player.cast
		local castable          							= br.player.cast.debug
        local clearcast                                     = br.player.buff.clearcasting.exists()
        local combatTime                                    = getCombatTime()
        local combo                                         = br.player.power.comboPoints.amount
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
        local level                                         = br.player.level
        local lootDelay                                     = getOptionValue("LootDelay")
        local lowestHP                                      = br.friend[1].unit
        local mfTick                                        = 20.0/(1+UnitSpellHaste("player")/100)/10
        local mode                                          = br.player.mode
        local multidot                                      = (br.player.mode.cleave == 1 or br.player.mode.rotation == 2) and br.player.mode.rotation ~= 3
        local perk                                          = br.player.perk
        local php                                           = br.player.health
        local playerMouse                                   = UnitIsPlayer("mouseover")
        local potion                                        = br.player.potion
        local power, powmax, powgen, powerDeficit           = br.player.power.energy.amount, br.player.power.energy.max, br.player.power.regen, br.player.power.energy.deficit
        local pullTimer                                     = br.DBM:getPulltimer()
        local racial                                        = br.player.getRacial()
        local recharge                                      = br.player.recharge
        local rkTick                                        = 3
        local rpTick                                        = 2
        local solo                                          = #br.friend < 2
        local friendsInRange                                = friendsInRange
        local spell                                         = br.player.spell
        local stealth                                       = br.player.stealth
        local t18_2pc                                       = TierScan("T18")>=2 --br.player.eq.t18_2pc
        local t18_4pc                                       = TierScan("T18")>=4 --br.player.eq.t18_4pc
        local t19_4pc                                       = TierScan("T19")>=4
        local talent                                        = br.player.talent
        local travel, flight, cat, noform                   = br.player.buff.travelForm.exists(), br.player.buff.flightForm.exists(), br.player.buff.catForm.exists(), GetShapeshiftForm()==0
        local trinketProc                                   = false
        local ttd                                           = getTTD
        local ttm                                           = br.player.power.ttm
        local units                                         = units or {}

        -- Get Best Unit for Range
        units.dyn40   = br.player.units(40)
        units.dyn20   = br.player.units(20)
        units.dyn8AoE = br.player.units(8,true)
        units.dyn8    = br.player.units(8)
        units.dyn5    = br.player.units(5)

        -- Get List of Enemies for Range
        enemies.yards40 = br.player.enemies(40)
        enemies.yards20 = br.player.enemies(20)
        enemies.yards13 = br.player.enemies(13)
        enemies.yards8  = br.player.enemies(8)
        enemies.yards5  = br.player.enemies(5)

   		if leftCombat == nil then leftCombat = GetTime() end
		if profileStop == nil then profileStop = false end
		if lastSpellCast == nil then lastSpellCast = spell.catForm end
        if opener == nil then opener = false end
        if lastForm == nil then lastForm = 0 end
		if not inCombat and not hastar and profileStop==true then
            profileStop = false
		end
        if talent.jaggedWounds then
            if rkTick == 3 then rkTick = rkTick - (rkTick * 0.3) end
            if rpTick == 2 then rpTick = rpTick - (rpTick * 0.3) end
        end
        if br.player.potion.agility ~= nil then
            if br.player.potion.agility[1] ~= nil then
                agiPot = br.player.potion.agility[1].itemID
            else
                agiPot = 0
            end
        else
            agiPot = 0
        end
        friendsInRange = 0
        if not solo then
            for i = 1, #br.friend do
                if getDistance(br.friend[i].unit) < 15 then
                    friendsInRange = friendsInRange + 1
                end
            end
        end
        if power > 50 then
            fbMaxEnergy = true
        else
            fbMaxEnergy = false
        end
        if not inCombat and not GetObjectExists("target") then
			shredCount = 7
            OPN1 = false
            RK1 = false
            SR1 = false
            BER1 = false
            TF1 = false
            AF1 = false
            MF1 = false
            SHR1 = false
            RIP1 = false
            opener = false
        end

        -- ChatOverlay(round2(getDistance("target","player","dist"),2)..", "..round2(getDistance("target","player","dist2"),2)..", "..round2(getDistance("target","player","dist3"),2)..", "..round2(getDistance("target","player","dist4"),2)..", "..round2(getDistance("target"),2))
--------------------
--- Action Lists ---
--------------------
	-- Action List - Extras
		local function actionList_Extras()
		-- Shapeshift Form Management
			if isChecked("自动变换形态") then
			-- Flight Form
				if IsFlyableArea() --[[and ((not (isInDraenor() or isInLegion())) or isKnown(191633))]] and not swimming and falling > 1 and level>=58 then
                    if GetShapeshiftForm() ~= 0 then
                        CancelShapeshiftForm()
                        RunMacroText("/CancelForm")
                        if cast.travelForm("player") then return end
                    else
	                   if cast.travelForm("player") then return end
                    end
		        end
			-- Aquatic Form
			    if swimming and not travel and not hastar and not deadtar and not buff.prowl.exists() then
				  	if cast.travelForm("player") then return end
				end
			-- Cat Form
				if not cat and not IsMounted() then
			    	-- Cat Form when not swimming or flying or stag and not in combat
			    	if not inCombat and moving and not swimming and not flying and not travel and not isValidUnit("target") then
		        		if cast.catForm("player") then return end
		        	end
		        	-- Cat Form when not in combat and target selected and within 20yrds
		        	if not inCombat and isValidUnit("target") and getDistance("target") < 30 then
		        		if cast.catForm("player") then return end
		        	end
		        	--Cat Form when in combat and not flying
		        	if inCombat and not flying then
		        		if cast.catForm("player") then return end
		        	end
		        end
			end -- End Shapeshift Form Management
		-- Perma Fire Cat
			-- check if its check and player out of combat an not stealthed
			if isChecked("使用火猫") and not inCombat and not buff.prowl.exists() and cat then
				-- check if Burning Essence buff expired
				if getBuffRemain("player",138927)==0 then
					-- check if player has the Fandral's Seed Pouch
					if PlayerHasToy(122304) then
						-- check if item is off cooldown
						if GetItemCooldown(122304)==0 then
							-- Let's only use it once and not spam it
							if not spamToyDelay or GetTime() > spamToyDelay then
								useItem(122304)
								spamToyDelay = GetTime() + 1
							end
						end
					-- check if Burning Seeds exist and are useable if Fandral's Seed Pouch doesn't exist
					elseif GetItemCooldown(94604)==0 and GetItemCount(94604,false,false) > 0 then
						useItem(94604)
					end
				end -- End Burning Essence Check
			end -- End Perma Fire Cat
		-- Death Cat mode
			if isChecked("Death Cat Mode") and cat then
		        if hastar and getDistance(units.dyn8AoE) > 8 then
		            ClearTarget()
		        end
	            if #enemies.yards20 > 0 then
	            -- Tiger's Fury - Low Energy
                	if cast.tigersFury() then return end
	            -- Savage Roar - Use Combo Points
	                if combo >= 5 then
	                	if cast.savageRoar() then return end
	                end
	            -- Shred - Single
	                if #enemies.yards5 == 1 then
	                	if cast.shred() then swipeSoon = nil; return end
	                end
	            -- Swipe - AoE
	                if #enemies.yards8 > 1 then
	                    if swipeSoon == nil then
	                        swipeSoon = GetTime();
	                    end
	                    if swipeSoon ~= nil and swipeSoon < GetTime() - 1 then
	                    	if cast.swipe() then swipeSoon = nil; return end
	                    end
	                end
	            end -- End 20yrd Enemy Scan
			end -- End Death Cat Mode
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
			if useDefensive() and not IsMounted() and not stealth and not flight and not buff.prowl.exists() then
		--Revive/Rebirth
				if isChecked("复生") then
					if buff.predatorySwiftness.exists() then
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
        -- Renewal
                if isChecked("新生") and php <= getOptionValue("新生") and inCombat then
                    if cast.renewal() then return end
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
                            cast.catForm("player")
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
		-- Engineering: Shield-o-tronic
				if isChecked("粒子护盾(工程物品)") and php <= getOptionValue("粒子护盾(工程物品)")
					and inCombat and canUse(118006)
				then
					useItem(118006)
				end
		-- Regrowth
        		if isChecked("愈合") and (buff.predatorySwiftness.exists() or not inCombat) then
	            	if inCombat and getOptionValue("自动治疗")==1 and getDistance(br.friend[1].unit) < 40
	                    and ((getHP(br.friend[1].unit) <= getOptionValue("愈合")/2 and inCombat)
	                        or (getHP(br.friend[1].unit) <= getOptionValue("愈合") and not inCombat)
	                        or (buff.predatorySwiftness.remain() < 1 and buff.predatorySwiftness.exists()))
	                then
	                    if cast.regrowth(br.friend[1].unit) then return end
	                end
	                if (getOptionValue("自动治疗")==2 or not inCombat)
	                    and (php <= getOptionValue("愈合") or (buff.predatorySwiftness.remain() < 1 and buff.predatorySwiftness.exists()))
	                then
                        if GetShapeshiftForm() ~= 0 then
                            CancelShapeshiftForm()
                            RunMacroText("/CancelForm")
                        else
	                       if cast.regrowth("player") then return end
                        end
	                end
	            end
		-- Survival Instincts
	            if isChecked("生存本能") and php <= getOptionValue("生存本能")
	            	and inCombat and not buff.survivalInstincts.exists() and charges.survivalInstincts > 0
	            then
	            	if cast.survivalInstincts() then return end
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
		-- Maim (PvP)
    			if isChecked("割碎") then
    				for i=1, #enemies.yards5 do
                        thisUnit = enemies.yards5[i]
    					if canInterrupt(thisUnit,getOptionValue("打断")) and isInPvP() then
    						if cast.maim(thisUnit) then return end
		    			end
	            	end
	          	end
		 	end -- End useInterrupts check
		end -- End Action List - Interrupts
	-- Action List - Cooldowns
		local function actionList_Cooldowns()
			if getDistance("target") < 5 then
		-- Berserk
				--if=buff.tigers_fury.up
	            if useCDs() and isChecked("狂暴") then
	            	if buff.tigersFury.exists() and not talent.incarnationKingOfTheJungle then
	            		if cast.berserk() then return end
	            	end
	            end
		-- Incarnation - King of the Jungle
                -- if=cooldown.tigers_fury.remain()s<gcd
	            if useCDs() and isChecked("化身") then
	            	if cd.tigersFury < gcd and cd.incarnationKingOfTheJungle == 0 then
	            		if cast.incarnationKingOfTheJungle() then return end
	            	end
	            end
		-- Trinkets
                -- if=buff.tigers_fury.up&energy.time_to_max>3&(!talent.savage_roar.enabled|buff.savage_roar.up)
				if useCDs() and isChecked("饰品") and getDistance(units.dyn5) < 5 then
                    if buff.tigersFury.exists() and ttm > 3 and (not talent.savageRoar or buff.savageRoar.exists()) then
						if canUse(13) then
							useItem(13)
						end
						if canUse(14) then
							useItem(14)
						end
                    end
				end
        -- Agi-Pot
                -- if=((buff.berserk.remains>10|buff.incarnation.remains>20)&(target.time_to_die<180|(trinket.proc.all.react&target.health.pct<25)))|target.time_to_die<=40
                if useCDs() and isChecked("爆发药水") and canUse(agiPot) and inRaid then
                    if ((buff.berserk.remain() > 10 or buff.incarnationKingOfTheJungle.exists() > 20) and (ttd(units.dyn5) < 180 or (trinketProc and getHP(units.dyn5)<25))) or ttd(units.dyn5)<=40 then
                        useItem(agiPot);
                        return true
                    end
                end
        -- Legendary Ring
                -- use_item,slot=finger1
                if isChecked("黑暗前途指环") then
                    if hasEquiped(142173) and canUse(142173) and getDebuffStacks("player",234143) < getOptionValue("黑暗前途指环") and select(2,IsInInstance()) ~= "pvp"  then
                        useItem(142173)
                        return true
                    end
                end
        -- Racial: Orc Blood Fury | Troll Berserking | Blood Elf Arcane Torrent
                -- blood_fury,buff.tigers_fury | berserking,buff.tigers_fury | arcane_torrent,buff.tigers_fury
                if useCDs() and isChecked("种族技能") and (br.player.race == "Orc" or br.player.race == "Troll" or br.player.race == "BloodElf") then
                    if buff.tigersFury.exists() and getSpellCD(racial) == 0 then
                        if castSpell("player",racial,false,false,false) then return end
                    end
                end
        -- Tiger's Fury
                -- if=(!buff.clearcasting.react&energy.deficit>=60)|energy.deficit>=80|(t18_class_trinket&buff.berserk.up&buff.tigers_fury.down)
                if isChecked("猛虎之怒") then
                    if ((not clearcast and powerDeficit >= 60) or powerDeficit >= 80 or (hasEquiped(124514) and buff.berserk.exists() and not buff.tigersFury.exists())) then
                        if cast.tigersFury() then return end
                    end
                end
        -- Incarnation - King of the Jungle
                -- if=energy.time_to_max>1&energy>=35
                if useCDs() and isChecked("化身") then
                    if ttm > 1 and power >= 35 and cd.incarnationKingOfTheJungle == 0 then
                        if cast.incarnationKingOfTheJungle() then return end
                    end
                end
            end -- End useCooldowns check
        end -- End Action List - Cooldowns
    -- Action List - Opener
        function actionList_Opener()
        -- Wild Charge
            if isChecked("野性冲锋") and isValidUnit("target") and getDistance("target") >= 8 and getDistance("target") < 30 then
                if cast.wildCharge("target") then return end
            end
		-- Start Attack
            -- auto_attack
            if isChecked("Opener") and isBoss("target") and opener == false then
                if isValidUnit("target") and getDistance("target") < 5 then
					if not OPN1 then 
                        Print("Starting Opener")
                        OPN1 = true
                    elseif (not RK1 or not debuff.rake.exists("target")) and power >= 35 then
            -- Rake
       					if castOpener("rake","RK1",1) then return end
       				elseif RK1 and not SR1 and power >= 40 then
       		-- Savage Roar
       					if castOpener("savageRoar","SR1",2) then return end
       				elseif SR1 and not TF1 then
       		-- Tiger's Fury
       					if castOpener("tigersFury","TF1",3) then return end
              		elseif TF1 and not BER1 then
          	-- Berserk
						if isChecked("狂暴") and useCDs() then
							if castOpener("berserk","BER1",4) then return end
						else
							Print("4: Berserk (Uncastable)")
							BER1 = true
						end
					elseif BER1 and not AF1 then
          	-- Ashamane's Frenzy
						if getOptionValue("神器技能") == 1 or (getOptionValue("神器技能") == 2 and useCDs()) then
                			if castOpener("ashamanesFrenzy","AF1",5) then return end
						else
							Print("5: Ashamane's Frenzy (Uncastable)")
							AF1 = true
						end
			  		elseif AF1 and not MF1 then
            -- Moonfire
                        if talent.moonfire then
			    			if castOpener("moonfire","MF1",6) then return end
						else
							Print("6: Moonfire (Uncastable)");
							MF1 = true
						end
					elseif MF1 and (not SHR1 or combo < 5) and power >= 40 then
            -- Shred
						if castOpener("shred","SHR1",shredCount) then shredCount = shredCount + 1 return end
                    elseif SHR1 and not RIP1 and power >= 30 then
       		-- Rip
     					if castOpener("rip","RIP1",shredCount) then return end
                    elseif RIP1 then
       					opener = true;
						Print("Opener Complete")
       					return
       				end
                end
			elseif (UnitExists("target") and not isBoss("target")) or not isChecked("Opener") then
				opener = true
			end
        end -- End Action List - Opener
    -- Action List - SBTOpener
        local function actionList_SBTOpener()
        -- Regrowth
            -- regrowth,if=talent.bloodtalons.enabled&combo_points=5&!buff.bloodtalons.up&!dot.rip.ticking
            if talent.bloodtalons and combo == 5 and not buff.bloodtalons.exists() and not debuff.rip.exists(units.dyn5) then
                if getOptionValue("自动治疗")==1 and getDistance(br.friend[1].unit) < 40 then
                    if cast.regrowth(br.friend[1].unit) then return end
                end
                if getOptionValue("自动治疗")==2 then
                    if cast.regrowth("player") then return end
                end
			end
        -- Tiger's Fury
            -- tigers_fury,if=!dot.rip.ticking&combo_points=5
            if not debuff.rip.exists(units.dyn5) and combo == 5 then
                if cast.tigersFury() then return end
            end
        end
    -- Action List - Finisher
        local function actionList_Finisher()
        -- Savage Roar
            -- pool_resource,for_next=1
            -- savage_roar,if=!buff.savage_roar.up&(combo_points=5|(talent.brutal_slash.enabled&spell_targets.brutal_slash>desired_targets&action.brutal_slash.charges>0))
            if not buff.savageRoar.exists() and (combo == 5 or (talent.brutalSlash and #enemies.yards8 > getOptionValue("Brutal Slash Targest") and charges.brutalSlash > 0)) then
                if power <= select(1, getSpellCost(spell.savageRoar)) then
                    return true
                elseif power > select(1, getSpellCost(spell.savageRoar)) then
                    if cast.savageRoar("player") then return end
                end
            end
        -- Thrash
            -- pool_resource,for_next=1
            -- cycle_targets=1,if=remains<=duration*0.3&spell_targets.thrash_cat>=5
            if ((mode.rotation == 1 and #enemies.yards8 >= 5) or mode.rotation == 2) then
                for i = 1, #enemies.yards8 do
                    local thisUnit = enemies.yards8[i]
                    if (multidot or (UnitIsUnit(thisUnit,units.dyn5) and not multidot)) then
                        if getDistance(thisUnit) < 8 then
                            if debuff.thrash.refresh(thisUnit) then
                                if power <= select(1, getSpellCost(spell.thrash)) then
                                    return true
                                elseif power > select(1, getSpellCost(spell.thrash)) then
                                    if cast.thrash("player") then return end
                                end
                            end
                        end
                    end
                end
            end
        -- Swipe
            -- pool_resource,for_next=1
            -- swipe_cat,if=spell_targets.swipe_cat>=8
            if ((mode.rotation == 1 and #enemies.yards8 >= 8) or mode.rotation == 2) then
                if power <= select(1, getSpellCost(spell.swipe)) then
                    return true
                elseif power > select(1, getSpellCost(spell.swipe)) then
                    if cast.swipe("player") then return end
                end
            end
        -- Rip
            -- rip,cycle_targets=1,if=(!ticking|(remains<8&target.health.pct>25&!talent.sabertooth.enabled)|persistent_multiplier>dot.rip.pmultiplier)&target.time_to_die-remains>tick_time*4&combo_points=5&(energy.time_to_max<1|buff.berserk.up|buff.incarnation.up|buff.elunes_guidance.up|cooldown.tigers_fury.remains<3|set_bonus.tier18_4pc|(buff.clearcasting.react&energy>65)|talent.soul_of_the_forest.enabled|!dot.rip.ticking|(dot.rake.remains<1.5&spell_targets.swipe_cat<6))
            if combo == 5 then
                for i = 1, #enemies.yards5 do
                    local thisUnit = enemies.yards5[i]
                    if (multidot or (UnitIsUnit(thisUnit,units.dyn5) and not multidot)) then
                        if getDistance(thisUnit) < 5 then
                            if (not debuff.rip.exists(thisUnit) or (debuff.rip.remain(thisUnit) < 8 and getHP(thisUnit) > 25 and not talent.sabertooth) or debuff.rip.calc() > debuff.rip.applied(thisUnit))
                                and (ttd(thisUnit) - debuff.rip.remain(thisUnit) > rpTick * 4 or isDummy())
                                and (ttm < 1 or buff.berserk.exists() or buff.incarnationKingOfTheJungle.exists() or buff.elunesGuidance.exists() or cd.tigersFury < 3 or t18_4pc
                                or (buff.clearcasting.exists() and power < 65) or talent.soulOfTheForest or not debuff.rip.exists(thisUnit) or (debuff.rake.remain(thisUnit) < 1.5 and #enemies.yards8 < 6))
                            then
                               if cast.rip(thisUnit) then return end
                            end
                        end
                    end
                end
            end
        -- Savage Roar
            -- savage_roar,if=((buff.savage_roar.remains<=10.5&talent.jagged_wounds.enabled)|(buff.savage_roar.remains<=7.2))&combo_points=5&(energy.time_to_max<1|buff.berserk.up|buff.incarnation.up|buff.elunes_guidance.up|cooldown.tigers_fury.remains<3|set_bonus.tier18_4pc|(buff.clearcasting.react&energy>65)|talent.soul_of_the_forest.enabled|!dot.rip.ticking|(dot.rake.remains<1.5&spell_targets.swipe_cat<6))
            if ((buff.savageRoar.remain() <= 10.5 and talent.jaggedWounds) or buff.savageRoar.remain() <= 7.2)
                and (combo == 5 or not buff.savageRoar.exists()) and (ttm < 1 or buff.berserk.exists() or buff.incarnationKingOfTheJungle.exists()
                or buff.elunesGuidance.exists() or cd.tigersFury < 3 or t18_4pc or (buff.clearcasting.exists() and power < 65)
                or talent.soulOfTheForest or not debuff.rake.exists(units.dyn5) or (debuff.rake.remain(units.dyn5) < 1.5 and #enemies.yards8 < 6))
            then
                if cast.savageRoar("player") then return end
            end
        -- Swipe
            -- swipe_cat,if=combo_points=5&(spell_targets.swipe_cat>=6|(spell_targets.swipe_cat>=3&!talent.bloodtalons.enabled))&combo_points=5&(energy.time_to_max<1|buff.berserk.up|buff.incarnation.up|buff.elunes_guidance.up|cooldown.tigers_fury.remains<3|set_bonus.tier18_4pc|(talent.moment_of_clarity.enabled&buff.clearcasting.react))
            if ((mode.rotaion == 1 and (#enemies.yards8 >= 6 or (#enemies.yards8 >= 3 and not talent.bloodtalons))) or mode.rotation == 2)
                and combo == 5 and (ttm < 1 or buff.berserk.exists() or buff.incarnationKingOfTheJungle.exists() or buff.elunesGuidance.exists()
                or cd.tigersFury < 3 or t18_4pc or (talent.momentOfClarity and buff.clearcasting.exists()))
            then
                if cast.swipe("player") then return end
            end
        -- Maim
            -- maim,,if=combo_points=5&buff.fiery_red_maimers.up&(energy.time_to_max<1|buff.berserk.up|buff.incarnation.up|buff.elunes_guidance.up|cooldown.tigers_fury.remains<3)
            if combo == 5 and buff.fieryRedMaimers.exists() and (ttm < 1 or buff.berserk.exists()
                or buff.incarnationKingOfTheJungle.exists() or buff.elunesGuidance.exists() or cd.tigersFury < 3)
            then
                if cast.maim(units.dyn5) then return end
            end
        -- Ferocious Bite
            -- ferocious_bite,max_energy=1,cycle_targets=1,if=combo_points=5&(energy.time_to_max<1|buff.berserk.up|buff.incarnation.up|buff.elunes_guidance.up|cooldown.tigers_fury.remains<3)
            if fbMaxEnergy and combo == 5 then
                for i = 1, #enemies.yards5 do
                    local thisUnit = enemies.yards5[i]
                    if (ttm < 1 or buff.berserk.exists() or buff.incarnationKingOfTheJungle.exists()
                        or buff.elunesGuidance.exists() or cd.tigersFury < 3 or (debuff.rip.remain(thisUnit) > 10 and buff.savageRoar.remain() > 10))
                    then
                        if cast.ferociousBite(thisUnit) then return end
                    end
                end
            end
        end
    -- Action List - Generator
        local function actionList_Generator()
        -- Brutal Slash
            -- brutal_slash,if=spell_targets.brutal_slash>desired_targets&combo_points<5
            if ((mode.rotation == 1 and #enemies.yards8 >= getOptionValue("野蛮挥砍")) or mode.rotation == 2) and combo < 5 then
                if cast.brutalSlash(units.dyn8) then return end
            end
        -- Ashamane's Frenzy
            -- ashamanes_frenzy,if=combo_points<=2&buff.elunes_guidance.down&(buff.bloodtalons.up|!talent.bloodtalons.enabled)&(buff.savage_roar.up|!talent.savage_roar.enabled)
            if getOptionValue("神器技能") == 1 or (getOptionValue("神器技能") == 2 and useCDs()) then
                if combo <= 2 and not buff.elunesGuidance.exists() and (buff.bloodtalons.exists() or not talent.bloodtalons) and (buff.savageRoar.exists() or not talent.savageRoar) then
                    if cast.ashamanesFrenzy(units.dyn5) then return end
                end
            end
        -- Pool for Elunes Guidance
            -- pool_resource,if=talent.elunes_guidance.enabled&combo_points=0&energy<action.ferocious_bite.cost+25-energy.regen*cooldown.elunes_guidance.remain()s
            -- elunes_guidance,if=talent.elunes_guidance.enabled&combo_points=0&energy>=action.ferocious_bite.cost+25
            if talent.elunesGuidance and combo == 0 then
                if power < select(1, getSpellCost(spell.ferociousBite)) + 25 - powgen * cd.elunesGuidance then
                    return true
                elseif power >= select(1, getSpellCost(spell.ferociousBite)) + 25 then
                    if cast.elunesGuidance() then return end
                end
            end
        -- Thrash
            -- pool_resource,for_next=1
            -- if=talent.brutal_slash.enabled&spell_targets.thrash_cat>=9
            if (multidot or (UnitIsUnit("target",units.dyn5) and not multidot)) then
                if talent.brutalSlash and ((mode.rotation == 1 and #enemies.yards8 >= 9) or mode.rotation == 2) then
                   if power <= select(1, getSpellCost(spell.thrash)) then
                        return true
                    elseif power > select(1, getSpellCost(spell.thrash)) then
                        if cast.thrash("player") then return end
                    end
                end
            end
        -- Swipe
            -- pool_resource,for_next=1
            -- swipe_cat,if=spell_targets.swipe_cat>=6
            if ((mode.rotation == 1 and #enemies.yards8 >= 6) or mode.rotation == 2) then
                if power <= select(1, getSpellCost(spell.swipe)) then
                    return true
                elseif power > select(1, getSpellCost(spell.swipe)) then
                    if cast.swipe("player") then return end
                end
            end
        -- Shadowmeld
            -- shadowmeld,if=combo_points<5&energy>=action.rake.cost&dot.rake.pmultiplier<2.1&buff.tigers_fury.up&(buff.bloodtalons.up|!talent.bloodtalons.enabled)&(!talent.incarnation.enabled|cooldown.incarnation.remains>18)&!buff.incarnation.up
            if useCDs() and isChecked("种族技能") and br.player.race == "NightElf" and getSpellCD(racial) == 0 and getDistance(units.dyn5) < 5 and not solo and friendsInRange > 0 then
                if combo < 5 and power >= select(1, getSpellCost(spell.rake)) and debuff.rake.applied(units.dyn5) < 2.1 and buff.tigersFury.exists()
                    and (buff.bloodtalons.exists() or not talent.bloodtalons) and (not talent.incarnationKingOfTheJungle or cd.incarnationKingOfTheJungle > 18)
                    and not buff.incarnationKingOfTheJungle.exists()
                then
                    if cast.shadowmeld() then return end
                end
            end
        -- Rake
            -- pool_resource,for_next=1
            -- rake,cycle_targets=1,if=combo_points<5&(!ticking|(!talent.bloodtalons.enabled&remains<duration*0.3)|(talent.bloodtalons.enabled&buff.bloodtalons.up&(!talent.soul_of_the_forest.enabled&remains<=7|remains<=5)&persistent_multiplier>dot.rake.pmultiplier*0.80))&target.time_to_die-remains>tick_time
            --
            if combo < 5 then
                for i = 1, #enemies.yards5 do
                    local thisUnit = enemies.yards5[i]
                    if (multidot or (UnitIsUnit(thisUnit,units.dyn5) and not multidot)) and getDistance(thisUnit) < 5 then
                        if (not debuff.rake.exists(thisUnit) or (not talent.bloodtalons and debuff.rake.refresh(thisUnit))
                            or (talent.bloodtalons and buff.bloodtalons.exists() and ((not talent.soulOfTheForest and debuff.rake.remain(thisUnit) <= 7)
                            or debuff.rake.remain(thisUnit) <= 5) and debuff.rake.calc() > debuff.rake.applied(thisUnit) * 0.80))
                            and (ttd(thisUnit) - debuff.rake.remain(thisUnit) > rkTick or isDummy(thisUnit))
                        then
                            if power <= select(1, getSpellCost(spell.rake)) then
                                return true
                            elseif power > select(1, getSpellCost(spell.rake)) then
                                if cast.rake(thisUnit) then return end
                            end
                        end
                    end
                end
            end
        -- Moonfire
            -- moonfire_cat,cycle_targets=1,if=combo_points<5&remains<=4.2&target.time_to_die-remains>tick_time*2
            if combo < 5 and talent.lunarInspiration then
                for i = 1, #enemies.yards40 do
                    local thisUnit = enemies.yards40[i]
                    if multidot or (UnitIsUnit(thisUnit,units.dyn5) and not multidot) then
                        if debuff.moonfire.remain(thisUnit) <= 4.2 and (ttd(thisUnit) - debuff.moonfire.remain(thisUnit) > mfTick * 2
                            or (isDummy(thisUnit) and getDistance(thisUnit) < 8))
                        then
                           if cast.moonfire(thisUnit) then return end
                        end
                    end
                end
            end
        -- Thrash
            -- pool_resource,for_next=1
            -- thrash_cat,cycle_targets=1,if=remains<=duration*0.3&(spell_targets.swipe_cat>=2|(buff.clearcasting.up&buff.bloodtalons.down&set_bonus.tier19_4pc))
            if (((mode.rotation == 1 or (mode.rotation == 3 and t19_4pc)) and (#enemies.yards8 >= 2 or (buff.clearcasting.exists() and not buff.bloodtalons.exists() and t19_4pc))) or mode.rotation == 2) then
                for i = 1, #enemies.yards8 do
                    local thisUnit = enemies.yards8[i]
                    if (multidot or (UnitIsUnit(thisUnit,units.dyn5) and not multidot)) and getDistance(thisUnit) < 5 then
                        if debuff.thrash.refresh(thisUnit) then
                            if power <= select(1, getSpellCost(spell.thrash)) then
                                return true
                            elseif power > select(1, getSpellCost(spell.thrash)) then
                                if cast.thrash("player") then return end
                            end
                        end
                    end
                end
            end
        -- Brutal Slash
            -- brutal_slash,if=combo_points<5&((raid_event.adds.exists&raid_event.adds.in>(1+max_charges-charges_fractional)*15)|(!raid_event.adds.exists&(charges_fractional>2.66&time>10)))
            if combo < 5 and ((addsExist and addsIn > (1 + charges.max.brutalSlash - charges.frac.brutalSlash) * 15)
                or (not addsExist and (charges.frac.brutalSlash > 2.66 and combatTime > 10)))
            then
                if cast.brutalSlash(units.dyn8) then return end
            end
        -- Swipe
            -- swipe_cat,if=combo_points<5&spell_targets.swipe_cat>=3
            if combo < 5 and ((mode.rotation == 1 and #enemies.yards8 >= 3) or mode.rotation == 2) then
                if cast.swipe("player") then return end
            end
        -- Shred
            -- shred,if=combo_points<5&(spell_targets.swipe_cat<3|talent.brutal_slash.enabled)
            if combo < 5 and (debuff.rake.exists(units.dyn5) or level < 12) and (((mode.rotation == 1 and #enemies.yards8 < 3) or mode.rotation == 3) or talent.brutalSlash or level < 32) then
                if cast.shred(units.dyn5) then return end
            end
        end
    -- Action List - PreCombat
        local function actionList_PreCombat()
            if not inCombat and not (IsFlying() or IsMounted()) then
                if not stealth then
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
        -- TODO: food,type=nightborne_delicacy_platte
        -- TOOD: augmentation,type=defiled
        -- Prowl - Non-PrePull
                    if cat and #enemies.yards20 > 0 and mode.prowl == 1  and not IsResting() and GetTime()-leftCombat > lootDelay then
                        for i = 1, #enemies.yards20 do
                            local thisUnit = enemies.yards20[i]
                            if UnitIsEnemy(thisUnit,"player") or isDummy("target") then
                                if cast.prowl("player") then return end
                            end
                        end
                    end
                end -- End No Stealth
        -- Wild Charge
                if isChecked("野性冲锋") and isValidUnit("target") then
                    if cast.wildCharge("target") then return end
                end
                if isChecked("Pre-Pull Timer") and pullTimer <= getOptionValue("Pre-Pull Timer") then
        -- Regrowth
                    -- regrowth,if=talent.bloodtalons.enabled
                    if talent.bloodtalons and not buff.bloodtalons.exists() and (htTimer == nil or htTimer < GetTime() - 1) then
                        if cast.regrowth("player") then htTimer = GetTime(); return end
                    end
		-- Incarnation - King of the Jungle
					if cast.incarnationKingOfTheJungle() then return end
        -- Prowl
                    if buff.bloodtalons.exists() and mode.prowl == 1 then
                        if cast.prowl("player") then return end
                    end
                    if buff.prowl.exists() then
        -- Pre-Pot
                        -- potion,name=old_war
                        -- if useCDs() and isChecked("爆发药水") and canUse(agiPot) then
                        --     useItem(agiPot);
                        --     return true
                        -- end
                    end -- End Prowl
                end -- End Pre-Pull
        -- Rake/Shred
                -- buff.prowl.up|buff.shadowmeld.up
                if isValidUnit("target") and (not isBoss("target") or not isChecked("Opener")) then
                    if level < 12 then
                        if cast.shred("target") then return end
                    else
                       if cast.rake("target") then return end
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
			if actionList_Opener() then return end
--------------------------
--- In Combat Rotation ---
--------------------------
        -- Cat is 4 fyte!
            if inCombat and not cat and not (flight or travel or IsMounted() or IsFlying()) and isChecked("自动变换形态") then
                if cast.catForm("player") then return end
            elseif inCombat and cat and profileStop==false and not isChecked("Death Cat Mode") and isValidUnit(units.dyn5) and getDistance(units.dyn5) < 5 then
        -- Wild Charge
                -- wild_charge
                if isChecked("野性冲锋") and isValidUnit("target") then
                    if cast.wildCharge("target") then return end
                end
        -- TODO: Displacer Beast
                -- displacer_beast,if=movement.distance>10
        -- TODO: Dash/Worgen Racial
                -- dash,if=movement.distance&buff.displacer_beast.down&buff.wild_charge_movement.down
		-- Opener
				if actionList_Opener() then return end
        -- Rake/Shred from Stealth
                -- rake,if=buff.prowl.up|buff.shadowmeld.up
                if (buff.prowl.exists() or buff.shadowmeld.exists()) and opener == true then
                    if debuff.rake.exists(units.dyn5) or level < 12 then
                        if cast.shred(units.dyn5) then return end
                    else
                       if cast.rake(units.dyn5) then return end
                    end
                elseif not (buff.prowl.exists() or buff.shadowmeld.exists()) and opener == true then
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
        -- Ferocious Bite
                        -- ferocious_bite,cycle_targets=1,if=dot.rip.ticking&dot.rip.remains<3&target.time_to_die>3&(target.health.pct<25|talent.sabertooth.enabled)
                        for i = 1, #enemies.yards5 do
                            local thisUnit = enemies.yards5[i]
                            if (multidot or (UnitIsUnit(thisUnit,units.dyn5) and not multidot)) then
                                if getDistance(thisUnit) < 5 then
                                    if debuff.rip.remain(thisUnit) > 0 and debuff.rip.remain(thisUnit) < 3
                                        and (ttd(thisUnit) > 3 or isDummy(thisUnit)) and (getHP(thisUnit) < 25 or talent.sabertooth)
                                    then
                                        if cast.ferociousBite(thisUnit) then return end
                                    end
                                end
                            end
                        end
        -- Regrowth
                        -- regrowth,if=talent.bloodtalons.enabled&buff.predatory_swiftness.up&buff.bloodtalons.down&(combo_points>=5|buff.predatory_swiftness.remains<1.5|(talent.bloodtalons.enabled&combo_points=2&cooldown.ashamanes_frenzy.remains<gcd)|(talent.elunes_guidance.enabled&((cooldown.elunes_guidance.remains<gcd&combo_points=0)|(buff.elunes_guidance.up&combo_points>=4))))
                        if talent.bloodtalons and buff.predatorySwiftness.exists() and not buff.bloodtalons.exists()
                            and (combo >= 5 or buff.predatorySwiftness.remain() < 1.5
                                or (talent.bloodtalons and combo == 2 and cd.ashamanesFrenzy < gcd)
                                or (talent.elunesGuidance and ((cd.elunesGuidance < gcd and combo == 0) or (buff.elunesGuidance.exists() and combo >= 4))))
                        then
                            if getOptionValue("自动治疗")==1 and getDistance(br.friend[1].unit) < 40 then
                                if cast.regrowth(br.friend[1].unit) then return end
                            end
                            if getOptionValue("自动治疗")==2 then
                                if cast.regrowth("player") then return end
                            end
                        end
        -- Call Action List - SBTOpener
                        -- call_action_list,name=sbt_opener,if=talent.sabertooth.enabled&time<20
                        -- if talent.sabertooth and combatTime < 20 then
                        --     if actionList_SBTOpener() then return end
                        -- end
        -- Regrowth
                        -- regrowth,if=equipped.ailuro_pouncers&talent.bloodtalons.enabled&buff.predatory_swiftness.stack>1&buff.bloodtalons.down
                        if hasEquiped(137024) and talent.bloodtalons and buff.predatorySwiftness.stack() > 1 and not buff.bloodtalons.exists() then
                            if getOptionValue("自动治疗")==1 and getDistance(br.friend[1].unit) < 40 then
                                if cast.regrowth(br.friend[1].unit) then return end
                            end
                            if getOptionValue("自动治疗")==2 then
                                if cast.regrowth("player") then return end
                            end
                        end
        -- Call Action List - Finisher
                        -- call_action_list,name=finisher
                        if actionList_Finisher() then return end
        -- Call Action List - Generator
                        -- call_action_list,name=generator
                        if actionList_Generator() then return end
                    end -- End SimC APL
    ------------------------
    --- Ask Mr Robot APL ---
    ------------------------
                    if getOptionValue("APL模式") == 2 then
        -- Regrowth
                        -- if HasTalent(Bloodtalons) and HasBuff(PredatorySwiftness) and not HasBuff(Prowl)
                        if talent.bloodtalons and buff.predatorySwiftness.exists() and not buff.prowl.exists() then
                            if getOptionValue("自动治疗")==1 and getDistance(br.friend[1].unit) < 40 then
                                if cast.regrowth(br.friend[1].unit) then return end
                            end
                            if getOptionValue("自动治疗")==2 then
                                if cast.regrowth("player") then return end
                            end
                        end
        -- Savage Roar
                        -- if AlternatePower >= 5 and BuffRemainingSec(SavageRoar) < 6 and not CanRefreshDot(Rip)
                        if combo >= 5 and buff.savageRoar.remain() < 6 and debuff.rip.refresh(units.dyn5) then
                            if cast.savageRoar("player") then return end
                        end
        -- Rake
                        -- multi-DoT = 3
                        -- if #bleed.rake < 3 then
                            for i = 1, #enemies.yards5 do
                                local thisUnit = enemies.yards5[i]
                                if multidot or (UnitIsUnit(thisUnit,units.dyn5) and not multidot) then
                                    if debuff.rake.refresh(thisUnit) then
                                        if cast.rake(thisUnit) then return end
                                    end
                                end
                            end
                        -- end
        -- Moonfire
                        -- multi-Dot = 3
                        if talent.lunarInspiration then
                            for i = 1, #enemies.yards40 do
                                local thisUnit = enemies.yards40[i]
                                if multidot or (UnitIsUnit(thisUnit,units.dyn5) and not multidot) then
                                    if debuff.moonfire.remain(thisUnit) <= 4.2 and (#enemies.yards8 <= 8 or (isDummy(thisUnit) and getDistance(thisUnit) < 8)) then
                                       if cast.moonfire(thisUnit) then return end
                                    end
                                end
                            end
                        end
        -- Elune's Guidance
                        -- if AlternatePower = 0
                        if combo == 0 then
                            if cast.elunesGuidance() then return end
                        end
        -- Cooldowns
                        -- if AlternatePower >= 5
                        if combo >= 5 then
                            if actionList_Cooldowns() then return end
                        end
        -- Ferocious Bite
                        -- if AlternatePower >= 5 and (CanExecuteTarget or not CanRefreshDot(Rip))
                        if combo >= 5 and (getHP(units.dyn5) < 25 or debuff.rip.refresh(units.dyn5)) then
                            if cast.ferociousBite() then return end
                        end
        -- Rip
                        -- if AlternatePower >= 5
                        if combo >= 5 then
                            if cast.rip() then return end
                        end
        -- Thrash
                        -- if TargetsInRadius(Thrash) >= 3 and CanRefreshDot(ThrashBleedFeral)
                        if #enemies.yards8 >= 3 and debuff.thrash.refresh(units.dyn8AoE) then
                            if cast.thrash() then return end
                        end
        -- Swipe
                        -- if TargetsInRadius(Swipe) >= 3
                        if useAoE() then
                            if cast.swipe() then return end
                        end
        -- Shred
                        if cast.shred() then return end
                    end
			    end -- End No Stealth | Rotation Off Check
			end --End In Combat
		end --End Rotation Logic
    -- end -- End Timer
end -- End runRotation
local id = 103
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})
