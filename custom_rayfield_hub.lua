--[[
	Custom Rayfield hub template
	- Uses only the tab names + icon IDs you provided
	- No game features: every tab is an empty shell for your own elements
]]

-- Load the improved library from a local file, falling back to the official release
local Rayfield
do
	local ok, lib = pcall(function()
		return loadstring(readfile("rayfield_improved.lua"))()
	end)
	Rayfield = ok and lib or loadstring(game:HttpGet("https://sirius.menu/rayfield"))()
end

local Window = Rayfield:CreateWindow({
	Name = "My Hub",
	LoadingTitle = "My Hub",
	LoadingSubtitle = "Custom Rayfield",
	Theme = "Default",
	ToggleUIKeybind = "K",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "MyHub",
		FileName = "Config",
	},
	KeySystem = false,
})

-- Tabs (name, icon asset ID)
local Tabs = {
	Main          = Window:CreateTab("Main",          14456045412),
	Miscellaneous = Window:CreateTab("Miscellaneous", 7733920644),
	Teleports     = Window:CreateTab("Teleports",     10734949856),
	Players       = Window:CreateTab("Players",       118232317792968),
	GunMods       = Window:CreateTab("Gun Mods",      7733955511),
	Combat        = Window:CreateTab("Combat",        76224309982741),
	Visuals       = Window:CreateTab("Visuals",       9752605466),
	Utility       = Window:CreateTab("Utility",       103344771690872),
	Settings      = Window:CreateTab("Settings",      7734053491),
}

-- Placeholder content so each tab shows something. Replace with your own elements.
for name, tab in pairs(Tabs) do
	if name ~= "Settings" then
		tab:CreateSection(name)
		tab:CreateLabel("Add your elements to the " .. name .. " tab here.")
	end
end

-- Settings tab: only UI-level options
local Settings = Tabs.Settings
Settings:CreateSection("Interface")

Settings:CreateDropdown({
	Name = "Theme",
	Options = { "Default", "Ocean", "AmberGlow", "Light", "Amethyst", "Green", "Bloom", "DarkBlue", "Serenity" },
	CurrentOption = { "Default" },
	MultipleOptions = false,
	Flag = "UITheme",
	Callback = function(Options)
		Window.ModifyTheme(Options[1])
	end,
})

Settings:CreateButton({
	Name = "Test notification",
	Callback = function()
		Rayfield:Notify({
			Title = "My Hub",
			Content = "Notifications are working.",
			Duration = 4,
		})
	end,
})

Settings:CreateButton({
	Name = "Close hub",
	Callback = function()
		Rayfield:Destroy()
	end,
})

Rayfield:LoadConfiguration()
