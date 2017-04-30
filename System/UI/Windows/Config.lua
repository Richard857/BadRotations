-- This creates the normal BadBay Configuration Window
br.ui.window.config = {}
function br.ui:createConfigWindow()
    br.ui.window.config = br.ui:createWindow("config", 275, 400,"Configuration")

    local section

    local function callGeneral()
        -- General
        section = br.ui:createSection(br.ui.window.config, "一般")
        br.ui:createSpinnerWithout(section, "执行率", 0.1, 0.0, 1.0, 0.01, "数值越小脚本执行速度越快.增加数值可以改善FPS但可能会导致反应延迟.默认是:0.1")
        -- As you should use the toggle to stop, i (defmaster) just activated this toggle default and made it non interactive
        local startStop = br.ui:createCheckbox(section, "开始/停止 BR", "Toggle this option from the Toggle Bar (Shift Left Click on the Minimap Icon.");
        startStop:SetChecked(true); br.data.settings[br.selectedSpec][br.selectedProfile]["开始/停止 BRCheck"] = true; startStop.frame:Disable()
        -- br.ui:createCheckbox(section, "Start/Stop BadRotations", "Uncheck to prevent BadRotations pulsing.");
        rotationLog = br.ui:createCheckbox(section, "运行日志", "显示运行日志.");
        -- br.ui:createCheckbox(section, "运行日志", "显示运行日志.")
        br.ui:createCheckbox(section, "显示失败", "在日志中显示失败信息.")
        br.ui:createCheckbox(section, "技能自动排队", "允许在某些配置文件上进行技能自动排队.")
        br.ui:createSpinner(section,  "自动拾取" ,0.5, 0.1, 3, 0.1, "设置自动拾取的延迟.")
		br.ui:createSpinner(section,  "远程拾取器",3, 0, 60, 1, "自动使用远程拾取器","间隔多少秒使用.")
		br.ui:createDropdownWithout(section, "远程拾取器 用法", {"|cffFFFFFF脱战后使用","|cffFFFFFF任何时候使用"}, 1, "|cffFFFFFF选择使用方法")
		br.ui:createSpinner(section,  "老妈的剥皮小刀",3, 0, 60, 1, "自动使用老妈的剥皮小刀.","间隔多少秒使用.")
		br.ui:createDropdownWithout(section, "老妈的剥皮小刀 用法", {"|cffFFFFFF脱战后使用","|cffFFFFFF任何时候使用"}, 1, "|cffFFFFFF选择使用方法")
        br.ui:createCheckbox(section, "自动售卖/维修", "当您打开维修供应商时，自动销售灰色和维修。")
        br.ui:createCheckbox(section, "接受队列", "自动接受副本.战场.竞技场..队列")
        br.ui:createCheckbox(section, "覆盖消息", "选中以启用聊天覆盖消息")
        br.ui:createSpinner(section,  "通知未解锁", 10, 5, 60, 5, "当FireHack或EWT未连接时，将以设置的间隔时间提醒您.")
        br.ui:createCheckbox(section, "重置选项", "|cffFF0000 警告!|cffFFFFFF 打开后然后重新加载就会重置所有设置!")
        br.ui:checkSectionState(section)
    end

    local function callEnemiesEngine()
        -- Enemies Engine
        section = br.ui:createSection(br.ui.window.config, "敌人引擎")
        br.ui:createCheckbox(section, "动态定位", "选中此选项可允许动态定位。如果未选中，配置文件将只攻击当前目标。")
        br.ui:createCheckbox(section, "自动切换目标", "将自动切换到动态定位的目标.")
		br.ui:createCheckbox(section, "只有敌人", "打开这个将只针对敌对你的单位.")
		br.ui:createCheckbox(section, "易爆助手", "将自动切换到邪能炸药.")
        br.ui:createDropdown(section, "智能目标", {"高血量", "低血量", "abs最高"}, 1, "|cffFFDD11检查您是否要使用智能目标，如果未选中，将不会有来自hp的优先级。")
        br.ui:createCheckbox(section, "强制攻击", "允许攻击一些特殊单位.")
        br.ui:createCheckbox(section, "避免无效单位", "检查以避免攻击无效单位")
        br.ui:createCheckbox(section, "坦克仇恨", "检查添加更多的优先考虑你失去了仇恨的目标（只有坦克）")
        br.ui:createCheckbox(section, "安全攻击检测", "检查以防止攻击你不想攻击的目标")
        br.ui:createCheckbox(section, "不打破控制", "检查以防止打破控制的目标 比如变羊之类的技能.")
        br.ui:createCheckbox(section, "优先攻击骷髅头目标", "动态启用焦点骷髅头目标.")
        br.ui:createDropdown(section, "打断处理程序", {"目标", "目标/鼠标位置", "目标/鼠标位置/焦点", "所有"}, 1, "检查这允许中断处理程序.不要使用！目前还没实现")
        br.ui:createCheckbox(section, "只有已知单位", "选中此项可仅使用白名单打断已知单位。")
        br.ui:createCheckbox(section, "人群控制", "检查选择单位/buff的人群控制")
        br.ui:createCheckbox(section, "激怒处理", "选中此项以允许激怒处理程序.")
        br.ui:checkSectionState(section)
    end

    local function callHealingEngine()
        -- Healing Engine
        section = br.ui:createSection(br.ui.window.config, "治疗引擎")
        br.ui:createCheckbox(section, "主动治疗", "治疗必须启用否则不会加血\n如果你不是治疗,关闭此功能可以提高FPS")
        br.ui:createCheckbox(section, "优先治疗", "优先治疗 焦点/目标/鼠标位置")		
        br.ui:createCheckbox(section, "治疗宠物", "治疗宠物.")
        br.ui:createDropdown(section, "特殊治疗", {"目标", "目标/鼠标位置", "目标/鼠标位置/焦点", "目标/焦点"}, 1, "选中此项就可以治疗一些特殊单位,如NPC.治疗木桩等等.", "选择你想要治疗的.")
        br.ui:createCheckbox(section, "用角色排序", "用角色排序")
        br.ui:createDropdown(section, "优先排列特定的目标", {"特殊", "所有"}, 1, "优先特定目标(鼠标位置/目标/焦点).", "选择要考虑的特殊单位.")
        br.ui:createSpinner(section, "黑名单", 95, nil, nil, nil, "|cffFFBB00多少 |cffFF0000%HP|cffFFBB00 添加到 |cffFFDD00黑名单 |cffFFBB00单位.使用/黑名单，而鼠标悬停某人将其添加到黑名单.")
        br.ui:createCheckbox(section, "忽略吸收", "如果你想忽略吸收屏蔽，请选中此项。如果选中，它将添加shieldBuffValue / 4到hp。 可能最终作为过热，禁用，以节省法力.")
        br.ui:createCheckbox(section, "预计治疗", "如果勾选此项,将预计的健康从其他治疗师HP。取消这如果你想防止过量治疗单位。")
        br.ui:createSpinner(section, "过量治疗取消", 95, nil, nil, nil, "置所需的阈值,你想阻止自己的施法. 目前还不可以用")
        healingDebug = br.ui:createCheckbox(section, "调试治疗", "调试检查显示治疗引擎.")
        br.ui:createSpinner(section, "刷新调试", 500, 0, 1000, 25, "设置所需的“治疗引擎调试表的刷新速率（以毫秒为单位）")
        br.ui:createSpinner(section, "驱散延迟", 15, 5, 90, 5, "设置所需的消除debuff持续时间的延迟.\n|cffFF0000会随机在你设定的值。")
        br.ui:createCheckbox(section, "治疗者的视线指标", "画一条线给治疗者.绿色在视线/红色不在视线")
        br.ui:checkSectionState(section)
    end

    local function callOtherFeaturesEngine()
        -- Other Features
        section = br.ui:createSection(br.ui.window.config, "其他功能")
        br.ui:createSpinner(section, "专业助手", 0.5, 0, 1, 0.1, "选中以启用“专业助手”.", "设置期望的重复延迟延迟.")
        br.ui:createDropdown(section, "探矿", {"军团","WoD", "MoP", "裂变", "所有"}, 1, "选择你要追踪的矿石.")
        br.ui:createDropdown(section, "探草", {"军团","WoD", "MoP", "裂变", "所有"}, 1, "选择你要追踪的药草.")
        br.ui:createCheckbox(section, "分解", "分解Cata蓝色/绿色.")
        br.ui:createCheckbox(section, "皮革废料", "组合皮革废料.")
        br.ui:checkSectionState(section)
    end

    -- Add Page Dropdown
    br.ui:createPagesDropdown(br.ui.window.config, {
        {
            [1] = "一般",
            [2] = callGeneral,
        },
        {
            [1] = "敌人引擎",
            [2] = callEnemiesEngine,
        },
        {
            [1] = "治疗引擎",
            [2] = callHealingEngine,
        },
        {
            [1] = "其他功能",
            [2] = callOtherFeaturesEngine,
        },
    })

    br.ui:checkWindowStatus("config")
end