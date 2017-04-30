local rotationName = "Cpoworks" -- Change to name of profile listed in options drop down

---------------
--- Toggles ---
---------------
local function createToggles()
-- Rotation Button
    RotationModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Automatic Rotation", tip = "基于范围内的目标数,在单目标和多目标自动切换输出方式.", highlight = 1, icon = br.player.spell.mongooseBite },
        [2] = { mode = "Mult", value = 2 , overlay = "Multiple Target Rotation", tip = "使用多目标方式输出.", highlight = 0, icon = br.player.spell.carve },
        [3] = { mode = "Sing", value = 3 , overlay = "Single Target Rotation", tip = "使用单目标方式输出.", highlight = 0, icon = br.player.spell.raptorStrike },
        [4] = { mode = "Off", value = 4 , overlay = "DPS Rotation Disabled", tip = "禁用DPS输出", highlight = 0, icon = br.player.spell.exhilaration}
    };
    CreateButton("Rotation",1,0)
-- Cooldown Button
    CooldownModes = {
        [1] = { mode = "Auto", value = 1 , overlay = "Cooldowns Automated", tip = "自动使用大技能 - 只在BOSS.", highlight = 1, icon = br.player.spell.aspectOfTheEagle },
        [2] = { mode = "On", value = 1 , overlay = "Cooldowns Enabled", tip = "不管任何目标都使用大技能.", highlight = 0, icon = br.player.spell.aspectOfTheEagle },
        [3] = { mode = "Off", value = 3 , overlay = "Cooldowns Disabled", tip = "不使用大技能.", highlight = 0, icon = br.player.spell.aspectOfTheEagle }
    };
    CreateButton("Cooldown",2,0)
-- Defensive Button
    DefensiveModes = {
        [1] = { mode = "On", value = 1 , overlay = "Defensive Enabled", tip = "使用保命技能.", highlight = 1, icon = br.player.spell.aspectOfTheTurtle },
        [2] = { mode = "Off", value = 2 , overlay = "Defensive Disabled", tip = "不使用保命技能.", highlight = 0, icon = br.player.spell.aspectOfTheTurtle }
    };
    CreateButton("Defensive",3,0)
-- Interrupt Button
    InterruptModes = {
        [1] = { mode = "On", value = 1 , overlay = "Interrupts Enabled", tip = "使用打断.", highlight = 1, icon = br.player.spell.muzzle },
        [2] = { mode = "Off", value = 2 , overlay = "Interrupts Disabled", tip = "不使用打断.", highlight = 0, icon = br.player.spell.muzzle }
    };
    CreateButton("Interrupt",4,0)
-- Trap Button
    TrapModes = {
        [1] = { mode = "On", value = 1 , overlay = "Traps Enabled", tip = "Will Use Traps.", highlight = 1, icon = br.player.spell.explosiveTrap },
        [2] = { mode = "Off", value = 2 , overlay = "Interrupts Disabled", tip = "Traps Will Not Be Used.", highlight = 0, icon = br.player.spell.freezingTrap }
    };
    CreateButton("Trap",5,0)
-- Artifact Button
    ArtifactModes = {
        [1] = { mode = "On", value = 1 , overlay = "Artifact Enabled", tip = "Will Use Artifact.", highlight = 1, icon = br.player.spell.furyOfTheEagle },
        [2] = { mode = "Off", value = 2 , overlay = "Artifact Disabled", tip = "Artifact Will Not Be Used.", highlight = 0, icon = 6603 }
    };
    CreateButton("Artifact",6,0)
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
        -- Artifact
            br.ui:createDropdownWithout(section, "神器技能", {"|cff00FF00任何时候","|cffFFFF00冷却技能","|cffFF0000决不"}, 1, "|cffFFFFFF何时使用神器技能.")
        -- AoE
            br.ui:createSpinnerWithout(section, "AOE目标数量", 3, 1, 10, 1, "|cffFFFFFF设置所需的AOE目标数量.")
        br.ui:checkSectionState(section)
    -- Pet Options
        section = br.ui:createSection(br.ui.window.profile, "宠物")
        -- Auto Summon
            br.ui:createDropdown(section, "自动召唤", {"宠物 1","宠物 2","宠物 3","宠物 4","宠物 5",}, 1, "选择您想要使用的宠物")
        -- Mend Pet
            br.ui:createSpinner(section, "治疗宠物",  50,  0,  100,  5,  "|cffFFFFFF多少百分比血量使用")
        br.ui:checkSectionState(section)
    -- Cooldown Options
        section = br.ui:createSection(br.ui.window.profile, "冷却技能")
        -- Potion
            br.ui:createCheckbox(section,"爆发药水")
        -- Flask / Crystal
            br.ui:createCheckbox(section,"奥拉留斯的低语水晶")
        -- Racial
            br.ui:createCheckbox(section,"种族技能")
        -- Trinkets
            br.ui:createCheckbox(section,"饰品")
        -- Aspect of the Eagle
            br.ui:createCheckbox(section,"雄鹰守护")
        br.ui:checkSectionState(section)
    -- Defensive Options
        section = br.ui:createSection(br.ui.window.profile, "保命")
        -- Healthstone
            br.ui:createSpinner(section, "药水/治疗石",  60,  0,  100,  5,  "|cffFFFFFF多少百分比血量使用")
        -- Heirloom Neck
            br.ui:createSpinner(section, "传家宝项链",  60,  0,  100,  5,  "|cffFFBB00多少百分比血量使用");
        -- Engineering: Shield-o-tronic
            br.ui:createSpinner(section, "粒子护盾(工程物品)",  50,  0,  100,  5,  "|cffFFFFFF多少百分比血量使用")
        -- Exhilaration
            br.ui:createSpinner(section, "意气风发",  60,  0,  100,  5,  "|cffFFBB00多少百分比血量使用");
        -- Aspect Of The Turtle
            br.ui:createSpinner(section, "灵龟守护",  60,  0,  100,  5,  "|cffFFBB00多少百分比血量使用");
        br.ui:checkSectionState(section)
    -- Interrupt Options
        section = br.ui:createSection(br.ui.window.profile, "打断")
        -- Counter Shot
            br.ui:createCheckbox(section,"压制")
        -- Interrupt Percentage
            br.ui:createSpinner(section, "打断",  0,  0,  95,  5,  "|cffFFFFFF读条百分比打断")
        br.ui:checkSectionState(section)
    -- Toggle Key Options
        section = br.ui:createSection(br.ui.window.profile, "切换快捷键")
        -- Single/Multi Toggle
            br.ui:createDropdownWithout(section, "Rotation Mode", br.dropOptions.Toggle,  6)
        -- Cooldown Key Toggle
            br.ui:createDropdownWithout(section, "Cooldown Mode", br.dropOptions.Toggle,  6)
        -- Defensive Key Toggle
            br.ui:createDropdownWithout(section, "Defensive Mode", br.dropOptions.Toggle,  6)
        -- Interrupts Key Toggle
            br.ui:createDropdownWithout(section, "Interrupt Mode", br.dropOptions.Toggle,  6)
        -- Traps Key Toggle
            br.ui:createDropdownWithout(section, "Trap Mode", br.dropOptions.Toggle,  6)
        -- Artifact Key Toggle
            br.ui:createDropdownWithout(section, "Artifact Mode", br.dropOptions.Toggle,  6)
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
    if br.timer:useTimer("debugSurvival", 0.1) then --change "debugFury" to "debugSpec" (IE: debugFire)
        --Print("Running: "..rotationName)

---------------
--- Toggles --- -- List toggles here in order to update when pressed
---------------
        UpdateToggle("Rotation",0.25)
        UpdateToggle("Cooldown",0.25)
        UpdateToggle("Defensive",0.25)
        UpdateToggle("Interrupt",0.25)
        UpdateToggle("Trap",0.25)
        br.player.mode.traps = br.data.settings[br.selectedSpec].toggles["Trap"]
        UpdateToggle("Artifact",0.25)
        br.player.mode.artifact = br.data.settings[br.selectedSpec].toggles["Artifact"]

--------------
--- Locals ---
--------------
        local addsExist                                     = false
        local addsIn                                        = 999
        local animality                                     = false
        local artifact                                      = br.player.artifact
        local buff                                          = br.player.buff
        local canFlask                                      = canUse(br.player.flask.wod.agilityBig)
        local cast                                          = br.player.cast
        local combatTime                                    = getCombatTime()
        local combo                                         = br.player.comboPoints
        local cd                                            = br.player.cd
        local charges                                       = br.player.charges
        local deadMouse                                     = UnitIsDeadOrGhost("mouseover")
        local deadtar, attacktar, hastar, playertar         = deadtar or UnitIsDeadOrGhost("target"), attacktar or UnitCanAttack("target", "player"), hastar or GetObjectExists("target"), UnitIsPlayer("target")
        local debuff, debuffcount                           = br.player.debuff, br.player.debuffcount
        local enemies                                       = enemies or {}
        local falling, swimming, flying, moving             = getFallTime(), IsSwimming(), IsFlying(), GetUnitSpeed("player")>0
        local fatality                                      = false
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
        local mode                                          = br.player.mode
        local multidot                                      = (br.player.mode.cleave == 1 or br.player.mode.rotation == 2) and br.player.mode.rotation ~= 3
        local multishotTargets                              = getEnemies("pet",8)
        local perk                                          = br.player.perk
        local php                                           = br.player.health
        local playerMouse                                   = UnitIsPlayer("mouseover")
        local potion                                        = br.player.potion
        local power, powerMax, powerRegen, powerDeficit     = br.player.power.amount.focus, br.player.power.focus.max, br.player.power.regen, br.player.power.focus.deficit
        local pullTimer                                     = br.DBM:getPulltimer()
        local racial                                        = br.player.getRacial()
        local recharge                                      = br.player.recharge
        local solo                                          = #br.friend < 2
        local friendsInRange                                = friendsInRange
        local spell                                         = br.player.spell
        local talent                                        = br.player.talent
        local trinketProc                                   = false
        local ttd                                           = getTTD
        local ttm                                           = br.player.power.ttm
        local units                                         = units or {}

        units.dyn5 = br.player.units(5)
        units.dyn40 = br.player.units(40)
        enemies.yards5 = br.player.enemies(5)
        enemies.yards5t = br.player.enemies(5,br.player.units(5,true))
        enemies.yards8 = br.player.enemies(8)
        enemies.yards40 = br.player.enemies(40)

        -- BeastCleave 118445
        local beastCleaveTimer                              = getBuffDuration("pet", 118445)

        if leftCombat == nil then leftCombat = GetTime() end
        if profileStop == nil then profileStop = false end

        -- if UnitExists("target") then
        --     ChatOverlay(round2(getDistance("target","player","dist"),2)..", "..round2(getDistance("target","player","dist2"),2)..", "..round2(getDistance("target","player","dist3"),2)..", "..round2(getDistance("target","player","dist4"),2)..", "..round2(getDistance("target"),2))
        -- end
--------------------
--- Action Lists ---
--------------------
    -- Action List - Pet Management
        local function actionList_PetManagement()
            if not IsMounted() then
                if isChecked("自动召唤") and not GetUnitExists("pet") and (UnitIsDeadOrGhost("pet") ~= nil or IsPetActive() == false) then
                  if waitForPetToAppear ~= nil and waitForPetToAppear < GetTime() - 2 then
                      if deadPet == true then
                        if castSpell("player",982) then return; end
                      elseif deadPet == false then
                        local Autocall = getValue("自动召唤");

                        if Autocall == 1 then
                          if castSpell("player",883) then return; end
                        elseif Autocall == 2 then
                          if castSpell("player",83242) then return; end
                        elseif Autocall == 3 then
                          if castSpell("player",83243) then return; end
                        elseif Autocall == 4 then
                          if castSpell("player",83244) then return; end
                        elseif Autocall == 5 then
                          if castSpell("player",83245) then return; end
                        else
                          Print("Auto Call Pet Error")
                        end
                      end

                  end
                  if waitForPetToAppear == nil then
                    waitForPetToAppear = GetTime()
                  end
                end
            end
            --Revive
            if isChecked("自动召唤") and UnitIsDeadOrGhost("pet") then
              if castSpell("player",982) then return; end
            end

            -- Mend Pet
            if isChecked("治疗宠物") and getHP("pet") < getValue("治疗宠物") and not UnitBuffID("pet",136) then
              if castSpell("pet",136) then return; end
            end

            -- Pet Attack / retreat
            if inCombat and isValidUnit(units.dyn40) and getDistance(units.dyn40) < 40 then
                if not UnitIsUnit("target","pettarget") then
                    PetAttack()
                end
            else
                if IsPetAttackActive() then
                    PetStopAttack()
                end
            end
        end
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
        end -- End Action List - Extras
    -- Action List - Defensive
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
        -- Engineering: Shield-o-tronic
                if isChecked("粒子护盾(工程物品)") and php <= getOptionValue("粒子护盾(工程物品)")
                    and inCombat and canUse(118006)
                then
                    useItem(118006)
                end
        -- Exhilaration
                if isChecked("意气风发") and php <= getOptionValue("意气风发") then
                    if cast.exhilaration("player") then return end
                end
        -- Aspect of the Turtle
                if isChecked("灵龟守护") and php <= getOptionValue("灵龟守护") then
                    if cast.aspectOfTheTurtle("player") then return end
                end
            end -- End Defensive Toggle
        end -- End Action List - Defensive
    -- Action List - Interrupts
        local function actionList_Interrupts()
            if useInterrupts() then
        -- Muzzle
                if isChecked("压制") then
                    for i=1, #enemies.yards5 do
                        thisUnit = enemies.yards5[i]
                        if canInterrupt(thisUnit,getOptionValue("打断")) then
                            if cast.muzzle(thisUnit) then return end
                        end
                    end
                end
            end -- End useInterrupts check
        end -- End Action List - Interrupts
    -- Action List - Cooldowns
        local function actionList_Cooldowns()
            if useCDs() and getDistance(units.dyn5) < 5 then
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
                if isChecked("种族技能") and getSpellCD(racial) == 0 then
                    if (((br.player.race == "Orc" or br.player.race == "Troll") and buff.aspectOfTheEagle.exists())
                        or (br.player.race == "BloodElf" and power <= 30))
                    then
                        if castSpell("player",racial,false,false,false) then return end
                    end
                end                
            -- Potion
                -- potion,if=buff.aspect_of_the_eagle.up
                if isChecked("爆发药水") and inRaid and canUse(142117) and buff.aspectOfTheEagle.exists() then
                    useItem(142117)
                end
            -- Snake Hunter
                -- snake_hunter,if=cooldown.mongoose_bite.charges=0&buff.mongoose_fury.remains>3*gcd
                if isChecked("Snake Hunter") then
                    if charges.mongooseBite == 0 and buff.mongooseFury.remain() > 3 * gcd then
                        if cast.snakeHunter("player") then return end
                    end
                end
            -- Aspect of the Eagle
                if isChecked("雄鹰守护") then
                    -- aspect_of_the_eagle,if=(buff.mongoose_fury.remains<=11&buff.mongoose_fury.up)&(cooldown.fury_of_the_eagle.remains>buff.mongoose_fury.remains)
                    if (buff.mongooseFury.remain() <= 11 and buff.mongooseFury.exists()) and (cd.furyOfTheEagle > buff.mongooseFury.remain()) then
                        if cast.aspectOfTheEagle("player") then return end
                    end
                    -- aspect_of_the_eagle,if=(buff.mongoose_fury.remains<=7&buff.mongoose_fury.up)
                    if (buff.mongooseFury.remain() <= 7 and buff.mongooseFury.exists()) then
                        if cast.aspectOfTheEagle("player") then return end
                    end
                end
            end -- End useCooldowns check
        end -- End Action List - Cooldowns
    -- Action List - AOE
        local function actionList_AOE()
        -- Butchery
            -- butchery
            if talent.butchery then
                if cast.butchery("player") then return end
            end
        -- Caltrops
            -- caltrops,if=!dot.caltrops.ticking
            if talent.caltrops and not debuff.caltrops.exists(units.dyn5) then
                if cast.caltrops("best",nil,1,5) then return end
            end
        -- Explosive Trap
            -- explosive_trap
            if cast.explosiveTrap("best",nil,1,5) then return end
        -- Carve
            -- carve,if=talent.serpent_sting.enabled&!dot.serpent_sting.ticking
            if talent.serpentSting and not debuff.serpentSting.exists(units.dyn5) and not talent.butchery then
                if cast.carve("player") then return end
            end
            -- carve,if=active_enemies>5
            if not talent.butchery and #enemies.yards5 > 5 then
                if cast.carve("player") then return end
            end
        end
    -- Action List - Bite Fill
        local function actionList_BiteFill()
        -- Spitting Cobra
            -- spitting_cobra
            if cast.spittingCobra() then return end
        -- Butchery
            -- butchery,if=equipped.frizzos_fingertrap&dot.lacerate.remains<3.6
            if talent.butchery and hasEquiped(137043) and debuff.lacerate.remain(units.dyn5) < 3.6 then
                if cast.butchery("player") then return end
            end
        -- Carve
            -- carve,if=equipped.frizzos_fingertrap&dot.lacerate.remains<3.6
            if not talent.butchery and hasEquiped(137043) and debuff.lacerate.remain(units.dyn5) < 3.6 then
                if cast.carve("player") then return end
            end
        -- Lacerate
            -- lacerate,if=dot.lacerate.remains<3.6
            if debuff.lacerate.remain(units.dyn5) < 3.6 then
                if cast.lacerate(units.dyn5) then return end
            end
        -- Raptor Strike
            -- raptor_strike,if=active_enemies=1&talent.serpent_sting.enabled&!dot.serpent_sting.ticking
            if ((mode.rotation == 1 and #enemies.yards5 == 1) or mode.rotation == 3) and talent.serpentSting and not debuff.serpentSting.exists(units.dyn5) then
                if cast.raptorStrike() then return end
            end
        -- Steel Trap
            -- steel_trap
            if cast.steelTrap("best",nil,1,5) then return end
        -- A Murder of Crows
            -- a_murder_of_crows
            if cast.aMurderOfCrows() then return end
        -- Dragonsfire Grenade
            -- dragonsfire_grenade
            if cast.dragonsfireGrenade() then return end
        -- Explosive Trap
            -- explosive_trap
            if cast.explosiveTrap("best",nil,1,5) then return end
        -- Caltrops
            -- caltrops,if=!dot.caltrops.ticking
            if not debuff.caltrops.exists() then
                if cast.caltrops("best",nil,1,5) then return end
            end
        end
    -- Action List - Bite Phase
        local function actionList_BitePhase()
        -- Fury of the Eagle
            -- fury_of_the_eagle,if=(!talent.way_of_the_moknathal.enabled|buff.moknathal_tactics.remains>(gcd*(8%3)))&buff.mongoose_fury.stack=6,interrupt_if=(talent.way_of_the_moknathal.enabled&buff.moknathal_tactics.remains<=tick_time)
            if mode.artifact == 1 and (getOptionValue("神器技能") == 1 or (getOptionValue("神器技能") == 2 and useCDs())) then
                if (not talent.wayOfTheMokNathal or buff.mokNathalTactics.remain() > (gcd * (8 / 3))) and buff.mongooseFury.stack() == 6 then
                    if cast.furyOfTheEagle("player") then return end
                end
            end
        -- Mongoose Bite
            -- mongoose_bite,if=charges>=2&cooldown.mongoose_bite.remains<gcd*2
            if charges.mongooseBite >= 2 and cd.mongooseBite < gcd * 2 then
                if cast.mongooseBite() then return end
            end
        -- Flanking Strike
            -- flanking_strike,if=((buff.mongoose_fury.remains>(gcd*(cooldown.mongoose_bite.charges+2)))&cooldown.mongoose_bite.charges<=1)&!buff.aspect_of_the_eagle.up
            if ((buff.mongooseFury.remain() > (gcd * (charges.mongooseBite + 2))) and charges.mongooseBite <= 1) and not buff.aspectOfTheEagle.exists() then
                if cast.flankingStrike() then return end
            end
        -- Mongoose Bite
            -- mongoose_bite,if=buff.mongoose_fury.up
            if buff.mongooseFury.exists() then
                if cast.mongooseBite() then return end
            end
        -- Flanking Strike
            -- flanking_strike
            if cast.flankingStrike() then return end
        end
    -- Action List - Fillers
        local function actionList_Fillers()
        -- Carve
            -- carve,if=active_enemies>1&talent.serpent_sting.enabled&!dot.serpent_sting.ticking
            if not talent.butchery and ((mode.rotation == 1 and #enemies.yards5 > 1) or (mode.rotation == 2 and #enemies.yards5 > 0)) and talent.serpentSting and not debuff.serpentSting.exists(units.dyn5) then
                if cast.carve("player") then return end
            end
        -- Throwing Axes
            -- throwing_axes
            if cast.throwingAxes(units.dyn5) then return end
        -- Carve
            -- carve,if=active_enemies>2
            if not talent.butchery and ((mode.rotation == 1 and #enemies.yards5 > 2) or (mode.rotation == 2 and #enemies.yards5 > 0)) then
                if cast.carve("player") then return end
            end
        -- Raptor Strike
            -- raptor_strike,if=(talent.way_of_the_moknathal.enabled&buff.moknathal_tactics.remains<gcd*4)
            if (talent.wayOfTheMokNathal and buff.mokNathalTactics.remain() < gcd * 4) then
                if cast.raptorStrike() then return end
            end
            -- raptor_strike,if=focus>((25-focus.regen*gcd)+55)
            if power > ((25 - powerRegen * gcd) + 55) then
                if cast.raptorStrike() then return end
            end
        end
    -- Action List - Mok'Maintain
        local function actionList_MokMaintain()
        -- Raptor Strike
            -- raptor_strike,if=buff.moknathal_tactics.remains<gcd
            if buff.mokNathalTactics.remain() < gcd then
                if cast.raptorStrike() then return end
            end
            -- raptor_strike,if=buff.moknathal_tactics.stack<2
            if buff.mokNathalTactics.stack() < 2 then
                if cast.raptorStrike() then return end
            end
        end
    -- Action List - Pre-Bite Phase
        local function actionList_PreBitePhase()
        -- Flanking Strike
            -- flanking_strike
            if cast.flankingStrike() then return end
        -- Spitting Cobra
            -- spitting_cobra
            if cast.spittingCobra() then return end
        -- Lacerate
            -- lacerate,if=!dot.lacerate.ticking
            if not debuff.lacerate.exists(units.dyn5) then
                if cast.lacerate() then return end
            end
        -- Raptor Strike
            -- raptor_strike,if=active_enemies=1&talent.serpent_sting.enabled&!dot.serpent_sting.ticking
            if ((mode.rotation == 1 and #enemies.yards5 == 1) or mode.rotation == 3) and talent.serpentSting and not debuff.serpentSting.exists(units.dyn5) then
                if cast.raptorStrike() then return end
            end
        -- Steel Trap
            -- steel_trap
            if cast.steelTrap("best",nil,1,5) then return end
        -- A Murder of Crows
            -- a_murder_of_crows
            if cast.aMurderOfCrows() then return end
        -- Dragonsfire Grenade
            -- dragonsfire_grenade
            if cast.dragonsfireGrenade() then return end
        -- Explosive Trap
            -- explosive_trap
            if cast.explosiveTrap("best",nil,1,5) then return end
        -- Caltrops
            -- caltrops,if=!dot.caltrops.ticking
            if not debuff.caltrops.exists() then
                if cast.caltrops("best",nil,1,5) then return end
            end
        -- Butchery
            -- butchery,if=equipped.frizzos_fingertrap&dot.lacerate.remains<3.6
            if talent.butchery and hasEquiped(137043) and debuff.lacerate.remain(units.dyn5) < 3.6 then
                if cast.butchery("player") then return end
            end
        -- Carve
            -- carve,if=equipped.frizzos_fingertrap&dot.lacerate.remains<3.6
            if not talent.butchery and hasEquiped(137043) and debuff.lacerate.remain(units.dyn5) < 3.6 then
                if cast.carve("player") then return end
            end
        -- Lacerate
            -- lacerate,if=dot.lacerate.remains<3.6
            if debuff.lacerate.remain(units.dyn5) < 3.6 then
                if cast.lacerate(units.dyn5) then return end
            end 
        end
    -- Action List - Multi Target
        local function actionList_MultiTarget()    
            -- Dragonsfire Grenade
            if talent.dragonsfireGrenade then
                if cast.dragonsfireGrenade(units.dyn5) then return end
            end
            -- Explosive Trap
            if cast.explosiveTrap(units.dyn5) then return end
            -- Caltrops
            -- if DotCount(Caltrops) < TargetsInRadius(Caltrops)
            if talent.caltrops then
                if cast.caltrops("best",nil,1,5) then return end
            end
            -- Butchery / Carve
            if talent.butchery then
                if cast.butchery(units.dyn5) then return end
            else
                if cast.carve(units.dyn5) then return end
            end
        end -- End Action List - Multi Target
    -- Action List - Pre-Combat
        local function actionList_PreCombat()
        -- Flask / Crystal
            -- flask,name=countless_armies
            if isChecked("奥拉留斯的低语水晶") and not (IsFlying() or IsMounted()) then
                if (raid or solo) and not (buff.agilityFlaskLow or buff.agilityFlaskBig) then--Draenor Str Flasks
                    if not UnitBuffID("player",176151) and canUse(118922) then --Draenor Insanity Crystal
                        if br.player.useCrystal() then return end
                    end
                end
            end
        -- Food
            -- food,type=food,name=azshari_salad
            -- TODO
        -- Augmentation
            -- augmentation,name=defiled
            -- TODO
        -- Potion
            -- potion,name=prolonged_power
            -- TODO
        -- Pre-pull
            if isChecked("Pre-Pull Timer") and pullTimer <= getOptionValue("Pre-Pull Timer") then

            end -- Pre-Pull
            if isValidUnit("target") and not inCombat and getDistance("target") < 40 then
                if mode.traps == 1 then  
        -- Explosive Trap
                    -- explosive_trap
                    if cast.explosiveTrap("best",nil,1,5) then return end
        -- Steel Trap
                    -- steel_trap
                    if cast.steelTrap("best",nil,1,5) then return end
        -- Caltrops
                    -- if cast.caltrops("best",nil,1,5) then return end
                end
        -- Dragonsfire Grenade
                -- dragonsfire_grenade 
                if cast.dragonsfireGrenade() then return end
        -- Start Attack
                StartAttack()
            end
        end -- End Action List - PreCombat
---------------------
--- Begin Profile ---
---------------------
    -- Profile Stop | Pause
        if not inCombat and not hastar and profileStop==true then
            profileStop = false
        elseif (inCombat and profileStop==true) or (IsMounted() or IsFlying()) or pause() or mode.rotation==4 then
            if not pause() and IsPetAttackActive() then
                PetStopAttack()
                PetFollow()
            end
            return true
        else
---------------------------------
--- Out Of Combat - Rotations ---
---------------------------------
    -----------------
    --- Pet Logic ---
    -----------------
            if actionList_PetManagement() then return end
    -----------------
    --- Defensive ---
    -----------------
            if actionList_Defensive() then return end
    ------------------
    --- Pre-Combat ---
    ------------------
            if not inCombat and GetObjectExists("target") and not UnitIsDeadOrGhost("target") and UnitCanAttack("target", "player") then
                if actionList_PreCombat() then return end
            end -- End Out of Combat Rotation
-----------------------------
--- In Combat - Rotations ---
-----------------------------
            if inCombat and isValidUnit(units.dyn40) and getDistance(units.dyn5) < 5 then
    -----------------
    --- Pet Logic ---
    -----------------
                if actionList_PetManagement() then return end
    ------------------------------
    --- In Combat - Interrupts ---
    ------------------------------
                if actionList_Interrupts() then return end
    ---------------------------
    --- SimulationCraft APL ---
    ---------------------------
                if getOptionValue("APL模式") == 1 then
            -- Start Attack
                    -- actions=auto_attack
                    if getDistance(units.dyn5) < 5 then
                        StartAttack()
                    end
            -- Call Action List - Mok'Maintain
                    -- call_action_list,name=mokMaintain,if=talent.way_of_the_moknathal.enabled
                    if talent.wayOfTheMokNathal then
                        if actionList_MokMaintain() then return end
                    end
            -- Cooldowns
                    -- call_action_list,name=CDs,if=buff.moknathal_tactics.stack>=2|!talent.way_of_the_moknathal.enabled
                    if buff.mokNathalTactics.stack() >= 2 or not talent.wayOfTheMokNathal then
                        if actionList_Cooldowns() then return end
                    end
            -- Call Action List - AOE
                    -- call_action_list,name=aoe,if=active_enemies>=3
                    if ((mode.rotation == 1 and #enemies.yards5 >= getOptionValue("AOE目标数量")) or (mode.rotation == 2 and #enemies.yards5 > 0)) 
                        and (not talent.butchery or (talent.butchery and charges.butchery > 0)) 
                    then
                        if actionList_AOE() then return end
                    else
            -- Call Action List - Pre-Bite Phase
                        -- call_action_list,name=preBitePhase,if=!buff.mongoose_fury.up
                        if not buff.mongooseFury.exists() then
                            if actionList_PreBitePhase() then return end
                        end
            -- Call Action List - Bite Phase
                        -- call_action_list,name=bitePhase
                        if actionList_BitePhase() then return end
            -- Call Action List - Bite Filler
                        -- call_action_list,name=biteFill
                        if actionList_BiteFill() then return end
                    end
            -- Call Action List - Filler
                    -- call_action_list,name=fillers
                    if actionList_Fillers() then return end
                end -- End SimC APL
    ------------------------
    --- Ask Mr Robot APL ---
    ------------------------
                if getOptionValue("APL模式") == 2 then
                    if getDistance(units.dyn5) < 5 then
                        StartAttack()
                    end
                    -- Harpoon
                    -- if not HasDot(OnTheTrail) and ArtifactTraitRank(EaglesBite) > 0
                    -- Cooldowns
                    -- if TargetsInRadius(Carve) > 2 or HasBuff(MongooseFury) or ChargesRemaining(MongooseBite) = SpellCharges(MongooseBite)
                    -- Use your cooldowns during or just before Mongoose Fury or an AoE phase.
                    if #enemies.yards5 > 2 or buff.mongooseFury.exists() or charges.mongooseBite == charges.max.mongooseBite then
                        if actionList_Cooldowns() then return end
                    end
                    -- MultiTarget
                    -- if TargetsInRadius(Carve) > 2
                    if (#enemies.yards5 > 2 and mode.rotation == 1) or mode.rotation == 2 then
                        if actionList_MultiTarget() then return end
                    end
                    -- Explosive Trap
                    if cast.explosiveTrap(units.dyn5) then return end
                    -- Dragonsfire Grenade
                    if talent.dragonsfireGrenade then
                        if cast.dragonsfireGrenade(units.dyn5) then return end
                    end
                    -- Raptor Strike
                    -- if HasTalent(WayOfTheMokNathal) and BuffRemainingSec(MokNathalTactics) <= GlobalCooldownSec
                    if talent.wayOfTheMokNathal and buff.mokNathalTactics.remain() <= gcd then
                        if cast.raptorStrike(units.dyn5) then return end
                    end
                    -- Snake Hunter
                    -- if ChargesRemaining(MongooseBite) = 0 and BuffRemainingSec(MongooseFury) > GlobalCooldownSec * 4
                    if talent.snakeHunter and charges.mongooseBite == 0 and buff.mongooseFury.remain() > gcd * 4 then
                        if cast.snakeHunter(units.dyn5) then return end
                    end
                    -- Fury of the Eagle
                    -- if HasBuff(MongooseFury) and BuffRemainingSec(MongooseFury) <= GlobalCooldownSec * 2
                    -- You want to use this near the end of Mongoose Fury, but leave time to use one or two Mongoose Bite charges you might gain during the channel.
                    if buff.mongooseFury.exists() and buff.mongooseFury.remain() <= gcd * 2 then
                        if cast.furyOfTheEagle(units.dyn5) then return end
                    end
                    -- Mongoose Bite
                    -- if HasBuff(MongooseFury) or ChargesRemaining(MongooseBite) = SpellCharges(MongooseBite)
                    -- Once you hit max charges of Mongoose Bite, use it.
                    if buff.mongooseFury or charges.mongooseBite == charges.max.mongooseBite then
                        if cast.mongooseBite(units.dyn5) then return end
                    end
                    -- Steel Trap
                    if talent.steelTrap then
                        if cast.steelTrap(units.dyn5) then return end
                    end
                    -- Caltrops
                    -- if not HasDot(Caltrops) or DotCount(Caltrops) < TargetsInRadius(Caltrops)
                    if talent.caltrops and not not UnitDebuffID(units.dyn5,spell.debuffs.caltrops,"player") then
                        if cast.caltrops(units.dyn5) then return end
                    end
                    -- A Murder of Crows
                    if talent.aMurderOfCrows then
                        if cast.aMurderOfCrows(units.dyn5) then return end
                    end
                    -- Lacerate
                    -- if CanRefreshDot(Lacerate)
                    if debuff.lacerate.refresh(units.dyn5) then
                        if cast.lacerate(units.dyn5) then return end
                    end
                    -- Spitting Cobra
                    if cast.splittingCobra(units.dyn5) then return end
                    -- Raptor Strike
                    -- if (HasTalent(SerpentSting) and CanRefreshDot(SerpentSting))
                    if talent.serpentSting and not UnitDebuffID(units.dyn5,spell.debuffs.serpentSting,"player") then
                        if cast.raptorStrike(units.dyn5) then return end
                    end
                    -- Flanking Strike
                    if cast.flankingStrike(units.dyn5) then return end
                    -- Butchery
                    -- if TargetsInRadius(Butchery) > 1
                    if talent.butchery and #enemies.yards5 > 1 then
                        if cast.butchery(units.dyn5) then return end
                    end
                    -- Carve
                    -- if TargetsInRadius(Carve) > 1
                    if not talent.butchery and #enemies.yards5 > 1 then
                        if cast.carve(units.dyn5) then return end
                    end
                    -- Throwing Axes
                    if cast.throwingAxes(units.dyn5) then return end
                    -- Raptor Strike
                    -- if Power > 75 - CooldownSecRemaining(FlankingStrike) * PowerRegen and not HasTalent(ThrowingAxes)
                    -- If using Raptor Strike could possibly delay a Flanking Strike by using up your Focus, it is better to just wait for Flanking Strike to come off GCD. It is also not worth using if you have Throwing Axes talented.
                    if power > 75 - cd.flankingStrike * powerRegen and not talent.throwingAxes then
                        if cast.raptorStrike(units.dyn5) then return end
                    end
                end -- End AMR
            end -- End In Combat Rotation
        end -- Pause
    end -- End Timer
end -- End runRotation
local id = 255 -- Change to the spec id profile is for.
if br.rotations[id] == nil then br.rotations[id] = {} end
tinsert(br.rotations[id],{
    name = rotationName,
    toggles = createToggles,
    options = createOptions,
    run = runRotation,
})
