local rotationName = "Svs" 

---------------
--- Toggles ---
---------------
local function createToggles()
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "基于范围内的目标数,在单目标和多目标自动切换输出方式.", highlight = 1, icon = br.player.spell.riptide},
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "使用多目标方式输出.", highlight = 0, icon = br.player.spell.chainHeal},
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "使用单目标方式输出.", highlight = 0, icon = br.player.spell.healingWave},
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "禁用DPS输出", highlight = 0, icon = br.player.spell.giftOfTheQueen}
    };
    CreateButton("Rotation",1,0)
-- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "自动使用大技能 - 只在BOSS.", highlight = 1, icon = br.player.spell.healingTideTotem},
        [2] = { mode = "On", value = 1 , overlay = "Cooldowns Enabled", tip = "不管任何目标都使用大技能.", highlight = 0, icon = br.player.spell.healingTideTotem},
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "不使用大技能.", highlight = 0, icon = br.player.spell.healingTideTotem}
    };
    CreateButton("Cooldown",2,0)
-- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "使用保命技能.", highlight = 1, icon = br.player.spell.astralShift},
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "不使用保命技能.", highlight = 0, icon = br.player.spell.astralShift}
    };
    CreateButton("Defensive",3,0)
-- Interrupt Button
    InterruptModes = {
        [1] = { mode = "On", value = 1 , overlay = "Interrupts Enabled", tip = "使用打断.", highlight = 1, icon = br.player.spell.windShear},
        [2] = { mode = "Off", value = 2 , overlay = "Interrupts Disabled", tip = "不使用打断.", highlight = 0, icon = br.player.spell.windShear}
    };
    CreateButton("Interrupt",4,0)
-- Decurse Button
    DecurseModes = {
        [1] = { mode = "On", value = 1 , overlay = "Decurse Enabled", tip = "启用驱散", highlight = 1, icon = br.player.spell.purifySpirit },
        [2] = { mode = "Off", value = 2 , overlay = "Decurse Disabled", tip = "禁用驱散", highlight = 0, icon = br.player.spell.purifySpirit }
    };
    CreateButton("Decurse",5,0)
-- DPS Button
    DPSModes = {
        [1] = { mode = "On", value = 1 , overlay = "DPS Enabled", tip = "启用DPS", highlight = 1, icon = br.player.spell.lightningBolt },
        [2] = { mode = "Off", value = 2 , overlay = "DPS Disabled", tip = "禁用DPS", highlight = 0, icon = br.player.spell.healingSurge }
    };
    CreateButton("DPS",6,0)
end

--------------
--- COLORS ---
--------------
    local colorBlue     = "|cff00CCFF"
    local colorGreen    = "|cff00FF00"
    local colorRed      = "|cffFF0000"
    local colorWhite    = "|cffFFFFFF"
    local colorGold     = "|cffFFDD11"

---------------
--- OPTIONS ---
---------------
local function createOptions()
    local optionTable

    local function rotationOptions()
        local section
    -- General Options
        section = br.ui:createSection(br.ui.window.profile, "一般")
            br.ui:createCheckbox(section,"持续治疗","|cff15FF00启用|cffFFFFFF/|cffD60000禁用 |cffFFFFFF不在战斗中也保持治疗|cffFFBB00.",1)
        -- Dummy DPS Test
            br.ui:createSpinner(section, "DPS测试",  5,  5,  60,  5,  "","|cffFFFFFF设置为所需的测试的时间（分钟）. 最小: 5 / 最大: 60 / 间隔: 5")
        -- Pre-Pull Timer
            br.ui:createSpinner(section, "Pre-Pull Timer",  5,  1,  10,  1,  "","|cffFFFFFF设置为所需的启动时间 Pre-Pull (必须有DBM). 最小: 1 / 最大: 10 / 间隔: 1")
        -- Ghost Wolf
            br.ui:createCheckbox(section,"幽魂之狼")
        -- Water Walking
            br.ui:createCheckbox(section,"水上行走")
        br.ui:checkSectionState(section)
    -- Cooldown Options
        section = br.ui:createSection(br.ui.window.profile, "冷却技能")
         -- Racial
            br.ui:createCheckbox(section,"种族技能")
        -- Trinkets
            br.ui:createSpinner(section, "饰品 1",  70,  0,  100,  5,  "多少血量百分比使用") 
            br.ui:createSpinnerWithout(section, "饰品 1 目标",  4,  1,  40,  1,  "","最低多少个人才使用饰品1", true)
            br.ui:createSpinner(section, "饰品 2",  70,  0,  100,  5,  "多少血量百分比使用") 
            br.ui:createSpinnerWithout(section, "饰品 2 目标",  4,  1,  40,  1,  "","最低多少个人才使用饰品2", true)
        -- Cloudburst Totem
            br.ui:createSpinner(section, "暴雨图腾",  90,  0,  100,  5,  "","|cffFFFFFF多少血量百分比使用") 
            br.ui:createSpinnerWithout(section, "暴雨图腾目标数量",  3,  0,  40,  1,  "多少人再使用")
        -- Ancestral Guidance
            br.ui:createSpinner(section, "先祖指引",  60,  0,  100,  5,  "","多少血量百分比使用") 
            br.ui:createSpinnerWithout(section, "先祖指引目标数量",  3,  0,  40,  1,  "多少人再使用")
        -- Ascendance
            br.ui:createSpinner(section,"升腾",  60,  0,  100,  5,  "","多少血量百分比使用")
            br.ui:createSpinnerWithout(section, "升腾目标数量",  3,  0,  40,  1,  "多少人再使用")
        -- Healing Tide Totem
            br.ui:createSpinner(section, "治疗之潮图腾",  50,  0,  100,  5,  "","多少血量百分比使用") 
            br.ui:createSpinnerWithout(section, "治疗之潮图腾目标数量",  3,  0,  40,  1,  "多少人再使用")
        -- Ancestral Protection Totem
            br.ui:createSpinner(section, "先祖护佑图腾",  70,  0,  100,  5,  "","多少血量百分比使用")
            br.ui:createSpinnerWithout(section, "先祖护佑图腾目标数量",  3,  0,  40,  1,  "多少人再使用")
        br.ui:checkSectionState(section)
    -- Defensive Options
        section = br.ui:createSection(br.ui.window.profile, "保命")
        -- Healthstone
            br.ui:createSpinner(section, "治疗石",  30,  0,  100,  5,  "","|cffFFFFFF多少血量百分比使用")
        -- Heirloom Neck
            br.ui:createSpinner(section, "传家宝项链",  60,  0,  100,  5,  "","|cffFFBB00多少血量百分比使用");
        -- Gift of The Naaru
            if br.player.race == "Draenei" then
                br.ui:createSpinner(section, "纳鲁的赐福",  50,  0,  100,  5,  "","|cffFFFFFF多少血量百分比使用")
            end
        -- Astral Shift
            br.ui:createSpinner(section, "星界转移",  50,  0,  100,  5,  "","|cffFFFFFF多少血量百分比使用")
        -- Purge
            br.ui:createCheckbox(section,"净化术")
        -- Lightning Surge Totem
            br.ui:createSpinner(section, "闪电奔涌图腾 - HP", 50, 0, 100, 5, "","|cffFFFFFF多少血量百分比使用")
            br.ui:createSpinner(section, "闪电奔涌图腾 - AoE", 5, 0, 10, 1, "","|cffFFFFFF多少人再使用")
        -- Earthen Shield Totem
            br.ui:createSpinner(section, "大地之盾图腾",  95,  0,  100,  5,  "","cffFFFFFF多少血量百分比使用") 
            br.ui:createSpinnerWithout(section, "大地之盾图腾目标数量",  1,  0,  40,  1,  "多少人再使用")
        br.ui:checkSectionState(section)
    -- Interrupt Options
        section = br.ui:createSection(br.ui.window.profile, "打断")
        -- Wind Shear
            br.ui:createCheckbox(section,"风剪")
        -- Lightning Surge Totem
            br.ui:createCheckbox(section,"闪电奔涌图腾")
        -- Interrupt Percentage
            br.ui:createSpinner(section, "打断",  0,  0,  95,  5,  "","|cffFFFFFF百分几打断")
        br.ui:checkSectionState(section)
    -- Healing Options
        section = br.ui:createSection(br.ui.window.profile, "治疗")
        -- Healing Rain
            br.ui:createSpinner(section, "治疗之雨",  80,  0,  100,  5,  "","多少血量百分比使用") 
            br.ui:createSpinnerWithout(section, "治疗之雨目标数量",  2,  0,  40,  1,  "","最低治疗雨目标数量","", true)
            br.ui:createDropdown(section,"治疗之雨快捷键", br.dropOptions.Toggle, 6, "","|cffFFFFFF按下快捷键就在鼠标位置放置治疗之雨.", true)
            br.ui:createCheckbox(section,"治疗之雨没CD")
        -- Spirit Link Totem
            br.ui:createSpinner(section, "灵魂链接图腾",  50,  0,  100,  5,  "","多少血量百分比使用") 
            br.ui:createSpinnerWithout(section, "灵魂链接图腾目标数量",  3,  0,  40,  1,  "最低灵魂链接图腾目标数量","", true)
            br.ui:createDropdown(section,"灵魂链接图腾快捷键", br.dropOptions.Toggle, 6, "","|cffFFFFFF按下快捷键就在鼠标位置放置灵魂链接图腾.", true)
        -- Riptide
            br.ui:createSpinner(section, "激流",  90,  0,  100,  5,  "","|cffFFFFFF多少血量百分比使用")
        -- Healing Stream Totem
            br.ui:createSpinner(section, "治疗之泉图腾",  80,  0,  100,  5,  "","|cffFFFFFF多少血量百分比使用")
        -- Unleash Life
            br.ui:createSpinner(section, "生命释放",  80,  0,  100,  5,  "","|cffFFFFFF多少血量百分比使用")
        -- Healing Wave
            br.ui:createSpinner(section, "治疗波",  70,  0,  100,  5,  "","|cffFFFFFF多少血量百分比使用")
        -- Healing Surge
            br.ui:createSpinner(section, "治疗之涌",  60,  0,  100,  5,  "","|cffFFFFFF多少血量百分比使用")
        -- Chain Heal
            br.ui:createSpinner(section, "治疗链",  70,  0,  100,  5,  "","|cffFFFFFF多少血量百分比使用")
            br.ui:createSpinnerWithout(section, "治疗链目标数量",  3,  0,  40,  1,  "多少人再使用")  
        -- Gift of the Queen
            br.ui:createSpinner(section, "女王的恩赐",  80,  0,  100,  5,  "","多少血量百分比使用") 
            br.ui:createSpinnerWithout(section, "女王的恩赐目标数量",  3,  0,  40,  1,  "多少人再使用")
        -- Wellspring
            br.ui:createSpinner(section, "奔涌之流",  80,  0,  100,  5,  "","多少血量百分比使用") 
            br.ui:createSpinnerWithout(section, "奔涌之流目标数量",  3,  0,  40,  1,  "多少人再使用")
        br.ui:checkSectionState(section)
    -- Toggle Key Options
        section = br.ui:createSection(br.ui.window.profile, "切换快捷键")
        -- Single/Multi Toggle
            br.ui:createDropdown(section, "Rotation Mode", br.dropOptions.Toggle,  4)
        -- Cooldown Key Toggle
            br.ui:createDropdown(section, "Cooldown Mode", br.dropOptions.Toggle,  3)
        -- Defensive Key Toggle
            br.ui:createDropdown(section, "Defensive Mode", br.dropOptions.Toggle,  6)
        -- Interrupts Key Toggle
            br.ui:createDropdown(section, "Interrupt Mode", br.dropOptions.Toggle,  6)
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
    if br.timer:useTimer("debugRestoration", 0.1) then
        --print("Running: "..rotationName)

---------------
--- Toggles --- -- List toggles here in order to update when pressed
---------------
        UpdateToggle("Rotation",0.25)
        UpdateToggle("Cooldown",0.25)
        UpdateToggle("Defensive",0.25)
        UpdateToggle("Interrupt",0.25)
        UpdateToggle("Decurse",0.25)
        UpdateToggle("DPS",0.25)
        br.player.mode.decurse = br.data.settings[br.selectedSpec].toggles["Decurse"]
        br.player.mode.dps = br.data.settings[br.selectedSpec].toggles["DPS"]
--------------
--- Locals ---
--------------
        local artifact                                      = br.player.artifact
        local buff                                          = br.player.buff
        local cast                                          = br.player.cast
        local combatTime                                    = getCombatTime()
        local cd                                            = br.player.cd
        local charges                                       = br.player.charges
        local debuff                                        = br.player.debuff
        local drinking                                      = UnitBuff("player",192002) ~= nil or UnitBuff("player",167152) ~= nil
        local gcd                                           = br.player.gcd
        local healPot                                       = getHealthPot()
        local inCombat                                      = br.player.inCombat
        local inInstance                                    = br.player.instance=="party"
        local inRaid                                        = br.player.instance=="raid"
        local falling, swimming, flying, moving             = getFallTime(), IsSwimming(), IsFlying(), GetUnitSpeed("player")>0
        local lastSpell                                     = lastSpellCast
        local level                                         = br.player.level
        local lowest                                        = br.friend[1].unit
        local mode                                          = br.player.mode
        local perk                                          = br.player.perk        
        local php                                           = br.player.health
        local power, powmax, powgen                         = br.player.power.amount.mana, br.player.power.mana.max, br.player.power.regen
        local pullTimer                                     = br.DBM:getPulltimer()
        local race                                          = br.player.race
        local racial                                        = br.player.getRacial()
        local recharge                                      = br.player.recharge
        local spell                                         = br.player.spell
        local talent                                        = br.player.talent
        local wolf                                          = br.player.buff.ghostWolf.exists()
        local ttd                                           = getTTD
        local ttm                                           = br.player.power.ttm
        local units                                         = units or {}
        local lowestTank                                    = {}    --Tank
        local enemies                                       = enemies or {}
        local friends                                       = friends or {}

        if CloudburstTotemTime == nil or cd.cloudburstTotem == 0 or not talent.cloudburstTotem then CloudburstTotemTime = 0 end

    -- Cloudburst Totem
        if isChecked("暴雨图腾") and talent.cloudburstTotem and not buff.cloudburstTotem.exists() then
            if getLowAllies(getValue("暴雨图腾")) >= getValue("暴雨图腾目标数量") then
                if cast.cloudburstTotem() then
                    ChatOverlay(colorGreen.."Cloudburst Totem!")
                    CloudburstTotemTime = GetTime()
                    return
                end
            end
        end

        if inCombat and not IsMounted() then
            if isChecked("先祖指引") and talent.ancestralGuidance and talent.cloudburstTotem and (not CloudburstTotemTime or GetTime() >= CloudburstTotemTime + 6) then
                if getLowAllies(getValue("先祖指引")) >= getValue("先祖指引目标数量") then
                    if cast.ancestralGuidance() then return end
                end
            end
        end

        
        units.dyn8 = br.player.units(8)
        units.dyn40 = br.player.units(40)
        enemies.yards5 = br.player.enemies(5)
        enemies.yards8 = br.player.enemies(8)
        enemies.yards8t = br.player.enemies(8,br.player.units(8,true))
        enemies.yards10 = br.player.enemies(10)
        enemies.yards20 = br.player.enemies(20)
        enemies.yards30 = br.player.enemies(30)
        enemies.yards40 = br.player.enemies(40)
        friends.yards8 = getAllies("player",8)
        friends.yards25 = getAllies("player",25)
        friends.yards40 = getAllies("player",40)

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
        -- Ghost Wolf
            if isChecked("幽魂之狼") then
                if ((#enemies.yards20 == 0 and not inCombat) or (#enemies.yards10 == 0 and inCombat)) and isMoving("player") and not buff.ghostWolf.exists() then
                    if cast.ghostWolf() then return end
                end
            end
        -- Purge
            if isChecked("净化术") and canDispel("target",spell.purge) and not isBoss() and GetObjectExists("target") then
                if cast.purge() then return end
            end
        -- Water Walking
            if falling > 1.5 and buff.waterWalking.exists() then
                CancelUnitBuffID("player", spell.waterWalking)
            end
            if isChecked("水上行走") and not inCombat and IsSwimming() then
                if cast.waterWalking() then return end
            end
        end -- End Action List - Extras
    -- Action List - Defensive
        local function actionList_Defensive()
            if useDefensive() then
            -- Healthstone
                if isChecked("治疗石") and php <= getOptionValue("治疗石")
                    and inCombat and  hasItem(5512)
                then
                    if canUse(5512) then
                        useItem(5512)
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
            -- Gift of the Naaru
                if isChecked("纳鲁的赐福") and php <= getOptionValue("纳鲁的赐福") and php > 0 and br.player.race == "Draenei" then
                    if castSpell("player",racial,false,false,false) then return end
                end
            -- Astral Shift
                if isChecked("星界转移") and php <= getOptionValue("星界转移") and inCombat then
                    if cast.astralShift() then return end
                end
            end -- End Defensive Toggle
        end -- End Action List - Defensive
    -- Action List - Interrupts
        local function actionList_Interrupts()
            if useInterrupts() then
                for i=1, #enemies.yards30 do
                    thisUnit = enemies.yards30[i]
                    if canInterrupt(thisUnit,getOptionValue("打断")) then
        -- Wind Shear
                        if isChecked("风剪") then
                            if cast.windShear(thisUnit) then return end
                        end
        -- Lightning Surge Totem
                        if isChecked("闪电奔涌图腾") and cd.windShear > gcd then
                            if hasThreat(thisUnit) and not isMoving(thisUnit) and ttd(thisUnit) > 7 and lastSpell ~= spell.lightningSurgeTotem then
                                if cast.lightningSurgeTotem(thisUnit,"ground") then return end
                            end
                        end
                    end
                end
            end -- End useInterrupts check
        end -- End Action List - Interrupts
        -- Action List - Pre-Combat
        function actionList_PreCombat()
        -- Riptide
            if isChecked("激流") then
                for i = 1, #br.friend do
                    if br.friend[i].hp <= getValue("激流") and buff.riptide.remain(br.friend[i].unit) <= 1 then
                        if cast.riptide(br.friend[i].unit) then return end     
                    end
                end
            end
        -- Healing Stream Totem
           if isChecked("治疗之泉图腾") then
                for i = 1, #br.friend do                           
                    if br.friend[i].hp <= getValue("治疗之泉图腾") then
                        if cast.healingStreamTotem(br.friend[i].unit) then return end     
                    end
                end
            end
        -- Healing Surge
            if isChecked("治疗之涌") then
                for i = 1, #br.friend do                           
                    if br.friend[i].hp <= getValue("治疗之涌") and (buff.tidalWaves.exists() or level < 34) then
                        if cast.healingSurge(br.friend[i].unit) then return end     
                    end
                end
            end
        -- Healing Wave
            if isChecked("治疗波") then
                for i = 1, #br.friend do                           
                    if br.friend[i].hp <= getValue("治疗波") and (buff.tidalWaves.exists() or level < 34) then
                        if cast.healingWave(br.friend[i].unit) then return end     
                    end
                end
            end
        -- Chain Heal
            if isChecked("治疗链") and lastSpell ~= spell.chainHeal then
                if castWiseAoEHeal(br.friend,spell.chainHeal,20,getValue("治疗链"),getValue("治疗链目标数量"),5,false,true) then return end
            end
        -- Healing Rain
            if not moving then
                if (SpecificToggle("治疗之雨快捷键") and not GetCurrentKeyBoardFocus()) then
                    if CastSpellByName(GetSpellInfo(spell.healingRain),"cursor") then return end 
                end
            end
        -- Spirit Link Totem
            if not moving then
                if (SpecificToggle("灵魂链接图腾快捷键") and not GetCurrentKeyBoardFocus()) then
                    if CastSpellByName(GetSpellInfo(spell.spiritLinkTotem),"cursor") then return end 
                end
            end
        end  -- End Action List - Pre-Combat
        function actionList_Cooldowns()
            if useCDs() then
            -- Ascendance
                if isChecked("升腾") and talent.ascendance and not talent.cloudburstTotem then
                    if getLowAllies(getValue("升腾")) >= getValue("升腾目标数量") then    
                        if cast.ascendance() then return end    
                    end
                end
            -- Healing Tide Totem
                if isChecked("治疗之潮图腾") and not talent.cloudburstTotem then
                    if getLowAllies(getValue("治疗之潮图腾")) >= getValue("治疗之潮图腾目标数量") then    
                        if cast.healingTideTotem() then return end    
                    end
                end
            -- Ancestral Protection Totem
                if castWiseAoEHeal(br.friend,spell.ancestralProtectionTotem,20,getValue("先祖护佑图腾"),getValue("先祖护佑图腾目标数量"),10,false,false) then return end
            -- Trinkets
            if isChecked("饰品 1") and getLowAllies(getValue("饰品 1")) >= getValue("饰品 1 目标") then
                if canUse(13) then
                    useItem(13)
                    return true
                end
            end
            if isChecked("饰品 2") and getLowAllies(getValue("饰品 2")) >= getValue("饰品 2 目标") then
                if canUse(14) then
                    useItem(14)
                    return true
                end
            end
            -- Racial: Orc Blood Fury | Troll Berserking | Blood Elf Arcane Torrent
                if isChecked("种族技能") and (br.player.race == "Orc" or br.player.race == "Troll" or br.player.race == "BloodElf") then
                    if castSpell("player",racial,false,false,false) then return end
                end
            end -- End useCooldowns check
        end -- End Action List - Cooldowns
        -- Cloudburst Totem
        function actionList_CBT()
        -- Ancestral Guidance
            if isChecked("先祖指引") and talent.ancestralGuidance and (not CloudburstTotemTime or GetTime() >= CloudburstTotemTime + 6) then
                if getLowAllies(getValue("先祖指引")) >= getValue("先祖指引目标数量") then
                    if cast.ancestralGuidance() then return end
                end
            end
        -- Ascendance
            if isChecked("升腾") and talent.ascendance then
                if getLowAllies(getValue("升腾")) >= getValue("升腾目标数量") then    
                    if cast.ascendance() then return end    
                end
            end
        -- Healing Tide Totem
            if isChecked("治疗之潮图腾") then
                if getLowAllies(getValue("治疗之潮图腾")) >= getValue("治疗之潮图腾目标数量") then    
                    if cast.healingTideTotem() then return end    
                end
            end
        -- Healing Rain
            if not moving then
                if (SpecificToggle("治疗之雨快捷键") and not GetCurrentKeyBoardFocus()) then
                    if CastSpellByName(GetSpellInfo(spell.healingRain),"cursor") then return end 
                end
                if isChecked("治疗之雨") and not buff.healingRain.exists() then
                    if castWiseAoEHeal(br.friend,spell.healingRain,12,getValue("治疗之雨"),getValue("治疗之雨目标数量"),6,false,true) then return end
                end
            end
        -- Riptide
            if isChecked("激流") then
                if not buff.tidalWaves.exists() and level >= 34 then
                    if cast.riptide(lowest) then return end
                end
                for i = 1, #br.friend do
                    if br.friend[i].hp <= getValue("激流") and buff.riptide.remain(br.friend[i].unit) <= 1 then
                        if cast.riptide(br.friend[i].unit) then return end     
                    end
                end
            end
        -- Gift of the Queen
            if isChecked("女王的恩赐") then
                if castWiseAoEHeal(br.friend,spell.giftOfTheQueen,12,getValue("女王的恩赐"),getValue("女王的恩赐目标数量"),5,false,false) then return end
            end
        -- Healing Stream Totem
            if isChecked("治疗之泉图腾") then
                for i = 1, #br.friend do                           
                    if br.friend[i].hp <= getValue("治疗之泉图腾") then
                        if cast.healingStreamTotem(br.friend[i].unit) then return end     
                    end
                end
            end
        -- Unleash Life
            if isChecked("生命释放") and talent.unleashLife and not hasEquiped(137051) then
                for i = 1, #br.friend do                           
                    if br.friend[i].hp <= getValue("生命释放") then
                        if cast.unleashLife() then return end
                    end
                end
            end
        -- Healing Surge
            if isChecked("治疗之涌") then
                for i = 1, #br.friend do                           
                    if br.friend[i].hp <= getValue("治疗之涌") and (buff.tidalWaves.exists() or level < 100) then
                        if cast.healingSurge(br.friend[i].unit) then return end     
                    end
                end
            end
        -- Healing Wave
            if isChecked("治疗波") then
                for i = 1, #br.friend do                           
                    if br.friend[i].hp <= getValue("治疗波") and (buff.tidalWaves.exists() or level < 100) then
                        if cast.healingWave(br.friend[i].unit) then return end     
                    end
                end
            end
        end -- End Action List - Cloudburst Totem
        -- AOE Healing
        function actionList_AOEHealing()
        -- Ancestral Guidance
            if isChecked("先祖指引") and talent.ancestralGuidance and not talent.cloudburstTotem then
               if getLowAllies(getValue("先祖指引")) >= getValue("先祖指引目标数量") then
                    if cast.ancestralGuidance() then return end
                end
            end
        -- Chain Heal
            if isChecked("治疗链") and lastSpell ~= spell.chainHeal then
                if talent.unleashLife and talent.highTide then
                    if cast.unleashLife(lowest) then return end
                    if buff.unleashLife.remain() > 2 then
                        if castWiseAoEHeal(br.friend,spell.chainHeal,20,getValue("治疗链"),(getValue("治疗链目标数量") + 1),5,false,true) then return end
                    end
                elseif talent.highTide then
                    if castWiseAoEHeal(br.friend,spell.chainHeal,20,getValue("治疗链"),(getValue("治疗链目标数量") + 1),5,false,true) then return end
                else
                    if castWiseAoEHeal(br.friend,spell.chainHeal,20,getValue("治疗链"),getValue("治疗链目标数量"),5,false,true) then return end
                end
            end
        -- Gift of the Queen
            if isChecked("女王的恩赐") then
                if castWiseAoEHeal(br.friend,spell.giftOfTheQueen,12,getValue("女王的恩赐"),getValue("女王的恩赐目标数量"),5,false,false) then return end
            end
        -- Wellspring
            if isChecked("奔涌之流") then
                if talent.cloudburstTotem and buff.cloudburstTotem.exists() then
                    if castWiseAoEHeal(br.friend,spell.wellspring,20,getValue("奔涌之流"),getValue("奔涌之流目标数量"),6,true,true) then return end
                else
                    if castWiseAoEHeal(br.friend,spell.wellspring,20,getValue("奔涌之流"),getValue("奔涌之流目标数量"),6,true,true) then return end
                end
            end
        -- Healing Rain
            if not moving then
                if (SpecificToggle("治疗之雨快捷键") and not GetCurrentKeyBoardFocus()) then
                    if CastSpellByName(GetSpellInfo(spell.healingRain),"cursor") then return end 
                end
                if isChecked("治疗之雨没CD") and not buff.healingRain.exists() then
                    --if castWiseAoEHeal(br.friend,spell.healingRain,12,100,3,6,false,true) then return end
                    --castGroundAtBestLocation(spellID, radius, minUnits, maxRange, minRange, spellType)
                    if castGroundAtBestLocation(spell.healingRain,20,2,40,5,"heal") then return end
                end
            end
        end -- End Action List - AOEHealing
        -- Single Target
        function actionList_SingleTarget()
        -- Purify Spirit
            if br.player.mode.decurse == 1 then
                for i = 1, #br.friend do
                    for n = 1,40 do
                        local buff,_,_,count,bufftype,duration = UnitDebuff(br.friend[i].unit, n)
                        if buff then
                            if bufftype == "Curse" or bufftype == "Magic" then
                                if cast.purifySpirit(br.friend[i].unit) then return end
                            end
                        end
                    end
                end
            end
        -- Tidal Waves Proc Handling
            if buff.tidalWaves.stack() == 2 or level < 100 then
                if isChecked("治疗之涌") then
                    for i = 1, #br.friend do                           
                        if br.friend[i].hp <= getValue("治疗之涌") then
                            if cast.healingSurge(br.friend[i].unit) then return end     
                        end
                    end
                end
                if isChecked("治疗波") then
                    for i = 1, #br.friend do                           
                        if br.friend[i].hp <= getValue("治疗波") then
                            if cast.healingWave(br.friend[i].unit) then return end     
                        end
                    end
                end
            end
        -- Riptide
            if isChecked("激流") then
                if not buff.tidalWaves.exists() and level >= 34 then
                    if cast.riptide(lowest) then return end
                end
                for i = 1, #br.friend do
                    if br.friend[i].hp <= getValue("激流") and buff.riptide.remain(br.friend[i].unit) <= 1 then
                        if cast.riptide(br.friend[i].unit) then return end     
                    end
                end
            end
        -- Earthen Shield Totem
            if isChecked("大地之盾图腾") and talent.earthenShieldTotem then
                if castWiseAoEHeal(br.friend,spell.earthenShieldTotem,20,getValue("大地之盾图腾"),getValue("大地之盾图腾目标数量"),6,false,true) then return end
            end
        -- Healing Stream Totem
            if isChecked("治疗之泉图腾") then
                for i = 1, #br.friend do                           
                    if br.friend[i].hp <= getValue("治疗之泉图腾") then
                        if not talent.echoOfTheElements then
                            if cast.healingStreamTotem(br.friend[i].unit) then return end
                        elseif talent.echoOfTheElements and (not HSTime or GetTime() - HSTime > 15) then
                            if cast.healingStreamTotem(br.friend[i].unit) then
                            HSTime = GetTime()
                            return true end
                        end 
                    end
                end
            end
        -- Unleash Life
            if isChecked("生命释放") and talent.unleashLife and not hasEquiped(137051) then
                for i = 1, #br.friend do                           
                    if br.friend[i].hp <= getValue("生命释放") then
                        if cast.unleashLife() then return end     
                    end
                end
            end
        -- Healing Surge
            if isChecked("治疗之涌") then
                for i = 1, #br.friend do                           
                    if br.friend[i].hp <= getValue("治疗之涌") and (buff.tidalWaves.exists() or level < 100) then
                        if cast.healingSurge(br.friend[i].unit) then return end     
                    end
                end
            end
        -- Healing Rain
            if not moving then
                if (SpecificToggle("治疗之雨快捷键") and not GetCurrentKeyBoardFocus()) then
                    if CastSpellByName(GetSpellInfo(spell.healingRain),"cursor") then return end 
                end
                if isChecked("治疗之雨") and not buff.healingRain.exists() then
                    if castWiseAoEHeal(br.friend,spell.healingRain,12,getValue("治疗之雨"),getValue("治疗之雨目标数量"),6,false,true) then return end
                end
            end
        -- Spirit Link Totem
            if isChecked("灵魂链接图腾") and not moving then
                if (SpecificToggle("灵魂链接图腾快捷键") and not GetCurrentKeyBoardFocus()) then
                    if CastSpellByName(GetSpellInfo(spell.spiritLinkTotem),"cursor") then return end 
                end
                if castWiseAoEHeal(br.friend,spell.spiritLinkTotem,12,getValue("灵魂链接图腾"),getValue("灵魂链接图腾目标数量"),40,false,true) then return end
            end
        -- Healing Wave
            if isChecked("治疗波") then
                for i = 1, #br.friend do                           
                    if br.friend[i].hp <= getValue("治疗波") and (buff.tidalWaves.exists() or level < 100) then
                        if cast.healingWave(br.friend[i].unit) then return end     
                    end
                end
            end
        -- Oh Shit! Healing Surge
            if isChecked("治疗之涌") then
                for i = 1, #br.friend do                           
                    if br.friend[i].hp <= 40 then
                        if cast.healingSurge(br.friend[i].unit) then return end     
                    end
                end
            end
            -- Ephemeral Paradox trinket
            if hasEquiped(140805) and getBuffRemain("player", 225771) > 2 then
                if cast.healingWave(lowest.unit) then return end
            end
        end -- End Action List Single Target
    -- Action List - DPS
        local function actionList_DPS()
        -- Lightning Surge Totem
            if isChecked("闪电奔涌图腾 - HP") and php <= getOptionValue("闪电奔涌图腾 - HP") and inCombat and #enemies.yards5 > 0 and lastSpell ~= spell.lightningSurgeTotem then
                if cast.lightningSurgeTotem("player","ground") then return end
            end
            if isChecked("闪电奔涌图腾 - AoE") and #enemies.yards5 >= getOptionValue("闪电奔涌图腾 - AoE") and inCombat and lastSpell ~= spell.lightningSurgeTotem then
                if cast.lightningSurgeTotem("best",nil,getOptionValue("闪电奔涌图腾 - AoE"),8) then return end
            end
        -- Lava Burst - Lava Surge
            if buff.lavaSurge.exists() then
                for i = 1, #enemies.yards40 do        
                    local thisUnit = enemies.yards40[i]
                    if debuff.flameShock.exists(thisUnit) and isValidUnit(thisUnit) then
                        if cast.lavaBurst(thisUnit) then return end
                    end
                end
            end
        -- Flameshock
            for i = 1, #enemies.yards40 do
                local thisUnit = enemies.yards40[i]
                if not debuff.flameShock.exists(thisUnit) and isValidUnit(thisUnit) then
                    if cast.flameShock(thisUnit) then return end
                end
            end
        -- Lava Burst
            if debuff.flameShock.remain(units.dyn40) > getCastTime(spell.lavaBurst) or level < 20 then
                if cast.lavaBurst() then return end
            end
        -- Lightning Bolt
            if cast.lightningBolt() then return end
        end -- End Action List - DPS
-----------------
--- Rotations ---
-----------------
        -- Pause
        if pause() or mode.rotation == 4 then
            return true
        else
---------------------------------
--- Out Of Combat - Rotations ---
---------------------------------
            if not inCombat and not IsMounted() and not drinking then
                actionList_Extras()
                if isChecked("持续治疗") then
                    actionList_PreCombat()
                end
            end -- End Out of Combat Rotation
-----------------------------
--- In Combat - Rotations --- 
-----------------------------
            if inCombat and not IsMounted() and not drinking then
                actionList_Defensive()
                actionList_Interrupts()
                actionList_Cooldowns()
                if talent.cloudburstTotem and buff.cloudburstTotem.exists() then
                    actionList_CBT()
                end
                actionList_AOEHealing()
                actionList_SingleTarget()
                if br.player.mode.dps == 1 then
                    actionList_DPS()
                end
            end -- End In Combat Rotation
        end -- Pause
    end -- End Timer
end -- End runRotation 
local id = 264
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})
