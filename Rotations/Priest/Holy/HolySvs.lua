local rotationName = "Svs" 

---------------
--- Toggles ---
---------------
local function createToggles()
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "基于范围内的目标数,在单目标和多目标自动切换方式.", highlight = 1, icon = br.player.spell.holyWordSanctify },
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "使用多目标方式", highlight = 0, icon = br.player.spell.prayerOfHealing },
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "使用单目标方式", highlight = 0, icon = br.player.spell.heal },
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "禁用治疗", highlight = 0, icon = br.player.spell.holyFire}
    };
    CreateButton("Rotation",1,0)
-- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "自动使用大技能 - 只在BOSS", highlight = 1, icon = br.player.spell.guardianSpirit },
        [2] = { mode = "On", value = 1 , overlay = "Cooldowns Enabled", tip = "不管任何目标都使用大技能", highlight = 0, icon = br.player.spell.guardianSpirit },
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "不使用大技能", highlight = 0, icon = br.player.spell.guardianSpirit }
    };
    CreateButton("Cooldown",2,0)
-- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "使用保命技能", highlight = 1, icon = br.player.spell.desperatePrayer },
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "不使用保命技能", highlight = 0, icon = br.player.spell.desperatePrayer }
    };
    CreateButton("Defensive",3,0)
-- Decurse Button
    DecurseModes = {
        [1] = { mode = "On", value = 1 , overlay = "Decurse Enabled", tip = "启用驱散", highlight = 1, icon = br.player.spell.purify },
        [2] = { mode = "Off", value = 2 , overlay = "Decurse Disabled", tip = "禁用驱散", highlight = 0, icon = br.player.spell.purify }
    };
    CreateButton("Decurse",4,0)
-- DPS Button
    DPSModes = {
        [1] = { mode = "On", value = 1 , overlay = "DPS Enabled", tip = "启动DPS", highlight = 1, icon = br.player.spell.smite },
        [2] = { mode = "Off", value = 2 , overlay = "DPS Disabled", tip = "禁用DPS", highlight = 0, icon = br.player.spell.renew }
    };
    CreateButton("DPS",5,0)
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
    -- General Options
        section = br.ui:createSection(br.ui.window.profile, "一般")
            br.ui:createCheckbox(section,"持续治疗","|cff15FF00启用|cffFFFFFF/|cffD60000禁用 |cffFFFFFF不在战斗中也保持治疗|cffFFBB00.")
        -- Dummy DPS Test
            br.ui:createSpinner(section, "DPS测试",  5,  5,  60,  5,  "|cffFFFFFF设置为所需的测试的时间（分钟）. 最小: 5 / 最大: 60 / 间隔: 5")
        -- Angelic Feather
            br.ui:createCheckbox(section,"天堂之羽","|cff15FF00启用|cffFFFFFF/|cffD60000禁用 |cffFFFFFF天堂之羽|cffFFBB00.")
        -- Body and Mind
            br.ui:createCheckbox(section,"身心合一","|cff15FF00启用|cffFFFFFF/|cffD60000禁用 |cffFFFFFF身心合一|cffFFBB00.")
        -- Dispel Magic
            br.ui:createCheckbox(section,"驱散魔法","|cff15FF00启用|cffFFFFFF/|cffD60000禁用 |cffFFFFFF驱散魔法|cffFFBB00.")
        -- Mass Dispel
            br.ui:createDropdown(section, "群体驱散", br.dropOptions.Toggle, 6, colorGreen.."启用"..colorWhite.."/"..colorRed.."禁用 "..colorWhite.." 群体驱散.")
        -- Racial
            br.ui:createCheckbox(section, "种族技能")
        br.ui:checkSectionState(section)
    -- Cooldown Options
        section = br.ui:createSection(br.ui.window.profile, "冷却技能")
        -- Flask / Crystal
            br.ui:createCheckbox(section,"奥拉留斯的低语水晶")
         -- Racial
            br.ui:createCheckbox(section,"种族技能")
        -- Trinkets
            br.ui:createCheckbox(section,"饰品")
        -- Divine Hymn
            br.ui:createSpinner(section, "神圣赞美诗",  50,  0,  100,  5,  "多少血量百分比使用") 
            br.ui:createSpinnerWithout(section, "神圣赞美诗 目标",  3,  0,  40,  1,  "最少多少个人才使用")
        -- Symbol of Hope
            br.ui:createSpinner(section, "希望象征",  50,  0,  100,  5,  "多少血量百分比使用") 
            br.ui:createSpinnerWithout(section, "希望象征 目标",  3,  0,  40,  1,  "最少多少个人才使用")
        br.ui:checkSectionState(section)
    -- Defensive Options
        section = br.ui:createSection(br.ui.window.profile, "保命")
        -- Healthstone
            br.ui:createSpinner(section, "治疗石",  30,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用")
        -- Heirloom Neck
            br.ui:createSpinner(section, "传家宝项链",  60,  0,  100,  5,  "|cffFFBB00多少百分比血量使用");
        -- Gift of The Naaru
            if br.player.race == "Draenei" then
                br.ui:createSpinner(section, "纳鲁的赐福",  50,  0,  100,  5,  "|cffFFFFFF多少百分比血量使用")
            end
        -- Desperate Prayer
            br.ui:createSpinner(section, "绝望祷言",  80,  0,  100,  5,  "|cffFFBB00多少百分比血量使用");
        br.ui:checkSectionState(section)
        -- Healing Options
        section = br.ui:createSection(br.ui.window.profile, "治疗")
        -- Leap of Faith
            br.ui:createSpinner(section, "信仰飞跃",  20,  0,  100,  5,  "多少血量百分比使用")
        -- Guardian Spirit
            br.ui:createSpinner(section, "守护之魂",  30,  0,  100,  5,  "多少血量百分比使用")
        -- Guardian Spirit Tank Only
            br.ui:createCheckbox(section,"只对坦克守护之魂")
        -- Renew
            br.ui:createSpinner(section, "恢复",  90,  0,  100,  1,  "多少血量百分比使用")
        -- Prayer of Mending
            br.ui:createSpinner(section, "愈合祷言",  100,  0,  100,  1,  "多少血量百分比使用")
        -- Light of T'uure
            br.ui:createSpinner(section, "图雷之光",  85,  0,  100,  5,  "多少血量百分比使用")
        -- Heal
            br.ui:createSpinner(section, "治疗术",  70,  0,  100,  5,  "多少血量百分比使用")
        -- Flash Heal
            br.ui:createSpinner(section, "快速治疗",  60,  0,  100,  5,  "多少血量百分比使用")
        -- Flash Heal Surge of Light
            br.ui:createSpinner(section, "快速治疗 圣光涌动",  80,  0,  100,  5,  "多少血量百分比使用")
        -- Holy Word: Serenity
            br.ui:createSpinner(section, "圣言术：静",  50,  0,  100,  5,  "多少血量百分比使用")
            -- Holy Word: Sanctify
            br.ui:createSpinner(section, "圣言术：灵",  80,  0,  100,  5,  "多少血量百分比使用") 
            br.ui:createSpinnerWithout(section, "圣言术：灵 目标",  3,  0,  40,  1,  "最少多少个人才使用")
        -- Prayer of Healing
            br.ui:createSpinner(section, "治疗祷言",  70,  0,  100,  5,  "多少血量百分比使用") 
            br.ui:createSpinner(section, "治疗祷言 目标",  3,  0,  40,  1,  "最少多少个人才使用")
            br.ui:createSpinner(section, "神圣之星",  80,  0,  100,  5,  colorGreen.."启用"..colorWhite.."/"..colorRed.."禁用 "..colorWhite.."神圣之星.", colorWhite.."多少血量百分比使用")
            br.ui:createSpinnerWithout(section, "神圣之星 目标",  3,  1,  40,  1,  colorBlue.."最少多少个人才使用 "..colorGold.."(包括你自己)")
            br.ui:createCheckbox(section,"显示神圣之星区域",colorGreen.."启用"..colorWhite.."/"..colorRed.."禁用 "..colorWhite.."效果面积画线.")
            -- Halo
            br.ui:createSpinner(section, "光晕",  70,  0,  100,  5,  "多少血量百分比使用") 
            br.ui:createSpinnerWithout(section, "光晕 目标",  3,  0,  40,  1,  "最少多少个人才使用")
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
    if br.timer:useTimer("debugHoly", 0.1) then
        --Print("Running: "..rotationName)

---------------
--- Toggles --- -- List toggles here in order to update when pressed
---------------
        UpdateToggle("Rotation",0.25)
        UpdateToggle("Cooldown",0.25)
        UpdateToggle("Defensive",0.25)
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
        local enemies                                       = enemies or {}
        local falling, swimming, flying, moving             = getFallTime(), IsSwimming(), IsFlying(), GetUnitSpeed("player")>0
        local gcd                                           = br.player.gcd
        local healPot                                       = getHealthPot()
        local inCombat                                      = br.player.inCombat
        local inInstance                                    = br.player.instance=="party"
        local inRaid                                        = br.player.instance=="raid"
        local lastSpell                                     = lastSpellCast
        local level                                         = br.player.level
        local lowestHP                                      = br.friend[1].unit
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
        local ttm                                           = br.player.power.ttm
        local units                                         = units or {}

        local lowest                                        = {}    --Lowest Unit
        lowest.hp                                           = br.friend[1].hp
        lowest.role                                         = br.friend[1].role
        lowest.unit                                         = br.friend[1].unit
        lowest.range                                        = br.friend[1].range
        lowest.guid                                         = br.friend[1].guid                      
        local tank                                          = {}    --Tank
        local averageHealth                                 = 0

        units.dyn5 = br.player.units(5)
        units.dyn8AoE = br.player.units(8,true)
        units.dyn40 = br.player.units(40)

        enemies.yards5  = br.player.enemies(5)
        enemies.yards8  = br.player.enemies(8)
        enemies.yards8t = br.player.enemies(8,br.player.units(8,true))
        enemies.yards40 = br.player.enemies(40)

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
        -- Moving
            if isMoving("player") then
                if isChecked("天堂之羽") and talent.angelicFeather and not buff.angelicFeather.exists("player") then
                    if cast.angelicFeather("player") then
                        RunMacroText("/stopspelltarget")
                    end
                end
                -- Body and Mind
                if isChecked("身心合一") and talent.bodyAndMind then
                    if cast.bodyAndMind("player") then return end
                end
            end
        -- Mass Dispel
            if isChecked("群体驱散") and (SpecificToggle("群体驱散") and not GetCurrentKeyBoardFocus()) then
                CastSpellByName(GetSpellInfo(spell.massDispel),"cursor")
                return true
            end
        end -- End Action List - Extras
        -- Action List - Pre-Combat
        function actionList_PreCombat()
        -- Renew
            if isChecked("恢复") then
                for i = 1, #br.friend do
                    if br.friend[i].hp <= getValue("恢复") and not buff.renew.exists(br.friend[i].unit) then
                        if cast.renew(br.friend[i].unit) then return end
                    end
                end                    
            end
        -- Heal
            if isChecked("治疗术") then
                for i = 1, #br.friend do
                    if br.friend[i].hp <= getValue("治疗术") then
                        if cast.heal(br.friend[i].unit) then return end
                    end
                end                    
            end
        -- Flash Heal
            if isChecked("快速治疗") then
                for i = 1, #br.friend do
                    if br.friend[i].hp <= getValue("快速治疗") then
                        if cast.flashHeal(br.friend[i].unit) then return end
                    end
                end                    
            end
        -- Flash Heal Surge of Light
            if isChecked("快速治疗 圣光涌动") and talent.surgeOfLight and buff.surgeOfLight.exists() then
                for i = 1, #br.friend do
                    if br.friend[i].hp <= getValue("快速治疗 圣光涌动") then
                        if cast.flashHeal(br.friend[i].unit) then return end
                    end
                end                    
            end
        end  -- End Action List - Pre-Combat
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
            -- Desperate Prayer
                if isChecked("绝望祷言") and php <= getOptionValue("绝望祷言") and inCombat then
                    if cast.desperatePrayer() then return end
                end
            end -- End Defensive Toggle
        end -- End Action List - Defensive
        function actionList_Cooldowns()
            if useCDs() then
            -- Divine Hymn
                if isChecked("神圣赞美诗") and not moving then
                    if getLowAllies(getValue("神圣赞美诗")) >= getValue("神圣赞美诗 目标") then    
                        if cast.prayerOfMending(lowest.unit) then return end
                        if isChecked("圣言术：灵") and not buff.divinity.exists() then
                            if castWiseAoEHeal(br.friend,spell.holyWordSanctify,10,getValue("圣言术：灵"),getValue("圣言术：灵 目标"),6,false,false) then return end
                        end
                        if isChecked("圣言术：灵") and not buff.divinity.exists() then
                            if cast.holyWordSerenity(lowest.unit) then return end
                        end
                        if cast.divineHymn() then return end
                        if isChecked("圣言术：灵") then
                            if castWiseAoEHeal(br.friend,spell.holyWordSanctify,10,getValue("圣言术：灵"),getValue("圣言术：灵 目标"),6,false,false) then return end    
                        end
                        if isChecked("圣言术：灵") then
                            if cast.holyWordSerenity(lowest.unit) then return end
                        end
                    end
                end
            -- Symbol of Hope
                if isChecked("希望象征") then
                    if getLowAllies(getValue("希望象征")) >= getValue("希望象征 目标") then    
                        if cast.symbolOfHope() then return end    
                    end
                end
            -- Trinkets
                if isChecked("饰品") then
                    if canUse(11) then
                        useItem(11)
                    end
                    if canUse(12) then
                        useItem(12)
                    end
                    if canUse(13) then
                        useItem(13)
                    end
                    if canUse(14) then
                        useItem(14)
                    end
                end
            -- Racial: Orc Blood Fury | Troll Berserking | Blood Elf Arcane Torrent
                if isChecked("种族技能") and (br.player.race == "Orc" or br.player.race == "Troll" or br.player.race == "BloodElf") then
                    if castSpell("player",racial,false,false,false) then return end
                end
            end -- End useCooldowns check
        end -- End Action List - Cooldowns
        -- Dispel
        function actionList_Dispel()
        -- Purify
            if br.player.mode.decurse == 1 then
                for i = 1, #br.friend do
                    for n = 1,40 do
                        local buff,_,_,count,bufftype,duration = UnitDebuff(br.friend[i].unit, n)
                        if buff then
                        if bufftype == "Disease" or bufftype == "Magic" then
                                if cast.purify(br.friend[i].unit) then return end
                            end
                        end
                    end
                end
            end
            -- Mass Dispel
                if isChecked("群体驱散") and (SpecificToggle("群体驱散") and not GetCurrentKeyBoardFocus()) then
                    CastSpellByName(GetSpellInfo(spell.massDispel),"cursor")
                    return true
                end
        end -- End Action List - Dispel
        -- Emergency (Healing below 40%)
        function actionList_Emergency()
        -- Holy Word: Sanctify
            if isChecked("圣言术：灵") then
                if castWiseAoEHeal(br.friend,spell.holyWordSanctify,40,40,2,6,false,false) then return end
            end
        -- Holy Word: Serenity
            if isChecked("圣言术：静") then
                 for i = 1, #br.friend do
                    if br.friend[i].hp <= 40 then
                        if cast.holyWordSerenity(br.friend[i].unit) then return end
                    end
                end
            end 
        -- Prayer of Healing
            if isChecked("治疗祷言")  then
                if castWiseAoEHeal(br.friend,spell.prayerOfHealing,40,40,3,5,false,true) then return end  
            end             
        -- Flash Heal
            if isChecked("快速治疗") then
                for i = 1, #br.friend do
                    if br.friend[i].hp <= 40 then
                        if cast.flashHeal(br.friend[i].unit) then return end
                    end
                end                    
            end
        end -- EndAction List Emergency (Healing below 40%)
       -- Divinity
        function actionList_Divinity()
        -- Holy Word: Sanctify
            if isChecked("圣言术：灵") and not buff.divinity.exists() then
                if castWiseAoEHeal(br.friend,spell.holyWordSanctify,40,getValue("圣言术：灵"),getValue("圣言术：灵 目标"),6,false,false) then return end
            end 
        -- Holy Word: Serenity
            if isChecked("圣言术：灵") and not buff.divinity.exists() then
                for i = 1, #br.friend do
                    if br.friend[i].hp <= getValue("圣言术：灵") then
                        if cast.holyWordSerenity(br.friend[i].unit) then return end
                    end
                end
            end 
        end -- End Action List - Divinity        
        -- AOE Healing
        function actionList_AOEHealing()
        -- Prayer of Mending
            if isChecked("愈合祷言") then
                for i = 1, #br.friend do
                    if br.friend[i].hp <= getValue("愈合祷言") and not buff.prayerOfMending.exists(br.friend[i].unit) then
                        if cast.prayerOfMending(br.friend[i].unit) then return end
                    end
                end                    
            end
        -- Prayer of Healing (with Power Of The Naaru Buff)
            if isChecked("治疗祷言") and talent.piety and buff.powerOfTheNaaru.exists() then
                if castWiseAoEHeal(br.friend,spell.prayerOfHealing,40,getValue("治疗祷言"),getValue("治疗祷言 目标"),5,false,true) then return end
            end
        -- Divine Star
            if isChecked("神圣之星") and talent.divineStar then
                if castWiseAoEHeal(br.friend,spell.divineStar,10,getValue("神圣之星"),getValue("神圣之星 目标"),10,false,false) then return end
            end
        --Halo
            if isChecked("光晕") and talent.halo then
                if getLowAllies(getValue("光晕")) >= getValue("光晕 目标") then    
                    if cast.halo() then return end    
                end
            end
        -- Prayer of Healing
            if isChecked("治疗祷言") and not talent.piety then
                if castWiseAoEHeal(br.friend,spell.prayerOfHealing,40,getValue("治疗祷言"),getValue("治疗祷言 目标"),5,false,true) then return end
            end
        end -- End Action List - AOE Healing
        -- Single Target
        function actionList_SingleTarget()
        -- Guardian Spirit
            if isChecked("守护之魂") then
                for i = 1, #br.friend do
                    if br.friend[i].hp <= getValue("守护之魂") then
                        if br.friend[i].role == "TANK" or not isChecked("只对坦克守护之魂") then
                            if cast.guardianSpirit(br.friend[i].unit) then return end
                        end
                    end
                end                    
            end
        -- Leap of Faith
            if isChecked("信仰飞跃") then
                for i = 1, #br.friend do
                    if br.friend[i].hp <= getValue("信仰飞跃") and not UnitIsUnit(br.friend[i].unit,"player") and br.friend[i].role ~= "TANK" then
                        if cast.leapOfFaith(br.friend[i].unit) then return end
                    end
                end                    
            end
        -- Light of T'uure
            if isChecked("图雷之光") then
                for i = 1, #br.friend do
                    if br.friend[i].hp <= getValue("图雷之光") then
                        if cast.lightOfTuure(br.friend[i].unit) then return end
                    end
                end
            end
        -- Flash Heal
            if isChecked("快速治疗") then
                for i = 1, #br.friend do
                    if br.friend[i].hp <= getValue("快速治疗") then
                        if cast.flashHeal(br.friend[i].unit) then return end
                    end
                end                    
            end
        -- Flash Heal Surge of Light
            if isChecked("快速治疗 圣光涌动") and talent.surgeOfLight and buff.surgeOfLight.remain() > 1.5 then
                for i = 1, #br.friend do
                    if br.friend[i].hp <= getValue("快速治疗 圣光涌动") then
                        if cast.flashHeal(br.friend[i].unit) then return end
                    end
                end                    
            end
        -- Heal
            if isChecked("治疗术") then
                for i = 1, #br.friend do
                    if br.friend[i].hp <= getValue("治疗术") then
                        if cast.heal(br.friend[i].unit) then return end
                    end
                end                    
            end
        -- Dispel Magic
            if isChecked("驱散魔法") and canDispel("target",spell.dispelMagic) and not isBoss() and GetObjectExists("target") then
                if cast.dispelMagic() then return end
            end
        -- Renew
            if isChecked("恢复") then
                for i = 1, #br.friend do
                    if br.friend[i].hp <= getValue("恢复") and not buff.renew.exists(br.friend[i].unit) then
                        if inInstance or (inRaid and moving) then
                            if cast.renew(br.friend[i].unit) then return end
                        end
                    end
                end                    
            end
        -- Moving
            if isMoving("player") then
                if isChecked("天堂之羽") and talent.angelicFeather and not buff.angelicFeather.exists("player") then
                    if cast.angelicFeather("player") then
                        RunMacroText("/stopspelltarget")
                    end
                end
                -- Body and Mind
                if isChecked("身心合一") and talent.bodyAndMind then
                    if cast.bodyAndMind("player") then return end
                end
            end
        end -- End Action List - Single Target
        -- DPS
        function actionList_DPS()
        -- Holy Word: Chastise
            if cast.holyWordChastise() then return end
        -- Holy Fire
            if cast.holyFire() then return end
        -- Divine Star
            if cast.divineStar(getBiggestUnitCluster(24,7)) then return end
        -- Smite
            if #enemies.yards8 < 3 then
                if cast.smite() then return end
            end
        -- Holy Nova
            if #enemies.yards8 >= 3 and getDistance(units.dyn8AoE) < 12 and level > 25 then
                if cast.holyNova() then return end
            end
        end
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
            if not inCombat and not IsMounted() then
                actionList_Extras()
                if isChecked("持续治疗") then
                    actionList_PreCombat()
                end
            end -- End Out of Combat Rotation
-----------------------------
--- In Combat - Rotations --- 
-----------------------------
            if inCombat and not IsMounted() then
                if buff.spiritOfRedemption.exists() then
                   actionList_Emergency() 
                end
                if not buff.spiritOfRedemption.exists() then
                    actionList_Defensive()
                    actionList_Cooldowns()
                    actionList_Dispel()
                    actionList_Emergency()
                    if talent.divinity then
                        actionList_Divinity()
                    end
                    actionList_AOEHealing()
                    actionList_SingleTarget()
                    if br.player.mode.dps == 1 then
                        actionList_DPS()
                    end
                end
            end -- End In Combat Rotation
        end -- Pause
    end -- End Timer
end -- End runRotation 
local id = 257
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})