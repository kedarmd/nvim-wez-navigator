local wezterm = require("wezterm")
local act = wezterm.action
local nvim_wez_nav = require("helpers/navigator").nvim_wez_nav

local M = {}

function M.keybindings()
	local keybindings = {
		{
			key = "h",
			mods = "CTRL",
			action = wezterm.action_callback(function(window)
				nvim_wez_nav(window, act.ActivatePaneDirection("Left"), "h", "CTRL")
			end),
		},
		{
			key = "j",
			mods = "CTRL",
			action = wezterm.action_callback(function(window)
				nvim_wez_nav(window, act.ActivatePaneDirection("Down"), "j", "CTRL")
			end),
		},
		{
			key = "k",
			mods = "CTRL",
			action = wezterm.action_callback(function(window)
				nvim_wez_nav(window, act.ActivatePaneDirection("Up"), "k", "CTRL")
			end),
		},
		{
			key = "l",
			mods = "CTRL",
			action = wezterm.action_callback(function(window)
				nvim_wez_nav(window, act.ActivatePaneDirection("Right"), "l", "CTRL")
			end),
		},
	}
	return keybindings
end

return M
