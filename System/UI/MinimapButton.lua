-- Minimap Button
function br:MinimapButton()
	local dragMode = nil --"free", nil
	local function moveButton(self)
		local centerX, centerY = Minimap:GetCenter()
		local x, y = GetCursorPosition()
		x, y = x / self:GetEffectiveScale() - centerX, y / self:GetEffectiveScale() - centerY
		centerX, centerY = math.abs(x), math.abs(y)
		centerX, centerY = (centerX / math.sqrt(centerX^2 + centerY^2)) * 76, (centerY / sqrt(centerX^2 + centerY^2)) * 76
		centerX = x < 0 and -centerX or centerX
		centerY = y < 0 and -centerY or centerY
		self:ClearAllPoints()
		self:SetPoint("CENTER", centerX, centerY)
	end
	local button = CreateFrame("Button", "BadRotationsButton", Minimap)
	button:SetHeight(25)
	button:SetWidth(25)
	button:SetFrameStrata("MEDIUM")
	button:SetPoint("CENTER", 75.70,-6.63)
	button:SetMovable(true)
	button:SetUserPlaced(true)
	button:SetNormalTexture("Interface\\HelpFrame\\HotIssueIcon.blp")
	button:SetPushedTexture("Interface\\HelpFrame\\HotIssueIcon.blp")
	button:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-Background.blp")
	button:SetScript("OnMouseDown",function(self, button)
		if button == "RightButton" then
			br.ui:toggleWindow("profile")
        end
        if button == "MiddleButton" then
        	if br.ui.window.help.parent == nil then
            	br.ui:createHelpWindow()
            else
            	br.ui:toggleWindow("help")
            end
        end
		if IsShiftKeyDown() and IsAltKeyDown() then
			self:SetScript("OnUpdate",moveButton)
		end
	end)
	button:SetScript("OnMouseUp",function(self)
		self:SetScript("OnUpdate",nil)
	end)
	button:SetScript("OnClick",function(self, button)
		if button == "LeftButton" then
			if IsShiftKeyDown() and not IsAltKeyDown() then
				if br.data.settings[br.selectedSpec].toggles["Main"] == 1 then
					br.data.settings[br.selectedSpec].toggles["Main"] = 0
					mainButton:Hide()
				else
					br.data.settings[br.selectedSpec].toggles["Main"] = 1
					mainButton:Show()
				end
			elseif not IsShiftKeyDown() and not IsAltKeyDown() then
				if br.ui.window.config.parent == nil then
	            	br.ui:createConfigWindow()
	            else
					br.ui:toggleWindow("config")
				end
            end
		end
	end)
	button:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(Minimap, "ANCHOR_CURSOR", 50 , 50)
		GameTooltip:SetText("BadRotations", 214/255, 25/255, 25/255)
		GameTooltip:AddLine("by CuteOne")
		GameTooltip:AddLine("左键点击 打开引擎界面", 1, 1, 1, 1)
		GameTooltip:AddLine("Shift+左键 显示或隐藏图标栏.", 1, 1, 1, 1)
		GameTooltip:AddLine("Alt+Shift+左键 可拖动小图标", 1, 1, 1, 1)
		GameTooltip:AddLine("左键点击 打开脚本设置界面", 1, 1, 1, 1)
	    GameTooltip:AddLine("滚轮点击 打开帮助框架", 1, 1, 1, 1)
		GameTooltip:Show()
	end)
	button:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)
end