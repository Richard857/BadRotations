local rotationName = "Bizkut"

--------------
--- COLORS ---
--------------
local colorGreen    = "|cff00FF00"
local colorRed      = "|cffFF0000"
local colorWhite    = "|cffFFFFFF"

---------------
--- Toggles ---
---------------
local function createToggles()
    -- Healer Button
    HealerModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Auto Rotation", tip = "HPS and DPS rotation used.", highlight = 1, icon = br.player.spell.plea},
        [2] = { mode = "ATO", value = 2 , overlay = "Atonement Rotation", tip = "Atonement will keep applied within limit regardless of HP threshold.", highlight = 0, icon = br.player.spell.shiningForce},
        [3] = { mode = "DPS", value = 3 , overlay = "DPS Rotation", tip = "DPS only rotation used.", highlight = 0, icon = br.player.spell.penance},
        [4] = { mode = "Off", value = 4 , overlay = "Atonement Disabled", tip = "Disable Atonement", highlight = 0, icon = br.player.spell.penance}
    };
    CreateButton("Healer",1,0)
    -- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "自动使用大技能 - 只在BOSS.", highlight = 1, icon = br.player.spell.powerInfusion },
        [2] = { mode = "On", value = 2 , overlay = "Cooldowns Enabled", tip = "不管任何目标都使用大技能.", highlight = 0, icon = br.player.spell.powerInfusion },
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "不使用大技能.", highlight = 0, icon = br.player.spell.powerInfusion }
    };
    CreateButton("Cooldown",2,0)
    -- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "使用保命技能.", highlight = 1, icon = br.player.spell.powerWordBarrier},
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "不使用保命技能.", highlight = 0, icon = br.player.spell.powerWordBarrier}
    };
    CreateButton("Defensive",3,0)
    HaloModes = {
        [1] = { mode = "On", value = 1 , overlay = "Halo Enabled", tip = "启用光晕.", highlight = 1, icon = br.player.spell.halo},
        [2] = { mode = "Off", value = 2 , overlay = "Halo Disabled", tip = "禁用光晕.", highlight = 0, icon = br.player.spell.halo}
    };
    CreateButton("Halo",4,0)
    BurstModes = {
        [1] = { mode = "On", value = 1 , overlay = "Burst Enabled", tip = "Burst Atonement enabled when getting Innervate/Symbol of Hope.", highlight = 1, icon = br.player.spell.powerWordRadiance},
        [2] = { mode = "Off", value = 2 , overlay = "Burst Disabled", tip = "Burst Atonement disabled when getting Innervate/Symbol of Hope.", highlight = 0, icon = br.player.spell.powerWordRadiance}
    };
    CreateButton("Burst",5,0)
    -- Decurse Button
    DecurseModes = {
        [1] = { mode = "On", value = 1 , overlay = "Decurse Enabled", tip = "Decurse Enabled", highlight = 1, icon = br.player.spell.purify },
        [2] = { mode = "Off", value = 2 , overlay = "Decurse Disabled", tip = "Decurse Disabled", highlight = 0, icon = br.player.spell.purify }
    };
    CreateButton("Decurse",6,0)
    -- Interrupt Button
    InterruptModes = {
        [1] = { mode = "On", value = 1 , overlay = "Interrupts Enabled", tip = "使用打断.", highlight = 1, icon = br.player.spell.psychicScream },
        [2] = { mode = "Off", value = 2 , overlay = "Interrupts Disabled", tip = "不使用打断.", highlight = 0, icon = br.player.spell.psychicScream }
    };
    CreateButton("Interrupt",7,0)
end

---------------
--- OPTIONS ---
---------------
local function createOptions()
    local optionTable

    local function rotationOptions()
        -------------------------
        -------- ARTIFACT -------
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, "神器技能")
            --Light's Wrath
            br.ui:createSpinner(section, "圣光之怒",  80,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用. 默认: 80") 
            br.ui:createSpinnerWithout(section, "圣光之怒 目标",  3,  0,  40,  1,  "|cffFFFFFFMinimum Light's Wrath Targets. 默认: 3")
            --Save Overloaded with Light for CD
            br.ui:createCheckbox(section, "Save Overloaded with Light for CD")
            --Only use on Boss with Overloaded with Light
            br.ui:createCheckbox(section, "Only use on Boss with Overloaded with Light")
            --Always use on Boss
            br.ui:createCheckbox(section, "Always use on Boss")
        br.ui:checkSectionState(section)
        -------------------------
        -------- UTILITY --------
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, "Utility")
            -- OOC Healing
            br.ui:createCheckbox(section,"持续治疗","|cff15FF00Enables|cffFFFFFF/|cffD60000Disables |cffFFFFFFout of combat healing|cffFFBB00.",1)
            -- Dispel Magic
            br.ui:createCheckbox(section,"驱散魔法","|cff15FF00Enables|cffFFFFFF/|cffD60000Disables |cffFFFFFFDispel Magic usage|cffFFBB00.")
            -- Mass Dispel
            br.ui:createDropdown(section, "群体驱散", br.dropOptions.Toggle, 1, colorGreen.."Enables"..colorWhite.."/"..colorRed.."Disables "..colorWhite.." Mass Dispel usage.")
            --Body and Soul
            br.ui:createCheckbox(section, "身心合一")
            --Angelic Feather
            br.ui:createCheckbox(section, "天堂之羽","|cffFFFFFFThis is weird")
            --Fade
            br.ui:createSpinner(section, "渐隐术",  99,  0,  100,  1,  "|cffFFFFFF多少血量百分比使用. 默认: 99")
            --Shining Force
            br.ui:createSpinner(section, "闪光力场",  50,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用. 默认: 50")
            --Psychic Scream
            br.ui:createSpinner(section, "心灵尖啸",  40,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用. 默认: 40")
            --Leap Of Faith
            br.ui:createSpinner(section, "信仰飞跃",  20,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用. Will never use on tank. 默认: 20")
            --Dominant Mind
            br.ui:createSpinner(section, "支配心智",  5,  0,  10,  1,  "|cffFFFFFFMinimum Dominant Mind Targets. 默认: 5")
            --Resurrection
            br.ui:createCheckbox(section, "复活术")
            br.ui:createDropdownWithout(section, "复活术 - 目标", {"|cff00FF00Target","|cffFF0000Mouseover","|cffFFBB00Auto"}, 1, "|cffFFFFFFTarget to cast on")
        br.ui:checkSectionState(section)
        -------------------------
        ---- SINGLE TARGET ------
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, "单目标治疗")
            --Atonement
            br.ui:createSpinnerWithout(section, "救赎 HP",  95,  0,  100,  1,  "|cffFFFFFFApply Atonement using Power Word: Shield, Plea and Power Word: Radiance. 多少血量百分比使用. 默认: 95")
            --Max Atonement when Rapture/PWS
            br.ui:createSpinnerWithout(section, "Max Atonement when Rapture/PWS",  20,  0,  40,  1,  "|cffFFFFFFMaximum Atonement to burst when Rapture/PWS. 默认: 15")
            --Max Atonement
            br.ui:createSpinnerWithout(section, "Max Atonement",  15,  0,  40,  1,  "|cffFFFFFFMaximum Atonement to keep at a time. 默认: 5")
            --Max Plea
            br.ui:createSpinnerWithout(section, "Max Plea",  4,  0,  40,  1,  "|cffFFFFFFMaximum Atonement before we avoid using Plea as it becomes too expensive. 默认: 5")
            --Power Word: Shield
            br.ui:createSpinner(section, "真言术：盾",  99,  0,  100,  1,  "|cffFFFFFF多少血量百分比使用. 默认: 99")
            --Debuff Shadow Mend/Penance Heal
            br.ui:createSpinner(section, "Debuff 暗影愈合/苦修 治疗",  70,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用. 默认: 70")
            --Penance Heal
            br.ui:createSpinner(section, "苦修 治疗",  60,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用. 默认: 60")
            --Shadow Mend
            br.ui:createSpinner(section, "暗影愈合",  65,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用. Only cast to players without Atonement buff. 默认: 65")
            --Shadow Mend Emergency
            br.ui:createSpinner(section, "暗影愈合紧急情况",  35,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用. Will be casted to any members. 默认: 35")
            --Shadow Mend Emergency Self
            br.ui:createSpinner(section, "暗影愈合紧急情况 自己",  50,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用. Will be casted to self only. 默认: 50")
            --Clarity of Will
            br.ui:createSpinner(section, "意志洞悉",  75,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用. 默认: 75")
            --Pain Suppression Tank
            br.ui:createSpinner(section, "痛苦压制 坦克",  30,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用. 默认: 30")
            --Pain Suppression
            br.ui:createSpinner(section, "痛苦压制",  15,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用. 默认: 15")
        br.ui:checkSectionState(section)
        -------------------------
        ------ AOE HEALING ------
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, "多目标治疗")
            --Power Infusion
            br.ui:createSpinner(section, "能量灌注",  50,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用. 默认: 50")
            br.ui:createSpinnerWithout(section, "能量灌注 目标",  3,  0,  40,  1,  "|cffFFFFFFMinimum Power Infusion Targets. 默认: 3")
            --Rapture
            br.ui:createSpinner(section, "全神贯注",  60,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用. 默认: 60")
            br.ui:createSpinnerWithout(section, "全神贯注 目标",  3,  0,  40,  1,  "|cffFFFFFFMinimum Rapture Targets. 默认: 3")
            --Power Word: Radiance
            br.ui:createSpinner(section, "真言术：耀",  70,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用. 默认: 70")
            br.ui:createSpinnerWithout(section, "真言术：耀 目标",  3,  0,  40,  1,  "|cffFFFFFFMinimum PWR Targets. 默认: 3")
            --Power Word: Barrier
            br.ui:createSpinner(section, "真言术：障",  50,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用. 默认: 50")
            br.ui:createSpinnerWithout(section, "真言术：障 目标",  3,  0,  40,  1,  "|cffFFFFFFMinimum PWB Targets. 默认: 3")
            --Shadow Covenant
            br.ui:createSpinner(section, "暗影盟约",  85,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用. 默认: 85")
            br.ui:createSpinnerWithout(section, "暗影盟约 目标",  4,  0,  40,  1,  "|cffFFFFFFMinimum Shadow Covenant Targets. 默认: 4")
            --Halo
            br.ui:createSpinner(section, "光晕",  90,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用. 默认: 90")
            br.ui:createSpinnerWithout(section, "光晕 目标",  5,  0,  40,  1,  "|cffFFFFFFMinimum Halo Targets. 默认: 5")
        br.ui:checkSectionState(section)
        -------------------------
        ----- DAMAGE OPTIONS ----
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, "输出")
            --Shadow Word: Pain/Purge The Wicked
            br.ui:createSpinner(section, "暗言术：痛/净化邪恶",  3,  1,  10,  1,  "|cffFFFFFFMaximum Shadow Word: Pain/Purge The Wicked buff to keep at a time. 默认: 3")
            --Schism
            br.ui:createSpinner(section, "教派分歧",  1,  0,  40,  1,  "|cffFFFFFFMinimum Atonement for casting Schism. 默认: 1")
            --Penance
            br.ui:createSpinner(section, "苦修",  1,  0,  40,  1,  "|cffFFFFFFMinimum Atonement for casting Penance. 默认: 1")
            --Power Word: Solace
            br.ui:createCheckbox(section, "真言术：慰")
            --Smite
            br.ui:createSpinner(section, "惩击",  5,  0,  40,  1,  "|cffFFFFFFMinimum Atonement for casting Smite. 默认: 5")
            --Divine Star
            br.ui:createSpinner(section, "神圣之星",  3,  0,  10,  1,  "|cffFFFFFFMinimum Divine Star Targets. 默认: 3")
            --Halo Damage
            br.ui:createSpinner(section, "光晕 输出",  3,  0,  10,  1,  "|cffFFFFFFMinimum Halo Damage Targets. 默认: 3")
            --Mindbender
            br.ui:createSpinner(section, "摧心魔",  80,  0,  100,  5,  "|cffFFFFFFMana Percent to Cast At. 默认: 80")
            --Shadowfiend
            br.ui:createSpinner(section, "暗影魔",  80,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用. 默认: 80")
            br.ui:createSpinnerWithout(section, "暗影魔 目标",  3,  0,  40,  1,  "|cffFFFFFFMinimum Shadowfiend Targets. 默认: 3")  
        br.ui:checkSectionState(section)
        -------------------------
        ------- COOLDOWNS -------
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, "冷却技能")
            --Disable CD during Speed: Slow on Chromatic Anomaly
            br.ui:createCheckbox(section, "Disable CD during Speed: Slow","|cffFFFFFFDisable CD during Speed: Slow debuff on Chromatic Anomaly")
            --High Botanist Tel'arn Parasitic Fetter dispel helper. Dispel 8 yards from allies
            br.ui:createCheckbox(section, "Parasitic Fetter Dispel Helper","|cffFFFFFFHigh Botanist Tel'arn Parasitic Fetter dispel helper")
            --Drink
            br.ui:createSpinner(section, "Drink",   50,  0,  100,  5,   "|cffFFFFFFMinimum mana to drink Ley-Enriched Water. 默认: 50")
            --Pre Pot
            br.ui:createSpinner(section, "Pre-Pot Timer",  3,  1,  10,  1,  "|cffFFFFFFSet to desired time for Pre-Pot using Potion of Prolonged Power (DBM Required). Second: Min: 1 / Max: 10 / Interval: 1. 默认: 3")
            --Pre-pull Opener
            br.ui:createSpinner(section, "Pre-pull Opener",  12,  10,  15,  1,  "|cffFFFFFFSet to desired time for Pre-pull Atonement blanket (DBM Required). Second: Min: 10 / Max: 15 / Interval: 1. 默认: 12")
            --Int Pot
            br.ui:createCheckbox(section,"Prolonged Pot","|cffFFFFFFUse Potion of Prolonged Power")
            --Trinkets
            br.ui:createCheckbox(section,"饰品")
            --Touch of the Void
            if hasEquiped(128318) then
                br.ui:createCheckbox(section,"虚空之触")
            end
            --Mindbender/Shadowfiend
            br.ui:createCheckbox(section, "摧心魔/暗影魔","|cffFFFFFFAlways cast Mindbender or Shadowfiend on CD")
            --Power Infusion CD
            br.ui:createCheckbox(section, "能量灌注 CD","|cffFFFFFFAlways use Power Infusion on CD")
            --Rapture and PW:S
            br.ui:createCheckbox(section, "Rapture and PW:S","|cffFFFFFFAlways cast Rapture and apply Power Word: Shield to all players on CD")
            --Power Word: Barrier CD
            br.ui:createCheckbox(section, "真言术：障 CD", "|cffFFFFFFAlways cast Power Word: Barrier on CD")
            --Divine Star CD
            br.ui:createCheckbox(section, "神圣之星 CD","|cffFFFFFFAlways use Divine Star on CD")
            --Halo CD
            br.ui:createCheckbox(section, "光晕 CD","|cffFFFFFFAlways use Halo on CD")
        br.ui:checkSectionState(section)
        -------------------------
        ------- DEFENSIVE -------
        -------------------------
        section = br.ui:createSection(br.ui.window.profile, "保命")
        -- Healthstone
            br.ui:createSpinner(section, "药水/治疗石",  35,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用. 默认: 35")
        -- Heirloom Neck
            br.ui:createSpinner(section, "传家宝项链",  60,  0,  100,  5,  "|cffFFBB00多少血量百分比使用.. 默认: 60");
        -- Gift of The Naaru
            if br.player.race == "Draenei" then
                br.ui:createSpinner(section, "纳鲁的赐福",  50,  0,  100,  5,  "|cffFFFFFF多少血量百分比使用. 默认: 50")
            end
        br.ui:checkSectionState(section)
        -- Interrupt Options
        section = br.ui:createSection(br.ui.window.profile, "打断")
        -- Shining Force - Int
            br.ui:createCheckbox(section,"闪光力场")
        -- Psychic Scream - Int
            br.ui:createCheckbox(section,"心灵尖啸")
        -- Quaking Palm - Int
            br.ui:createCheckbox(section,"Quaking Palm - Int")
        -- Interrupt Percentage
            br.ui:createSpinner(section, "打断",  30,  0,  95,  5,  "|cffFFFFFF读条百分几打断. 默认: 30")
        br.ui:checkSectionState(section)
        -- Toggle Key Options
        section = br.ui:createSection(br.ui.window.profile, "切换快捷键")
        -- Single/Multi Toggle
            br.ui:createDropdown(section, "Healer Mode", br.dropOptions.Toggle,  4)
        -- Cooldown Key Toggle
            br.ui:createDropdown(section, "Cooldown Mode", br.dropOptions.Toggle,  3)
        -- Defensive Key Toggle
            br.ui:createDropdown(section, "Defensive Mode", br.dropOptions.Toggle,  6)
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
    if br.timer:useTimer("debugDiscipline", 0.1) then
        --Print("Running: "..rotationName)

---------------
--- Toggles --- -- List toggles here in order to update when pressed
---------------
        UpdateToggle("Healer",0.25)
        UpdateToggle("Cooldown",0.25)
        UpdateToggle("Defensive",0.25)
        UpdateToggle("Halo",0.25)
        UpdateToggle("Burst",0.25)
        UpdateToggle("Decurse",0.25)
        UpdateToggle("Interrupt",0.25)
        br.player.mode.healer = br.data.settings[br.selectedSpec].toggles["Healer"]
        br.player.mode.halo = br.data.settings[br.selectedSpec].toggles["Halo"]
        br.player.mode.burst = br.data.settings[br.selectedSpec].toggles["Burst"]
        br.player.mode.decurse = br.data.settings[br.selectedSpec].toggles["Decurse"]

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
        local friends                                       = friends or {}
        local gcd                                           = br.player.gcd
        local healPot                                       = getHealthPot()
        local inCombat                                      = br.player.inCombat
        local inInstance                                    = br.player.instance=="party"
        local inRaid                                        = br.player.instance=="raid"
        local lastSpell                                     = lastSpellCast
        local level                                         = br.player.level
        local lootDelay                                     = getOptionValue("LootDelay")
        local lowestHP                                      = br.friend[1].unit
        local mode                                          = br.player.mode
        local perk                                          = br.player.perk        
        local php                                           = br.player.health
        local power, powmax, powgen                         = br.player.power.amount.mana, br.player.power.mana.max, br.player.power.regen
        local pullTimer                                     = br.DBM:getPulltimer()
        local race                                          = br.player.race
        local racial                                        = br.player.getRacial()
        local recharge                                      = br.player.recharge
        local solo                                          = br.player.instance=="none"
        local spell                                         = br.player.spell
        local talent                                        = br.player.talent
        local ttd                                           = getTTD
        local ttm                                           = br.player.power.ttm
        local units                                         = units or {}
        local lowest                                        = {}    --Lowest Unit
        lowest.hp                                           = br.friend[1].hp
        lowest.role                                         = br.friend[1].role
        lowest.unit                                         = br.friend[1].unit
        lowest.range                                        = br.friend[1].range
        lowest.guid                                         = br.friend[1].guid                      
        local tank                                          = {}    --Tank

        units.dyn30 = br.player.units(30)
        units.dyn40 = br.player.units(40)
        enemies.dyn24 = br.player.enemies(24)
        enemies.dyn30 = br.player.enemies(30)
        enemies.dyn40 = br.player.enemies(40)
        friends.yards40 = getAllies("player",40)

        atonementCount = 0
        for i=1, #br.friend do
            local atonementRemain = getBuffRemain(br.friend[i].unit,spell.buffs.atonement,"player") or 0 -- 194384
            if atonementRemain > 0 then
                atonementCount = atonementCount + 1
            end
        end

        local freeMana                                      = mode.burst == 1 and (buff.innervate.exists() or buff.symbolOfHope.exists())
        local freeCast                                      = freeMana or mode.healer == 3 or getMana("player") > 90
        local epTrinket                                     = hasEquiped(140805) and getBuffRemain("player", 225766) > 2
        local buffDarkside                                  = UnitBuffID("player", 198069)


        if leftCombat == nil then leftCombat = GetTime() end
        if profileStop == nil then profileStop = false end

--------------------
--- Action Lists ---
--------------------
        -- Mitigate heavy damage
        function actionList_MitigateDamage(u,n)
            if cast.powerWordShield(br.friend[u].unit) then
                if cast.penance() then return end
            elseif getSpellCD(spell.penance) <= 0 and atonementCount <= 6 and getBuffRemain(br.friend[u].unit, spell.buffs.atonement, "player") < 1 then
                if cast.plea(br.friend[u].unit) then
                    if cast.penance() then return end
                end
            elseif getSpellCD(spell.penance) <= 0 and getBuffRemain(br.friend[u].unit, spell.buffs.atonement, "player") > 1 then
                if cast.penance() then return end
            end
            if not isMoving("player") and br.friend[u].hp <= n then
                if talent.grace and atonementCount <= 6 and getBuffRemain(br.friend[u].unit, spell.buffs.atonement, "player") < 1 then
                    if cast.plea(br.friend[u].unit) then
                        if cast.shadowMend(br.friend[u].unit) then return end
                    end
                elseif cast.shadowMend(br.friend[u].unit) then return end
            elseif atonementCount <= 6 and br.friend[u].hp <= n then
                if cast.plea(br.friend[u].unit) then return end
            end
        end
        -- Action List - Interrupts
        function actionList_Interrupts()
            if useInterrupts() then
                for i=1, #enemies.dyn40 do
                    thisUnit = enemies.dyn40[i]
                    if canInterrupt(thisUnit,getOptionValue("打断")) then
                -- Shining Force - Int
                        if isChecked("闪光力场") and getDistance(thisUnit) < 40 then
                            if cast.shiningForce() then return end
                        end
                -- Psychic Scream - Int
                        if isChecked("心灵尖啸") and getDistance(thisUnit) < 8 then
                            if cast.psychicScream() then return end
                        end
                -- Quaking Palm
                        if isChecked("Quaking Palm - Int") and getDistance(thisUnit) < 5 then
                            if cast.quakingPalm(thisUnit) then return end
                        end
                    end
                end
            end -- End useInterrupts check
        end -- End Action List - Interrupts
        --Check Atonement
        function actionList_CheckAtonement()
            if buff.rapture.exists("player") then
                for i = 1, #br.friend do
                    if mode.healer == 1 or mode.healer == 2 then
                        actionList_SpreadAtonement(i)
                    end
                    if mode.healer == 3 and UnitIsUnit(br.friend[i].unit,"player") then
                        actionList_SpreadAtonement(i)
                    end
                end
            end
            for i = 1, #br.friend do
                -- Got Innervate/Symbol of Hope
                if mode.healer == 2 or freeMana or epTrinket then
                    actionList_SpreadAtonement(i)
                elseif br.friend[i].hp <= getValue("救赎 HP") then
                    if mode.healer == 1 then
                        actionList_SpreadAtonement(i)
                    end
                    if mode.healer == 3 and UnitIsUnit(br.friend[i].unit,"player") then
                        actionList_SpreadAtonement(i)
                    end
                end
            end
            --Shadow Mend Emergency
            if isChecked("暗影愈合紧急情况") then
                for i = 1, #br.friend do
                    if br.friend[i].hp <= getValue("暗影愈合紧急情况") then
                        if mode.healer == 1 or mode.healer == 2 or (mode.healer == 3 and UnitIsUnit(br.friend[i].unit,"player")) then
                            actionList_MitigateDamage(i,getValue("暗影愈合紧急情况"))
                        end
                    end
                end
            end
            --Shadow Mend Emergency Self
            if isChecked("暗影愈合紧急情况 自己") then
                if php <= getValue("暗影愈合紧急情况 自己") then
                    actionList_MitigateDamage(i,getValue("暗影愈合紧急情况 自己"))
                end
            end
        end
        --Spread Atonement
        function actionList_SpreadAtonement(u)
            if getLineOfSight("player",br.friend[u].unit) and (inRaid or inInstance or (solo and inCombat)) and mode.healer ~= 4 and (not buff.powerWordShield.exists(br.friend[u].unit) or getBuffRemain(br.friend[u].unit, spell.buffs.atonement, "player") < 1) then
                -- Ephemeral Paradox trinket with Temporal Shift buff
                if epTrinket and not buff.rapture.exists("player") and not freeMana and not isMoving("player") then
                    if cast.shadowMend(br.friend[u].unit) then return end
                elseif getSpellCD(spell.powerWordShield) <= 0 and buff.rapture.exists("player") then
                    if atonementCount <= getValue("Max Atonement when Rapture/PWS") then
                        if atonementCount >= #friends.yards40 or (atonementCount < #friends.yards40 and getBuffRemain(br.friend[u].unit, spell.buffs.atonement, "player") < 1) then
                            if cast.powerWordShield(br.friend[u].unit) then return end
                        end
                    end
                elseif not buff.rapture.exists("player") and not buff.powerWordShield.exists(br.friend[u].unit) and getBuffRemain(br.friend[u].unit, spell.buffs.atonement, "player") < 1 then
                    -- Getting Innervate/Symbol of Hope
                    if freeMana and atonementCount < getValue("Max Atonement when Rapture/PWS") then
                        -- Legendary Chest, Estel 2% Haste per Atonement
                        if (hasEquiped(132861) and ((lastSpell == spell.powerWordRadiance and atonementCount <= getOptionValue("Max Plea") + 3) or buff.innervate.remain() < 2 or buff.symbolOfHope.remain() < 2)) or isMoving("player") then 
                            if cast.plea(br.friend[u].unit) then return end
                        elseif not isMoving("player") then
                            if cast.powerWordRadiance(br.friend[u].unit) then return end
                        end
                    end
                    if atonementCount < getOptionValue("Max Plea") and atonementCount < getOptionValue("Max Atonement") and ((atonementCount >= getValue("苦修") and inCombat and lastSpell ~= spell.plea) or atonementCount < getValue("苦修") or buffDarkside or not inCombat) and ((not inCombat and buffDarkside) or getSpellCD(spell.penance) > 1 or (inCombat and atonementCount < getValue("苦修")) or (mode.healer == 2 and not inCombat and not isMoving("player"))) then
                        if cast.plea(br.friend[u].unit) then return end
                    end
                    if getMana("player") > 10 and (getSpellCD(spell.penance) > 3 or atonementCount < getValue("苦修") or mode.healer == 2) and ((not inRaid and atonementCount < 5) or inRaid) and atonementCount >= getOptionValue("Max Plea") and atonementCount < getOptionValue("Max Atonement") and not isMoving("player") then
                        if cast.powerWordRadiance(br.friend[u].unit) then return end
                    end
                end
            end
        end
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
                    if cast.giftOfTheNaaru() then return end
                end
            end -- End Defensive Toggle
        end -- End Action List - Defensive
        -----------------
        --- COOLDOWNS ---
        -----------------
        function actionList_Cooldowns()
            if useCDs() then
                if isChecked("Disable CD during Speed: Slow") and UnitDebuffID("player",207011) then
                    return --Speed: Slow debuff during the Chromatic Anomaly encounter
                else
                    --Racials
                    --blood_fury
                    --arcane_torrent
                    --berserking
                    if (br.player.race == "Orc" or br.player.race == "Troll" or br.player.race == "Blood Elf") then
                        if br.player.castRacial() then return end
                    end
                    --potion,name=prolonged_power
                    if isChecked("Prolonged Pot") and canUse(142117) and not solo then
                        useItem(142117)
                    end
                    --Power Infusion
                    if isChecked("能量灌注 CD") then
                        if cast.powerInfusion() then return end
                    end
                    --Touch of the Void
                    if isChecked("虚空之触") and getDistance(br.player.units.dyn5)<5 then
                        if hasEquiped(128318) then
                            if GetItemCooldown(128318)==0 then
                                useItem(128318)
                            end
                        end
                    end
                    --Trinkets
                    if isChecked("饰品") then
                        if canUse(13) then
                            useItem(13)
                        end
                        if canUse(14) then
                            useItem(14)
                        end
                    end
                    if isChecked("真言术：障 CD") then
                        if cast.powerWordBarrier(lowest.unit) then return end
                    end
                    --Rapture and PW:S
                    if isChecked("Rapture and PW:S") and not freeMana then
                        if cast.rapture() then return end
                    end
                    --Only use on Boss with Overloaded with Light
                    --Always use on Boss
                    if isChecked("Always use on Boss") or (isChecked("Only use on Boss with Overloaded with Light") and getBuffRemain("player",spell.buffs.overloadedWithLight) ~= 0) then
                        if getSpellCD(spell.lightsWrath) == 0 and not buff.rapture.exists("player") then
                            if mode.healer == 1 or mode.healer == 2 then
                                for i = 1, #br.friend do
                                    actionList_SpreadAtonement(i)
                                end
                            end
                            targetBoss = units.dyn40
                            if not isMoving("player") and isBoss(targetBoss) and getDistance("player",targetBoss) < 40 and ((inRaid and atonementCount >= getOptionValue("Max Atonement")) or (inInstance and atonementCount >= #br.friend)) or (not inInstance and not inRaid) then
                                if (talent.schism and isChecked("教派分歧") and schismBuff and isValidUnit(schismBuff)) or not talent.schism or not isChecked("教派分歧") then
                                    if cast.lightsWrath(targetBoss) then return end
                                end
                            end
                        end
                    end
                    --Mindbender/Shadowfiend
                    if isChecked("摧心魔/暗影魔") then
                        if cast.mindbender() then return end
                        if cast.shadowfiend() then return end
                    end
                    --Divine Star CD
                    if isChecked("神圣之星 CD") and isBoss("target") and getDistance("player","target") < 24 and getFacing("player","target",10) and not buff.rapture.exists("player") then
                        if cast.divineStar() then return end
                    end
                    --Halo CD
                    if not isMoving("player") and isChecked("光晕 CD") and isBoss("target") and getDistance("player","target") < 30 and mode.halo == 1 and atonementCount > 2 and not buff.rapture.exists("player") then
                        if cast.halo() then return end
                    end
                end
            end
        end -- End Action List - Cooldowns
        -- Action List - Pre-Combat
        function actionList_PreCombat()
            prepullOpener = inRaid and isChecked("Pre-pull Opener") and pullTimer <= getOptionValue("Pre-pull Opener") and not buff.rapture.exists("player")
            if isChecked("Pre-Pot Timer") and (pullTimer <= getOptionValue("Pre-Pot Timer") or prepullOpener) and canUse(142117) and not solo then
                useItem(142117)
            end
             -- Pre-pull Opener
            if prepullOpener then
                if pullTimer > 5 then
                    for i = 1, #br.friend do
                        actionList_SpreadAtonement(i)
                    end
                elseif pullTimer <= 5 and getMana("player") < 95 then
                     useItem(138292)
                end
            end
            if not isMoving("player") and isChecked("Drink") and getMana("player") <= getOptionValue("Drink") and canUse(138292) and not IsResting() then
                useItem(138292)
            end
            if isChecked("持续治疗") then
                for i = 1, #br.friend do
                    if not isMoving("player") and br.friend[i].hp < 80 then
                        if talent.grace and atonementCount <= 6 and getBuffRemain(br.friend[i].unit, spell.buffs.atonement, "player") < 1 then
                            if cast.plea(br.friend[i].unit) then
                                if cast.shadowMend(br.friend[i].unit) then return end
                            end
                        elseif cast.shadowMend(br.friend[i].unit) then return end
                    elseif atonementCount <= 6 and br.friend[i].hp < 95 then
                        if cast.plea(br.friend[i].unit) then return end
                    end
                end
            end
        end  -- End Action List - Pre-Combat
        --AOE Healing
        function actionList_AOEHealing()
            --Power Word: Barrier
            if isChecked("真言术：障") and (mode.healer == 1 or mode.healer == 2) and not isMoving("player") then
                if getLowAllies(getValue("真言术：障")) >= getValue("真言术：障 目标") then
                    if cast.powerWordBarrier(lowest.unit) then return end
                end
            end
            --Shadow Covenant
            if isChecked("暗影盟约") and talent.shadowCovenant and (mode.healer == 1 or mode.healer == 2) then
                if getLowAllies(getValue("暗影盟约")) >= getValue("暗影盟约 目标") and lastSpell ~= spell.shadowCovenant then
                    if cast.shadowCovenant(lowest.unit) then return end
                end
            end
            --Power Infusion
            if isChecked("能量灌注") then
                if getLowAllies(getValue("能量灌注")) >= getValue("能量灌注 目标") then
                    if cast.powerInfusion() then return end
                end
            end
            --Rapture
            if isChecked("全神贯注") and not freeMana then
                if getLowAllies(getValue("全神贯注")) >= getValue("全神贯注 目标") then
                    if cast.rapture() then return end
                end
            end
            --Power Word: Radiance
            if isChecked("真言术：耀") and (mode.healer == 1 or mode.healer == 2) and not isMoving("player") then
                if getLowAllies(getValue("真言术：耀")) >= getValue("真言术：耀 目标") and lastSpell ~= spell.powerWordRadiance then
                    if cast.powerWordRadiance(lowest.unit) then return end
                end
            end
            --Halo
            if isChecked("光晕") and mode.halo == 1 and not isMoving("player") and not buff.rapture.exists("player") then
                if getLowAllies(getValue("光晕")) >= getValue("光晕 目标") and atonementCount >= getValue("光晕 目标") then
                    if cast.halo(lowest.unit) then return end
                end
            end
        end
        --Single Target Defence
        function actionList_SingleTargetDefence()
            --Leap Of Faith
            if isChecked("信仰飞跃") and (mode.healer == 1 or mode.healer == 2) and inCombat then
                for i = 1, #br.friend do
                    if br.friend[i].hp <= getValue("信仰飞跃") and not UnitIsUnit(br.friend[i].unit,"player") and UnitGroupRolesAssigned(br.friend[i].unit) ~= "TANK" then
                        if cast.leapOfFaith(br.friend[i].unit) then return end
                    end
                end
            end
            --Pain Suppression Tank
            if isChecked("痛苦压制 坦克") and (mode.healer == 1 or mode.healer == 2) and inCombat then
                for i = 1, #br.friend do
                    if br.friend[i].hp <= getValue("痛苦压制 坦克") and getBuffRemain(br.friend[i].unit, spell.painSuppression, "player") < 1 and UnitGroupRolesAssigned(br.friend[i].unit) == "TANK" then
                        if cast.painSuppression(br.friend[i].unit) then
                            actionList_MitigateDamage(i,getValue("痛苦压制 坦克"))
                        end
                    end
                end
            end
            --Pain Suppression
            if isChecked("痛苦压制") and inCombat then
                for i = 1, #br.friend do
                    if br.friend[i].hp <= getValue("痛苦压制") and getBuffRemain(br.friend[i].unit, spell.painSuppression, "player") < 1 then
                        if mode.healer == 1 or mode.healer == 2 or (mode.healer == 3 and UnitIsUnit(br.friend[i].unit,"player")) then
                            if cast.painSuppression(br.friend[i].unit) then
                                actionList_MitigateDamage(i,getValue("痛苦压制"))
                            end
                        end
                    end
                end
            end
            --Psychic Scream
            if isChecked("心灵尖啸") and inCombat then
                if php <= getValue("心灵尖啸") then
                    if cast.psychicScream() then return end
                end
            end
            --Shining Force
            if isChecked("闪光力场") and talent.shiningForce and inCombat then
                for i = 1, #br.friend do
                    if br.friend[i].hp <= getValue("闪光力场") then
                        if mode.healer == 1 or mode.healer == 2 then
                            if cast.shiningForce(br.friend[i].unit) then return end
                        end
                        if mode.healer == 3 and UnitIsUnit(br.friend[i].unit,"player") then
                            if cast.shiningForce("player") then return end
                        end
                    end
                end
            end
            --Clarity of Will
            if isChecked("意志洞悉") and talent.clarityOfWill and not isMoving("player") and (not inCombat or (inCombat and getSpellCD(spell.penance) > 2)) then
                for i = 1, #br.friend do
                    if br.friend[i].hp <= getValue("意志洞悉") and lastSpell ~= spell.clarityOfWill and getBuffRemain(br.friend[i].unit, spell.buffs.clarityOfWill, "player") <= 0 then
                        if mode.healer == 1 or mode.healer == 2 then
                            if cast.clarityOfWill(br.friend[i].unit) then return end
                        end
                        if mode.healer == 3 and UnitIsUnit(br.friend[i].unit,"player") then
                            if cast.clarityOfWill("player") then return end
                        end
                    end
                end
            end
            --Power Word: Shield
            if isChecked("真言术：盾") and (inCombat or (not inCombat and not isMoving("player"))) then
                for i = 1, #br.friend do
                    if (mode.healer == 1 or mode.healer == 2 or (mode.healer == 3 and UnitIsUnit(br.friend[i].unit,"player"))) and br.friend[i].hp <= getValue("真言术：盾") and not buff.powerWordShield.exists(br.friend[i].unit) and getSpellCD(spell.powerWordShield) <= 0 and not buff.rapture.exists("player") then
                        if UnitIsUnit(br.friend[i].unit,"player") or UnitGroupRolesAssigned(br.friend[i].unit) == "TANK" or isInPvP() then
                            if cast.powerWordShield(br.friend[i].unit) then return end
                        end
                    end
                end
            end
        end
        --Single Target Heal
        function actionList_SingleTargetHeal()
            if isMoving("player") then
                if isChecked("天堂之羽") and talent.angelicFeather and not buff.angelicFeather.exists("player") then
                    if cast.angelicFeather("player") then
                        RunMacroText("/stopspelltarget")
                    end
                end
                -- Power Word: Shield Body and Soul
                if isChecked("身心合一") and talent.bodyAndSoul then
                    if cast.powerWordShield("player") then return end
                end
            end
            -- Dispel Magic
            if isChecked("驱散魔法") and canDispel("target",spell.dispelMagic) and not isBoss() and GetObjectExists("target") then
                if cast.dispelMagic() then return end
            end
            -- Mass Dispel
            if not isMoving("player") and isChecked("群体驱散") and (SpecificToggle("群体驱散") and not GetCurrentKeyBoardFocus()) then
                CastSpellByName(GetSpellInfo(spell.massDispel),"cursor")
                return true
            end
            --Resurrection
            if isChecked("复活术") and not inCombat and not isMoving("player") then
                if getOptionValue("复活术 - 目标") == 1 
                    and UnitIsPlayer("target") and UnitIsDeadOrGhost("target") and UnitIsFriend("target","player")
                then
                    if cast.resurrection("target","dead") then return end
                end
                if getOptionValue("复活术 - 目标") == 2 
                    and UnitIsPlayer("mouseover") and UnitIsDeadOrGhost("mouseover") and UnitIsFriend("mouseover","player")
                then
                    if cast.resurrection("mouseover","dead") then return end
                end
                if getOptionValue("复活术 - 目标") == 3 then
                    for i =1, #br.friend do
                        if UnitIsPlayer(br.friend[i].unit) and UnitIsDeadOrGhost(br.friend[i].unit) and lastSpell ~= spell.resurrection then
                            if cast.resurrection(br.friend[i].unit) then return end
                        end
                    end
                end
            end
            --Purify
            if mode.decurse == 1 and (inCombat and getSpellCD(spell.penance) > 1 or not inCombat) then
                for i = 1, #br.friend do
                    for n = 1,40 do
                        local buff,_,_,count,bufftype,duration = UnitDebuff(br.friend[i].unit, n)
                        if buff then
                            if (bufftype == "Disease" or bufftype == "Curse" or bufftype == "Magic") then
                                --High Botanist Tel'arn Parasitic Fetter dispel helper
                                if isChecked("Parasitic Fetter Dispel Helper") and UnitDebuffID(br.friend[i].unit,218304) then
                                    if #getAllies(br.friend[i].unit,15) < 2 then
                                        if cast.purify(br.friend[i].unit) then return end
                                    end
                                elseif mode.healer == 1 or mode.healer == 2 then
                                    if cast.purify(br.friend[i].unit) then return end
                                elseif mode.healer == 3 and UnitIsUnit(br.friend[i].unit,"player") then
                                    if cast.purify("player") then return end
                                end
                            end
                        end
                    end
                end
            end
            --Debuff Shadow Mend/Penance Heal
            if isChecked("Debuff 暗影愈合/苦修 治疗") then
                for i = 1, #br.friend do
                    for n = 1,40 do
                        local buff,_,_,count,bufftype,duration = UnitDebuff(br.friend[i].unit, n)
                        if (buff and br.friend[i].hp <= getValue("Debuff 暗影愈合/苦修 治疗") and not UnitDebuffID(br.friend[i].unit,187464) and not UnitDebuffID(br.friend[i].unit,207011)) or (br.friend[i].hp <= 90 and UnitDebuffID(br.friend[i].unit,225484)) or UnitDebuffID(br.friend[i].unit,200238) then
                            if mode.healer == 1 or mode.healer == 2 or (mode.healer == 3 and UnitIsUnit(br.friend[i].unit,"player")) then
                                if cast.powerWordShield(br.friend[i].unit) then
                                    if cast.penance() then return end
                                elseif getSpellCD(spell.penance) <= 0 and atonementCount <= 6 and getBuffRemain(br.friend[i].unit, spell.buffs.atonement, "player") < 1 then
                                    if cast.plea(br.friend[i].unit) then
                                        if cast.penance() then return end
                                    end
                                elseif getSpellCD(spell.penance) <= 0 and getBuffRemain(br.friend[i].unit, spell.buffs.atonement, "player") > 1 then
                                    if cast.penance() then return end
                                elseif isMoving("player") and talent.thePenitent then
                                    if cast.penance(br.friend[i].unit) then return end
                                elseif not isMoving("player") then
                                    if talent.grace and atonementCount <= 6 and getBuffRemain(br.friend[i].unit, spell.buffs.atonement, "player") < 1 then
                                        if cast.plea(br.friend[i].unit) then
                                            if cast.shadowMend(br.friend[i].unit) then return end
                                        end
                                    elseif cast.shadowMend(br.friend[i].unit) then return end
                                elseif atonementCount <= 6 then
                                    if cast.plea(br.friend[i].unit) then return end
                                end
                            end
                        end
                    end
                end
            end
            --Penance Heal
            if isChecked("苦修 治疗") and talent.thePenitent then
                for i = 1, #br.friend do
                    if br.friend[i].hp <= getValue("苦修 治疗") then
                        if mode.healer == 1 or mode.healer == 2 then
                            if cast.penance(br.friend[i].unit) then return end
                        end
                        if mode.healer == 3 and UnitIsUnit(br.friend[i].unit,"player") then
                            if cast.penance("player") then return end
                        end
                    end
                end
            end
            --Shadow Mend
            if isChecked("暗影愈合") then
                for i = 1, #br.friend do
                    if br.friend[i].hp <= getValue("暗影愈合") and getBuffRemain(br.friend[i].unit, spell.buffs.atonement, "player") < 1 then
                        if mode.healer == 1 or mode.healer == 2 or (mode.healer == 3 and UnitIsUnit(br.friend[i].unit,"player")) then
                            actionList_MitigateDamage(i,getValue("暗影愈合"))
                        end
                    end
                end
            end
            --Fade
            if isChecked("渐隐术") then                         
                if php <= getValue("渐隐术") then
                    if cast.fade() then return end
                end
            end
        end
        ------------
        -- DAMAGE --
        ------------
        function actionList_Damage()
            --Shadow Word: Pain/Purge The Wicked
            if isChecked("暗言术：痛/净化邪恶") and not buffDarkside and (getSpellCD(spell.penance) > 1 or (getSpellCD(spell.penance) <= 0 and (debuff.purgeTheWicked.count() == 0 or debuff.shadowWordPain.count() == 0))) then
                if talent.purgeTheWicked and debuff.purgeTheWicked.count() < getValue("暗言术：痛/净化邪恶") then
                    ptwDebuffnew = units.dyn40
                    if UnitIsUnit(ptwDebuffnew,"target") or hasThreat(ptwDebuffnew) or isDummy(ptwDebuffnew) then
                        if debuff.purgeTheWicked.remain(ptwDebuffnew) < gcd and (lastSpell ~= spell.purgeTheWicked or debuff.purgeTheWicked.count() == 0) then
                            ptwDebuff = ptwDebuffnew
                            if cast.purgeTheWicked(ptwDebuff,"aoe") then return end
                        end
                    end
                end
                if not talent.purgeTheWicked and debuff.shadowWordPain.count() < getValue("暗言术：痛/净化邪恶") then
                    ptwDebuffnew = units.dyn40
                    if UnitIsUnit(ptwDebuffnew,"target") or hasThreat(ptwDebuffnew) or isDummy(ptwDebuffnew) then
                        if debuff.shadowWordPain.remain(ptwDebuffnew) < gcd and (lastSpell ~= spell.shadowWordPain or debuff.shadowWordPain.count() == 0) then
                            if cast.shadowWordPain(ptwDebuffnew,"aoe") then return end
                        end
                    end
                end
            end
            --Schism
            if talent.schism and isChecked("教派分歧") and getMana("player") > 20 and getSpellCD(spell.schism) <= 0 and (atonementCount >= getValue("教派分歧") or freeCast) and not isMoving("player") then
                if not schismBuff then
                    schismBuff = units.dyn40
                end
                if UnitIsUnit(schismBuff,"target") or hasThreat(schismBuff) or isDummy(schismBuff) then
                    if debuff.schism.remain(schismBuff) < gcd then
                        if cast.schism(schismBuff) then return end
                    end
                end
            end
            if debuff.purgeTheWicked.count() > 0 and not debuff.purgeTheWicked.exists(ptwDebuff) then
                for i = 1, #enemies.dyn40 do
                    local thisUnit = enemies.dyn40[i]
                    if debuff.purgeTheWicked.exists(thisUnit) then
                        ptwDebuff = thisUnit
                    end
                end
            end
            if buffDarkside and getSpellCD(spell.penance) > 1 then
                for i = 1, #br.friend do
                    actionList_SpreadAtonement(i)
                end
            end
            --Penance
            if isChecked("苦修") and (atonementCount >= getValue("苦修") or #friends.yards40 <= getValue("苦修")) and (debuff.schism.exists(schismBuff) or debuff.purgeTheWicked.exists(ptwDebuff) or debuff.shadowWordPain.count() > 0 or not isChecked("暗言术：痛/净化邪恶") or buffDarkside) then
                if schismBuff then
                    if cast.penance(schismBuff) then return end
                elseif debuff.purgeTheWicked.count() > 0 then
                    if cast.penance(ptwDebuff) then return end
                elseif cast.penance() then return end
            end
            --Mindbender
            if isChecked("摧心魔") and getMana("player") <= getValue("摧心魔") then
                if schismBuff then
                    if cast.mindbender(schismBuff) then return end
                end
                if cast.mindbender() then return end
            end
           --Shadowfiend
            if isChecked("暗影魔") then
                if getLowAllies(getValue("暗影魔")) >= getValue("暗影魔 目标") then
                    if schismBuff then
                        if cast.shadowfiend(schismBuff) then return end
                    end
                    if cast.shadowfiend() then return end    
                end
            end
            --PowerWordSolace
            if isChecked("真言术：慰") then
                if schismBuff then
                    if cast.powerWordSolace(schismBuff) then return end
                end
                if cast.powerWordSolace() then return end
            end
            --Light's Wrath
            if isChecked("圣光之怒") and getSpellCD(spell.lightsWrath) == 0 then
                if getLowAllies(getValue("圣光之怒")) >= getValue("圣光之怒 目标") then
                    if isChecked("Save Overloaded with Light for CD") and getBuffRemain("player",spell.buffs.overloadedWithLight) ~= 0 then
                        return false
                    end
                    for i = 1, #enemies.dyn40 do
                        local thisUnit = enemies.dyn40[i]
                        if schismBuff == thisUnit or schismBuff == nil then
                            if not inInstance and not inRaid then
                                if talent.schism then
                                    if cast.lightsWrath(thisUnit) then return end
                                end
                                if not talent.schism or not isChecked("教派分歧") then
                                    if cast.lightsWrath() then return end
                                end
                            end
                            if mode.healer == 1 or mode.healer == 2 then
                                for i = 1, #br.friend do
                                    actionList_SpreadAtonement(i)
                                end
                                if (inRaid and atonementCount >= getOptionValue("Max Atonement")) or (not inRaid and atonementCount >= 5) then
                                    if talent.schism then
                                        if cast.lightsWrath(thisUnit) then return end
                                    end
                                    if not talent.schism or not isChecked("教派分歧") then
                                        if cast.lightsWrath() then return end
                                    end
                                end
                            end
                            if mode.healer == 3 then
                                if talent.schism then
                                    if cast.lightsWrath(thisUnit) then return end
                                end
                                if not talent.schism or not isChecked("教派分歧") then
                                    if cast.lightsWrath() then return end
                                end
                            end
                        end
                    end
                end
            end
            --Divine Star
            if isChecked("神圣之星") and talent.divineStar then
                if #enemies.dyn24 >= getOptionValue("神圣之星") and getFacing("player","target",10) and not buff.rapture.exists("player") then
                    if cast.divineStar() then return end
                end
            end
            --Halo Damage
            if isChecked("光晕 输出") and talent.halo and mode.halo == 1 and not isMoving("player") and not buff.rapture.exists("player") then
                if #enemies.dyn30 >= getOptionValue("光晕 输出") then
                    if cast.halo() then return end
                end
            end
            --Smite
            if isChecked("惩击") and not isMoving("player") and getSpellCD(spell.penance) > 1 then
                if (getMana("player") > 20 and ((not inInstance and not inRaid) or atonementCount >= getValue("惩击"))) or freeCast then
                    if schismBuff then
                        if cast.smite(schismBuff) then return end
                    end
                    if cast.smite() then return end
                end
            end
            --Dominant Mind
            if isChecked("支配心智") and talent.dominantMind and not isMoving("player") then
                if #enemies.dyn30 >= getOptionValue("支配心智") then
                    if cast.mindControl() then return end
                end
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
            if not inCombat and not IsMounted() and (getBuffRemain("player", 192001) < 1 or getMana("player") == 100) and getBuffRemain("player", 192002) < 10 and getBuffRemain("player", 188023) < 1 and getBuffRemain("player", 175833) < 1 then
                actionList_PreCombat()
                actionList_CheckAtonement()
                actionList_SingleTargetHeal()
                actionList_SingleTargetDefence()
            end -- End Out of Combat Rotation
-----------------------------
--- In Combat - Rotations --- 
-----------------------------
            if inCombat and not IsMounted() then
                actionList_Interrupts()
                actionList_CheckAtonement()
                actionList_Defensive()
                actionList_Cooldowns()
                actionList_SingleTargetDefence()
                actionList_SingleTargetHeal()
                actionList_AOEHealing()
                actionList_Damage()
            end -- End In Combat Rotation
        end -- Pause
    end -- End Timer
end -- End runRotation 
local id = 256
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})