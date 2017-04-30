local rotationName = "THFrost"


---------------
--- Toggles ---
---------------
local function createToggles()
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "基于范围内的目标数,在单目标和多目标自动切换输出方式.", highlight = 1, icon = br.player.spell.howlingBlast },
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "使用多目标方式输出.", highlight = 0, icon = br.player.spell.howlingBlast },
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "使用单目标方式输出.", highlight = 0, icon = br.player.spell.frostStrike },
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "禁用DPS输出", highlight = 0, icon = br.player.spell.battleCry}
    };
    CreateButton("Rotation",1,0)
-- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "自动使用大技能 - 只在BOSS.", highlight = 1, icon = br.player.spell.empowerRuneWeapon },
        [2] = { mode = "On", value = 1 , overlay = "Cooldowns Enabled", tip = "不管任何目标都使用大技能.", highlight = 0, icon = br.player.spell.empowerRuneWeapon },
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "不使用大技能.", highlight = 0, icon = br.player.spell.battleCry }
    };
    CreateButton("Cooldown",2,0)
-- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "使用保命技能.", highlight = 1, icon = br.player.spell.iceboundFortitude },
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "不使用保命技能.", highlight = 0, icon = br.player.spell.battleCry }
    };
    CreateButton("Defensive",3,0)
-- Interrupt Button
    InterruptModes = {
        [1] = { mode = "On", value = 1 , overlay = "Interrupts Enabled", tip = "使用打断.", highlight = 1, icon = br.player.spell.mindFreeze },
        [2] = { mode = "Off", value = 2 , overlay = "Interrupts Disabled", tip = "不使用打断.", highlight = 0, icon = br.player.spell.battleCry }
    };
    CreateButton("Interrupt",4,0)
end

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
--- local Functions
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Toogle Section
    local function uncheck(Value)
        if br.data~=nil then
             print(Value)
            br.data.settings[br.selectedSpec][br.selectedProfile][Value.. "Check"] = false
        end
    end
-- ObjectCheck 
    local function GetObjExists(objectID)
        for i = 1, ObjectCount() do
            local thisUnit = GetObjectWithIndex(i)
            if GetObjectExists(thisUnit) and GetObjectID(thisUnit) == objectID then
                return true
            end
        end
        return false
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
            -- Remove Spells from queue with CD
            br.ui:createSpinner(section, "法术队列清除",  5,  0,  100,  5,  "|cffFFBB00如果cd更大，删除法术.")
            -- Artifact
            br.ui:createDropdownWithout(section, "神器技能", {"|cff00FF00任何时候","|cffFFFF00冷却技能","|cffFF0000决不"}, 1, "|cffFFFFFF什么时候使用神器技能.")
            br.ui:createSpinnerWithout(section, "神器技能 数量",  5,  1,  10,  1,  "|cffFFFFFF设置多少个敌方单位才使用神器技能. 最小: 1 / 最大: 10 / 间隔: 1")               
            --DebugInfo
            br.ui:createCheckbox(section,"调试信息")
            -- Glacial Advance
            br.ui:createSpinner(section, "冰川突进",  5,  1,  10,  1,  "|cffFFFFFF设置多少个敌方单位才使用冰川突进. 最小: 1 / 最大: 10 / 间隔: 1")
            -- Pre-Pull Timer
            br.ui:createSpinner(section, "Pre-Pull Timer",  5,  1,  10,  1,  "|cffFFFFFF设置为所需的启动时间 Pre-Pull (必须有DBM). 最小: 1 / 最大: 10 / 间隔: 1")
            --Autotarget
            br.ui:createCheckbox(section,"自动目标","没有/友好目标在8码内切换到敌人")
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
            br.ui:createCheckbox(section,"饰品")
            -- Breath of Sindragosa
            br.ui:createCheckbox(section,"冰龙吐息")
            -- Empower Rune Weapon
            br.ui:createCheckbox(section,"符文武器")
            -- Obliteration
            br.ui:createCheckbox(section,"湮没")
            -- Pillar of Frost
            br.ui:createDropdownWithout(section, "冰霜之柱", {"|cff00FF00任何时候","|cffFFFF00冷却技能","|cffFF0000决不"}, 1, "|cffFFFFFF什么时候使用冰霜之柱.")
        br.ui:checkSectionState(section)
        -------------------------
        --- DEFENSIVE OPTIONS ---
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, "保命")
            -- Healthstone
            br.ui:createSpinner(section, "治疗石",  60,  0,  100,  5,  "|cffFFBB00多少百分比血量使用.")
            -- Heirloom Neck
            br.ui:createSpinner(section, "传家宝项链",  60,  0,  100,  5,  "|cffFFBB00多少百分比血量使用.")
            -- Anti-Magic Shell
            br.ui:createSpinner(section, "反魔法护罩",  75,  0,  100,  5,  "|cffFFFFFF多少百分比血量使用")
            -- Blinding Sleet
            br.ui:createSpinner(section, "致盲冰雨",  75,  0,  100,  5,  "|cffFFFFFF多少百分比血量使用")
            -- Death Strike
            br.ui:createSpinner(section, "灵界打击",  65,  0,  100,  5,  "|cffFFFFFF多少百分比血量使用")
            -- Trinkets
            br.ui:createCheckbox(section,"灵界打击 BOSS","|cffFFFFFF灵界打击只在BOSS战使用")
            -- Icebound Fortitude
            br.ui:createSpinner(section, "冰封之韧",  35,  0,  100,  5,  "|cffFFFFFF多少百分比血量使用")
            -- Raise Ally
            br.ui:createCheckbox(section,"复活盟友")
            br.ui:createDropdownWithout(section, "复活盟友 目标", {"|cff00FF00目标","|cffFF0000鼠标位置"}, 1, "|cffFFFFFF选择目标")
        br.ui:checkSectionState(section)
        -------------------------
        --- INTERRUPT OPTIONS ---
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, "打断")
            -- Anti-Magic Zone
            -- br.ui:createCheckbox(section,"Anti-Magic Zone - Int")
            -- Death Grip
            br.ui:createCheckbox(section,"死亡之握")
            -- Mind Freeze
            br.ui:createCheckbox(section,"心灵冰冻")
            -- Interrupt Percentage
            br.ui:createSpinnerWithout(section,  "打断",  17,  0,  95,  5,  "|cffFFBB00读条百分几打断.")
        br.ui:checkSectionState(section)
        ----------------------
        --- PVP            ---
        ----------------------
        section = br.ui:createSection(br.ui.window.profile, "PVP")
            -- Chains of Ice
            br.ui:createCheckbox(section,"寒冰锁链")
            -- Chians of Ice Focus
            br.ui:createCheckbox(section,"寒冰锁链 焦点", "寒冰锁链焦点目标")
            --BOS Cancel IBF
            br.ui:createCheckbox(section,"Cancel BoS on IBF")
            --BOS Cancel Thornes
            br.ui:createCheckbox(section,"Cancel BoS on Thornes")
            -- AMS Counter
            br.ui:createCheckbox(section,"AMS Counter")
            --Eye of Leotheras
            br.ui:createCheckbox(section, "莱欧瑟拉斯之眼", "Pause CR on Eye of Leotheras Debuff")
        br.ui:checkSectionState(section)
        ----------------------
        --- TOGGLE OPTIONS ---
        ----------------------
        section = br.ui:createSection(br.ui.window.profile,  "快捷键")
            -- Single/Multi Toggle
            br.ui:createDropdownWithout(section,  "Rotation Mode", br.dropOptions.Toggle,  4)
            --Cooldown Key Toggle
            br.ui:createDropdownWithout(section,  "Cooldown Mode", br.dropOptions.Toggle,  3)
            --Defensive Key Toggle
            br.ui:createDropdownWithout(section,  "Defensive Mode", br.dropOptions.Toggle,  6)
            -- Interrupts Key Toggle
            br.ui:createDropdownWithout(section,  "Interrupt Mode", br.dropOptions.Toggle,  6)
            -- Cleave Toggle
            br.ui:createDropdownWithout(section,  "Cleave Mode", br.dropOptions.Toggle,  6)
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
    if br.timer:useTimer("debugFrost", 0.1) then
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
		local lastSpell         = lastCast
		local bop				= UnitBuff("target","Blessing of Protection") ~= nil
		local cloak 			= UnitBuff("target","Cloak of Shadows") ~= nil or UnitBuff("target","Anti-Magic Shell") ~= nil
		local immunDS  			= UnitBuff("target","Divine Shield") ~= nil 
		local immunIB			= UnitBuff("target","Ice Block") ~= nil
		local immunAotT			= UnitBuff("target","Aspect of the Turtle") ~= nil
		local immunCyclone		= UnitBuff("target","Cyclone") ~= nil
		local immun				= immun or immunIB or immunAotT or immunDS or immunCyclone
        local attacktar         = UnitCanAttack("target", "player")
        local buff              = br.player.buff
        local BL 				= buff.ancientHysteria.exists() or buff.bloodlust.exists() or buff.heroism.exists() or buff.timeWarp.exists() 
        local cast              = br.player.cast
        local cd                = br.player.cd
        local charges           = br.player.charges
        local deadtar			= UnitIsDeadOrGhost("target") or isDummy()
        local playertar			= UnitIsPlayer("target")
        local debuff            = br.player.debuff
        local enemies           = enemies or {}
        local gcd               = br.player.gcd
        local glyph             = br.player.glyph
        local inCombat          = br.player.inCombat
        local level             = br.player.level
        local mode              = br.player.mode
        local moving            = GetUnitSpeed("player")>0
        local normalMob         = not(useCDs() or UnitIsPlayer("target"))
        local php               = br.player.health
        local power             = br.player.power
        local pullTimer         = br.DBM:getPulltimer()
        local racial            = br.player.getRacial()
        local runicPower        = br.player.power.amount.runicPower
        local runicPowerDeficit = br.player.power.runicPower.deficit
        local runes             = br.player.power.runes.frac
        local swimming          = IsSwimming()
        local talent            = br.player.talent
        local t19_2pc           = TierScan("T19") >= 2
        local t19_4pc           = TierScan("T19") >= 4
        local ttd               = getTTD
        local units             = units or {}

        units.dyn5 = br.player.units(5)
        units.dyn8 = br.player.units(8)
        units.dyn30 = br.player.units(30)
        enemies.yards8 = br.player.enemies(8)
        enemies.yards10 = br.player.enemies(10)
        enemies.yards10t = br.player.enemies(10,br.player.units(10,true))
        enemies.yards15 = br.player.enemies(15)
        enemies.yards30 = br.player.enemies(30)
        enemies.yards40 = br.player.enemies(40)
       
        if lastSpell == nil or not inCombat then lastSpell = 0 end
        if waitforNextIoC == nil then waitforNextIoC = 0 end
        if waitforNextIoCFocus == nil then waitforNextIoCFocus = 0 end
        if waitforNextKick == nil then waitforNextKick = 0 end  
        if waitfornextHowl == nil then waitfornextHowl = 0 end
	

        if isChecked("调试信息") then
			if immun then print ("Immun festgestellt")	end
			if immunDS then print("Divine Shield") end
			if immunIB then print("Ice Block") 	end
			if immunAotT then print("Trutlepower") end
			if bop then print("BOP") end
			if cloak then print("Cloak") end
		end

    -- Profile Stop
        if profileStop == nil then profileStop = false end
     
--------------------
--- Action Lists ---
--------------------
    ---------------------------------------------------------------------------------------------------------------------------------    
    -- Action List - Extras
    ---------------------------------------------------------------------------------------------------------------------------------
        local function actionList_Extras()        
        	if isChecked("调试信息") then Print("actionList_Extras") end
        -- Dummy Test
            if isChecked("DPS测试") then
                if GetObjectExists("target") then
                    if getCombatTime() >= (tonumber(getValue("DPS测试"))*60) and isDummy() then
                        profileStop = true
                        StopAttack()
                        ClearTarget()
                        Print(tonumber(getValue("DPS测试")) .." Minute Dummy Test Concluded - Profile Stopped")
                        return true
                    end
                end
            end
        -- Chains of Ice
            if isChecked("寒冰锁链") then
            	if waitforNextIoC < GetTime() -1.5 then
	              	if playertar 
	              		and (not debuff.chainsOfIce.exists("target") or debuff.chainsOfIce.remain("target") < 1.5)
	              		and (not talent.breathOfSindragosa or  (not buff.breathOfSindragosa.exists() or (buff.breathOfSindragosa.exists() and getDistance("target") > 5)))
	              		and (not talent.obliteration or (not buff.obliteration.exists() or (buff.obliteration.exists() and getDistance("target") > 5)))
	              		and not (UnitBuff("target","Blessing of Freedom") ~= nil)
	              		and not immun
	             		and not cloak
	                    and getDistance("target") <= 30
	                then
	                    if cast.chainsOfIce("target","aoe") then waitforNextIoC = GetTime() return end
	                end
	            end
            end
        --Chains of Ice focus
            if isChecked("寒冰锁链 焦点") then
                if waitforNextIoCFocus < GetTime() -1.5 then
                    if GetUnitExists("focus")
                        and (not debuff.chainsOfIce.exists("focus"))
                        and (not talent.breathOfSindragosa or not buff.breathOfSindragosa.exists())
                        and (not talent.obliteration or not buff.obliteration.exists())
                        and not (UnitBuff("focus","Blessing of Freedom") ~= nil)
                        and not immun
                        and not cloak
                        and isMoving("focus") 
                        and getDistance("focus") <= 30
                    then
                        if cast.chainsOfIce("focus","aoe") then waitforNextIoCFocus = GetTime() return end
                    end
                end
            end  
        -- Pillar of Frost
            if inCombat
                and not UnitIsDeadOrGhost("target") 
                and
                (
                getOptionValue("冰霜之柱") == 1
                or (getOptionValue("冰霜之柱") == 2) and (useCDs() or playertar)
                ) 
                and getDistance("target") < 5  
                and (normalMob or not talent.breathOfSindragosa or cd.breathOfSindragosa > 50 or buff.breathOfSindragosa.exists())
            then
                if cast.pillarOfFrost() then return end
            end  
        --Howling Blast
            if inCombat 
                and GetUnitExists("target") 
                and (normalMob or buff.rime.exists())
                and not IsMounted() 
                and ((waitfornextHowl < GetTime() - 4) or buff.rime.exists()) 
                and not buff.breathOfSindragosa.exists()
            then
                for i = 1, #enemies.yards30 do
                    local thisUnit = enemies.yards30[i]
                    if not debuff.frostFever.exists(thisUnit) 
                        and UnitAffectingCombat(thisUnit) 
                        and not cloak
                        and not immun
                    then
                        if cast.howlingBlast(thisUnit) then 
                            waitfornextHowl = GetTime() 
                            return 
                        end
                        break
                    end
                end  
            end 
        -- Raise Ally
            if isChecked("复活盟友") then
                if getOptionValue("复活盟友 目标")==1
                    and UnitIsPlayer("target") and UnitIsDeadOrGhost("target") and UnitIsFriend("target","player")
                then
                    if cast.raiseAlly("target","dead") then return end
                end
                if getOptionValue("复活盟友 目标")==2
                    and UnitIsPlayer("mouseover") and UnitIsDeadOrGhost("mouseover") and UnitIsFriend("mouseover","player")
                then
                    if cast.raiseAlly("mouseover","dead") then return end
                end
            end
        end -- End Action List - Extras
    ---------------------------------------------------------------------------------------------------------------------------------    
    -- Action List - Defensive
    ---------------------------------------------------------------------------------------------------------------------------------
        local function actionList_Defensive()
            if useDefensive() and not IsMounted() and inCombat then
            	if isChecked("调试信息") then Print("actionList_Defensive") end
            --Healthstone
             	if isChecked("治疗石") 
             		and php <= getOptionValue("治疗石")
                    and inCombat 
                    and hasItem(5512)
                then
                    if canUse(5512) then
                        useItem(5512)
                    end
                end
        -- Anti-Magic Shell
                if isChecked("反魔法护罩") 
                	and php < getOptionValue("反魔法护罩") 
                	and inCombat 
                then
                    if cast.antiMagicShell() then return end
                end
        --- AMS Counter
                if isChecked("AMS Counter") 
                    and inCombat
                    and 
                    ( 
                        UnitDebuff("player","Soul Reaper") ~= nil 
                        or
                        UnitDebuff("player","莱欧瑟拉斯之眼") ~= nil
                    )
                then                    
                    if cast.antiMagicShell() then print("AMS Counter - Soul Reaper") return end
                end
        -- Blinding Sleet
                if isChecked("致盲冰雨") 
                	and php < getOptionValue("致盲冰雨") 
                	and inCombat 
                then
                    if cast.blindingSleet() then return end
                end
        -- PVP - hungering runeweapon if IBF and playertar
        		if playertar and buff.iceboundFortitude.exists() and (runicPower < 45 or runes < 2)
        		then 
                    if talent.hungeringRuneWeapon then
            		    if not buff.hungeringRuneWeapon.exists() then
    	                    if cast.hungeringRuneWeapon() then return end
    	                end
                    else
                        if cast.empowerRuneWeapon() then return end
                    end              
        		end
        -- Death Strike
                if (buff.breathOfSindragosa.exists() and isChecked("灵界打击 BOSS")) or not buff.breathOfSindragosa.exists() then
                	if isChecked("灵界打击") 
                		and inCombat 
                		and (buff.darkSuccor.exists() and (php < getOptionValue("灵界打击") or (buff.darkSuccor.remain() < 2 and php < 90)))
                		or  (
                             runicPower >= 45 
                			 and 
                                ( 
                                 (buff.iceboundFortitude.exists() and ((php < 90) or (buff.iceboundFortitude.remain() < 2)))
                				 or(
                		 			php < getOptionValue("灵界打击") 
                                    and (cd.iceboundFortitude > 1.5) 
                                    and not buff.breathOfSindragosa.exists()
                    	  		   )
                    	  	    )
                    	    )  
                    then
                        if getDistance("target") > 5 or immun or bop then
                            for i=1, #getEnemies("player",20) do
                                thisUnit = getEnemies("player",20)[i]
                                distance = getDistance(thisUnit)
                                if distance < 5 and getFacing("player",thisUnit) then
                                    if cast.deathStrike(thisUnit) then print("Random Hit Deathstrike") return end
                                end
                            end
                        else
                            if cast.deathStrike("target") then return end
                        end
                    end
                end
        -- Icebound Fortitude
                if isChecked("冰封之韧") 
                	and php < getOptionValue("冰封之韧") 
                then
                    if cast.iceboundFortitude() then return end
                end
            end
            if isChecked("调试信息") then Print("~actionList_Defensive") end
        end -- End Action List - Defensive
    ---------------------------------------------------------------------------------------------------------------------------------
    -- Action List - Interrupts
    ---------------------------------------------------------------------------------------------------------------------------------
        local function actionList_Interrupts()
            if useInterrupts() then
            	if isChecked("调试信息") then Print("actionList_Interrupts") end
                if waitforNextKick < GetTime() -2 then
                	if cd.mindFreeze <= 0 or cd.deathGrip <= 0 then   
                        if kickpercent == nil or kickCommited == nil or kickCommited then
                            kickCommited = false
                            kickpercent = getOptionValue("打断") + math.random(-5,5)
                            print("new Kickpercent : ", kickpercent)
                        end
                        for i=1, #enemies.yards30 do
                            thisUnit = enemies.yards30[i]
                            if inCombat 
                                and (UnitIsPlayer(thisUnit) or not playertar)
                                and isValidUnit(thisUnit) 
                                and not isDummy(thisUnit) 
                                and canInterrupt(thisUnit,kickpercent)
                                and not immunDS
                                and not immunAotT
                            then                      
                                -- Mind Freeze
                                if isChecked("心灵冰冻") 
                                    and getDistance(thisUnit) < 15 
                                    and getFacing("player",thisUnit) 
                                then
                                    if cast.mindFreeze(thisUnit) then waitforNextKick = GetTime(); print("心灵冰冻"); kickCommited = true; return end
                                end
                                -- DeathGrip
                                if isChecked("死亡之握") 
                                    and getDistance("target") < 5
                                    and getFacing("player",thisUnit) 
                                then
                                    if cast.deathGrip(thisUnit) then waitforNextKick = GetTime(); print ("Grip Kick"); kickCommited = true; return end
                                end
                            end
                        end --endfor
                    end --Kick auf CD				 
                end
            end -- End Use Interrupts Check
        end -- End Action List - Interrupts
    ---------------------------------------------------------------------------------------------------------------------------------
    -- Action List - Cooldowns
    ---------------------------------------------------------------------------------------------------------------------------------
        local function actionList_Cooldowns()
        	if isChecked("调试信息") then Print("actionList_Cooldowns") end
            if (useCDs() or playertar) and getDistance("target") < 5 then
            -- Trinkets
                if isChecked("饰品") then
                    if canUse(13) then
                        useItem(13)
                    end
                    if canUse(14) then
                        useItem(14)
                    end
                end
            -- Racial: Orc Blood Fury | Troll Berserking | Blood Elf Arcane Torrent
                -- arcane_torrent,if=runic_power.deficit>20
                -- blood_fury,if=buff.pillar_of_frost.up
                -- berserking,if=buff.pillar_of_frost.up
                if isChecked("种族技能") and (((br.player.race == "Troll" or br.player.race == "Orc") and buff.pillarOfFrost.exists())
                    or (br.player.race == "BloodElf" and runicPowerDeficit > 20)) and getSpellCD(racial) == 0
                then
                    if castSpell("player",racial,false,false,false) then return end
                end
            -- Potion
                if useCDs() and isChecked("爆发药水") and getDistance("target") < 15 and not isDummy() and not playertar then
                    --Old War
                    if hasItem(127844) and canUse(127844) then
                        useItem(127844)
                    end
                    --Prolongued Power
                    if hasItem(142117) and canUse(142117) then
                        useItem(142117)
                    end
                end
            end -- End Use Cooldowns Check
        end -- End Action List - Cooldowns
    ---------------------------------------------------------------------------------------------------------------------------------
    -- Action List - Pre-Combat
    ---------------------------------------------------------------------------------------------------------------------------------
        local function actionList_PreCombat()
        	if isChecked("调试信息") then Print("actionList_PreCombat") end
        -- Flask / Crystal
            -- flask,name=countless_armies
            if isChecked("奥拉留斯的低语水晶") and not (IsFlying() or IsMounted()) then
                if (raid or solo) and not (buff.strenthFlaskLow or buff.strengthFlaskBig) then--Draenor Str Flasks
                    if not UnitBuffID("player",176151) and canUse(118922) then --Draenor Insanity Crystal
                        if br.player.useCrystal() then return end
                    end
                end
            end
        -- Food
            -- food,type=food,name=fishbrul_special
            -- TODO
        -- Augmentation
            -- augmentation,name=defiled
            -- TODO
        -- Potion
            -- potion,name=old_war
            -- TODO
        -- Pre-pull
            if isChecked("Pre-Pull Timer") and pullTimer <= getOptionValue("Pre-Pull Timer") then

            end -- Pre-Pull
        -- Start Attack
            if isValidUnit("target") and not inCombat then
                StartAttack()
            end
        end -- End Action List - PreCombat
    ---------------------------------------------------------------------------------------------------------------------------------
	-- Action List - Breath of Sindragosa	-----------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------------------------------------
        local function actionList_BreathOfSindragosa()       
        	if isChecked("调试信息") then Print("actionList_BreathOfSindragosa") end
        -- Frost Strike
            -- frost_strike,if=talent.icy_talons.enabled&buff.icy_talons.remains<1.5&cooldown.breath_of_sindragosa.remains>6
            if talent.icyTalons 
            	and buff.icyTalons.remain() < 1.5 
            	and cd.breathOfSindragosa > 6 
            	and not cloak
            	and not immun
            then
                if cast.frostStrike() then return end
            end
        -- Remorseless Winter
            -- remorseless_winter,if=talent.gathering_storm.enable
            if (talent.gatheringStorm or buff.pillarOfFrost.exists()) 
            	and getDistance("target") < 8 
            	and (not playertar or cd.pillarOfFrost > 10 or buff.pillarOfFrost.exists() or bop)  
                and (cd.breathOfSindragosa > 24 or normalMob or (cd.breathOfSindragosa < 24 and hasEquiped(137223) and cd.hungeringRuneWeapon > 0))
            	and not immun
            	and not cloak
            then
                if cast.remorselessWinter() then return end
            end
        -- Howling Blast
            -- howling_blast,target_if=!dot.frost_fever.ticking
            if normalMob and (not debuff.frostFever.exists("target") or debuff.frostFever.remain("target") < 1.5 or (bop and runicPower < 25))
            	and not immun
            	and not cloak
            then
                if cast.howlingBlast() then return end
            end
        -- Breath of Sindragosa
            -- breath_of_sindragosa,if=runic_power>=50
            if (useCDs() or playertar) 
            	and isChecked("冰龙吐息") 
            	and cd.breathOfSindragosa <= 0 
            	and (cd.hungeringRuneWeapon <= 0 or (not playertar and not hasEquiped(137223)))
            	and not immun
            	and not cloak
            then
                if (BL and runicPower >= 70 and runes > 2 ) or (runicPower >= 80 and runes > 3)
                    and getDistance("target") < 5
                then
                    if cast.breathOfSindragosa() then return end
                end
            end       
        -- Howling Blast
            -- howling_blast,if=buff.rime.react&(dot.remorseless_winter.ticking|cooldown.remorseless_winter.remain()s>1.5|!equipped.132459)
            if buff.rime.exists() 
            	and ((t19_4pc and runicPower < 90) or not t19_4pc)
            	and (buff.remorselessWinter.exists() or (cd.remorselessWinter > 1.5) or cd.breathOfSindragosa < 24 or (cd.breathOfSindragosa < 24 and hasEquiped(137223) and cd.hungeringRuneWeapon > 0) ) 
            	and not immun
            	and not cloak
            then
                if cast.howlingBlast() then return end
            end
        -- Obliterate
            -- obliterate,if=!buff.rime.react&!(talent.gathering_storm.enabled&!(cooldown.remorseless_winter.remains>2|rune>4))&rune>3
            if not buff.rime.exists() 
                and ((cd.breathOfSindragosa <= 1.5 and runicPower <= 80)
                or (cd.breathOfSindragosa > 1.5 and runicPower <= 70))
            	and (not (talent.gatheringStorm and not (cd.remorselessWinter > 2 or runes > 4)) or cd.breathOfSindragosa < 24 or (cd.breathOfSindragosa < 24 and hasEquiped(137223) and cd.hungeringRuneWeapon > 0) ) 
            	and runes > 3
            	and not immun
            	and not bop
            then
                if cast.obliterate() then return end
            end
        -- Frost Strike
            -- frost_strike,if=runic_power>=70|((talent.gathering_storm.enabled&cooldown.remorseless_winter.remains<3&cooldown.breath_of_sindragosa.remains>10)&rune<5)
            if (runicPower >= 70 or bop)
            	and (cd.breathOfSindragosa > 6 or (cd.breathOfSindragosa <= 0 and normalMob) or (cd.breathOfSindragosa < 24 and hasEquiped(137223) and cd.hungeringRuneWeapon > 6))
            	and not (php < getOptionValue("灵界打击"))
            	and not immun
            	and not cloak
            then
                if cast.frostStrike() then return end
            end
        -- Horn of Winter
            -- horn_of_winter,if=cooldown.breath_of_sindragosa.remains>15&runic_power<=70&rune<4
            if cd.breathOfSindragosa > 15 and runicPower <= 70 and runes < 4 then
                if cast.hornOfWinter() then return end
            end
        -- Remorseless Winter
            -- remorseless_winter,if=cooldown.breath_of_sindragosa.remains>10
            if (cd.breathOfSindragosa > 10 or (cd.breathOfSindragosa < 24 and hasEquiped(137223) and cd.hungeringRuneWeapon > 0))
            	and getDistance(units.dyn5) < 5
            	and not immun
            	and not cloak 
            then
                if cast.remorselessWinter() then return end
            end
        end
    --------------------------------------------------------------------------------------------------------------------------------------------    
    -- Action List - Breath of Sindragosa Ticking
    --------------------------------------------------------------------------------------------------------------------------------------------
        local function actionList_BreathOfSindragosaTicking()
        	if isChecked("调试信息") then Print("actionList_BreathOfSindragosaTicking") end
        --Cancel Breath if IceboundFortitude exists
        	if buff.iceboundFortitude.exists() and isChecked("Cancel BoS on IBF") and playertar then
                Print("IBF -> Cancel BoS")
        		CancelUnitBuff("player","冰龙吐息")
        		return
        	end
        --Cancel Breath on Thornes
        	if UnitBuff("target","Thorns") ~= nil and isChecked("Cancel BoS on Thornes") and playertar then
        		Print("Thorns -> Cancel BoS")
        		CancelUnitBuff("player","冰龙吐息")
        		return
        	end
        -- Horn of Winter
            -- horn_of_winter,if=runic_power<70&!buff.hungering_rune_weapon.up&rune<5
            if talent.hornOfWinter 
                and runicPower < 70 
                and runes < 3 
                and not buff.hungeringRuneWeapon.exists() then 
                if cast.hornOfWinter() then return end
            end
        -- Remorseless Winter
            -- remorseless_winter,if=runic_power>=30&((buff.rime.react&equipped.132459)|(talent.gathering_storm.enabled&(dot.remorseless_winter.remains<=gcd|!dot.remorseless_winter.ticking)))
            if runicPower >= 35 
                and getDistance("target") < 8 
                and not immun
            	and not cloak
            then
                if cast.remorselessWinter() then return end
            end
        -- Howling Blast
            -- howling_blast,if=((runic_power>=20&set_bonus.tier19_4pc)|runic_power>=30)&buff.rime.react
            if  buff.rime.exists()
                and
                (
                 (runicPower > 40 and runes >= 2)
                 or (runicPower > 50) 
                 or (t19_4pc and runicPower > 40)
                )
            	and (not buff.hungeringRuneWeapon.exists() or t19_4pc)
            	and not immun
            	and not cloak
            then
                if cast.howlingBlast() then return end
            end
        -- Obliterate
            -- obliterate,if=runic_power<=75|rune>3
            if runicPower <= 75 
            	and not immun
            	and not bop
            then
                if cast.obliterate() then return end
            end
       
        -- Hungering Rune Weapon
            if isChecked("符文武器") then 
                -- hungering_rune_weapon,if=talent.runic_attenuation.enabled&runic_power<30&!buff.hungering_rune_weapon.up&rune<2
                if  talent.hornOfWinter and talent.runicAttenuation and runicPower < 30 and not buff.hungeringRuneWeapon.exists() and cd.hornOfWinter ~= 0 then 
                    if cast.hungeringRuneWeapon() then return end
                end
                -- hungering_rune_weapon,if=runic_power<25&!buff.hungering_rune_weapon.up&rune<2
                if not buff.hungeringRuneWeapon.exists() 
                    and (
                        runicPower <= 30
                        or (runicPower <= 40 and runes < 2)
                        )
                then --and runes < 2 then
                    if cast.hungeringRuneWeapon() then return end
                end
        -- Empower Rune Weapon
                -- empower_rune_weapon,if=runic_power<20
                if runicPower < 20 and cd.hornOfWinter ~= 0 then
                    if cast.empowerRuneWeapon() then return end
                end
            end
        end
    --------------------------------------------------------------------------------------------------------------------------------------------    
    -- Action List - Generic
    --------------------------------------------------------------------------------------------------------------------------------------------
        local function actionList_Generic()
        	if isChecked("调试信息") then Print("actionList_Generic") end
        -- Frost Strike
            -- frost_strike,if=!talent.shattering_strikes.enabled&(buff.icy_talons.remains<1.5&talent.icy_talons.enabled)
            if (talent.icyTalons and (buff.icyTalons.remain() < 1.5 or not buff.icyTalons.exists()))
            	and not immun
            	and not cloak
            	and not buff.iceboundFortitude.exists()
            then
                if cast.frostStrike() then return end
            end
        -- Howling Blast
            -- howling_blast,target_if=!dot.frost_fever.ticking
            if (not debuff.frostFever.exists("target") or (bop and runicPower < 25))
            	and not immun
            	and not cloak
            then
                if cast.howlingBlast() then return end
            end
        --Frost Strike to avoid max RP
        	if (runicPower >= 70 or bop)
            	and not (php < getOptionValue("灵界打击") and (cd.iceboundFortitude > 0))
            	and not immun
            	and not cloak
            	and not buff.iceboundFortitude.exists()
            then
                if cast.frostStrike() then return end
            end
        -- Remorseless Winter
        	if getDistance("target") < 8 
            	and buff.pillarOfFrost.exists()
            	and not buff.obliteration.exists()
            	and not immun
            	and not cloak
            then
                if cast.remorselessWinter() then return end
            end
        -- Howling Blast
            -- howling_blast,if=buff.rime.react&!(buff.obliteration.up&spell_targets.howling_blast<2)
            if (buff.rime.exists() or bop)
            	and not immun
            	and not cloak
            	and not buff.obliteration.exists()  
            then
                if cast.howlingBlast() then return end
            end
        -- Obliteration
            -- obliteration,if=(!talent.frozen_pulse.enabled|(rune<2&runic_power<28))&!talent.gathering_storm.enabled
            if isChecked("湮没") and( useCDs() or playertar) then
                if runes > 2 
                	and runicPower > 25
                	and not (cd.pillarOfFrost < 10)
                	and not immun
                	and not cloak
                	and not bop
                then
                    if cast.obliteration() then return end
                end
            end
        -- Frost Strike
            -- frost_strike,if=buff.obliteration.up&!buff.killing_machine.react
            if buff.obliteration.exists() 
            	and not buff.killingMachine.exists() 
            	and not buff.iceboundFortitude.exists()
            	and not immun
            	and not cloak
            then
                if cast.frostStrike() then return end
            end
        -- Obliterate
            -- obliterate,if=buff.killing_machine.react
            if buff.killingMachine.exists() 
            	and not immun
            	and not bop
            then
                if cast.obliterate() then return end
            end
        -- Remorseless Winter
        	if getDistance("target") < 8 
            	and (cd.pillarOfFrost > 10 or buff.pillarOfFrost.exists() or bop)  
            	and not immun
            	and not cloak
            then
                if cast.remorselessWinter() then return end
            end
        -- Obliterate
            if not immun
            	and not bop
            	and (not (cd.obliteration == 0) or runicPower < 25)
            then
            	if cast.obliterate() then return end
            end
        -- Frost Strike
        	if (runicPower > 40)
            	and not (php < getOptionValue("灵界打击") and (cd.iceboundFortitude > 0))
            	and not immun
            	and not cloak
            	and not buff.iceboundFortitude.exists()
            then
                if cast.frostStrike() then return end
            end
        -- Empower/Hungering Rune Weapon
            if isChecked("符文武器") and (useCDs() or playertar) 
            	and runicPower < 75
            	and runes < 2
            	and cd.obliteration == 0
            then
        -- Empower Rune Weapon
                -- empower_rune_weapon
                if cast.empowerRuneWeapon() then return end
        -- Hungering Rune Weapon
                -- hungering_rune_weapon,if=!dot.hungering_rune_weapon.ticking
                if not buff.hungeringRuneWeapon.exists() then
                    if cast.hungeringRuneWeapon() then return end
                end
            end
        end
    --------------------------------------------------------------------------------------------------------------------------------------------    
    -- Action List - Gathering Storm Ticking
    --------------------------------------------------------------------------------------------------------------------------------------------
        local function actionList_GatheringStormTicking()
        if isChecked("调试信息") then Print("actionList_GatheringStormTicking") end
        -- Frost Strike
            -- frost_strike,if=buff.icy_talons.remains<1.5&talent.icy_talons.enabled
           if (talent.icyTalons and (buff.icyTalons.remain() < 1.5 or not buff.icyTalons.exists()))
                and not immun
                and not cloak
                and not buff.iceboundFortitude.exists()
            then
                if cast.frostStrike() then return end
            end
        -- Howling Blast
            -- howling_blast,target_if=!dot.frost_fever.ticking
            if not debuff.frostFever.exists(units.dyn30) then
                if cast.howlingBlast() then return end
            end
            -- howling_blast,if=buff.rime.react&!(buff.obliteration.up&spell_targets.howling_blast<2)
            if buff.rime.exists() and not (buff.obliteration.exists() and ((mode.rotation == 1 and #enemies.yards10t < 2) or mode.rotation == 3)) then
                if cast.howlingBlast() then return end
            end
        -- Obliteration
            -- obliteration,if=(!talent.frozen_pulse.enabled|(rune<2&runic_power<28))
            if isChecked("湮没") and (useCDs() or playertar) then
                if not talent.frozenPulse or (runes < 2 and runicPower < 28) then
                    if cast.obliteration() then return end
                end
            end
        -- Obliterate
            -- obliterate,if=rune>3|buff.killing_machine.react|buff.obliteration.up
            if runes > 3 or buff.killingMachine.exists() or buff.obliteration.exists() then
                if cast.obliterate() then return end
            end
        -- Frost Strike
            -- frost_strike,if=runic_power>80|(buff.obliteration.up&!buff.killing_machine.react)
            if runicPower > 80 or (buff.obliteration.exists() or not buff.killingMachine.exists()) then
                if cast.frostStrike() then return end
            end
        -- Obliterate
            -- obliterate
            if cast.obliterate() then return end
        -- Horn of Winter
            -- horn_of_winter,if=runic_power<70&!dot.hungering_rune_weapon.ticking
            if runicPower < 70 and not buff.hungeringRuneWeapon.exists() then
                if cast.hornOfWinter() then return end
            end
        -- Glacial Advance
            -- glacial_advance
            if #enemies.yards10 >= getOptionValue("冰川突进") then
                if cast.glacialAdvance("player") then return end
            end
        -- Frost Strike
            -- frost_strike
            if cast.frostStrike() then return end
            if isChecked("符文武器") and (useCDs() or playertar) then
        -- Hungering Rune Weapon
                -- hungering_rune_weapon,if=!dot.hungering_rune_weapon.ticking
                if not buff.hungeringRuneWeapon.exists() then
                    if cast.hungeringRuneWeapon() then return end
                end
        -- Empower Rune Weapon
                -- empower_rune_weapon
                if cast.empowerRuneWeapon() then return end
            end
        end
-------------------------------------------------------------------------------------------------------------------------------------
--- Begin Profile ---
-------------------------------------------------------------------------------------------------------------------------------------
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
            if inCombat and profileStop==false and isValidUnit(units.dyn5) then
    ------------------------------------
    --- In Combat - EYE OF LEOTHERAS ---
    ------------------------------------
                if isChecked("莱欧瑟拉斯之眼") and UnitDebuff("player","莱欧瑟拉斯之眼") ~= nil then
                    ClearTarget()
                    Print("Warning : Eye of Leotheras detected")
                    return
                end
                if isChecked("自动目标") 
                    and not GetObjectExists("target")
                    or (not UnitIsEnemy("target", "player") and not UnitIsDeadOrGhost("target")) 
                then
                    if #enemies.yards8 > 0 and UnitAffectingCombat(enemies.yards8[1]) then
                        TargetUnit(enemies.yards8[1])
                    end
                end
    -------------------------------           
    --- In Combat - AUTO ATTACK ---
    -------------------------------
                if getDistance(units.dyn5) < 5 then
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
        -- Singragosa's Fury
	                -- sindragosas_fury,if=buff.pillar_of_frost.up&(buff.unholy_strength.up|(buff.pillar_of_frost.remains<3&target.time_to_die<60))&debuff.razorice.stack=5&!buff.obliteration.up
	                if getOptionValue("神器技能") == 1 or (getOptionValue("神器技能") == 2 and (useCDs() or playertar)) then
	                    if buff.pillarOfFrost.exists() and (buff.unholyStrength.exists() or (buff.pillarOfFrost.remain() < 3 ))
	                        and debuff.razorice.stack(units.dyn5) == 5 and not buff.obliteration.exists()
	                        and #enemies.yards40 >= getOptionValue("神器技能 数量") and getFacing("player",units.dyn8)
	                    then
	                        if cast.sindragosasFury() then return end
	                    end
	                end
        -- Generic
	                -- call_action_list,name=generic,if=!talent.breath_of_sindragosa.enabled&!(talent.gathering_storm.enabled&buff.remorseless_winter.remains)
	                if not talent.breathOfSindragosa and not (talent.gatheringStorm and buff.remorselessWinter.exists()) then
	                    if actionList_Generic() then return end
	                end
        -- Breath of Sindragosa
	                -- call_action_list,name=bos,if=talent.breath_of_sindragosa.enabled&!dot.breath_of_sindragosa.ticking
	                if talent.breathOfSindragosa and not buff.breathOfSindragosa.exists() then
	                    if actionList_BreathOfSindragosa() then return end
	                end
	                -- call_action_list,name=bos_ticking,if=talent.breath_of_sindragosa.enabled&dot.breath_of_sindragosa.ticking
	                if talent.breathOfSindragosa and buff.breathOfSindragosa.exists() then
	                    if actionList_BreathOfSindragosaTicking() then return end
	                end
        -- Gathering Storm
                    -- call_action_list,name=gs_ticking,if=talent.gathering_storm.enabled&buff.remorseless_winter.remain()s&!talent.breath_of_sindragosa.enabled
                    if talent.gatheringStorm and buff.remorselessWinter.exists() and not talent.breathOfSindragosa then
                        if actionList_GatheringStormTicking() then return end
                    end
    ---------------------------
    --- Queue               ---
    -------------------------

                    if #br.player.queue ~= 0 and isChecked("法术队列清除") then
                        for i = 1, #br.player.queue do
                            if br.player.queue[i].name == nil then
                                tremove(br.player.queue,i)
                            elseif getSpellCD(br.player.queue[i].name) >=  getOptionValue("法术队列清除") then
                                Print("Removed |cFFFF0000"..br.player.queue[i].name.. "|r cause CD")
                                tremove(br.player.queue,i)
                            end
                        end
                    end
            end -- End Combat Check
        end -- End Rotation Pause
    end -- End Timer
end -- runRotation
local id = 251
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})
