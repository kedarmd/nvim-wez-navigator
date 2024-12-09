local wezterm = require("wezterm")
local act = wezterm.action

---@class Keymap
---@field key string
---@field mods string
---@field direction "Left" | "Right" | "Up" | "Down"

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

local M = {}

---@type Keymap[]
local default_keymaps = {
	{ key = "h", mods = "CTRL", direction = "Left" },
	{ key = "j", mods = "CTRL", direction = "Down" },
	{ key = "k", mods = "CTRL", direction = "Up" },
	{ key = "l", mods = "CTRL", direction = "Right" },
}

---
---@param user_keymaps Keymap[] | nil
---@return table
function M.keybindings(user_keymaps)
	local keybindings = {}

	---@param keymap Keymap
	local function insert_to_keybindings(keymap)
		table.insert(keybindings, {
			key = keymap.key,
			mods = keymap.mods,
			action = wezterm.action_callback(function(window)
				move(window, keymap.direction, keymap.key, keymap.mods)
			end),
		})
	end

	if user_keymaps then
		for _, keymap in ipairs(user_keymaps) do
			insert_to_keybindings(keymap)
		end
	else
		for _, keymap in ipairs(default_keymaps) do
			insert_to_keybindings(keymap)
		end
	end
	return keybindings
end

return M
