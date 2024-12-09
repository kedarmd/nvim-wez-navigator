local wezterm = require("wezterm")
local move = require("helpers/navigator").move

local M = {}

---@class Keymap
---@field key string
---@field mods string
---@field direction "Left" | "Right" | "Up" | "Down"

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
		keybindings.insert({
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
