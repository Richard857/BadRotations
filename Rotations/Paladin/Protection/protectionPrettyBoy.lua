local rotationName = "PrettyBoy"
---------------
--- Toggles ---
---------------
local function createToggles()
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "基于范围内的目标数,在单目标和多目标自动切换输出方式.", highlight = 1, icon = br.player.spell.eyeOfTyr },
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "使用多目标方式输出.", highlight = 0, icon = br.player.spell.avengersShield },
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "使用单目标方式输出.", highlight = 0, icon = br.player.spell.judgment },
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "禁用DPS输出", highlight = 0, icon = br.player.spell.flashOfLight }
    }
    CreateButton("Rotation",1,0)
-- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "自动使用大技能 - 只在BOSS.", highlight = 1, icon = br.player.spell.avengingWrath },
        [2] = { mode = "On", value = 1 , overlay = "Cooldowns Enabled", tip = "不管任何目标都使用大技能.", highlight = 0, icon = br.player.spell.avengingWrath },
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "不使用大技能.", highlight = 0, icon = br.player.spell.avengingWrath }
    };
    CreateButton("Cooldown",2,0)
-- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "使用保命技能.", highlight = 1, icon = br.player.spell.guardianOfAncientKings },
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "不使用保命技能.", highlight = 0, icon = br.player.spell.guardianOfAncientKings }
    };
    CreateButton("Defensive",3,0)
-- Interrupt Button
    InterruptModes = {
        [1] = { mode = "On", value = 1 , overlay = "Interrupts Enabled", tip = "使用打断.", highlight = 1, icon = br.player.spell.hammerOfJustice },
        [2] = { mode = "Off", value = 2 , overlay = "Interrupts Disabled", tip = "不使用打断.", highlight = 0, icon = br.player.spell.hammerOfJustice }
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
            -- Dummy DPS Test
            br.ui:createSpinner(section, "DPS测试",  5,  5,  60,  5,  "|cffFFFFFF设置为所需的测试的时间（分钟）. 最小: 5 / 最大: 60 / 间隔: 5")
            -- Hand of Freedom
            br.ui:createCheckbox(section, "自由祝福")
        -- Taunt
            br.ui:createCheckbox(section,"嘲讽","|cffFFFFFF自动使用嘲讽")
        br.ui:checkSectionState(section)
        ------------------------
        --- COOLDOWN OPTIONS ---
        ------------------------
        section = br.ui:createSection(br.ui.window.profile,  "冷却技能")
            -- Racial
            br.ui:createCheckbox(section,"种族技能")
            -- Trinkets
            br.ui:createSpinner(section, "饰品 血量",  70,  0,  100,  5,  "多少血量百分比使用")		
            br.ui:createDropdownWithout(section, "饰品", {"|cff00FF00只用第一个","|cff00FF00只用第二个","|cffFFFF00两个都用","|cffFF0000不用"}, 1, "|cffFFFFFF选择饰品使用.")
            -- Seraphim
            br.ui:createSpinner(section, "炽天使",  0,  0,  20,  2,  "|cffFFFFFFEnemy TTD")
            -- Avenging Wrath
            br.ui:createSpinner(section, "复仇之怒",  0,  0,  200,  5,  "|cffFFFFFFEnemy TTD")
            -- Bastion of Light
            br.ui:createCheckbox(section,"圣光壁垒")

        br.ui:checkSectionState(section)
        -------------------------
        --- DEFENSIVE OPTIONS ---
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, "保命")
            -- Healthstone
            br.ui:createSpinner(section, "药水/治疗石",  30,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用")
            -- Ardent Defender
            br.ui:createSpinner(section, "炽热防御者",  60,  0,  100,  5,  "|cffFFBB00多少血量百分比使用")
            -- Blinding Light
            br.ui:createSpinner(section, "盲目之光 - HP", 50, 0, 100, 5, "|cffFFFFFF多少血量百分比使用")
            br.ui:createSpinner(section, "盲目之光 - AoE", 3, 0, 10, 1, "|cffFFFFFF多少人在5码内才使用")
            -- Cleanse Toxin
            br.ui:createDropdown(section, "清毒术", {"|cff00FF00自己","|cffFFFF00所选的目标","|cffFF0000鼠标位置目标"}, 1, "|ccfFFFFFF选择目标使用清毒术")
            -- Divine Shield
            br.ui:createSpinner(section, "圣盾术",  5,  0,  100,  5,  "|cffFFBB00多少血量百分比使用")
            -- Eye of Tyr
            br.ui:createSpinner(section, "提尔之眼 - HP", 60, 0, 100, 5, "|cffFFFFFF多少血量百分比使用")
            br.ui:createSpinner(section, "提尔之眼 - AoE", 4, 0, 10, 1, "|cffFFFFFF多少人在10码内才使用")
            -- Flash of Light
            br.ui:createSpinner(section, "圣光闪现",  50,  0,  100,  5,  "|cffFFBB00多少血量百分比使用")
            -- Guardian of Ancient Kings
            br.ui:createSpinner(section, "远古列王守卫",  30,  0,  100,  5,  "|cffFFBB00多少血量百分比使用")
            -- Hammer of Justice
            br.ui:createSpinner(section, "制裁之锤 - HP",  60,  0,  100,  5,  "|cffFFBB00多少血量百分比使用")
            -- Light of the Protector
            br.ui:createSpinner(section, "守护之光",  70,  0,  100,  5,  "|cffFFBB00多少血量百分比使用.")
            -- Hand of the Protector - on others
            br.ui:createSpinner(section, "守护者之手 - 队友",  70,  0,  100,  5,  "|cffFFBB00队友多少血量百分比使用.")
            -- Lay On Hands
            br.ui:createSpinner(section, "圣疗术", 20, 0, 100, 5, "","多少血量百分比使用")
            br.ui:createDropdownWithout(section, "圣疗术 目标", {"|cffFFFFFF自己","|cffFFFFFF目标", "|cffFFFFFF鼠标位置", "|cffFFFFFF坦克", "|cffFFFFFF奶妈", "|cffFFFFFF奶妈/坦克", "|cffFFFFFF所有人"}, 7, "|cffFFFFFF选择使用圣疗术的目标")	
            -- Blessing of Protection
            br.ui:createSpinner(section, "保护祝福", 30, 0, 100, 5, "","多少血量百分比使用")
            br.ui:createDropdownWithout(section, "保护祝福 目标", {"|cffFFFFFF自己","|cffFFFFFF目标", "|cffFFFFFF鼠标位置", "|cffFFFFFF坦克", "|cffFFFFFF奶妈", "|cffFFFFFF奶妈/坦克", "|cffFFFFFF所有人"}, 7, "|cffFFFFFF选择使用保护祝福的目标")				
            -- Blessing Of Sacrifice
            br.ui:createSpinner(section, "牺牲祝福", 40, 0, 100, 5, "","多少血量百分比使用")
            br.ui:createDropdownWithout(section, "牺牲祝福 目标", {"|cffFFFFFF自己","|cffFFFFFF目标", "|cffFFFFFF鼠标位置", "|cffFFFFFF坦克", "|cffFFFFFF奶妈", "|cffFFFFFF奶妈/坦克", "|cffFFFFFF所有人"}, 7, "|cffFFFFFF选择使用牺牲祝福的目标")				
            -- Shield of the Righteous
            br.ui:createSpinner(section, "正义盾击 - HP", 60, 0 , 100, 5, "|cffFFBB00多少血量百分比使用")
            -- Redemption
            br.ui:createDropdown(section, "救赎", {"|cffFFFF00所选的目标","|cffFF0000鼠标位置目标"}, 1, "|ccfFFFFFF施放技能")
            -- Gift of The Naaru
            if br.player.race == "Draenei" then
                br.ui:createSpinner(section, "纳鲁的赐福",  50,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用")
            end
        br.ui:checkSectionState(section)
        -------------------------
        --- INTERRUPT OPTIONS ---
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, "打断")
            -- Blinding Light
            br.ui:createCheckbox(section, "盲目之光")
            -- Hammer of Justice
            br.ui:createCheckbox(section, "制裁之锤")
            -- Rebuke
            br.ui:createCheckbox(section, "责难")
            -- Avenger's Shield
            br.ui:createCheckbox(section, "复仇者之盾")
            -- Interrupt Percentage
            br.ui:createSpinner(section,  "打断",  35,  0,  95,  5,  "|cffFFBB00读条百分几打断")
        br.ui:checkSectionState(section)
        ------------------------
        --- ROTATION OPTIONS ---
        ------------------------
        section = br.ui:createSection(br.ui.window.profile, "输出选项")
            -- Avenger's Shield
            br.ui:createCheckbox(section,"复仇者之盾")
            -- Consecration
            br.ui:createCheckbox(section,"奉献")
            -- Blessed Hammer
            br.ui:createCheckbox(section,"祝福之锤")
            -- Hammer of the Righteous
            br.ui:createCheckbox(section,"正义之锤")
            -- Judgment
            br.ui:createCheckbox(section,"审判")
            -- Shield of the Righteous
            br.ui:createCheckbox(section,"正义盾击")

        br.ui:checkSectionState(section)
        ----------------------
        --- TOGGLE OPTIONS ---
        ----------------------
        section = br.ui:createSection(br.ui.window.profile,  "切换快捷键")
            -- Single/Multi Toggle
            br.ui:createDropdown(section,  "运行模式", br.dropOptions.Toggle,  4)
            --Cooldown Key Toggle
            br.ui:createDropdown(section,  "冷却技能模式", br.dropOptions.Toggle,  3)
            --Defensive Key Toggle
            br.ui:createDropdown(section,  "保命模式", br.dropOptions.Toggle,  6)
            -- Interrupts Key Toggle
            br.ui:createDropdown(section,  "打断模式", br.dropOptions.Toggle,  6)
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
    if br.timer:useTimer("debugProtection", math.random(0.15,0.3)) then 
        --Print("Running: "..rotationName)

---------------
--- Toggles ---
---------------
        UpdateToggle("Rotation",0.25)
        UpdateToggle("Cooldown",0.25)
        UpdateToggle("Defensive",0.25)
        UpdateToggle("Interrupt",0.25)

--- FELL FREE TO EDIT ANYTHING BELOW THIS AREA THIS IS JUST HOW I LIKE TO SETUP MY ROTATIONS ---

--------------
--- Locals ---
--------------
        local artifact      = br.player.artifact
        local buff          = br.player.buff
        local cast          = br.player.cast
        local cd            = br.player.cd
        local charges       = br.player.charges
        local combatTime    = getCombatTime()
        local debuff        = br.player.debuff
        local enemies       = enemies or {}
        local gcd           = br.player.gcd
        local hastar        = GetObjectExists("target")
        local healPot       = getHealthPot()
        local inCombat      = br.player.inCombat
        local level         = br.player.level
        local inInstance    = br.player.instance=="party"
        local inRaid        = br.player.instance=="raid"	
        local lowest        = br.friend[1]		
        local mode          = br.player.mode
        local php           = br.player.health
        local race          = br.player.race
        local racial        = br.player.getRacial()
        local resable       = UnitIsPlayer("target") and UnitIsDeadOrGhost("target") and UnitIsFriend("target","player")
        local solo          = GetNumGroupMembers() == 0
        local spell         = br.player.spell
        local talent        = br.player.talent
        local ttd           = getTTD(br.player.units(5))
        local units         = units or {}

        units.dyn5 = br.player.units(5)
		units.dyn10 = br.player.units(10)
		units.dyn30 = br.player.units(30)
        enemies.yards5 = br.player.enemies(5)
        enemies.yards10 = br.player.enemies(10)
        enemies.yards30 = br.player.enemies(30)

        if profileStop == nil then profileStop = false end
        judgmentExists = debuff.judgment.exists(units.dyn5)
        judgmentRemain = debuff.judgment.remain(units.dyn5)
        if debuff.judgment.exists(units.dyn5) or level < 42 or (cd.judgment > 2 and not debuff.judgment.exists(units.dyn5)) then
            judgmentVar = true
        else
            judgmentVar = false
        end

        local greaterBuff
        greaterBuff = 0
        local lowestUnit
        lowestUnit = "player"
        for i = 1, #br.friend do
            local thisUnit = br.friend[i].unit
            local thisHP = getHP(thisUnit)
            local lowestHP = getHP(lowestUnit)
            if thisHP < lowestHP then
                lowestUnit = thisUnit
            end
        end

--------------------
--- Action Lists ---
--------------------
    -- Action List - Extras
        local function actionList_Extras()
        -- Hand of Freedom
            if isChecked("自由祝福") and hasNoControl("player") then
                if cast.blessingOfFreedom("player") then return end
            end
        -- Taunt
            if isChecked("嘲讽") and inInstance then
                for i = 1, #enemies.yards30 do
                    local thisUnit = enemies.yards30[i]
                    if not isAggroed(thisUnit) and hasThreat(thisUnit) then
                        if cast.handOfReckoning(thisUnit) then return end
                    end
                end
            end

        end -- End Action List - Extras
    -- Action List - Defensives
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
        -- Light of the Protector
                if isChecked("守护之光") and php <= getOptionValue("守护之光") and not talent.handOfTheProtector then
                    if cast.lightOfTheProtector("player") then return end
                end
        -- Hand of the Protector - Others
                if isChecked("守护者之手 - 队友") and talent.handOfTheProtector then
                    if getHP(lowestUnit) < getOptionValue("守护者之手 - 队友") then
                        if cast.handOfTheProtector(lowestUnit) then return end
                    end
                end
        -- Lay On Hands
                if isChecked("圣疗术") and inCombat then
                -- Player
                if getOptionValue("圣疗术 目标") == 1 then
                    if php <= getValue("圣疗术") then
                        if cast.layOnHands("player") then return true end
                    end
                    -- Target
                elseif getOptionValue("圣疗术 目标") == 2 then
                    if getHP("target") <= getValue("圣疗术") then
                        if cast.layOnHands("target") then return true end
                    end
                    -- Mouseover
                elseif getOptionValue("圣疗术 目标") == 3 then
                    if getHP("mouseover") <= getValue("圣疗术") then
                        if cast.layOnHands("mouseover") then return true end
                    end
                elseif lowest.hp <= getValue("圣疗术") then
                    -- Tank
                    if getOptionValue("圣疗术 目标") == 4 then
                        if (lowest.role) == "TANK" then
                            if cast.layOnHands(lowest.unit) then return true end
                        end
                    -- Healer
                    elseif getOptionValue("圣疗术 目标") == 5 then
                        if (lowest.role) == "HEALER" then
                            if cast.layOnHands(lowest.unit) then return true end
                        end
                    -- Healer/Tank
                    elseif getOptionValue("圣疗术 目标") == 6 then
                        if (lowest.role) == "HEALER" or (lowest.role) == "TANK" then
                            if cast.layOnHands(lowest.unit) then return true end
                        end
                    -- Any
                    elseif  getOptionValue("圣疗术 目标") == 7 then
                        if cast.layOnHands(lowest.unit) then return true end
                    end
                end
            end				
        -- Blessing of Protection
                if isChecked("保护祝福") and inCombat then
                -- Player
                if getOptionValue("保护祝福 目标") == 1 then
                    if php <= getValue("保护祝福") then
                        if cast.blessingOfProtection("player") then return true end
                    end
                    -- Target
                elseif getOptionValue("保护祝福 目标") == 2 then
                    if getHP("target") <= getValue("保护祝福") then
                        if cast.blessingOfProtection("target") then return true end
                    end
                    -- Mouseover
                elseif getOptionValue("保护祝福 目标") == 3 then
                    if getHP("mouseover") <= getValue("保护祝福") then
                        if cast.blessingOfProtection("mouseover") then return true end
                    end
                elseif lowest.hp <= getValue("保护祝福") then
                    -- Tank
                    if getOptionValue("保护祝福 目标") == 4 then
                        if (lowest.role) == "TANK" then
                            if cast.blessingOfProtection(lowest.unit) then return true end
                        end
                    -- Healer
                    elseif getOptionValue("保护祝福 目标") == 5 then
                        if (lowest.role) == "HEALER" then
                            if cast.blessingOfProtection(lowest.unit) then return true end
                        end
                    -- Healer/Tank
                    elseif getOptionValue("保护祝福 目标") == 6 then
                        if (lowest.role) == "HEALER" or (lowest.role) == "TANK" then
                            if cast.blessingOfProtection(lowest.unit) then return true end
                        end
                    -- Any
                    elseif  getOptionValue("保护祝福 目标") == 7 then
                        if cast.blessingOfProtection(lowest.unit) then return true end
                    end
                end
            end
        -- Blessing Of Sacrifice		
                if isChecked("牺牲祝福") and php >= 50 and inCombat then
                -- Player
                if getOptionValue("牺牲祝福 目标") == 1 then
                    if php <= getValue("牺牲祝福") then
                        if cast.blessingOfSacrifice("player") then return true end
                    end
                    -- Target
                elseif getOptionValue("牺牲祝福 目标") == 2 then
                    if getHP("target") <= getValue("牺牲祝福") then
                        if cast.blessingOfSacrifice("target") then return true end
                    end
                    -- Mouseover
                elseif getOptionValue("牺牲祝福 目标") == 3 then
                    if getHP("mouseover") <= getValue("牺牲祝福") then
                        if cast.blessingOfSacrifice("mouseover") then return true end
                    end
                elseif lowest.hp <= getValue("牺牲祝福") then
                    -- Tank
                    if getOptionValue("牺牲祝福 目标") == 4 then
                        if (lowest.role) == "TANK" then
                            if cast.blessingOfSacrifice(lowest.unit) then return true end
                        end
                    -- Healer
                    elseif getOptionValue("牺牲祝福 目标") == 5 then
                        if (lowest.role) == "HEALER" then
                            if cast.blessingOfSacrifice(lowest.unit) then return true end
                        end
                    -- Healer/Tank
                    elseif getOptionValue("牺牲祝福 目标") == 6 then
                        if (lowest.role) == "HEALER" or (lowest.role) == "TANK" then
                            if cast.blessingOfSacrifice(lowest.unit) then return true end
                        end
                    -- Any
                    elseif  getOptionValue("牺牲祝福 目标") == 7 then
                        if cast.blessingOfSacrifice(lowest.unit) then return true end
                    end
                end
            end					
        -- Divine Shield
                if isChecked("圣盾术") then
                    if php <= getOptionValue("圣盾术") and inCombat then
                        if cast.divineShield() then return end
                    end
                end	
        -- Cleanse Toxins
                if isChecked("清毒术") then
                    if getOptionValue("清毒术")==1 and canDispel("player",spell.cleanseToxins) then
                        if cast.cleanseToxins("player") then return end
                    end
                    if getOptionValue("清毒术")==2 and canDispel("target",spell.cleanseToxins) then
                        if cast.cleanseToxins("target") then return end
                    end
                    if getOptionValue("清毒术")==3 and canDispel("mouseover",spell.cleanseToxins) then
                        if cast.cleanseToxins("mouseover") then return end
                    end
                end					
        -- Eye of Tyr
                if isChecked("提尔之眼 - HP") and php <= getOptionValue("提尔之眼 - HP") and inCombat and #enemies.yards10 > 0 then
                    if cast.eyeOfTyr() then return end
                end
                if isChecked("提尔之眼 - AoE") and #enemies.yards10 >= getOptionValue("提尔之眼 - AoE") and inCombat then
                    if cast.eyeOfTyr() then return end
                end
        -- Blinding Light
                if isChecked("盲目之光 - HP") and php <= getOptionValue("盲目之光 - HP") and inCombat and #enemies.yards10 > 0 then
                    if cast.blindingLight() then return end
                end
                if isChecked("盲目之光 - AoE") and #enemies.yards5 >= getOptionValue("盲目之光 - AoE") and inCombat then
                    if cast.blindingLight() then return end
                end
        -- Shield of the Righteous
                if isChecked("正义盾击 - HP") then
                    if php <= getOptionValue("正义盾击 - HP") and inCombat and not buff.shieldOfTheRighteous.exists() then
                        if cast.shieldOfTheRighteous() then return end
                    end
                end
        -- Guardian of Ancient Kings
                if isChecked("远古列王守卫") then
                    if php <= getOptionValue("远古列王守卫") and inCombat and not buff.ardentDefender.exists() then
                        if cast.guardianOfAncientKings() then return end
                    end
                end
        -- Ardent Defender
                if isChecked("炽热防御者") then
                    if php <= getOptionValue("炽热防御者") and inCombat and not buff.guardianOfAncientKings.exists() then
                        if cast.ardentDefender() then return end
                    end
                end
        -- Gift of the Naaru
                if isChecked("纳鲁的赐福") and php <= getOptionValue("纳鲁的赐福") and php > 0 and race == "Draenei" then
                    if castSpell("player",racial,false,false,false) then return end
                end
        -- Hammer of Justice
                if isChecked("制裁之锤 - HP") and php <= getOptionValue("制裁之锤 - HP") and inCombat then
                    if cast.hammerOfJustice(units.dyn10) then return end
                end			
        -- Flash of Light
                if isChecked("圣光闪现") then
                    if (forceHeal or (inCombat and php <= getOptionValue("圣光闪现") / 2) or (not inCombat and php <= getOptionValue("圣光闪现"))) and not isMoving("player") then
                        if cast.flashOfLight() then return end
                    end
                end
        -- Redemption
                if isChecked("救赎") then
                    if getOptionValue("救赎")==1 and not isMoving("player") and resable then
                        if cast.redemption("target","dead") then return end
                    end
                    if getOptionValue("救赎")==2 and not isMoving("player") and resable then
                        if cast.redemption("mouseover","dead") then return end
                    end
                end
            end
        end -- End Action List - Defensive
    -- Action List - Cooldowns
        local function actionList_Cooldowns()
            if useCDs() or burst then
            -- Trinkets
                if isChecked("饰品 血量") and php <= getOptionValue("饰品 血量") then
					if (getOptionValue("饰品") == 1 or getOptionValue("饰品") == 3) and canUse(13) then
						useItem(13)
					end
					if (getOptionValue("饰品") == 2 or getOptionValue("饰品") == 3) and canUse(14) then
						seItem(14)
					end
                end
            end -- End Cooldown Usage Check
        end -- End Action List - Cooldowns		
    -- Action List - Interrupts
        local function actionList_Interrupts()
            if useInterrupts() then
                if isChecked("复仇者之盾") then
                    for i = 1, #enemies.yards30 do
                        local thisUnit = enemies.yards30[i]
                        local distance = getDistance(thisUnit)
                        if canInterrupt(thisUnit, 100) then
                            if distance < 30 then
                                if cast.avengersShield() then return end
                            end
                        end
                    end
                end
                for i = 1, #enemies.yards10 do
                    local thisUnit = enemies.yards10[i]
                    local distance = getDistance(thisUnit)
                    if canInterrupt(thisUnit,getOptionValue("打断")) then
        -- Hammer of Justice
                        if isChecked("制裁之锤") and distance < 10 then
                            if cast.hammerOfJustice(thisUnit) then return end
                        end
        -- Rebuke
                        if isChecked("责难") and distance < 5 then
                            if cast.rebuke(thisUnit) then return end
                        end
        -- Blinding Light
                        if isChecked("盲目之光") and distance < 10 then
                            if cast.blindingLight() then return end
                        end
                    end
                end
            end
        end -- End Action List - Interrupts
    -- Action List - PreCombat
        local function actionList_PreCombat()
            -- PreCombat abilities listed here
        end -- End Action List - PreCombat
    -- Action List - Opener
        local function actionList_Opener()
            if isValidUnit("target") then
        -- Judgment
                if cast.judgment("target") then return end
        -- Start Attack
            if getDistance("target") < 5 and isValidUnit("target") then
                StartAttack(units.dyn5)
			end
		end	
    end -- End Action List - Opener
---------------------
--- Begin Profile ---
---------------------
    --Profile Stop | Pause
        if not inCombat and not hastar and profileStop == true then
            profileStop = false
        elseif (inCombat and profileStop == true) or IsFlying() or pause() or mode.rotation == 4 then
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
----------------------------
--- Out of Combat Opener ---
----------------------------
            if actionList_Opener() then return end
--------------------------
--- In Combat Rotation ---
--------------------------
            if inCombat and profileStop==false then
------------------------------
--- In Combat - Interrupts ---
------------------------------
            if actionList_Interrupts() then return end
-----------------------------
--- In Combat - Cooldowns ---
-----------------------------
            if actionList_Cooldowns() then return end
----------------------------------
--- In Combat - Begin Rotation ---
----------------------------------
--------------------------------
--- In Combat - SimCraft APL ---
--------------------------------
                if not IsMounted() or buff.divineSteed.exists() then
            -- Racials
                    -- berserking
                    if isChecked("种族技能") and useCDs() then
                        if race == "Orc" or race == "Troll" and getSpellCD(racial) == 0 then
                            if castSpell("player",racial,false,false,false) then return end
                        end
                    end
                    if useCDs() and getDistance(units.dyn5) < 5 then
            -- Seraphim
                    if isChecked("炽天使") and charges.frac.shieldOfTheRighteous >= 1.99 and (getOptionValue("炽天使") <= ttd ) then
                        if cast.seraphim() then return end
                    end
            -- Avenging Wrath
                    if isChecked("复仇之怒") and (not talent.seraphim or buff.seraphim.remain() > 15) and (getOptionValue("复仇之怒") <= ttd ) then
                        if cast.avengingWrath() then return end
                    end
            -- Bastion of Light
                    if isChecked("圣光壁垒") and (charges.frac.shieldOfTheRighteous < 0.2) and (not talent.seraphim or buff.seraphim.exists()) then
                        if cast.bastionOfLight() then return end
                    end
                end
				    if not UnitIsFriend("target", "player") then
            -- Shield of the Righteous
                    if isChecked("正义盾击") and (charges.frac.shieldOfTheRighteous > 2.5) then
                        if cast.shieldOfTheRighteous(units.dyn5) then return end
                    end
            -- Avenger's Shield 
                    if isChecked("复仇者之盾") then
                        if cast.avengersShield(units.dyn30) then return end
                    end
            -- Consecration 
                    if isChecked("奉献") and not isMoving("player") and #enemies.yards10 >= 1 and getDistance(units.dyn5) < 5 then
                        if cast.consecration() then return end
                    end
            -- Judgment 
                    if isChecked("审判") then
                        if cast.judgment(units.dyn30) then return end
                    end
            -- Blessed Hammer 
                    if isChecked("祝福之锤") and getDistance(units.dyn5) < 5 then
                        if cast.blessedHammer() then return end
                    end
            -- Eye of Tyr 
                    if isChecked("提尔之眼") and getDistance(units.dyn5) < 5 then
                        if cast.eyeOfTyr() then return end
                    end
            -- Hammer of the Righteous 
                    if isChecked("正义之锤") then
                        if cast.hammerOfTheRighteous(units.dyn5) then return end
						end
                    end
				end	
            end -- End In Combat
        end -- End Profile
    end -- Timer
end -- runRotation
local id = 66
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})
