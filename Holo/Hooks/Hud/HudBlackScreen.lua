Hooks:PostHook(HUDBlackScreen, "init", "HoloInit", function(self, hud)
	self._blackscreen_panel:rect({
		name = "bg",
		color = Holo:GetColor("Colors/MenuBackground"),
		layer = -1,
	})
    self._skip_circle._circle:hide()
    self._progress = self._blackscreen_panel:rect({
        name = "line",
		color = Holo:GetColor("Colors/Main"),
        h = 2,
    })
end)
Hooks:PostHook(HUDBlackScreen, "set_loading_text_status", "HoloSetLoadingTextStatus", function(self, status)
	if status then
		local loading_text = self._blackscreen_panel:child("loading_text")
		local skip_text = self._blackscreen_panel:child("skip_text")
		managers.hud:make_fine_text(skip_text)
		managers.hud:make_fine_text(loading_text)
		local w = (skip_text:visible() and skip_text:w() or loading_text:w()) + 8
		if status == "wait_for_peers" then
			local _, peer_status = managers.network:session():peer_streaming_status()
            self._progress:set_w(w * (peer_status / 100))
		elseif type(tonumber(status)) == "number" then
			self._progress:set_w(w * (tonumber(status) / 100))
		else
			self._progress:set_w(w)
		end
		self._progress:set_rightbottom(self._blackscreen_panel:w()- 4, self._blackscreen_panel:h() - 4)
		local x,y = self._progress:right() - 4, self._progress:bottom() - 4
		skip_text:set_rightbottom(x,y)
		loading_text:set_rightbottom(x,y)
	end
end)
function HUDBlackScreen:skip_circle_done()
	GUIAnim.play(self._blackscreen_panel:child("loading_text"), "y", self._progress:bottom(), 4)
	GUIAnim.play(self._blackscreen_panel:child("skip_text"), "y", self._progress:bottom(), 4)
	GUIAnim.play(self._blackscreen_panel:child("loading_text"), "h", 0, 4)
	GUIAnim.play(self._blackscreen_panel:child("skip_text"), "h", 0, 4, function() 
		GUIAnim.play(self._progress, "h", 0, 4)
	end)
end
 