local rotationName = "团本" 

---------------
--- Toggles ---
---------------
local function createToggles()
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "基于范围内的目标数,在单目标和多目标自动切换方式.", highlight = 1, icon = br.player.spell.wildGrowth },
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "使用多目标方式", highlight = 1, icon = br.player.spell.wildGrowth },
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "使用单目标方式", highlight = 1, icon = br.player.spell.regrowth },
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "禁用治疗", highlight = 0, icon = br.player.spell.rejuvenation}
    };
    CreateButton("Rotation",1,0)
-- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "自动使用大技能 - 只在BOSS.", highlight = 1, icon = br.player.spell.tranquility },
        [2] = { mode = "On", value = 1 , overlay = "Cooldowns Enabled", tip = "不管任何目标都使用大技能.", highlight = 0, icon = br.player.spell.tranquility },
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "不使用大技能.", highlight = 0, icon = br.player.spell.tranquility }
    };
    CreateButton("Cooldown",2,0)
-- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "使用保命技能.", highlight = 1, icon = br.player.spell.barkskin },
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "不使用保命技能.", highlight = 0, icon = br.player.spell.barkskin }
    };
    CreateButton("Defensive",3,0)
-- Decurse Button
    DecurseModes = {
        [1] = { mode = "On", value = 1 , overlay = "Decurse Enabled", tip = "启用驱散", highlight = 1, icon = br.player.spell.naturesCure },
        [2] = { mode = "Off", value = 2 , overlay = "Decurse Disabled", tip = "禁用驱散", highlight = 0, icon = br.player.spell.naturesCure }
    };
    CreateButton("Decurse",4,0)
-- DPS Button
    DPSModes = {
        [2] = { mode = "On", value = 1 , overlay = "DPS Enabled", tip = "启动DPS", highlight = 1, icon = br.player.spell.rake },
        [1] = { mode = "Off", value = 2 , overlay = "DPS Disabled", tip = "禁用DPS", highlight = 0, icon = br.player.spell.regrowth }
    };
    CreateButton("DPS",5,0)
-- Rejuvenaion Button
    RejuvenaionModes = {
        [2] = { mode = "On", value = 1 , overlay = "Rejuvenaion Enabled", tip = "启动铺回春", highlight = 1, icon = br.player.spell.rejuvenation },
        [1] = { mode = "Off", value = 2 , overlay = "Rejuvenaion Disabled", tip = "禁用铺回春", highlight = 0, icon = br.player.spell.rejuvenation }
    };
    CreateButton("Rejuvenaion",6,0)	
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
		-- DBM预铺回春
            br.ui:createCheckbox(section,"DBM预铺回春","|cff15FF00启用|cffFFFFFF/|cffD60000禁用 |cffFFFFFF根据DBM大型AOE前5秒铺回春|cffFFBB00.")		
	    -- 延时之力药水	
		    br.ui:createSpinner(section, "延时之力药水",  2,  0,  20,  1,  "|cffFFFFFF根据DBM倒数计时多少秒使用延时之力药水.")
	    -- 改装的邪能焦镜
		    br.ui:createCheckbox(section,"改装的邪能焦镜","|cff15FF00启用|cffFFFFFF/|cffD60000禁用 |cffFFFFFF自动使用改装的邪能焦镜|cffFFBB00.")
        -- Travel Shapeshifts
            br.ui:createCheckbox(section,"自动变换形态","|cff15FF00启用|cffFFFFFF/|cffD60000禁用 |cffFFFFFF根据场所自动变换最好的形态|cffFFBB00.")
		-- 输出省蓝
            br.ui:createSpinnerWithout(section, "输出省蓝",  40,  0,  100,  5,  "|cffFFFFFF多少蓝量百分比以下不使用月火术和阳炎术")	
		-- 重伤助手
            br.ui:createCheckbox(section,"重伤助手","|cff15FF00请在|cffD60000重伤|cff15FF00词缀下启用，天赋一定要点出丰饶和开启铺回春.")		
        br.ui:checkSectionState(section)
    -- Cooldown Options
        section = br.ui:createSection(br.ui.window.profile, "技能冷却")
        -- 法力药水
            br.ui:createSpinner(section, "法力药水",  50,  0,  100,  1,  "多少蓝量百分比使用") 
         -- Racial
            br.ui:createCheckbox(section,"种族技能")
        -- Trinkets
            br.ui:createSpinner(section, "饰品 1",  70,  0,  100,  5,  "多少血量百分比使用") 
            br.ui:createSpinnerWithout(section, "饰品 1 目标",  5,  1,  40,  1,  "","最低多少个人才使用饰品1", true)
            br.ui:createSpinner(section, "饰品 2",  70,  0,  100,  5,  "多少血量百分比使用") 
            br.ui:createSpinnerWithout(section, "饰品 2 目标",  5,  1,  40,  1,  "","最低多少个人才使用饰品2", true)
        -- Innervate
            br.ui:createSpinner(section, "激活",  70,  0,  100,  5,  "多少血量百分比使用") 
            br.ui:createSpinner(section, "激活目标数量",  8,  0,  40,  1,  "","最低多少个人才使用激活", true)			
        --Incarnation: Tree of Life
            br.ui:createSpinner(section, "化身",  60,  0,  100,  5,  "多少血量百分比使用") 
            br.ui:createSpinner(section, "化身目标数量",  3,  0,  40,  1,  "","最低多少个人才使用化身", true)
        -- Tranquility
            br.ui:createSpinner(section, "宁静",  50,  0,  100,  5,  "多少血量百分比使用") 
            br.ui:createSpinner(section, "宁静目标数量",  3,  0,  40,  1,  "","最低多少个人才使用宁静", true)
        br.ui:checkSectionState(section)
    -- Defensive Options
        section = br.ui:createSection(br.ui.window.profile, "保命")
        -- Rebirth
            br.ui:createCheckbox(section,"复生","|cff15FF00启用|cffFFFFFF/|cffD60000禁用 |cffFFFFFF使用战复|cffFFBB00.",1)
            br.ui:createDropdownWithout(section, "复生 - 目标", {"|cff00FF00目标","|cffFF0000鼠标位置","|cffFFBB00自动"}, 1, "|cffFFFFFF施放目标")
        -- Healthstone
            br.ui:createSpinner(section, "治疗石",  30,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用")
        -- Barkskin
            br.ui:createSpinner(section, "树皮术",  60,  0,  100,  5,  "|cffFFBB00多少血量百分比使用.");		
        br.ui:checkSectionState(section)
    -- Healing Options
        section = br.ui:createSection(br.ui.window.profile, "治疗")
        -- Efflorescence
            br.ui:createSpinner(section, "百花齐放",  95,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用")
            br.ui:createSpinnerWithout(section, "百花齐放目标数量",  3,  0,  40,  1,  "放置百花齐放的目标数量")
            br.ui:createSpinnerWithout(section, "百花齐放重放延迟", 28, 1, 30, 1, colorWhite.."百花齐放重放延迟多少秒.")
            br.ui:createDropdown(section,"百花齐放快捷键", br.dropOptions.Toggle, 6, "","|cffFFFFFF按下快捷键就在鼠标位置放置百花齐放.", true)			
        -- Lifebloom
            br.ui:createCheckbox(section,"生命绽放","|cff15FF00启用|cffFFFFFF/|cffD60000禁用 |cffFFFFFF使用生命绽放|cffFFBB00.",1)
        -- Cenarion Ward
            br.ui:createSpinner(section, "塞纳里奥结界",  70,  0,  100,  5,  "","|cffFFFFFF多少血量百分比使用")
        -- Ironbark
            br.ui:createSpinner(section, "铁木树皮", 30, 0, 100, 5, "","多少血量百分比使用")
            br.ui:createDropdownWithout(section, "铁木树皮 目标", {"|cffFFFFFF自己","|cffFFFFFF目标", "|cffFFFFFF鼠标位置", "|cffFFFFFF坦克", "|cffFFFFFF奶妈", "|cffFFFFFF奶妈/坦克", "|cffFFFFFF所有人"}, 4, "|cffFFFFFF使用迅捷治愈的目标")	
        -- Swiftmend
            br.ui:createSpinner(section, "迅捷治愈", 30, 0, 100, 5, "","多少血量百分比使用")
            br.ui:createDropdownWithout(section, "迅捷治愈 目标", {"|cffFFFFFF自己","|cffFFFFFF目标", "|cffFFFFFF鼠标位置", "|cffFFFFFF坦克", "|cffFFFFFF奶妈", "|cffFFFFFF奶妈/坦克", "|cffFFFFFF所有人"}, 6, "|cffFFFFFF使用迅捷治愈的目标")				
        -- Rejuvenaion
            br.ui:createSpinner(section, "回春术",  90,  0,  100,  5,  "","|cffFFFFFF多少血量百分比使用")
            br.ui:createSpinnerWithout(section, "最大回春目标数量",  10,  0,  20,  1,  "","|cffFFFFFF最大回春目标数量")
        -- Germination
            br.ui:createSpinner(section, "萌芽",  70,  0,  100,  5,  "","|cffFFFFFF多少血量百分比使用", true)
            br.ui:createCheckbox(section,"只有坦克萌芽","|cff15FF00启用|cffFFFFFF/|cffD60000禁用 |cffFFFFFF只有坦克萌芽|cffFFBB00.")
        -- Regrowth
            br.ui:createSpinner(section, "愈合",  5,  0,  100,  5,  "","|cffFFFFFF多少血量百分比使用")
	        br.ui:createSpinner(section, "紧急愈合",  5,  0,  100,  5,  "","|cffFFFFFF多少血量会优先使用愈合", true)
        -- Regrowth Clearcasting
            br.ui:createSpinner(section, "愈合 清晰预兆",  80,  0,  100,  5,  "","|cffFFFFFF多少血量百分比使用", true)
        -- Regrowth on tank
            br.ui:createCheckbox(section,"在坦克身上保持愈合","|cff15FF00启用|cffFFFFFF/|cffD60000禁用 |cffFFFFFF在坦克身保持愈合BUFF|cffFFBB00.")
        -- Healing Touch
            br.ui:createSpinner(section, "治疗之触",  60,  0,  100,  5,  "","|cffFFFFFF多少血量百分比使用")
        -- Wild Growth
            br.ui:createSpinner(section, "野性成长",  75,  0,  100,  5,  "","多少血量百分比使用") 
            br.ui:createSpinner(section, "野性成长目标数量",  5,  0,  40,  1,  "","最低多少个人才使用野性成长", true)            
        -- Essence of G'Hanir
            br.ui:createSpinner(section, "加尼尔的精华",  70,  0,  100,  5,  "","多少血量百分比使用") 
            br.ui:createSpinner(section, "加尼尔的精华目标数量",  5,  0,  40,  1,  "","最低多少个人才使用加尼尔的精华", true)
        -- Flourish
            br.ui:createSpinner(section, "繁盛",  80,  0,  100,  5,  "","多少血量百分比使用") 
            br.ui:createSpinner(section, "繁盛目标数量",  8,  0,  40,  1,  "","最低多少个人到达血量百分比才使用繁盛", true)			
            br.ui:createSpinner(section, "繁盛回春数量",  8,  0,  40,  1,  "","最低多少个人有回春才使用繁盛", true)			
        br.ui:checkSectionState(section)
    -- Toggle Key Options
        section = br.ui:createSection(br.ui.window.profile, "切换快捷键")
        -- Pause Toggle
		    br.ui:createDropdown(section, "Rejuvenaion Mode", br.dropOptions.Toggle,  6, "铺回春快捷键")
			br.ui:createDropdown(section, "DPS Mode", br.dropOptions.Toggle,  6, "DPS快捷键")
			br.ui:createDropdown(section, "Decurse Mode", br.dropOptions.Toggle,  6, "驱散快捷键")
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
        UpdateToggle("Decurse",0.25)
        UpdateToggle("DPS",0.25)
		UpdateToggle("Rejuvenaion",0.25)
        br.player.mode.decurse = br.data.settings[br.selectedSpec].toggles["Decurse"]
        br.player.mode.dps = br.data.settings[br.selectedSpec].toggles["DPS"]
		br.player.mode.rejuvenaion = br.data.settings[br.selectedSpec].toggles["Rejuvenaion"]
--------------
--- Locals ---
--------------
        local clearcast                                     = br.player.buff.clearcasting.exists
        local artifact                                      = br.player.artifact
        local buff                                          = br.player.buff
        local cast                                          = br.player.cast
        local combatTime                                    = getCombatTime()
        local combo                                         = br.player.power.amount.comboPoints
        local cd                                            = br.player.cd
        local charges                                       = br.player.charges
        local debuff                                        = br.player.debuff
        local drinking                                      = UnitBuff("player",192002) ~= nil or UnitBuff("player",167152) ~= nil or UnitBuff("player",192001) ~= nil
        local enemies                                       = enemies or {}
        local falling, swimming, flying, moving             = getFallTime(), IsSwimming(), IsFlying(), GetUnitSpeed("player")>0
        local gcd                                           = br.player.gcd
        local healPot                                       = getHealthPot()
        local inCombat                                      = br.player.inCombat
        local inInstance                                    = br.player.instance=="party"
        local inRaid                                        = br.player.instance=="raid"
        local stealthed                                     = UnitBuffID("player",5215) ~= nil
        local lossPercent                                   = getHPLossPercent("player",5)		
        local lastSpell                                     = lastSpellCast
        local level                                         = br.player.level
        local lowest                                        = br.friend[1]
        local lowestHP                                      = br.friend[1].unit
        local mana                                          = br.player.power.mana.percent
        local mode                                          = br.player.mode
        local perk                                          = br.player.perk        
        local php                                           = br.player.health
        local power, powmax, powgen                         = br.player.power.amount.mana, br.player.power.mana.max, br.player.power.regen
        local pullTimer                                     = br.DBM:getPulltimer()
        local race                                          = br.player.race
        local racial                                        = br.player.getRacial()
        local recharge                                      = br.player.recharge
        local rejuvCount                                    = 0
        local rkTick                                        = 3
        local rpTick                                        = 2
        local snapLossHP                                    = 0		
        local spell                                         = br.player.spell
        local talent                                        = br.player.talent
        local travel, flight, cat, moonkin, bear, noform    = br.player.buff.travelForm.exists(), br.player.buff.flightForm.exists(), br.player.buff.catForm.exists(), br.player.buff.moonkinForm.exists(), br.player.buff.bearForm.exists(), GetShapeshiftForm()==0
        local ttm                                           = br.player.power.ttm
        local units                                         = units or {}
        local lowestTank                                    = {}    --Tank
        local bloomCount                                    = 0
        local tHp                                           = 95

        units.dyn5 = br.player.units(5)
        units.dyn8    = br.player.units(8)
        units.dyn40 = br.player.units(40)

        enemies.yards5  = br.player.enemies(5)
        enemies.yards8  = br.player.enemies(8)
        enemies.yards40 = br.player.enemies(40)
		
        if lossPercent > snapLossHP or php > snapLossHP then snapLossHP = lossPercent end

        --ChatOverlay("|cff00FF00Abundance stacks: "..buff.abundance.stack().."")

--------------------
--- Action Lists ---
--------------------
    -- Action List - Extras
        local function actionList_Extras()
		-- 延时之力药水
			if isChecked("延时之力药水") and pullTimer <= getOptionValue("延时之力药水") then
                if pullTimer <= getOptionValue("延时之力药水") then
                    if canUse(142117) and not buff.prolongedPower.exists() then
                        useItem(142117);
                            return true
                            end
                        end
		    end
		-- 改装的邪能焦镜					
			if isChecked("改装的邪能焦镜") and getBuffRemain("player",242551) < 1 and getBuffRemain("player",188031) < 1 then					
                    if canUse(147707) then
                        useItem(147707);
                            return true
                            end
			end	
        -- Shapeshift Form Management
            if isChecked("自动变换形态") then
            -- Flight Form
                if IsFlyableArea() and ((not (isInDraenor() or isInLegion())) or isKnown(191633)) and not swimming and falling > 1 and level>=58 then
                    if cast.travelForm() then return end
                end
            -- Travel Form
                if not inCombat and swimming and not travel and not hastar and not deadtar and not buff.prowl.exists() then
                    if cast.travelForm() then return end
                end
                if not inCombat and moving and not travel and not IsMounted() and not IsIndoors() then
                    if cast.travelForm() then return end
                end
            -- Cat Form
                if not cat and not IsMounted() then
                    -- Cat Form when not swimming or flying or stag and not in combat
                    if not inCombat and moving and not swimming and not flying and not travel and not isValidUnit("target") then
                        if cast.catForm() then return end
                    end
                end
            end -- End Shapeshift Form Management
        -- Efflorescence
                if (SpecificToggle("百花齐放快捷键") and not GetCurrentKeyBoardFocus()) then
                    CastSpellByName(GetSpellInfo(spell.efflorescence),"cursor")
                    LastEfflorescenceTime = GetTime()
                    return
                end
                if isChecked("百花齐放") and not moving and (not LastEfflorescenceTime or GetTime() - LastEfflorescenceTime > getOptionValue("百花齐放重放延迟")) then
                    if getLowAllies(getValue("百花齐放")) >= getValue("百花齐放目标数量") then
                        if castGroundAtBestLocation(spell.efflorescence, 10, 0, 40, 0, "heal") then
                        LastEfflorescenceTime = GetTime()
                        return true end
                end
            end			
        end -- End Action List - Extras
        -- Action List - Pre-Combat
        function actionList_PreCombat()
            -- Swiftmend
                if isChecked("迅捷治愈") and not isCastingSpell(spell.tranquility) and not buff.soulOfTheForest.exists() then
                -- Player
                if getOptionValue("迅捷治愈 目标") == 1 then
                    if php <= getValue("迅捷治愈") then
                        if cast.swiftmend("player") then return true end
                    end
                    -- Target
                elseif getOptionValue("迅捷治愈 目标") == 2 then
                    if getHP("target") <= getValue("迅捷治愈") then
                        if cast.swiftmend("target") then return true end
                    end
                    -- Mouseover
                elseif getOptionValue("迅捷治愈 目标") == 3 then
                    if getHP("mouseover") <= getValue("迅捷治愈") then
                        if cast.swiftmend("mouseover") then return true end
                    end
                elseif lowest.hp <= getValue("迅捷治愈") then
                    -- Tank
                    if getOptionValue("迅捷治愈 目标") == 4 then
                        if (lowest.role) == "TANK" then
                            if cast.swiftmend(lowest.unit) then return true end
                        end
                    -- Healer
                    elseif getOptionValue("迅捷治愈 目标") == 5 then
                        if (lowest.role) == "HEALER" then
                            if cast.swiftmend(lowest.unit) then return true end
                        end
                    -- Healer/Tank
                    elseif getOptionValue("迅捷治愈 目标") == 6 then
                        if (lowest.role) == "HEALER" or (lowest.role) == "TANK" then
                            if cast.swiftmend(lowest.unit) then return true end
                        end
                    -- Any
                    elseif  getOptionValue("迅捷治愈 目标") == 7 then
                        if cast.swiftmend(lowest.unit) then return true end
                    end
                end
            end		
	        -- 重伤助手
           if isChecked("重伤助手") and talent.abundance and not isCastingSpell(spell.tranquility) then
                for i = 1, #br.friend do  
				    if br.friend[i].hp >= 80 and br.friend[i].hp <= 90 and buff.abundance.stack() >= 5 and not moving then
					    if cast.healingTouch(br.friend[i].unit) then return end
					end
				end
				for i = 1, #br.friend do  
				    if br.friend[i].hp <= 80 and (not moving or buff.incarnationTreeOfLife.exists()) and buff.abundance.stack() >= 5 then
					    if cast.regrowth(br.friend[i].unit) then return end
					end
				end
				for i = 1, #br.friend do  
				    if br.friend[i].hp <= 90 and talent.germination and not buff.rejuvenationGermination.exists(br.friend[i].unit) and moving then
					    if cast.rejuvenation(br.friend[i].unit) then return end 
					end
				end	
			end			
            -- Rejuvenation
            if isChecked("回春术") and not isCastingSpell(spell.tranquility) then
                rejuvCount = 0
                for i=1, #br.friend do
                    if buff.rejuvenation.remain(br.friend[i].unit) > 1 then
                        rejuvCount = rejuvCount + 1
                    end
                end
                for i = 1, #br.friend do
                    if br.friend[i].hp <= getValue("萌芽") and talent.germination and (rejuvCount < getValue("最大回春目标数量")) and not buff.rejuvenationGermination.exists(br.friend[i].unit) then
                        if cast.rejuvenation(br.friend[i].unit) then return end
                    elseif br.friend[i].hp <= getValue("回春术") and buff.rejuvenation.remain(br.friend[i].unit) <= 1 and (rejuvCount < getValue("最大回春目标数量")) then
                        if cast.rejuvenation(br.friend[i].unit) then return end     
                    end
                end
            end
            -- Regrowth
           if isChecked("愈合") and (not moving or buff.incarnationTreeOfLife.exists()) and not isCastingSpell(spell.tranquility) and lastSpell ~= spell.regrowth then
                for i = 1, #br.friend do
                    if br.friend[i].hp <= getValue("愈合 清晰预兆") and buff.clearcasting.remain() > 1.5 then
                        if cast.regrowth(br.friend[i].unit) then return end     
                    elseif br.friend[i].hp <= getValue("愈合") and buff.regrowth.remain(br.friend[i].unit) <= 1 then
                        if cast.regrowth(br.friend[i].unit) then return end     
                    end
                end
            end
        end  -- End Action List - Pre-Combat
        local function actionList_Defensive()
            if useDefensive() then
            -- Rebirth
                if isChecked("复生") then
                    if getOptionValue("复生 - 目标") == 1 
                        and UnitIsPlayer("target") and UnitIsDeadOrGhost("target") and UnitIsFriend("target","player")
                    then
                        if cast.rebirth("target","dead") then return end
                    end
                    if getOptionValue("复生 - 目标") == 2 
                        and UnitIsPlayer("mouseover") and UnitIsDeadOrGhost("mouseover") and UnitIsFriend("mouseover","player")
                    then
                        if cast.rebirth("mouseover","dead") then return end
                    end
                    if getOptionValue("复生 - 目标") == 3 then
                        for i =1, #br.friend do
                            if UnitIsPlayer(br.friend[i].unit) and UnitIsDeadOrGhost(br.friend[i].unit) and UnitIsFriend(br.friend[i].unit,"player") then
                                if cast.rebirth(br.friend[i].unit,"dead") then return end
                            end
                        end
                    end
                end
            -- Healthstone
                if isChecked("治疗石") and php <= getOptionValue("治疗石") and not isCastingSpell(spell.tranquility) 
                    and inCombat and (hasHealthPot() or hasItem(5512)) then
                    if canUse(5512) then
                        useItem(5512)
                    elseif canUse(healPot) then
                        useItem(healPot)
                    end
                end
            -- Barkskin
                if isChecked("树皮术") and not isCastingSpell(spell.tranquility) then
                    if php <= getOptionValue("树皮术") and inCombat then
                        if cast.barkskin() then return end
                    end
                end
            end -- End Defensive Toggle
        end -- End Action List - Defensive	
        function actionList_Cooldowns()
            if useCDs() then
            -- Incarnation: Tree of Life
                if isChecked("化身") and talent.incarnationTreeOfLife and not buff.incarnationTreeOfLife.exists() and not isCastingSpell(spell.tranquility) then
                    if getLowAllies(getValue("化身")) >= getValue("化身目标数量") then    
                        if cast.incarnationTreeOfLife() then return end    
                    end
                end
            -- Tranquility
                if isChecked("宁静") and not isCastingSpell(spell.tranquility) and not buff.incarnationTreeOfLife.exists() then
                    if getLowAllies(getValue("宁静")) >= getValue("宁静目标数量") then    
                        if cast.tranquility() then return end    
                    end
                end
            -- Innervate
                if isChecked("激活") and not isCastingSpell(spell.tranquility) and mana ~= nil then
                    if getLowAllies(getValue("激活")) >= getValue("激活目标数量") and mana < 80 then    
                        if cast.innervate("player") then return end    
                    end
                end
            -- Trinkets
            if isChecked("饰品 1") and getLowAllies(getValue("饰品 1")) >= getValue("饰品 1 目标") and not isCastingSpell(spell.tranquility) then
                if canUse(13) then
                    useItem(13)
                    return true
                end
            end
            if isChecked("饰品 2") and getLowAllies(getValue("饰品 2")) >= getValue("饰品 2 目标") and not isCastingSpell(spell.tranquility) then
                if canUse(14) then
                    useItem(14)
                    return true
                end
            end
			-- 法力药水
            if isChecked("法力药水") and mana <= getValue("法力药水") then
                if hasItem(127835) then
                    useItem(127835)
                    return true
                end
            end			
        -- Racial: Orc Blood Fury | Troll Berserking | Blood Elf Arcane Torrent
                if isChecked("种族技能") and (br.player.race == "Orc" or br.player.race == "Troll" or br.player.race == "BloodElf") and not isCastingSpell(spell.tranquility) then
                    if castSpell("player",racial,false,false,false) then return end
                end
            end -- End useCooldowns check
        end -- End Action List - Cooldowns
        -- AOE Healing
        function actionList_AOEHealing()
		    -- 变熊
			if talent.guardianAffinity then
			if bear then
			    if cast.mangle(units.dyn5) then return end
			end
			if bear then
			    if cast.thrash(units.dyn8) then return end
			end	
			if bear and (snapLossHP >= 20 or (snapLossHP > php and snapLossHP > 5)) and not buff.frenziedRegeneration.exists() then
			    if cast.frenziedRegeneration() then snapLossHP = 0; return end
			end
		end	
            -- Wild Growth
            if isChecked("野性成长") and not moving and not isCastingSpell(spell.tranquility) then
                if getLowAllies(getValue("野性成长")) >= getValue("野性成长目标数量") then    
                    if cast.wildGrowth() then return end
                end
            end	
            -- Essence of G'Hanir
            if isChecked("加尼尔的精华") and not isCastingSpell(spell.tranquility) then
                if getLowAllies(getValue("加尼尔的精华")) >= getValue("加尼尔的精华目标数量") and (lastSpell == spell.wildGrowth or lastSpell == spell.flourish) then  
                    if cast.essenceOfGhanir() then return end    
                end
            end
        end
            -- Flourish          
                if isChecked("繁盛") and talent.flourish and not isCastingSpell(spell.tranquility) then
                rejuvCount = 0
                for i=1, #br.friend do
                    if buff.rejuvenation.exists(br.friend[i].unit) then
                        rejuvCount = rejuvCount + 1
                    end
                end
                for i=1, #br.friend do				
                    if getLowAllies(getValue("繁盛")) >= getValue("繁盛目标数量") and rejuvCount >= getValue("繁盛回春数量") and (lastSpell == spell.wildGrowth or lastSpell == spell.essenceOfGhanir) then
                        if cast.flourish() then return end    
                    end
                end
	        end	
        -- Single Target
        function actionList_SingleTarget()
            -- Nature's Cure
            if br.player.mode.decurse == 1 then
                for i = 1, #br.friend do
                    for n = 1,40 do
                        local buff,_,_,count,bufftype,duration = UnitDebuff(br.friend[i].unit, n)
                        if buff then
                            if bufftype == "Curse" or bufftype == "Magic" or bufftype == "Poison" then
                                if cast.naturesCure(br.friend[i].unit) then return end
                            end
                        end
                    end
                end
            end
            -- Ironbark
                if isChecked("铁木树皮") and not isCastingSpell(spell.tranquility) then
                -- Player
                if getOptionValue("铁木树皮 目标") == 1 then
                    if php <= getValue("铁木树皮") then
                        if cast.ironbark("player") then return true end
                    end
                    -- Target
                elseif getOptionValue("铁木树皮 目标") == 2 then
                    if getHP("target") <= getValue("铁木树皮") then
                        if cast.ironbark("target") then return true end
                    end
                    -- Mouseover
                elseif getOptionValue("铁木树皮 目标") == 3 then
                    if getHP("mouseover") <= getValue("铁木树皮") then
                        if cast.ironbark("mouseover") then return true end
                    end
                elseif lowest.hp <= getValue("铁木树皮") then
                    -- Tank
                    if getOptionValue("铁木树皮 目标") == 4 then
                        if (lowest.role) == "TANK" then
                            if cast.ironbark(lowest.unit) then return true end
                        end
                    -- Healer
                    elseif getOptionValue("铁木树皮 目标") == 5 then
                        if (lowest.role) == "HEALER" then
                            if cast.ironbark(lowest.unit) then return true end
                        end
                    -- Healer/Tank
                    elseif getOptionValue("铁木树皮 目标") == 6 then
                        if (lowest.role) == "HEALER" or (lowest.role) == "TANK" then
                            if cast.ironbark(lowest.unit) then return true end
                        end
                    -- Any
                    elseif  getOptionValue("铁木树皮 目标") == 7 then
                        if cast.ironbark(lowest.unit) then return true end
                    end	
                    end
                end
            -- Swiftmend
                 if isChecked("迅捷治愈") and not isCastingSpell(spell.tranquility) and not buff.soulOfTheForest.exists() then
                -- Player
                if getOptionValue("迅捷治愈 目标") == 1 then
                    if php <= getValue("迅捷治愈") then
                        if cast.swiftmend("player") then return true end
                    end
                    -- Target
                elseif getOptionValue("迅捷治愈 目标") == 2 then
                    if getHP("target") <= getValue("迅捷治愈") then
                        if cast.swiftmend("target") then return true end
                    end
                    -- Mouseover
                elseif getOptionValue("迅捷治愈 目标") == 3 then
                    if getHP("mouseover") <= getValue("迅捷治愈") then
                        if cast.swiftmend("mouseover") then return true end
                    end
                elseif lowest.hp <= getValue("迅捷治愈") then
                    -- Tank
                    if getOptionValue("迅捷治愈 目标") == 4 then
                        if (lowest.role) == "TANK" then
                            if cast.swiftmend(lowest.unit) then return true end
                        end
                    -- Healer
                    elseif getOptionValue("迅捷治愈 目标") == 5 then
                        if (lowest.role) == "HEALER" then
                            if cast.swiftmend(lowest.unit) then return true end
                        end
                    -- Healer/Tank
                    elseif getOptionValue("迅捷治愈 目标") == 6 then
                        if (lowest.role) == "HEALER" or (lowest.role) == "TANK" then
                            if cast.swiftmend(lowest.unit) then return true end
                        end
                    -- Any
                    elseif  getOptionValue("迅捷治愈 目标") == 7 then
                        if cast.swiftmend(lowest.unit) then return true end
                    end	
                    end
                end
	        -- 提前绽放			
			if isChecked("生命绽放") and not isCastingSpell(spell.tranquility) then
		        for i = 1, #br.friend do    
                    if br.friend[i].hp <= 70 and buff.lifebloom.remain(br.friend[i].unit) < 5 and buff.lifebloom.remain(br.friend[i].unit) > 0 and UnitGroupRolesAssigned(br.friend[i].unit) == "TANK" then
		                if cast.lifebloom(br.friend[i].unit) then return end
		                end
		            end
		        end					
	        -- 重伤助手
           if isChecked("重伤助手") and talent.abundance and not isCastingSpell(spell.tranquility) then
                for i = 1, #br.friend do  
				    if br.friend[i].hp >= 80 and br.friend[i].hp <= 90 and buff.abundance.stack() >= 5 and not moving then
					    if cast.healingTouch(br.friend[i].unit) then return end
					end
				end
				for i = 1, #br.friend do  
				    if br.friend[i].hp <= 80 and (not moving or buff.incarnationTreeOfLife.exists()) and buff.abundance.stack() >= 5 then
					    if cast.regrowth(br.friend[i].unit) then return end
					end
				end
				for i = 1, #br.friend do  
				    if br.friend[i].hp <= 90 and talent.germination and not buff.rejuvenationGermination.exists(br.friend[i].unit) and moving then
					    if cast.rejuvenation(br.friend[i].unit) then return end 
					end
				end	
			end		
            -- Oh Shit! Regrowth
           if isChecked("愈合") and (not moving or buff.incarnationTreeOfLife.exists()) and not isCastingSpell(spell.tranquility) then
                for i = 1, #br.friend do                           
                    if br.friend[i].hp <= getValue("紧急愈合") then
                        if cast.regrowth(br.friend[i].unit) then return end
                    end
                end
            end				
            -- Lifebloom			
            if isChecked("生命绽放") and not isCastingSpell(spell.tranquility) then
                if inInstance then    
                    for i = 1, #br.friend do
                        if not buff.lifebloom.exists(br.friend[i].unit) and UnitGroupRolesAssigned(br.friend[i].unit) == "TANK" then
                            if cast.lifebloom(br.friend[i].unit) then return end
                        end
                    end              
                else 
                    if inRaid then
                        bloomCount = 0
                        for i=1, #br.friend do
                            if buff.lifebloom.exists(br.friend[i].unit) then
                                bloomCount = bloomCount + 1
                            end
                        end
                        for i = 1, #br.friend do
                            if bloomCount < 1 and not buff.lifebloom.exists(br.friend[i].unit) and UnitGroupRolesAssigned(br.friend[i].unit) == "TANK" then
                                if cast.lifebloom(br.friend[i].unit) then return end
                            end
                        end
                    end
                end
            end
            -- Cenarion Ward
           if isChecked("塞纳里奥结界") and talent.cenarionWard and not isCastingSpell(spell.tranquility) then
                for i = 1, #br.friend do                           
                    if br.friend[i].hp <= getValue("塞纳里奥结界") and UnitGroupRolesAssigned(br.friend[i].unit) == "TANK" and not buff.cenarionWard.exists(br.friend[i].unit) then
                        if cast.cenarionWard(br.friend[i].unit) then return end     
                    end
                end
            end
            -- Regrowth
           if isChecked("愈合") and (not moving or buff.incarnationTreeOfLife.exists()) and not isCastingSpell(spell.tranquility) and lastSpell ~= spell.regrowth then
                for i = 1, #br.friend do
                    if br.friend[i].hp <= getValue("愈合 清晰预兆") and buff.clearcasting.remain() > 1.5 then
                        if cast.regrowth(br.friend[i].unit) then return end
                    elseif isChecked("在坦克身上保持愈合") and buff.lifebloom.exists(br.friend[i].unit) and buff.regrowth.remain(br.friend[i].unit) <= 1 and br.friend[i].hp <= getValue("愈合") then
                        if cast.regrowth(br.friend[i].unit) then return end
                    elseif br.friend[i].hp <= getValue("愈合") and buff.regrowth.remain(br.friend[i].unit) <= 1 then
                            if cast.regrowth(br.friend[i].unit) then return end
                    end
                end
            end
            -- Healing Touch with abundance stacks >= 5
           if isChecked("治疗之触") and not moving and not isCastingSpell(spell.tranquility) then
                for i = 1, #br.friend do                           
                    if br.friend[i].hp <= getValue("治疗之触") and talent.abundance and buff.abundance.stack() >= 5 then
                        if cast.healingTouch(br.friend[i].unit) then return end
                    end
                end
            end
            -- Rejuvenation
            if isChecked("回春术") and not isCastingSpell(spell.tranquility) then
                rejuvCount = 0
                for i=1, #br.friend do
                    if buff.rejuvenation.remain(br.friend[i].unit) > 1 then
                        rejuvCount = rejuvCount + 1
                    end
                end
                for i = 1, #br.friend do
                    if br.friend[i].hp <= getValue("萌芽") and talent.germination and (rejuvCount < getValue("最大回春目标数量")) and not buff.rejuvenationGermination.exists(br.friend[i].unit) then
                        if isChecked("只有坦克萌芽") and UnitGroupRolesAssigned(br.friend[i].unit) == "TANK" then
                            if cast.rejuvenation(br.friend[i].unit) then return end
                        elseif not isChecked("只有坦克萌芽") then
                            if cast.rejuvenation(br.friend[i].unit) then return end
                        end
                    elseif br.friend[i].hp <= getValue("回春术") and buff.rejuvenation.remain(br.friend[i].unit) <= 1 and (rejuvCount < getValue("最大回春目标数量")) then
                        if cast.rejuvenation(br.friend[i].unit) then return end
                    end
                end
            end
            -- Healing Touch
           if isChecked("治疗之触") and not moving and not isCastingSpell(spell.tranquility) then
                for i = 1, #br.friend do                           
                    if br.friend[i].hp <= getValue("治疗之触") then
                        if cast.healingTouch(br.friend[i].unit) then return end
                    end
				end	
            end				
			-- 给DOT伤害的队友铺回春
			local debuff_list={
				228253, --  影舌舔舐  高姆
				204531, --  奥术桎梏  老1  对T
				206607, --  时光粒子  老2
				219966, --  时间释放红    老2
				219965, --  时间释放黄    老2
				206798, --  毒性薄片  老3
				213166, --  灼热烙印  魔剑
				212587, --  冰霜印记  魔剑
				206936, --  寒冰喷射  占星
				205649, --  邪能喷射  占星
				206464, --  日冕喷射  占星
				214486,--   虚空爆炸 占星
				206480, --  腐肉瘟疫  蝙蝠
				219235, --  剧毒孢子  植物
				218809, --  黑夜的召唤  植物
				206677, --  灼烧烙印  断桥  对T
				209615, --  消融      大姐姐 对T
				211258, --  透心折磨  大姐姐
				206222, --  邪能束缚  古尔丹
				206221, --  强化邪能束缚  古尔丹
				212568, --  吸取  古尔丹
			}
			for i=1, #br.friend do
				for k,v in pairs(debuff_list) do
					if getDebuffRemain(br.friend[i].unit,v) > 5.0 and not buff.rejuvenation.exists(br.friend[i].unit) and not isCastingSpell(spell.tranquility) then
						if cast.rejuvenation(br.friend[i].unit) then return end
					end
				end
			end
        end
		    --根据DBM预铺回春
			local precast_spell_list={
				--spell_id	, precast_time	,	spell_name
				{214652 	, 5				,	'老1酸性碎片'},
				{205862 	, 5				,	'断桥猛击'},
				{218774 	, 5				,	'离子球'},
				{206949 	, 5				,	'严寒新星--占星'},
				{206517 	, 5				,	'邪能新星--占星'},
				{207720 	, 5				,	'见证虚空'},
				{206219 	, 5				,	'液态地狱火'},
				{211439 	, 5				,	'内心恶魔的意志'},
				{209270 	, 5				,	'古尔丹之眼'},
				{227071 	, 5				,	'烈焰冲撞'},
			}			
			for i=1 , #precast_spell_list do
				local boss_spell_id = precast_spell_list[i][1]
				local precast_time = precast_spell_list[i][2]
				local spell_name = precast_spell_list[i][3]
				local time_remain = br.DBM:getPulltimer_fix(nil,boss_spell_id)		
				if time_remain < precast_time then
				if isChecked("DBM预铺回春") then
					for j = 1, #br.friend do
						if not buff.rejuvenation.exists(br.friend[j].unit) and not isCastingSpell(spell.tranquility) then
							if cast.rejuvenation(br.friend[j].unit) then 
								Print("预铺回春--"..spell_name)
								return 
							end
						end
					end
				end
			end
		end	
    -- Ephemeral Paradox trinket
            if hasEquiped(140805) and getBuffRemain("player", 225766) > 2 then
                if cast.healingTouch(lowestHP) then return end
            end					
    -- 铺回春
	    local function actionList_Rejuvenaion()
		if br.player.mode.rejuvenaion == 2 then
		  for i = 1, #br.friend do
			   if not buff.rejuvenation.exists(br.friend[i].unit) and not isCastingSpell(spell.tranquility) and getBuffRemain("player",167152) < 1 then
				    if cast.rejuvenation(br.friend[i].unit) then return end
                   end
                end
            end	
        end
	-- 不浪费激活
			if buff.innervate.remain() >= 1 and not isCastingSpell(spell.tranquility) then
				for i=1, #br.friend do
				    if buff.rejuvenation.remain(br.friend[i].unit) < 1 then
				        if cast.rejuvenation(br.friend[i].unit) then return end
					end	
				end
			end
	-- 满蓝回春
	        for i = 1, #br.friend do
			    if not travel and inCombat and mana >= 99 and not buff.rejuvenation.exists(br.friend[i].unit) and inRaid and not isCastingSpell(spell.tranquility) then
				    if cast.rejuvenation(br.friend[i].unit) then return end	
				end
			end	
    -- Action List - DPS
        local function actionList_DPS()
        -- Guardian Affinity/Level < 45
            if talent.guardianAffinity or level < 45 then
            -- Sunfire
                if not bear and not debuff.sunfire.exists(units.dyn40) and mana >= getOptionValue("输出省蓝") then
                    if cast.sunfire(units.dyn40) then return end
                end
            -- Moonfire
                if not debuff.moonfire.exists(units.dyn40) and mana >= getOptionValue("输出省蓝") then
                    if cast.moonfire(units.dyn40) then return end
                end
            -- Solar Wrath
                if not moving then
                    if cast.solarWrath(units.dyn40) then return end
               end	
            end 
        -- Feral Affinity
            if talent.feralAffinity then
            -- Cat form
                if not cat and getDistance(units.dyn5) < 5 then
                    if cast.catForm() then return end
                end
            -- Rake
                if combo < 5 then
                    for i = 1, #enemies.yards5 do
                        local thisUnit = enemies.yards5[i]
                        if getDistance(thisUnit) < 5 then
                            if not debuff.rake.exists(thisUnit) then
                                if cast.rake(thisUnit) then return end
                            end
                        end
                    end
                end
            -- Rip
                if combo == 5 then
                    for i = 1, #enemies.yards5 do
                        local thisUnit = enemies.yards5[i]
                        if getDistance(thisUnit) < 5 then
                            if not debuff.rip.exists(thisUnit) or debuff.rip.remain(thisUnit) < 4 then
                               if cast.rip(thisUnit) then return end
                            end
                        end
                    end
                end
            -- Ferocious Bite
                if combo == 5 then
                    for i = 1, #enemies.yards5 do
                        local thisUnit = enemies.yards5[i]
                        if getDistance(thisUnit) < 5 and debuff.rip.exists(thisUnit) then
                            if cast.ferociousBite(thisUnit) then return end
                        end
                    end
                end
            -- Swipe
                if ((mode.rotation == 1 and #enemies.yards8 >= 6) or mode.rotation == 2) then
                    if cast.swipe("player") then return end
                end
            -- Shred
                if combo < 5 and debuff.rake.exists(units.dyn5) and (((mode.rotation == 1 and #enemies.yards8 < 3) or mode.rotation == 3) or level < 32) then
                    if cast.shred(units.dyn5) then return end
                end
            end -- End - Feral Affinity
        -- Balance Affinity 
            if talent.balanceAffinity then
            -- Moonkin form
                if not moonkin and not moving and not travel and not IsMounted() then
                    if cast.moonkinForm() then return end
                end
            -- Lunar Strike 3 charges
                if buff.lunarEmpowerment.stack() == 3 then
                    if cast.lunarStrike() then return end
                end
            -- Starsurge
                if cast.starsurge() then return end
            -- Sunfire
                if not debuff.sunfire.exists(units.dyn40) and mana >= getOptionValue("输出省蓝") then
                    if cast.sunfire(units.dyn40) then return end
                end
            -- Moonfire
                if not debuff.moonfire.exists(units.dyn40) and mana >= getOptionValue("输出省蓝") then
                    if cast.moonfire(units.dyn40) then return end
                end
            -- Lunar Strike charged
                if buff.lunarEmpowerment.exists() then
                    if cast.lunarStrike() then return end
                end
            -- Solar Wrath charged
                if buff.solarEmpowerment.exists() then
                    if cast.solarWrath(units.dyn40) then return end
                end
            -- Solar Wrath uncharged
                if cast.solarWrath(units.dyn40) then return end
            -- Lunar Strike uncharged
                if cast.lunarStrike() then return end
            end -- End -- Balance Affinity
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
            if not inCombat and not IsMounted() and not stealthed and not drinking and not buff.shadowmeld.exists() then
                    actionList_Extras()
                if isChecked("持续治疗") then
                    actionList_PreCombat()
                    actionList_Rejuvenaion()
                end
            end -- End Out of Combat Rotation
-----------------------------
--- In Combat - Rotations --- 
-----------------------------
            if inCombat and not IsMounted() and not stealthed and not drinking and not buff.shadowmeld.exists() then
                actionList_Rejuvenaion()
                actionList_Extras()
                actionList_Defensive()				
                actionList_Cooldowns()
                actionList_AOEHealing()
                actionList_SingleTarget()
                if br.player.mode.dps == 2 then
                    actionList_DPS()
                end
            end -- End In Combat Rotation
        end -- Pause
    end -- End Timer
end -- End runRotation 
local id = 105
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})
