if Holo.Options:GetValue("Base/Info") and Holo.Options:GetValue("Info/ECM") then
Hooks:PostHook(ECMJammerBase, "set_active", "HoloSetActive", function(self, active)
	if not Holo.Info then
		return 
	end	
	if active == true then
		Holo.Info:CreateInfo({
			timer = true,
			visible = true,
			name = self._unit:id(),
			panel = "ECM",
		})
	end
end)

Hooks:PostHook(ECMJammerBase, "update", "HoloUpdate", function(self)
	if not Holo.Info then
		return 
	end	
	if self._jammer_active == true then
		Holo.Info:SetInfoTime("ECM", self._unit:id(), self._chk_feedback_retrigger_t or self._battery_life)
	end
end)

Hooks:PostHook(ECMJammerBase, "set_battery_empty", "HoloSetBatteryEmpty", function(self)
	if not Holo.Info then
		return 
	end
	Holo.Info:RemoveInfoValue("ECM", self._unit:id())
end)

Hooks:PostHook(ECMJammerBase, "destroy", "HoloDestroy", function(self)
	if not Holo.Info then
		return 
	end
	Holo.Info:RemoveInfoValue("ECM", self._unit:id())
end)
end