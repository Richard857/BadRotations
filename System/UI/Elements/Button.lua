local DiesalGUI = LibStub("DiesalGUI-1.0")

function br.ui:createButton(parent, buttonName, x, y)
    local newButton = DiesalGUI:Create('Button')
    local parent = parent

    parent:AddChild(newButton)
    newButton:SetParent(parent.content)
    newButton:AddStyleSheet(br.ui.buttonStyleSheet)
    newButton:SetPoint("TOPLEFT", parent.content, "TOPLEFT", x, y)
    newButton:SetText(buttonName)
    newButton:SetWidth(100)
    newButton:SetHeight(20)
    --newBox:SetEventListener("OnClick", function()
    --
    --end)

    parent:AddChild(newButton)

    return newButton
end

function br.ui:createSettingsButton(parent, buttonName, x, y)
        local newButton = DiesalGUI:Create('Button')
        local parent = parent

        parent:AddChild(newButton)
        newButton:SetParent(parent.content)
        newButton:AddStyleSheet(br.ui.buttonStyleSheet)
        newButton:SetPoint("TOPLEFT", parent.content, "TOPLEFT", x, y)
        newButton:SetText(buttonName)
        newButton:SetWidth(100)
        newButton:SetHeight(20)
        newButton:SetEventListener("OnClick", function()
            if buttonName == "保存" then
                if isChecked("地下城") and not isChecked("团本") then
                    br.dungeon = deepcopy(br.data)
                    print("地下城 数据 保存")
                elseif isChecked("团本") and not isChecked("地下城") then
                    --raiddata = brdata
                    br.raid = deepcopy(br.data)
                    print("团本 数据 保存")
                else 
                    print("保存 错误")
                end
            elseif buttonName == "加载" then
                if isChecked("地下城") and not isChecked("团本") then
                    br.data = {}
                    if br.dungeon ~= nil then
                        br.data = deepcopy(br.dungeon)
                        print("地下城 数据 加载")
                        br.ui:closeWindow("all")
                        br:loadSettings()
                        if isChecked("保存/加载 设置") == true then
                            slsettings:SetChecked(false)
                        end
                    else 
                        print("地下城 设置不存在.")
                    end                         
                elseif isChecked("团本") and not isChecked("地下城") then
                    if br.raid ~= nil then
                        br.data = deepcopy(br.raid)
                        print("团本 数据 加载")
                        br.ui:closeWindow("all")
                        br:loadSettings()
                        if isChecked("保存/加载 设置") == true then
                            slsettings:SetChecked(false)
                        end
                    else
                        print("团本 设置不存在.")
                    end
                else
                    print("加载 错误")
                end
            end
        end)

        parent:AddChild(newButton)

        return newButton
    end
