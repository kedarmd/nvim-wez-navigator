local wezterm = require("wezterm")
local act = wezterm.action

---@param window unknown
---@param command unknown
---@param key string
---@param mods string
local function nvim_wez_nav(window, command, key, mods)
	local pane = window:active_pane()

	if not pane then
		wezterm.log_error("No active pane found.")
		return
	end
	local title = pane:get_title()
	if title == "nvim" then
		window:perform_action(act.SendKey({ key = key, mods = mods }), pane)
	else
		window:perform_action(command, pane)
	end
end

--- @param window unknown
--- @param direction "Left" | "Right" | "Up" | "Down"
--- @param key string
--- @param mods string
local move = function(window, direction, key, mods)
	nvim_wez_nav(window, act.ActivatePaneDirection(direction), key, mods)
end

return {
	move = move,
}
