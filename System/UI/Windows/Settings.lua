br.ui.window.settings = {}
function br.ui:createSettingsWindow()
		if not br.ui.window['settings']['parent'] then
			br.ui.window.settings = br.ui:createWindow("保存/加载 设置", 200, 125, "保存/加载 设置")
			local section
			section = br.ui:createSection(br.ui.window.settings, "保存/加载")
			br.ui:createCheckbox(section, "地下城", "保存/加载 地下城 数据")
			br.ui:createCheckbox(section, "团本", "保存/加载 团本 数据")
			br.ui:createSettingsButton(section, "保存", 0, -40)
			br.ui:createSettingsButton(section, "加载", 100, -40)
        	br.ui:checkSectionState(section)
	        br.ui.window.settings.parent.closeButton:SetScript("OnClick", function()
		    	if br.data.settings[br.selectedSpec][br.selectedProfile] ~= nil then
					br.data.settings[br.selectedSpec][br.selectedProfile]["保存/加载 设置Check"] = false
				end
		    	if slsettings ~= nil then slsettings:SetChecked(false) end
		        br.data.settings[br.selectedSpec].settings["active"] = false
		        br.ui.window.settings.parent:Hide()
	    	end)
	    	br.ui:checkWindowStatus("settings")
			br.ui:closeWindow("settings")
		end
		if isChecked("保存/加载 设置") then
	    	if not br.ui.window['settings']['parent'] then 
	    		br.ui.window.settings = br.ui:createWindow("保存/加载 设置", 200, 125, "保存/加载 设置")
				local section
				section = br.ui:createSection(br.ui.window.settings, "保存/加载")
				br.ui:createCheckbox(section, "地下城", "保存/加载 地下城 数据")
				br.ui:createCheckbox(section, "团本", "保存/加载 团本 数据")
				br.ui:createSettingsButton(section, "保存", 0, -40)
				br.ui:createSettingsButton(section, "加载", 100, -40)
	        	br.ui:checkSectionState(section)
	        	br.ui.window.settings.parent.closeButton:SetScript("OnClick", function()
		    	if br.data.settings[br.selectedSpec][br.selectedProfile] ~= nil then
					br.data.settings[br.selectedSpec][br.selectedProfile]["保存/加载 设置Check"] = false
				end
		    	if slsettings ~= nil then slsettings:SetChecked(false) end
		        br.data.settings[br.selectedSpec].settings["active"] = false
		        br.ui.window.settings.parent:Hide()
	    	end)
	    	br.ui:checkWindowStatus("settings")
	        end
			br.ui:showWindow("settings")
	    elseif br.data.settings[br.selectedSpec]["settings"] == nil then
    		br.data.settings[br.selectedSpec]["settings"] = {}
    		br.data.settings[br.selectedSpec]["settings"].active = false
    	elseif br.data.settings[br.selectedSpec]["settings"].active == true then
	    	br.ui:closeWindow("settings")
		end
	end