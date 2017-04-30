local rotationName = "LyLoLoq"

---------------
--- Toggles ---
---------------
local function createToggles()
    -- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "自动使用大技能 - 只在BOSS", highlight = 1, icon = br.player.spell.lifeCocoon },
        [2] = { mode = "On", value = 2 , overlay = "Cooldowns Enabled", tip = "不管任何目标都使用大技能", highlight = 1, icon = br.player.spell.lifeCocoon },
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "不使用大技能", highlight = 0, icon = br.player.spell.lifeCocoon }
    };
    CreateButton("Cooldown",1,0)
    -- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "使用保命技能", highlight = 1, icon = br.player.spell.dampenHarm },
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "不使用保命技能", highlight = 0, icon = br.player.spell.dampenHarm }
    };
    CreateButton("Defensive",2,0)
    -- Dispell
    DispellModes = {
        [1] = { mode = "On", value = 1 , overlay = "Dispell Enabled", tip = "启用驱散", highlight = 1, icon = br.player.spell.detox },
        [2] = { mode = "Off", value = 2 , overlay = "Dispell Disabled", tip = "禁用驱散", highlight = 0, icon = br.player.spell.detox }
    };
    CreateButton("Dispell",3,0)
    -- DPS Button
    DPSModes = {
        [1] = { mode = "On", value = 1 , overlay = "DPS Enabled", tip = "启用DPS ", highlight = 1, icon = br.player.spell.risingSunKick },
        [2] = { mode = "Off", value = 2 , overlay = "DPS Disabled", tip = "禁用DPS", highlight = 0, icon = br.player.spell.risingSunKick }
    };
    CreateButton("DPS",4,0)
    -- Interrupt Button
    InterruptModes = {
        [1] = { mode = "On", value = 1 , overlay = "Interrupts Enabled", tip = "使用打断.", highlight = 1, icon = br.player.spell.legSweep },
        [2] = { mode = "Off", value = 2 , overlay = "Interrupts Disabled", tip = "不使用打断.", highlight = 0, icon = br.player.spell.legSweep }
    };
    CreateButton("Interrupt",5,0)
end

---------------
--- OPTIONS ---
---------------
local function createOptions()
    local optionTable

    local function rotationOptions()
        --------------
        --- COLORS ---
        --------------
        local colorBlue     = "|cff00CCFF"
        local colorGreen    = "|cff00FF00"
        local colorRed      = "|cffFF0000"
        local colorWhite    = "|cffFFFFFF"
        local colorGold     = "|cffFFDD11"
        --------------
        --- OPTIONS ---
        --------------

        -- General Options
        section = br.ui:createSection(br.ui.window.profile, "一般")
        br.ui:createDropdown(section, "滚地翻/真气突", br.dropOptions.Toggle, 6, colorGreen.."启用"..colorWhite.."/"..colorRed.."禁用 "..colorWhite.." use of Roll/Chi Torpedo with Key.",colorWhite.."Set hotkey to use Roll/Chi Torpedo with key.")
        br.ui:createDropdown(section, "魂体双分/魂体双分：转移", br.dropOptions.Toggle, 6, colorGreen.."启用"..colorWhite.."/"..colorRed.."禁用 "..colorWhite.." use of Transcendence/Transcendence:Transfer with Key.",colorWhite.."Set hotkey to use Transcendence/Transcendence:Transfer with key.")
        br.ui:createCheckbox(section, "迅如猛虎", colorGreen.."启用"..colorWhite.."/"..colorRed.."禁用 "..colorWhite.." use of Tiger's Lust"..colorBlue.." (Auto use on snare and root).")
        br.ui:createDropdown(section, "迅如猛虎", br.dropOptions.Toggle, 6, colorGreen.."启用"..colorWhite.."/"..colorRed.."禁用 "..colorWhite.." use of Tiger's Lust with Key.",colorWhite.."Set hotkey to use Tiger's Lust with key.")
        br.ui:createDropdown(section, "平心之环", br.dropOptions.Toggle, 6, colorGreen.."启用"..colorWhite.."/"..colorRed.."禁用 "..colorWhite.." use of Ring Of Peace with Key on "..colorRed.."Cursor",colorWhite.."Set hotkey to use Ring Of Peace with key.")

        br.ui:createSpinnerWithout(section, "DPS",  90,  0,  100,  1,  colorWhite.." Dps when lowest health >= ")
        br.ui:checkSectionState(section)

        -- Cooldown Options
        section = br.ui:createSection(br.ui.window.profile, "冷却技能")
        br.ui:createSpinner(section, "还魂术",  30,  0,  100,  1,  colorGreen.."启用"..colorWhite.."/"..colorRed.."禁用 "..colorWhite.." use of Revival.", colorWhite.."多少血量百分比使用")
        br.ui:createSpinnerWithout(section, "还魂术 目标",  3,  1,  40,  1,  colorBlue.."Minimum Revival Targets "..colorGold.."(This includes you)")
        br.ui:createSpinner(section, "朱鹤赤精",  30,  0,  100,  1,  colorGreen.."启用"..colorWhite.."/"..colorRed.."禁用 "..colorWhite.." use of Invoke Chi-Ji, the Red Crane.", colorWhite.."多少血量百分比使用")
        br.ui:createSpinnerWithout(section, "朱鹤赤精 目标",  3,  1,  40,  1,  colorBlue.."Minimum Invoke Chi-Ji, the Red Crane Targets "..colorGold.."(This includes you)")
        br.ui:createSpinner(section, "作茧缚命",  20,  0,  100,  1,  colorGreen.."启用"..colorWhite.."/"..colorRed.."禁用 "..colorWhite.." use of Life Cocoon.", colorWhite.."多少血量百分比使用")
        br.ui:createDropdownWithout(section, "作茧缚命 目标", {colorGreen.."自己",colorBlue.."目标",colorWhite.."鼠标位置",colorRed.."坦克",colorGreen.."奶妈",colorGreen.."奶妈/坦克",colorBlue.."所有"}, 6, colorWhite.."Target to cast on")
        br.ui:createSpinner(section, "饰品 1",  50,  0,  100,  1,  colorGreen.."启用"..colorWhite.."/"..colorRed.."禁用 "..colorWhite.." use of Trinket 1.", colorWhite.."多少血量百分比使用")
        br.ui:createSpinnerWithout(section, "饰品 1 目标",  1,  1,  40,  1,  colorBlue.."Minimum Trinket 1 Targets "..colorGold.."(This includes you)")
        br.ui:createSpinner(section, "饰品 2",  50,  0,  100,  1,  colorGreen.."启用"..colorWhite.."/"..colorRed.."禁用 "..colorWhite.." use of Trinket 2.", colorWhite.."多少血量百分比使用")
        br.ui:createSpinnerWithout(section, "饰品 2 目标",  1,  1,  40,  1,  colorBlue.."Minimum Trinket 2 Targets "..colorGold.."(This includes you)")
        br.ui:createSpinner(section, "法力茶",  50,  0,  100,  1,  colorGreen.."启用"..colorWhite.."/"..colorRed.."禁用 "..colorWhite.." use of Mana Tea.", colorWhite.."Mana Percent to Cast At")
        br.ui:createSpinnerWithout(section, "法力茶 - 血量",  50,  0,  100,  1,  colorWhite.."多少血量百分比使用")
        br.ui:createSpinnerWithout(section, "法力茶 目标",  3,  1,  40,  1,  colorBlue.."Minimum Low Life Targets "..colorGold.."(This includes you)")
        br.ui:createSpinner(section, "奥术洪流",  90,  0,  100,  1,  colorGreen.."启用"..colorWhite.."/"..colorRed.."禁用 "..colorWhite.." use of Arcane Torrent to mana recover.", colorWhite.."多少蓝量百分比使用")
        br.ui:createSpinner(section, "法力药水",  50,  0,  100,  1,  colorGreen.."启用"..colorWhite.."/"..colorRed.."禁用 "..colorWhite.." use of Ancient Mana Potion.", colorWhite.."Mana Percent to Cast At")
        br.ui:createSpinner(section, "雷光聚神茶+活血术",  50,  0,  100,  1,  colorGreen.."启用"..colorWhite.."/"..colorRed.."禁用 "..colorWhite.." use of Thunder Focus Tea + Vivify.", colorWhite.."多少血量百分比使用")
        br.ui:createSpinnerWithout(section, "雷光聚神茶+活血术 法力",  50,  0,  100,  1,  colorGreen.."启用"..colorWhite.."/"..colorRed.."禁用 "..colorWhite.." use of Thunder Focus Tea + Vivify.", colorWhite.."Mana Percent to Cast At")
        br.ui:createSpinner(section, "雷光聚神茶+复苏之雾",  50,  0,  100,  1,  colorGreen.."启用"..colorWhite.."/"..colorRed.."禁用 "..colorWhite.." use of Thunder Focus Tea + Renewing Mist.", colorWhite.."多少血量百分比使用")
        br.ui:createSpinner(section, "雷光聚神茶+氤氲之雾",  50,  0,  100,  1,  colorGreen.."启用"..colorWhite.."/"..colorRed.."禁用 "..colorWhite.." use of Thunder Focus Tea + Enveloping Mist.", colorWhite.."多少血量百分比使用")
        br.ui:checkSectionState(section)

        -- Defensive Options
        section = br.ui:createSection(br.ui.window.profile, "保命")
        br.ui:createSpinner(section, "金创药/散魔功/躯不坏",  40,  0,  100,  1,  colorGreen.."启用"..colorWhite.."/"..colorRed.."禁用 "..colorWhite.." use of Healing Elixir/Diffuse Magic/Dampen Harm.", colorWhite.."多少血量百分比使用")
        br.ui:createDropdown(section, "金创药/散魔功/躯不坏 快捷键", br.dropOptions.Toggle, 6, colorGreen.."启用"..colorWhite.."/"..colorRed.."禁用 "..colorWhite.." use of Healing Elixir/Diffuse Magic/Dampen Harm with Key.",colorWhite.."Set hotkey to use Healing Elixir/Diffuse Magic/Dampen Harm with key.")
        br.ui:createSpinner(section, "壮胆酒",  40,  0,  100,  1,  colorGreen.."Enables"..colorWhite.."/"..colorRed.."Disables "..colorWhite.." use of Fortifying Brew.", colorWhite.."Health Percent to Cast At")
        br.ui:createSpinner(section, "治疗石",  30,  0,  100,  5,  colorWhite.."多少血量百分比使用")
        br.ui:checkSectionState(section)

        -- Healing Options
        section = br.ui:createSection(br.ui.window.profile, "治疗")
        br.ui:createSpinner(section, "精华之泉",  60,  0,  100,  1,  colorGreen.."启用"..colorWhite.."/"..colorRed.."禁用 "..colorWhite.." use of Essence Font.", colorWhite.."多少血量百分比使用")
        br.ui:createSpinnerWithout(section, "精华之泉 目标",  5,  1,  40,  1,  colorBlue.."Minimum Essence Font Targets "..colorGold.."(This includes you)")
        br.ui:createSpinner(section, "碧玉疾风",  60,  0,  100,  1,  colorGreen.."启用"..colorWhite.."/"..colorRed.."禁用 "..colorWhite.." use of Refreshing Jade Wind.", colorWhite.."多少血量百分比使用")
        br.ui:createSpinnerWithout(section, "碧玉疾风 目标",  3,  1,  40,  1,  colorBlue.."Minimum Refreshing Jade Wind "..colorGold.."(This includes you)")
        br.ui:createSpinner(section, "真气爆裂",  70,  0,  100,  1,  colorGreen.."启用"..colorWhite.."/"..colorRed.."禁用 "..colorWhite.."Use of Chi Burst.", colorWhite.."多少血量百分比使用")
        br.ui:createSpinnerWithout(section, "真气爆裂 目标",  3,  1,  40,  1,  colorBlue.."Minimum Chi Burst Targets "..colorGold.."(This includes you)")
        br.ui:createCheckbox(section,"显示线",colorGreen.."启用"..colorWhite.."/"..colorRed.."禁用 "..colorWhite.."Lines of Chi Burst.")
        br.ui:createSpinner(section, "活血术",  80,  0,  100,  1,  colorGreen.."启用"..colorWhite.."/"..colorRed.."禁用 "..colorWhite.."Use of Vivify.", colorWhite.."多少血量百分比使用")
        br.ui:createSpinnerWithout(section, "活血术 目标",  2,  1,  3,  1,  colorBlue.."Minimum Vivify Targets "..colorGold.."(This includes you)")
        br.ui:createSpinner(section, "活血术+生生不息",  85,  0,  100,  1,  colorGreen.."启用"..colorWhite.."/"..colorRed.."禁用 "..colorWhite.."Use of Vivify with Lifecycles.", colorWhite.."多少血量百分比使用")
        br.ui:createSpinnerWithout(section, "活血术+生生不息 目标",  2,  1,  3,  1,  colorBlue.."Minimum ivify with Lifecycles Targets "..colorGold.."(This includes you)")
        br.ui:createSpinner(section, "Vivify with Uplift",  90,  0,  100,  1,  colorGreen.."启用"..colorWhite.."/"..colorRed.."禁用 "..colorWhite.."Use of Vivify with Uplift.", colorWhite.."多少血量百分比使用")
        br.ui:createSpinnerWithout(section, "Min Vivify with Uplift Targets",  2,  1,  3,  1,  colorBlue.."Minimum Vivify with Uplift Targets "..colorGold.."(This includes you)")
        br.ui:createSpinner(section, "Vivify with Lifecycles + Uplift",  95,  0,  100,  1,  colorGreen.."启用"..colorWhite.."/"..colorRed.."禁用 "..colorWhite.."Use of Vivify with Lifecycles + Uplift.", colorWhite.."多少血量百分比使用")
        br.ui:createSpinnerWithout(section, "Min Vivify with Lifecycles + Uplift Targets",  2,  1,  3,  1,  colorBlue.."Minimum Vivify with Lifecycles + Uplift Targets "..colorGold.."(This includes you)")
        br.ui:createSpinner(section, "神龙之赐",  70,  0,  100,  1,  colorGreen.."启用"..colorWhite.."/"..colorRed.."禁用 "..colorWhite.."Use of Sheilun's Gift.", colorWhite.."多少血量百分比使用")
        br.ui:createSpinnerWithout(section, "神龙之赐 Charges",  5,  1,  12,  1,  colorBlue.."Minimum Sheilun's Gift charges")
        br.ui:createSpinner(section, "氤氲之雾",  75,  0,  100,  1,  colorGreen.."启用"..colorWhite.."/"..colorRed.."禁用 "..colorWhite.."Use of Enveloping Mist.", colorWhite.."多少血量百分比使用")
        br.ui:createCheckbox(section, "氤氲之雾 - 只有坦克", colorGreen.."Enables"..colorWhite.."/"..colorRed.."Disables "..colorWhite.."Use of Enveloping Mist on tank only.")
        br.ui:createSpinner(section, "氤氲之雾+生生不息",  65,  0,  100,  1,  colorGreen.."启用"..colorWhite.."/"..colorRed.."禁用 "..colorWhite.."Use of Enveloping Mist.", colorWhite.."多少血量百分比使用")
        br.ui:createSpinner(section, "禅意波",  90,  0,  100,  1,  colorGreen.."启用"..colorWhite.."/"..colorRed.."禁用 "..colorWhite.."Use of Zen Pulse.", colorWhite.."多少血量百分比使用")
        br.ui:createSpinnerWithout(section, "禅意波 敌人",  3,  1,  100,  1,  colorBlue.."Minimum Zen Pulse Enemies")
        br.ui:createCheckbox(section, "真气贯通", colorGreen.."Enables"..colorWhite.."/"..colorRed.."Disables "..colorWhite.."Use of Effuse.")
        br.ui:createSpinnerWithout(section, "真气贯通 大于或等于",  90,  0,  100,  1,  colorGreen.."Enables"..colorWhite.."/"..colorRed.."Disables "..colorWhite.."Use of Effuse.", colorWhite.."Health Percent to Cast At. (Exemple: Effuse Greater or equals 80% and <= 100%)")
        br.ui:createSpinnerWithout(section, "真气贯通 小于或等于",  90,  0,  100,  1,  colorGreen.."Enables"..colorWhite.."/"..colorRed.."Disables "..colorWhite.."Use of Effuse.", colorWhite.."Health Percent to Cast At. (Exemple: Effuse Greater or equals 80% and <= 100%)")
        br.ui:createSpinner(section, "复苏之雾",  100,  0,  100,  1,  colorGreen.."启用"..colorWhite.."/"..colorRed.."禁用 "..colorWhite.."Use of Renewing Mist.", colorWhite.."多少血量百分比使用")
        br.ui:createCheckbox(section,"复苏之雾 - On CD",colorGreen.."启用"..colorWhite.."/"..colorRed.."禁用 "..colorWhite.."Renewing Mist on CD regardless in combat.")
        --        br.ui:createSpinner(section, "Mistwalk",  80,  0,  100,  1,  colorGreen.."Enables"..colorWhite.."/"..colorRed.."Disables "..colorWhite.."Use of Mistwalk.", colorWhite.."Health Percent to Cast At")
        br.ui:createSpinner(section, "真气波",  80,  0,  100,  1,  colorGreen.."Enables"..colorWhite.."/"..colorRed.."Disables "..colorWhite.."Use of Chi Wave.", colorWhite.."Health Percent to Cast At")
        br.ui:createDropdown(section, "青龙雕像", {colorGreen.."自己",colorBlue.."目标",colorRed.."坦克"}, 3,colorGreen.."启用"..colorWhite.."/"..colorRed.."禁用 "..colorWhite.."Use of Summon Jade Serpent.", colorWhite.."Use Summon Jade Serpent at location of.")
        br.ui:checkSectionState(section)


        --Offensive Options
        section = br.ui:createSection(br.ui.window.profile, "进攻")
        br.ui:createCheckbox(section,"碎玉闪电",colorGreen.."启用"..colorWhite.."/"..colorRed.."禁用 "..colorWhite.."the use of Crackling Jade Lightning.")
        br.ui:checkSectionState(section)


        -- Interrupt Options
        section = br.ui:createSection(br.ui.window.profile, "打断")
        br.ui:createCheckbox(section,"分筋错骨",colorGreen.."启用"..colorWhite.."/"..colorRed.."禁用 "..colorWhite.." use of Leg Sweep.")
        br.ui:createCheckbox(section,"扫堂腿",colorGreen.."启用"..colorWhite.."/"..colorRed.."禁用 "..colorWhite.." use of Paralysis.")
        br.ui:checkSectionState(section)

        -- Interrupt Percentage
        br.ui:createSpinnerWithout(section,  "打断",  50,  0,  100,  1,  colorBlue.."百分几打断.")
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

    ---------------
    --- Toggles ---
    ---------------
    UpdateToggle("Defensive",0.25)
    UpdateToggle("Dispell",0.25)
    UpdateToggle("DPS",0.25)
    UpdateToggle("Interrupt",0.25)
    br.player.mode.dispell = br.data.settings[br.selectedSpec].toggles["Dispell"]
    br.player.mode.dps = br.data.settings[br.selectedSpec].toggles["DPS"]
    br.player.mode.interrupt = br.data.settings[br.selectedSpec].toggles["Interrupt"]

    --------------
    --- Locals ---
    --------------
    local cast                                          = br.player.cast
    local talent                                        = br.player.talent
    local cd                                            = br.player.cd
    local buff                                          = br.player.buff
    local spell                                         = br.player.spell
    local inCombat                                      = br.player.inCombat
    local useDispell                                    = br.player.mode.dispell == 1
    local useDPS                                        = br.player.mode.dps == 1
    local php                                           = br.player.health
    local healPot                                       = getHealthPot()
    local mana                                          = br.player.power.mana.percent
    local debuff                                        = br.player.debuff
    local gcd                                           = br.player.gcd

    local lowest                                        = br.friend[1]
    local lossPercent                                   = getHPLossPercent(lowest.unit,5)
    local enemies                                       = enemies or {}
    local friends                                       = friends or {}

    enemies.yards5 = br.player.enemies(5)
    enemies.yards8 = br.player.enemies(8)
    enemies.yards20 = br.player.enemies(20)
    enemies.yards40 = br.player.enemies(40)
    friends.yards8 = getAllies("player",8)
    friends.yards25 = getAllies("player",25)
    friends.yards40 = getAllies("player",40)

    if not inCombat then
        TFV = false
        TFRM = false
        TFEM = false
    end
    if botSpell == nil then
        botSpell = 61304
    end
    if currentTarget == nil then
        currentTarget = UnitGUID("player")
    end
    --    Print("LastSpell:"..GetSpellInfo(botSpell))
    --    Print("LastTarget:"..SetRaidTarget(currentTarget,8))
    --------------------
    --- Action Lists ---
    --------------------
    local function actionList_Detox()
        if useDispell then
            for i = 1, #friends.yards40 do
                for n = 1,40 do
                    local buff,_,_,_,bufftype,_ = UnitDebuff(br.friend[i].unit, n)
                    if buff then
                        if bufftype == "Disease" or bufftype == "Magic" or bufftype == "Poison" then
                            if cast.detox(br.friend[i].unit) then return true end
                        end
                    end
                end
            end
        end
        return false
    end--OK--TODO

    local function actionList_Interrupt()
        if useInterrupts() then
            if isChecked("分筋错骨") and talent.legSweep and cd.legSweep == 0 then
                for i = 1, #enemies.yards5 do
                    local thisUnit = enemies.yards5[i]
                    if canInterrupt(thisUnit,getValue("打断")) then
                        if cast.legSweep() then return true end
                    end
                end
            end
            if isChecked("扫堂腿") and cd.paralysis == 0 then
                for i = 1, #enemies.yards20 do
                    local thisUnit = enemies.yards20[i]
                    if canInterrupt(thisUnit,getValue("打断")) then
                        if cast.paralysis(thisUnit) then return true end
                    end
                end
            end
            return false
        end
    end--OK

    local function actionList_Defensive()
        if useDefensive() then
            if (isChecked("金创药/散魔功/躯不坏") and php <= getValue("金创药/散魔功/躯不坏"))
                    or (isChecked("金创药/散魔功/躯不坏 快捷键") and (SpecificToggle("金创药/散魔功/躯不坏 快捷键") and not GetCurrentKeyBoardFocus())) then
                if cast.healingElixir() then return true end
                if cast.diffuseMagic() then return true end
                if cast.dampenHarm() then return true end
            end
            if isChecked("壮胆酒") and php <=  getValue("壮胆酒") and cd.fortifyingBrew == 0 then
                if cast.fortifyingBrew() then return true end
            end
            if isChecked("治疗石") and php <= getValue("治疗石") and inCombat and (hasHealthPot() or hasItem(5512)) then
                if canUse(5512) then
                    useItem(5512)
                    return true
                elseif canUse(healPot) then
                    useItem(healPot)
                    return true
                end
            end
        end
        return false
    end--OK

    local function actionList_Extra()
        if isChecked("滚地翻/真气突") and (SpecificToggle("滚地翻/真气突") and not GetCurrentKeyBoardFocus()) then
            if cast.roll() then return true end
            if cast.chiTorpedo() then return true end
        end
        if isChecked("魂体双分/魂体双分：转移") and (SpecificToggle("魂体双分/魂体双分：转移") and not GetCurrentKeyBoardFocus()) then
            if tPX == nil or tPY == nil or not buff.transcendence.exists() then tPX, tPY, tPZ = ObjectPosition("player"); if cast.transcendence() then return true end
            elseif getDistanceToObject("player",tPX,tPY,tPZ) > 40 and buff.transcendence.exists() then
                if cast.transcendence() then return true end
            else
                if cast.transcendenceTransfer("player") then return true end
            end
        end
        if isChecked("迅如猛虎") and hasNoControl()
                or (isChecked("迅如猛虎") and (SpecificToggle("迅如猛虎") and not GetCurrentKeyBoardFocus())) then
            if cast.tigersLust() then return true end
        end
        if isChecked("平心之环") and (SpecificToggle("平心之环") and not GetCurrentKeyBoardFocus()) and cd.ringOfPeace == 0 then
            CastSpellByName(GetSpellInfo(spell.ringOfPeace),"cursor")
            return true
        end
        if buff.innervate.exists() or buff.symbolOfHope.exists() or buff.manaTea.exists() then
            if isChecked("碧玉疾风") and talent.refreshingJadeWind and #friends.yards8 > 1 then
                if cast.refreshingJadeWind() then return true end
            end
            if isChecked("精华之泉") and #friends.yards25 > 5  then
                if cast.essenceFont() then return true end
            end
            if isChecked("活血术") then
                if cast.vivify(lowest.unit) then return true end
            end
        end
        if isChecked("复苏之雾 - On CD") then
            for i = 1, #friends.yards40 do
                local thisUnit = friends.yards40[i]
                if thisUnit.hp <= getValue("复苏之雾") and buff.renewingMist.remain(thisUnit.unit) < gcd then
                    if cast.renewingMist(thisUnit.unit) then return true end
                end
            end
        end
        return false
    end--OK

    local function actionList_Cooldown()
        if useCDs() then
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
            if isChecked("法力药水") and mana <= getValue("法力药水")then
                if hasItem(127835) and canUse(127835) then
                    useItem(127835)
                    return true
                end
            end
            if isChecked("奥术洪流") and mana <= getValue("奥术洪流") and br.player.race == "BloodElf" then
                if br.player.castRacial() then return true end
            end
            if isChecked("法力茶") and mana <= getValue("法力茶") and getLowAllies(getValue("法力茶 - 血量")) >= getValue("法力茶 目标") and talent.manaTea  then
                if cast.manaTea() then return true end
            end
            if isChecked("还魂术") and getLowAllies(getValue("还魂术")) >= getValue("还魂术 目标") and cd.revival == 0 then
                SpellStopCasting()
                if cast.revival() then return true end
            end
            if isChecked("朱鹤赤精") and talent.invokeChiJiTheRedCrane and cd.invokeChiJiTheRedCrane == 0 then
                if getLowAllies(getValue("朱鹤赤精")) >= getValue("朱鹤赤精 目标") then
                    SpellStopCasting()
                    if cast.invokeChiJiTheRedCrane("player") then return true end
                end
            end
            if isChecked("作茧缚命") and cd.lifeCocoon == 0  then
                -- Player
                if getOptionValue("作茧缚命 目标") == 1 then
                    if php <= getValue("作茧缚命") then
                        SpellStopCasting()
                        if cast.lifeCocoon("player") then return true end
                    end
                    -- Target
                elseif getOptionValue("作茧缚命 目标") == 2 then
                    if getHP("target") <= getValue("作茧缚命") then
                        SpellStopCasting()
                        if cast.lifeCocoon("target") then return true end
                    end
                    -- Mouseover
                elseif getOptionValue("作茧缚命 目标") == 3 then
                    if getHP("mouseover") <= getValue("作茧缚命") then
                        SpellStopCasting()
                        if cast.lifeCocoon("mouseover") then return true end
                    end
                elseif lowest.hp <= getValue("作茧缚命") then
                    -- Tank
                    if getOptionValue("作茧缚命 目标") == 4 then
                        if (lowest.role) == "TANK" then
                            SpellStopCasting()
                            if cast.lifeCocoon(lowest.unit) then return true end
                        end

                        -- Healer
                    elseif getOptionValue("作茧缚命 目标") == 5 then
                        if (lowest.role) == "HEALER" then
                            SpellStopCasting()
                            if cast.lifeCocoon(lowest.unit) then return true end
                        end
                        -- Healer/Tank
                    elseif getOptionValue("作茧缚命 目标") == 6 then
                        if (lowest.role) == "HEALER" or (lowest.role) == "TANK" then
                            SpellStopCasting()
                            if cast.lifeCocoon(lowest.unit) then return true end
                        end
                        -- Any
                    elseif  getOptionValue("作茧缚命 目标") == 7 then
                        SpellStopCasting()
                        if cast.lifeCocoon(lowest.unit) then return true end
                    end
                end
            end
        end
        return false
    end--OK

    local function actionList_SingleTargetHealing()
        if isChecked("青龙雕像") and lowest.hp >= 55 and talent.summonJadeSerpentStatue then
            --player
            if getOptionValue("青龙雕像") == 1 then
                param = "player"
                --target
            elseif getOptionValue("青龙雕像") == 2 and GetObjectExists("target") then
                param = "target"
                --tank
            elseif getOptionValue("青龙雕像") == 3 and #getTanksTable() > 0 then
                local tanks = getTanksTable()
                param = tanks[1].unit
            else
                param = "player"
            end
            if tsPX == nil or tsPY == nil then
                tsPX, tsPY, tsPZ = GetObjectPosition(param)
                if cast.summonJadeSerpentStatue(param) then return true end
            elseif getDistanceToObject("player",tsPX,tsPY,tsPZ) > 40 then
                tsPX, tsPY, tsPZ = GetObjectPosition(param)
                if cast.summonJadeSerpentStatue(param) then return true end
            end
        end
        if (botSpell ~= spell.envelopingMist and currentTarget ~= UnitGUID(lowest.unit)) or not buff.envelopingMist.exists(lowest.unit) or buff.envelopingMist.remain(lowest.unit) <= 2 then
            if isChecked("神龙之赐") and GetSpellCount(spell.sheilunsGift) >= getValue("神龙之赐 Charges") then
                if lowest.hp <= getValue("神龙之赐") then
                    if cast.sheilunsGift(lowest.unit) then return true end
                end
            end
            if isChecked("禅意波") and talent.zenPulse then
                if lowest.hp <= getValue("禅意波") and getNumEnemies(lowest.unit, 8) >= getValue("禅意波 敌人") then
                    if cast.zenPulse(lowest.unit) then return true end
                end
            end
            --        if isChecked("Mistwalk") and talent.mistwalk and lowest.hp <= getValue("Mistwalk") and UnitIsPlayer(lowest.unit) and UnitGUID(lowest.unit) ~= UnitGUID("player") then
            --            if cast.mistwalk(lowest.unit) then return true end
            --        end
            if isChecked("真气波") and talent.chiWave and lowest.hp <= getValue("真气波") then
                if cast.chiWave(lowest.unit) then return true end
            end
            if isChecked("氤氲之雾") then
                if (not buff.envelopingMist.exists(lowest.unit) or buff.envelopingMist.remain(lowest.unit) <= getCastTime(spell.envelopingMist)) and lowest.hp <= getValue("Enveloping Mist")then
                    if (isChecked("氤氲之雾 - 只有坦克") and (lowest.role) == "TANK") or not isChecked("氤氲之雾 - 只有坦克") then
                        if cast.envelopingMist(lowest.unit) then return true end
                    end
                end
            end
            if isChecked("氤氲之雾+生生不息") then
                if buff.lifeCyclesEnvelopingMist.exists() and (not buff.envelopingMist.exists(lowest.unit) or buff.envelopingMist.remain(lowest.unit) <= getCastTime(spell.envelopingMist))
                        and lowest.hp <= getValue("氤氲之雾+生生不息") then
                    if (isChecked("氤氲之雾 - 只有坦克") and (lowest.role) == "TANK") or not isChecked("氤氲之雾 - 只有坦克") then
                        if cast.envelopingMist(lowest.unit) then return true end
                    end
                end
            end
            if isChecked("复苏之雾") and cd.renewingMist == 0 then
                for i = 1, #friends.yards40 do
                    local thisUnit = friends.yards40[i]
                    if thisUnit.hp <= getValue("复苏之雾") and buff.renewingMist.remain(thisUnit.unit) < gcd then
                        if cast.renewingMist(thisUnit.unit) then return true end
                    end
                end
            end
            if isChecked("真气贯通") and getValue("真气贯通 大于或等于") <= lowest.hp and getValue("真气贯通 小于或等于") >= lowest.hp then
                if botSpell == spell.effuse and currentTarget == UnitGUID(lowest.unit) then
                    return false
                end
                if cast.effuse(lowest.unit) then return true end
            end
        end

        -- Ephemeral Paradox trinket
        if hasEquiped(140805) and getBuffRemain("player", 225767) > 2 then
            if cast.effuse(lowest.unit) then return true end
        end
        return false
    end--OK

    local function actionList_AOEHealing()
        if isChecked("真气爆裂") and talent.chiBurst then
            if getUnitsInRect(7,47,isChecked("显示线"),getValue("真气爆裂")) >= getValue("真气爆裂 目标") then
                if cast.chiBurst("player") then return true end
            end
        end
        if (botSpell ~= spell.envelopingMist and currentTarget ~= UnitGUID(lowest.unit)) or not buff.envelopingMist.exists(lowest.unit) or buff.envelopingMist.remain(lowest.unit) <= 2 then
            if isChecked("Vivify with Lifecycles + Uplift") and buff.upliftTrance.exists() and buff.lifeCyclesVivify.exists() then
                if getLowAlliesInTable(getValue("Vivify with Lifecycles + Uplift"), friends.yards40) >= getValue("Min Vivify with Lifecycles + Uplift Targets") then
                    if cast.vivify(lowest.unit) then return true end
                end
            end
            if isChecked("Vivify with Uplift") and buff.upliftTrance.exists() then
                if getLowAlliesInTable(getValue("Vivify with Uplift"), friends.yards40) >= getValue("Min Vivify with Uplift Targets") then
                    if cast.vivify(lowest.unit) then return true end
                end
            end
            if isChecked("活血术+生生不息") and buff.lifeCyclesVivify.exists() then
                if getLowAlliesInTable(getValue("活血术+生生不息"), friends.yards40) >= getValue("活血术+生生不息 目标") then
                    if cast.vivify(lowest.unit) then return true end
                end
            end
            if isChecked("活血术")  then
                if getLowAlliesInTable(getValue("活血术"), friends.yards40) >= getValue("活血术 目标") then
                    if cast.vivify(lowest.unit) then return true end
                end
            end
        end

        if isChecked("碧玉疾风") and talent.refreshingJadeWind and getLowAlliesInTable(getValue("碧玉疾风"), friends.yards8) >= getValue("碧玉疾风 目标")  then
            if cast.refreshingJadeWind() then return true end
        end
        if isChecked("精华之泉") and getLowAlliesInTable(getValue("精华之泉"), friends.yards25) >= getValue("精华之泉 目标")  then
            if cast.essenceFont() then return true end
        end
        return false
    end--OK

    local function actionList_DPS()
        if useDPS then
            if lowest.hp >= getValue("DPS") then
                if talent.risingThunder then
                    if cast.risingSunKick() then return true end
                end
                if #enemies.yards8 >= 3 and not isCastingSpell(spell.spinningCraneKick) then
                    if cast.spinningCraneKick() then return true end
                elseif #enemies.yards5 >= 1 then
                    if cd.risingSunKick == 0 then
                        if cast.risingSunKick(enemies.yards5[1].unit) then return true end
                    end
                    if buff.teachingsOfTheMonastery.stack() == 3 then
                        if cast.blackoutKick(enemies.yards5[1].unit) then return true end
                    end
                    if cast.tigerPalm(enemies.yards5[1].unit) then return true end
                elseif #enemies.yards40 > 0 and not isCastingSpell(spell.cracklingJadeLighting) and isChecked("碎玉闪电") then
                    if cast.cracklingJadeLighting(enemies.yards40[1].unit) then return true end
                end
            end
        end
        return false
    end

    local function actionList_ThunderFocus()
        if isChecked("雷光聚神茶+活血术") and lowest.hp <= getValue("雷光聚神茶+活血术") and mana <= getValue("雷光聚神茶+活血术 法力") then
            if cd.thunderFocusTea == 0 then
                if cast.thunderFocusTea() then
                    TFV = true
                    return true
                end
            end
        end
        if isChecked("雷光聚神茶+氤氲之雾") and lowest.hp <= getValue("雷光聚神茶+氤氲之雾") then
            if cd.thunderFocusTea == 0 then
                if cast.thunderFocusTea() then
                    TFEM = true
                    return true
                end
            end
        end
        if isChecked("雷光聚神茶+复苏之雾") and cd.renewingMist == 0 and lowest.hp <= getValue("雷光聚神茶+复苏之雾") then
            if cd.thunderFocusTea == 0 then
                if cast.thunderFocusTea() then
                    TFRM = true
                    return true
                end
            end
        end
        if isChecked("雷光聚神茶+活血术") and lowest.hp <= getValue("雷光聚神茶+活血术") and TFV and mana <= getValue("雷光聚神茶+活血术 法力") then
            if cast.vivify(lowest.unit) then
                TFV = false
                return true
            end
        end
        if isChecked("雷光聚神茶+氤氲之雾") and lowest.hp <= getValue("雷光聚神茶+氤氲之雾") and TFEM then
            if cast.envelopingMist(lowest.unit) then
                TFEM = false
                return true
            end
        end
        if isChecked("雷光聚神茶+复苏之雾") and cd.renewingMist == 0 and lowest.hp <= getValue("雷光聚神茶+复苏之雾") and TFRM then
            for i = 1, #friends.yards40 do
                local thisUnit = friends.yards40[i]
                if thisUnit.hp <= getValue("雷光聚神茶+复苏之雾") and buff.renewingMist.remain(thisUnit.unit) < gcd then
                    if cast.renewingMist(thisUnit.unit) then
                        TFRM = false
                        return true
                    end
                end
            end
        end
        return false
    end--OK

    function profile()
        -----------------
        --- Rotations ---
        -----------------
        -- Pause
        if pause(true) or isCastingSpell(spell.essenceFont) then return true end
        if actionList_ThunderFocus() then return true end
        if not IsMounted() and getBuffRemain("player", 192002 ) < 10 then
            if actionList_Extra() then return true end
        end
        if inCombat and not IsMounted() and getBuffRemain("player", 192002 ) < 10 then
            if actionList_Defensive() then return true end
            if actionList_Cooldown() then return true end
            if actionList_AOEHealing() then return true end
            if actionList_Detox() then return true end
            if actionList_SingleTargetHealing() then return true end
            if actionList_Interrupt() then return true end
            if actionList_DPS() then return true end
        end
        -----------
        --- END ---
        -----------
    end
--    if not executando and getSpellCD(spell.effuse) == 0 then
--    if botSpell == spell.envelopingMist or botSpell == spell.effuse or botSpell == spell.sheilunsGift or botSpell == spell.vivify or botSpell == spell.lifeCoccon or
    if br.timer:useTimer("debugMistweaver", 0.45)  then
--        executando = true
        profile()
--        executando = false
    end
    return true
end

local id = 270

if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})
