local rotationName = "THUnholy" -- Change to name of profile listed in options drop down

---------------
--- Toggles ---
---------------
local function createToggles() -- Define custom toggles
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "基于范围内的目标数,在单目标和多目标自动切换输出方式.", highlight = 0, icon = br.player.spell.deathAndDecay },
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "使用多目标方式输出.", highlight = 0, icon = br.player.spell.deathAndDecay },
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "使用单目标方式输出.", highlight = 0, icon = br.player.spell.furiousSlash },
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "禁用DPS输出", highlight = 0, icon = br.player.spell.enragedRegeneration}
    };
    CreateButton("Rotation",1,0)
-- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "自动使用大技能 - 只在BOSS.", highlight = 1, icon = br.player.spell.summonGargoyle },
        [2] = { mode = "On", value = 2 , overlay = "Cooldowns Enabled", tip = "不管任何目标都使用大技能.", highlight = 0, icon = br.player.spell.darkArbiter },
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "不使用大技能.", highlight = 0, icon = br.player.spell.battleCry }
    };
    CreateButton("Cooldown",2,0)
-- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "使用保命技能.", highlight = 1, icon = br.player.spell.corpseShield },
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "不使用保命技能.", highlight = 0, icon = br.player.spell.enragedRegeneration }
    };
    CreateButton("Defensive",3,0)
-- Interrupt Button
    InterruptModes = {
        [1] = { mode = "On", value = 1 , overlay = "Interrupts Enabled", tip = "使用打断.", highlight = 1, icon = br.player.spell.mindFreeze },
        [2] = { mode = "Off", value = 2 , overlay = "Interrupts Disabled", tip = "不使用打断.", highlight = 0, icon = br.player.spell.pummel }
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
        --- GENERAL OPTIONS --- -- Define General Options
        -----------------------
        section = br.ui:createSection(br.ui.window.profile,  "一般")
            -- Dummy DPS Test
            br.ui:createSpinner(section, "DPS测试",  5,  5,  60,  5,  "|cffFFFFFF设置为所需的测试的时间（分钟）. 最小: 5 / 最大: 60 / 间隔: 5")
            -- Remove Spells from queue with CD
            br.ui:createSpinner(section, "法术队列清除",  5,  0,  100,  5,  "|cffFFBB00如果cd更大，删除法术.")
            --Autotarget
            br.ui:createCheckbox(section,"自动目标","没有/友好目标在8码内切换到敌人")
            -- Debug
            br.ui:createCheckbox(section,"调试信息")

        br.ui:checkSectionState(section)
        ------------------------
        --- COOLDOWN OPTIONS --- -- Define Cooldown Options
        ------------------------
        section = br.ui:createSection(br.ui.window.profile,  "冷却技能")
            -- Racial
            br.ui:createCheckbox(section,"种族技能")
            -- Potion of prolongued Power
            br.ui:createCheckbox(section,"药水")
            -- Dark Transformation
            br.ui:createDropdownWithout(section, "黑暗突变", {"|cff00FF00Units or Boss","|cffFFFF00Cooldowns","|cffFF0000Never"}, 1, "|cffFFFFFFWhen to use Dark Transformation ability.")
            br.ui:createSpinnerWithout(section, "黑暗突变目标数量",  1,  1,  10,  1,  "|cffFFFFFFSet to desired targets to use Dark Transformation on. Min: 1 / Max: 10 / Interval: 1")
            --Death and Decay
            br.ui:createSpinnerWithout(section, "枯萎凋零", 1, 1, 10, 1, "|cffFFFFFFSet to desired targets to use Death and Decay on. Min: 1 / Max: 10 / Interval: 1")
            br.ui:createSpinnerWithout(section, "DnD Festering Wounds", 1, 0, 8, 1, "|cffFFFFFFSet to Number of Wounds must exists before DnD. Min: 0 / Max: 8")
            --Asphyxiate
            --br.ui:createCheckbox(section,"Asphyxiate")
            --Summon Gargoyle
            br.ui:createCheckbox(section,"召唤石像鬼")

        br.ui:checkSectionState(section)
        ------------------------
        --- Pet OPTIONS --- -- 
        ------------------------
        section = br.ui:createSection(br.ui.window.profile, "宠物")
        -- Auto Summon
            br.ui:createCheckbox(section,"自动召唤")
        --Auto Attack
            br.ui:createCheckbox(section,"自动攻击")
         br.ui:checkSectionState(section)    
        -------------------------
        --- DEFENSIVE OPTIONS --- -- Define Defensive Options
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, "保命")
            -- Healthstone
            br.ui:createSpinner(section, "治疗石",  61,  0,  100,  5,  "|cffFFBB00多少百分比血量使用.")
             -- Anti-Magic Shell
            br.ui:createSpinner(section, "反魔法护罩",  75,  0,  100,  5,  "|cffFFFFFF多少百分比血量使用")
             -- Death Strike
            br.ui:createSpinner(section, "灵界打击",  70,  0,  100,  5,  "|cffFFFFFF多少百分比血量使用")
            -- Icebound Fortitude
            br.ui:createSpinner(section, "冰封之韧",  35,  0,  100,  5,  "|cffFFFFFF多少百分比血量使用")
            -- Corpse Shield
            br.ui:createSpinner(section, "血肉之盾",  59,  0,  100,  5,  "|cffFFFFFF多少百分比血量使用")
            -- Raise Ally
            br.ui:createCheckbox(section,"复活盟友")
            br.ui:createDropdownWithout(section, "复活盟友 - 目标", {"|cff00FF00目标","|cffFF0000鼠标位置"}, 1, "|cffFFFFFF施放目标")

        br.ui:checkSectionState(section)
        -------------------------
        --- INTERRUPT OPTIONS --- -- Define Interrupt Options
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, "打断")
            -- Leap
            br.ui:createCheckbox(section,"跳跃")
            -- Mind Freeze
            br.ui:createCheckbox(section,"心灵冰冻")
            -- Asphyxiate Kick
            br.ui:createCheckbox(section,"窒息")
            -- DeathGrip
            br.ui:createCheckbox(section,"死亡之握")
            -- Interrupt Percentage
            br.ui:createSpinner(section,  "打断",  17,  0,  85,  5,  "|cffFFBB00读条百分几打断.")    
        br.ui:checkSectionState(section)

        ---------------------
        --- PVP Option    ---
        ---------------------
         section = br.ui:createSection(br.ui.window.profile,  "PVP选项")
            -- Necrotic Strike
            br.ui:createCheckbox(section,"死疽打击")
            -- Chains of Ice
            br.ui:createCheckbox(section,"寒冰锁链")
            -- Chians of Ice Focus
            br.ui:createCheckbox(section,"寒冰锁链 焦点", "Chains focus target")
            -- AMS Counter
            br.ui:createCheckbox(section,"AMS Counter")
            -- Necro Spam
            br.ui:createSpinner(section,  "Necro Spam",  45,  0,  100,  5,  "|cffFFBB00Prefer Necro at X percent dampening.")
            --Eye of Leotheras
            br.ui:createCheckbox(section, "莱欧瑟拉斯之眼", "Pause CR on Eye of Leotheras Debuff")
         br.ui:checkSectionState(section)
        ----------------------
        --- TOGGLE OPTIONS --- -- Degine Toggle Options
        ----------------------
        section = br.ui:createSection(br.ui.window.profile,  "快捷键")
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
    if br.timer:useTimer("debugUnholy", 0.1) then --change "debugFury" to "debugSpec" (IE: debugFire)
        --Print("Running: "..rotationName)

---------------
--- Toggles --- -- List toggles here in order to update when pressed
---------------
        UpdateToggle("Rotation",0.25)
        UpdateToggle("Cooldown",0.25)
        UpdateToggle("Defensive",0.25)
        UpdateToggle("Interrupt",0.25)
--------------
--- Locals ---
--------------
        local lastSpell         = lastCast
        local bop               = UnitBuff("target","Blessing of Protection") ~= nil
        local cloak             = UnitBuff("target","Cloak of Shadows") ~= nil or UnitBuff("target","Anti-Magic Shell") ~= nil
        local immunDS           = UnitBuff("target","Divine Shield") ~= nil 
        local immunIB           = UnitBuff("target","Ice Block") ~= nil
        local immunAotT         = UnitBuff("target","Aspect of the Turtle") ~= nil
        local immunCyclone      = UnitBuff("target","Cyclone") ~= nil
        local immun             = immun or immunIB or immunAotT or immunDS or immunCyclone
        local attacktar         = UnitCanAttack("target", "player")
        local buff              = br.player.buff
        local cast              = br.player.cast
        local cd                = br.player.cd
        local charges           = br.player.charges
        local deadtar           = UnitIsDeadOrGhost("target") or isDummy()
        local playertar         = UnitIsPlayer("target")
        local debuff            = br.player.debuff
        local enemies           = enemies or {}
        local petMinion         = false
        local petRisen          = false
        local gcd               = br.player.gcd
        local glyph             = br.player.glyph
        local inCombat          = br.player.inCombat
        local level             = br.player.level
        local mode              = br.player.mode
        local moving            = GetUnitSpeed("player")>0
        local normalMob         = not(useCDs() or playertar)
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
        if profileStop == nil then profileStop = false end
        if waitfornextVirPlague == nil or objIDLastVirPlagueTarget == nil then
            waitfornextVirPlague = GetTime() - 10
            objIDLastVirPlagueTarget = 0
        end 
        if waitForPetToAppear == nil then waitForPetToAppear = 0 end
        if waitforNextKick == nil then waitforNextKick = 0 end     
        if waitfornextPrint == nil or printevery2S == nil then
            waitfornextPrint = GetTime()
            printevery2S = true
        elseif waitfornextPrint <= GetTime() -2 then
            printevery2S = true
            waitfornextPrint = GetTime()
        else
            printevery2S = false
        end
        if waitforNextIoC == nil then waitforNextIoC = 0 end
        if waitforNextIoCFocus == nil then waitforNextIoCFocus = 0 end

-------------------
--- Raise Pet   ---
-------------------
        if not inCombat and not IsMounted() and isChecked("自动召唤") and not GetUnitExists("pet") and (UnitIsDead("pet") ~= nil or UnitIsDead("pet") == false) then
            if waitForPetToAppear ~= nil and waitForPetToAppear < GetTime() - 2 and onlyOneTry ~= nil and not onlyOneTry then
                onlyOneTry = true
                if cast.raiseDead() then return end
            end

            if waitForPetToAppear == nil then
                waitForPetToAppear = GetTime()
            end
        else
            onlyOneTry = false
        end

--------------------
--- Action Lists ---
--------------------
    ---------------------------------------------------------------------------------------------------------------------------------
    -- Action List - Cooldowns
    ---------------------------------------------------------------------------------------------------------------------------------
        local function actionList_Cooldowns()
            if isChecked("调试信息") then Print("actionList_Cooldowns") end
        --Racial
            if isChecked("种族技能") and (((br.player.race == "Troll" or br.player.race == "Orc"))
                or (br.player.race == "BloodElf" and runicPowerDeficit > 20)) and getSpellCD(racial) == 0
                and (not talent.soulReaper or (not debuff.soulReaper.exists("target") or buff.soulReaper.stack("player") == 3))
                and getDistance("target") < 5
            then
                if castSpell("player",racial,false,false,false) then return end
            end
        --Dark Transformation
            if  (    
                    (   getOptionValue("黑暗突变") == 1 --Units or Boss
                        and #enemies.yards10 >= getOptionValue("黑暗突变目标数量") 
                        or useCDs() 
                        or playertar
                    )   
                    or 
                    (   getOptionValue("黑暗突变") == 2 --Cooldown only
                        and (
                                useCDs() or playertar
                            )
                    )
                )
                and not immun
                and not bop
                and (((hasEquiped(137075) and not (cd.apocalypse < 10)) or playertar) or not hasEquiped(137075))
                and getDistance("target") < 5
                and (not talent.darkArbiter or (talent.darkArbiter and cd.summonGargoyle > 60))
                and (not talent.soulReaper or (not debuff.soulReaper.exists("target") or buff.soulReaper.stack("player") == 3))
                and not (buff.soulReaper.stack("player") == 3 and cd.summonGargoyle <= 0)
            then
                if cast.darkTransformation() then return end
            end
        --Death and Decay
            if #enemies.yards10 >= getOptionValue("枯萎凋零") and debuff.festeringWound.stack("target") >= getOptionValue("DnD Festering Wounds") and not isMoving("player") then
                if cast.deathAndDecay("player") then return end
            end
        --Potion
            if useCDs() and isChecked("药水") and getDistance("target") < 15 and not isDummy() and not playertar then
                --Old War
                if hasItem(127844) and canUse(127844) then
                    useItem(127844)
                end
                --Prolongued Power
                if hasItem(142117) and canUse(142117) then
                    useItem(142117)
                end
            end
        --Blighted Runeweapon
            if talent.blightedRuneWeapon
                and (not talent.soulReaper or (not debuff.soulReaper.exists("target") or buff.soulReaper.stack("player") == 3))
                and getDistance("target") < 5
                and not immun
                and not bop 
            then
                if cast.blightedRuneWeapon() then return end
            end
        --Summon Gargoyle
            if isChecked("召唤石像鬼") 
                and (useCDs() or playertar)
                and (not talent.soulReaper or buff.soulReaper.stack("player") == 3 or (not debuff.soulReaper.exists("target") and cd.soulReaper > 30))
                and cd.summonGargoyle <= 0 
                and (not talent.darkArbiter or runicPowerDeficit <= 10)
            then
                if cast.summonGargoyle() then return end               
            end
        end
    ---------------------------------------------------------------------------------------------------------------------------------    
    -- Action List - Defensive
    ---------------------------------------------------------------------------------------------------------------------------------
        local function actionList_Defensive()
            if isChecked("调试信息") then Print("actionList_Defensive") end
            if useDefensive() and not IsMounted() and inCombat then
            --- AMS Counter
                if isChecked("AMS Counter") 
                    and UnitDebuff("player","Soul Reaper") ~= nil
                then                    
                    if cast.antiMagicShell() then print("AMS Counter - Soul Reaper") return end
                end
            --Healthstone
                if isChecked("治疗石") 
                    and php <= getOptionValue("治疗石")
                    and hasItem(5512)
                then
                    if canUse(5512) then
                        useItem(5512)
                    end
                end
            -- Death Strike
                if isChecked("灵界打击") 
                    and (buff.darkSuccor.exists() and (php < getOptionValue("灵界打击") or buff.darkSuccor.remain() < 2))
                    or  runicPower >= 45  
                    and php < getOptionValue("灵界打击") 
                    and (not talent.darkArbiter or (cd.darkArbiter <= 3 and not (useCDs() or playertar)))
                then
                     -- Death strike everything in reach
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
            -- Icebound Fortitude
                if isChecked("冰封之韧") 
                    and php < getOptionValue("冰封之韧") 
                then
                    if cast.iceboundFortitude() then return end
                end
            -- Corpse Shield
                if isChecked("血肉之盾") 
                    and php < getOptionValue("血肉之盾") 
                then
                    if cast.corpseShield() then return end
                end
            -- Anti-Magic Shell
                if isChecked("反魔法护罩") and php <= getOptionValue("反魔法护罩") then
                    if cast.antiMagicShell() then return end
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
        end
    ---------------------------------------------------------------------------------------------------------------------------------
    -- Action List - DebuffReader
    ---------------------------------------------------------------------------------------------------------------------------------
        local function actionList_DebuffReader()
            if startDampeningTimer == nil then startDampeningTimer = false end
            if printDampeningTimer == nil then printDampeningTimer = true end

            if debuff.dampening.exists("player") and not startDampeningTimer then
                startDampeningTimer = true
                printDampeningTimer = true
                dampeningStartTime = GetTime()                            
            elseif not debuff.dampening.exists("player") then
                startDampeningTimer = false
            end

            if startDampeningTimer then
                dampeningCount = math.floor((GetTime() - dampeningStartTime) / 10) + 1
            else
                dampeningCount = 0
            end
            if isChecked("Necro Spam") and dampeningCount >= getOptionValue("Necro Spam")  and printDampeningTimer then
                Print("Dampening level reached -> Necro Spam active")
                printDampeningTimer = false
            end
        end
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
                        PetStopAttack()
                        PetPassiveMode()
                        Print(tonumber(getValue("DPS测试")) .." Minute Dummy Test Concluded - Profile Stopped")
                        return true
                    end
                end
            end
        -- Chains of Ice
            if isChecked("寒冰锁链") then
                if waitforNextIoC < GetTime() -1.5 then
                    if playertar 
                        and (not debuff.chainsOfIce.exists("target"))
                        and (not talent.soulReaper or not debuff.soulReaper.exists("target") or (buff.soulReaper.stack("player") == 3)  or  getDistance("target") > 5)
                        and not (UnitBuff("target","Blessing of Freedom") ~= nil)
                        and not immun
                        and not cloak
                        and isMoving("target") 
                        and getDistance("target") <= 30
                        and inCombat
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
                        and (not talent.soulReaper or not debuff.soulReaper.exists("target") or (buff.soulReaper.stack("player") == 3))
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
        --Virulent Plague
            if GetUnitExists("target") and ((objIDLastVirPlagueTarget ~= ObjectID("target")) or (waitfornextVirPlague < GetTime() - 6)) then
                if (not debuff.virulentPlague.exists("target")
                    or debuff.virulentPlague.remain("target") < 1.5) 
                    and not debuff.soulReaper.exists("target")
                    and not immun
                    and not cloak
                    and UnitIsDeadOrGhost("target") ~= nil
                then
                    if cast.outbreak("target","aoe") then 
                        waitfornextVirPlague = GetTime() 
                        objIDLastVirPlagueTarget = ObjectID("target")
                        return 
                    end
                end
                for i = 1, #enemies.yards30 do
                    local thisUnit = enemies.yards30[i]
                    if not debuff.virulentPlague.exists(thisUnit) 
                        and UnitAffectingCombat(thisUnit) 
                        and not cloak
                        and not immun
                    then
                        if cast.outbreak(thisUnit,"aoe") then 
                            waitfornextVirPlague = GetTime() 
                            return 
                        end
                        break
                    end
                end
            end
        end
    ---------------------------------------------------------------------------------------------------------------------------------
    -- Action List - Interrupts
    ---------------------------------------------------------------------------------------------------------------------------------
        local function actionList_Interrupts()
            if isChecked("调试信息") then Print("actionList_Interrupts") end
            if useInterrupts() then
                if waitforNextKick < GetTime() -2 then
                    if cd.mindFreeze <= 0 
                        or cd.deathGrip <= 0 
                        or cd.asphyxiate <= 0 
                        or (not talent.sludgeBelcher and cd.leap <= 0) 
                        or (talent.sludgeBelcher and cd.hook <= 0) 
                    then
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
                                -- Leap Dark Transormation
                                if getDistance(thisUnit) > 5
                                    and getDistance(thisUnit) < 30
                                then
                                    if talent.sludgeBelcher then
                                        if cast.hook(thisUnit) then waitforNextKick = GetTime(); print("Hook Kick"); kickCommited = true; return end
                                    elseif buff.darkTransformation.exists("pet")
                                    then
                                        if cast.leap(thisUnit) then waitforNextKick = GetTime(); print("Leap Kick"); kickCommited = true; return end
                                    end
                                end
                                -- Mind Freeze
                                if isChecked("心灵冰冻") 
                                   -- and cd.mindFreeze == 0 
                                    and getDistance(thisUnit) < 15 
                                    and getFacing("player",thisUnit) 
                                then
                                    if cast.mindFreeze(thisUnit) then waitforNextKick = GetTime(); print("Mind Freeze"); kickCommited = true; return end
                                end
                                --Asphyxiate
                                if isChecked("窒息") 
                                    and talent.asphyxiate
                                    and getDistance(thisUnit) < 20 
                                    and getFacing("player",thisUnit) 
                                then
                                    if cast.asphyxiate(thisUnit) then waitforNextKick = GetTime(); print("Asphyxiate Kick"); kickCommited = true; return end
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
                end --Timer
            end -- End Use Interrupts Check
        end -- End Action List - Interrupts
    ---------------------------------------------------------------------------------------------------------------------------------
    -- Action List - Pet Management
    ---------------------------------------------------------------------------------------------------------------------------------
        local function actionList_PetManagement()
            if isChecked("调试信息") then Print("actionList_PetManagement") end
            if not IsMounted() then
            --Corpse Shield
                if buff.corpseShield.exists() then
                    if talent.sludgeBelcher then
                        if cast.protectiveBile() then return end
                    else
                        if cast.huddle() then return end
                    end
                end
            --PetDismiss
                if getHP("pet") < 20 
                    and GetUnitExists("pet")
                    and not buff.corpseShield.exists() 
                then
                    print("Pet Dismiss - Low Health")
                    PetDismiss()
                end
            --Auto Summon
                if isChecked("自动召唤") and not GetUnitExists("pet") and (UnitIsDead("pet") ~= nil or UnitIsDead("pet") == false) then
                    if waitForPetToAppear < GetTime() - 2 then
                        if cast.raiseDead() then waitForPetToAppear = GetTime(); return end
                    end
                end
            -- Pet Attack / retreat
                if  isChecked("自动攻击") then
                    if inCombat and isValidUnit(units.dyn30) and getDistance(units.dyn30) < 30 then
                        if not UnitIsUnit("target","pettarget") and attacktar and not IsPetAttackActive() then
                            PetAttack()
                            PetAssistMode()
                        end
                    else
                        if IsPetAttackActive() then
                            PetStopAttack()
                            PetPassiveMode()
                        end
                    end
                end
            end
        end
    ---------------------------------------------------------------------------------------------------------------------------------
    -- Action List - Soul Reaper Debuff
    ---------------------------------------------------------------------------------------------------------------------------------
        local function actionList_SoulReaperDebuff()
        --Apocalypse
            if cd.apocalypse <= 0
                and debuff.festeringWound.stack("target") >= 7
                and not immun
                and not bop
            then
                if cast.apocalypse("target") then return end
            end
        --ScourgeStrike if Soulreaper
            if debuff.festeringWound.stack("target") >= 1
                and not immun
            then
                if talent.clawingShadows then
                    if cast.clawingShadows("target") then return end
                else
                    if cast.scourgeStrike("target") then return end
                end
            elseif not immun then
                if cast.festeringStrike("target") then return end
            end
        end
    ---------------------------------------------------------------------------------------------------------------------------------
    -- Action List - Soul Reaper
    ---------------------------------------------------------------------------------------------------------------------------------
        local function actionList_SoulReaper()
            if isChecked("调试信息") then Print("actionList_SoulReaper") end
            if printevery2S then
               -- print(runicPowerDeficit, runicPower, runes)
            end
           
          
        --Soul Reaper if artifact == 0 and festeringWound > 6
            if debuff.festeringWound.stack("target") >= 7
                and cd.apocalypse <= 0
                and not immun
                and not bop
                and not cloak
            then 
                if cast.soulReaper("target") then return end
            end  
        --Apocalypse
            if cd.apocalypse <= 0
                and cd.soulReaper > 10
                and debuff.festeringWound.stack("target") >= 7
                and not immun
                and not bop
            then
                if cast.apocalypse("target") then return end
            end
        --ScourgeStrike spam DnD
            if buff.deathAndDecay.exists("player")
                and #enemies.yards10 > 2
                and runicPowerDeficit > 13
                and not immun
                and not cloak
            then
                if playertar and isChecked("Necro Spam") and dampeningCount >= getOptionValue("Necro Spam") then 
                    if cast.necroticStrike("target") then
                        return 
                    elseif talent.clawingShadows then
                        if cast.clawingShadows("target") then return end
                    else
                        if cast.scourgeStrike("target") then return end
                    end
                elseif talent.clawingShadows then
                    if cast.clawingShadows("target") then return end
                else
                    if cast.scourgeStrike("target") then return end
                end
            end      
        --ScourgeStrike if Scourge of Worlds / Necrosis
            if (debuff.scourgeOfWorlds.exists("target")  or buff.necrosis.exists("player"))
                and debuff.festeringWound.stack("target") > 1
                and runicPowerDeficit > 13
                and (not (cd.apocalypse == 0) or getDistance("target") > 5 )
                and not (cd.soulReaper < 5)
                and not immun
                and not cloak
            then
                if playertar and isChecked("Necro Spam") and dampeningCount >= getOptionValue("Necro Spam") then 
                    if cast.necroticStrike("target") then
                        return 
                    elseif talent.clawingShadows then
                        if cast.clawingShadows("target") then return end
                    else
                        if cast.scourgeStrike("target") then return end
                    end
                elseif talent.clawingShadows then
                    if cast.clawingShadows("target") then return end
                else
                    if cast.scourgeStrike("target") then return end
                end
            end           
        --Death Coil
            if (runicPower >= 80
                or (buff.suddenDoom.exists() and buff.suddenDoom.remain() < 8))
                and (not buff.necrosis.exists("player") or ((not br.player.artifact.doubleDoom or buff.suddenDoom.stack("player") > 1) and buff.suddenDoom.remain() < 2) or runicPowerDeficit <= 20)
                and not immun
                and not cloak
            then
                if cast.deathCoil("target") then return end
            end
        --Festering Strike
            if ((debuff.festeringWound.stack("target") < 5)
                or (debuff.festeringWound.stack("target") < 8 and cd.apocalypse == 0))
                and not immun
                and not bop
                then
                if cast.festeringStrike("target") then return end
            end
        --Soul Reaper if not artifact== 0
            if debuff.festeringWound.stack("target") >= 3 
                and cd.soulReaper <= 0
                and not (cd.apocalypse <= 0) 
                and runes >= 3.6
                and not immun
                and not bop
                and not cloak
            then
                if cast.soulReaper("target") then return end
            end
        --Scourge
            if debuff.festeringWound.stack("target") > 3
                and (not (cd.soulReaper < 5) or runes > 4)
                and runes > 2
                and not immun
                and not cloak
            then
                if playertar and isChecked("死疽打击") then 
                    if cast.necroticStrike("target") then 
                        return 
                    elseif talent.clawingShadows then
                        if cast.clawingShadows("target") then return end
                    else
                        if cast.scourgeStrike("target") then return end
                    end
                elseif talent.clawingShadows then
                    if cast.clawingShadows("target") then return end
                else
                    if cast.scourgeStrike("target") then return end
                end
            end
        --Clawing Shadow  is out of range
            if  talent.clawingShadows 
                and getDistance("target") > 5 
                and runes > 2 
                and not cloak
                and not immun
            then
                if cast.clawingShadows("target") then return end
            end
        --DeathCoil
            if getDistance("target") > 5 
                and not immun
                and not cloak
            then
                if cast.deathCoil("target") then return end
            end
        end
    ---------------------------------------------------------------------------------------------------------------------------------
    -- Action List - Dark Arbiter
    ---------------------------------------------------------------------------------------------------------------------------------
        local function actionList_PreDarkArbiter()
        --Apocalypse
            if cd.apocalypse <= 0
                and debuff.festeringWound.stack("target") >= 7
                and not immun
                and not bop
            then
                if cast.apocalypse("target") then return end
            end
        --ScourgeStrike if Scourge of Worlds / Death and Decay
            if (debuff.scourgeOfWorlds.exists("target") or buff.deathAndDecay.exists())
                and debuff.festeringWound.stack("target") > 1
                and runicPower < 90
                and (not (cd.apocalypse == 0) or getDistance("target") > 5)
                and not immun
                and not cloak
            then
                if playertar and isChecked("Necro Spam") and dampeningCount >= getOptionValue("Necro Spam") then 
                    if cast.necroticStrike("target") then
                        return 
                    elseif talent.clawingShadows then
                        if cast.clawingShadows("target") then return end
                    else
                        if cast.scourgeStrike("target") then return end
                    end
                elseif talent.clawingShadows then
                    if cast.clawingShadows("target") then return end
                else
                    if cast.scourgeStrike("target") then return end
                end
            end           
        --Death Coil
            if normalMob or cd.darkArbiter >= 5 then
                if runicPowerDeficit <= 20
                    or (buff.suddenDoom.exists() and buff.suddenDoom.remain() < 8)
                
                    and (not buff.necrosis.exists("player") or buff.suddenDoom.remain() < 2 or runicPowerDeficit < 20)
                    and not immun
                    and not cloak
                then
                    if cast.deathCoil("target") then return end
                end
            end
        --Festering Strike
            if ((debuff.festeringWound.stack("target") < 5)
                or (debuff.festeringWound.stack("target") < 8 and cd.apocalypse == 0))
                and not immun
                and not bop
                then
                if cast.festeringStrike("target") then return end
            end
        --Scourge
            if debuff.festeringWound.stack("target") > 3
                and runes > 2
                and not immun
                and not cloak
            then
                if playertar and isChecked("死疽打击") then 
                    if cast.necroticStrike("target") then 
                        return 
                    elseif talent.clawingShadows then
                        if cast.clawingShadows("target") then return end
                    else
                        if cast.scourgeStrike("target") then return end
                    end
                elseif talent.clawingShadows then
                    if cast.clawingShadows("target") then return end
                else
                    if cast.scourgeStrike("target") then return end
                end
            end
        --Clawing Shadow  is out of range
            if  talent.clawingShadows 
                and getDistance("target") > 5 
                and runes > 2 
                and not cloak
                and not immun
            then
                if cast.clawingShadows("target") then return end
            end
        --DeathCoil
            if getDistance("target") > 5 
                and cd.darkArbiter >= 5
                and not immun
                and not cloak
            then
                if cast.deathCoil("target") then return end
            end
        end
    ---------------------------------------------------------------------------------------------------------------------------------
    -- Action List - Dark Arbiter exist
    ---------------------------------------------------------------------------------------------------------------------------------
        local function actionList_DarkArbiter()
            --Apocalypse
                if cd.apocalypse <= 0
                    and debuff.festeringWound.stack("target") >= 7
                    and runicPowerDeficit > 21
                    and not immun
                    and not bop
                then
                    if cast.apocalypse("target") then return end
                end
            --Dark Transformation
                if hasEquiped(137075)  then 
                    if cast.darkTransformation() then return end
                end
            --DeathCoil Dump        
                if not immun and not cloak
                then
                    if cast.deathCoil("target") then return end
                end
            --Festering Strike
                if runes >= 2 and debuff.festeringWound.stack("target") < 5 then
                    if cast.festeringStrike("target") then return end
                end
            --Scourge
                if playertar and isChecked("Necro Spam") and dampeningCount >= getOptionValue("Necro Spam") then 
                    if cast.necroticStrike("target") then
                        return 
                    elseif talent.clawingShadows then
                        if cast.clawingShadows("target") then return end
                    else
                        if cast.scourgeStrike("target") then return end
                    end
                elseif talent.clawingShadows then
                    if cast.clawingShadows("target") then return end
                else
                    if cast.scourgeStrike("target") then return end
                end
                
        end
    ---------------------------------------------------------------------------------------------------------------------------------
    -- Action List -Generic
    ---------------------------------------------------------------------------------------------------------------------------------
        local function actionList_Generic()
            --ScourgeStrike spam DnD
            if buff.deathAndDecay.exists("player")
                and #enemies.yards10 > 2
                and not immun
                and not cloak
            then
                if playertar and isChecked("Necro Spam") and dampeningCount >= getOptionValue("Necro Spam") then 
                    if cast.necroticStrike("target") then
                        return 
                    elseif talent.clawingShadows then
                        if cast.clawingShadows("target") then return end
                    else
                        if cast.scourgeStrike("target") then return end
                    end
                elseif talent.clawingShadows then
                    if cast.clawingShadows("target") then return end
                else
                    if cast.scourgeStrike("target") then return end
                end
            end  
            --Death Coil
            if (runicPower >= 80
                or (buff.suddenDoom.exists() and buff.suddenDoom.remain() < 8))
                and ((not buff.necrosis.exists("player") or buff.suddenDoom.remain() < 2) or runicPowerDeficit >= 20)
                and not immun
                and not cloak
            then
                if cast.deathCoil("target") then return end
            end
            --Festering Strike
            if ((debuff.festeringWound.stack("target") < 5)
                or (debuff.festeringWound.stack("target") < 8 and cd.apocalypse == 0))
                and not immun
                and not bop
                then
                if cast.festeringStrike("target") then return end
            end
            --Scourge
            if debuff.festeringWound.stack("target") > 3
                and (not (cd.soulReaper < 5) or runes > 4)
                and runes > 2
                and not immun
                and not cloak
            then
                if playertar and isChecked("死疽打击") then 
                    if cast.necroticStrike("target") then 
                        return 
                    elseif talent.clawingShadows then
                        if cast.clawingShadows("target") then return end
                    else
                        if cast.scourgeStrike("target") then return end
                    end
                elseif talent.clawingShadows then
                    if cast.clawingShadows("target") then return end
                else
                    if cast.scourgeStrike("target") then return end
                end
            end
            --Clawing Shadow  is out of range
            if  talent.clawingShadows 
                and getDistance("target") > 5 
                and runes > 2 
                and not cloak
                and not immun
            then
                if cast.clawingShadows("target") then return end
            end
            --DeathCoil
            if getDistance("target") > 5 
                and not immun
                and not cloak
            then
                if cast.deathCoil("target") then return end
            end
        end
-----------------
--- Rotations ---
-----------------
        -- Pause
        if pause() or (GetUnitExists("target") and (UnitIsDeadOrGhost("target") or not UnitCanAttack("target", "player"))) or mode.rotation == 4 then
            if isChecked("调试信息") then Print("Rotation Pause") end
            return true
        else
---------------------------------
--- Out Of Combat - Rotations ---
---------------------------------
            if not inCombat and GetObjectExists("target") and not UnitIsDeadOrGhost("target") and UnitCanAttack("target", "player") then
                if isChecked("调试信息") then Print("OOC") end
                startDampeningTimer = false
            end -- End Out of Combat Rotation
-----------------------------
--- In Combat - Rotations --- 
-----------------------------
            if inCombat and not IsMounted() and getBuffRemain("player", 192002 ) < 10 then
                if isChecked("调试信息") then Print("inCombat") end

                if debuff.dampening ~= nil then
                    if actionList_DebuffReader() then return end
                end

                if isChecked("莱欧瑟拉斯之眼") and UnitDebuff("player","莱欧瑟拉斯之眼") ~= nil then
                    ClearTarget()
                    Print("Warning : Eye of Leotheras detected")
                    return
                end

                if isChecked("自动目标") 
                    and not GetUnitExists("target")
                    or (not UnitIsEnemy("target", "player") and not UnitIsDeadOrGhost("target")) 
                then
                    if #enemies.yards8 > 0 and UnitAffectingCombat(enemies.yards8[1]) then
                        TargetUnit(enemies.yards8[1])
                    end
                end

            ---------------------------
            --- Queue Casting
            ---------------------------
                if isChecked("Queue Casting") and not UnitChannelInfo("player") then
                    -- Catch for spells not registering on Combat log
                    if castQueue() then return end
                end
            ---------------------------
            --- SoulReaper          ---
            ---------------------------
                if talent.soulReaper and debuff.soulReaper.exists("target") and buff.soulReaper.stack("player") < 3  then
                    if actionList_SoulReaperDebuff() then return end
                else             
                ---------------------------
                --- Extras              ---
                ---------------------------
                    if actionList_Extras() then return end
                ---------------------------
                --- Cooldowns           ---
                ---------------------------
                    if actionList_Cooldowns() then return end
                ---------------------------
                --- Interrupt           ---
                ---------------------------
                   if actionList_Interrupts() then return end
                ---------------------------
                --- Pet Logic           ---
                ---------------------------
                    if actionList_PetManagement() then return end
                ---------------------------
                --- Defensive Rotation  ---
                ---------------------------
                    if actionList_Defensive() then return end
                ---------------------------
                --- Dark Arbiter Exist  ---
                ---------------------------
                    if talent.darkArbiter then
                        if GetObjExists(100876) then
                            if actionList_DarkArbiter() then return end
                        else
                            if actionList_PreDarkArbiter() then return end
                        end                
                ---------------------------
                --- Soul Reaper         ---
                ---------------------------
                    elseif talent.soulReaper then
                        if actionList_SoulReaper() then return end
                    else
                        if actionList_Generic() then return end
                    end
                ---------------------------
                --- Queue               ---
                ---------------------------
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
                end

                if isChecked("调试信息") then uncheck("调试信息") end
            end -- End In Combat Rotation
        end -- Pause
    end -- End Timer
end -- End runRotation 
local id = 252 -- Change to the spec id profile is for.
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})