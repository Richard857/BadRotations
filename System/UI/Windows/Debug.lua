-- TODO: create new debug frame
br.ui.window.debug = {}
function br.ui:createDebugWindow()
    br.ui.window.debug = br.ui:createMessageWindow("debug",300,250,"运行日志")
    br.ui.window.debug.parent.closeButton:SetScript("OnClick", function()
    	if br.data.settings[br.selectedSpec][br.selectedProfile] ~= nil then
			br.data.settings[br.selectedSpec][br.selectedProfile]["运行日志Check"] = false
		end
    	if rotationLog ~= nil then rotationLog:SetChecked(false) end
        br.data.settings[br.selectedSpec].debug["active"] = false
        br.ui.window.debug.parent:Hide()
    end)
	br.ui:checkWindowStatus("debug")
end