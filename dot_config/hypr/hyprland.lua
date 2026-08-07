local dragonYellow = "rgb(c4b28a)"
local sumiInk3 = "rgb(1f1f28)"
local dragonRed = "rgb(c4746e)"

hl.config({
	general = {
		layout = "scrolling",
		allow_tearing = true,
		gaps_in = 2,
		gaps_out = 5,
		border_size = 2,
		col = {
			active_border = dragonYellow,
			inactive_border = sumiInk3,
		},
	},
	decoration = {
		rounding = 10,
		rounding_power = 2.0,
	},
	scrolling = {
		fullscreen_on_one_column = false,
		wrap_focus = false,
		wrap_swapcol = false,
	},
	input = {
		accel_profile = "flat",
		sensitivity = 0,
	},
	cursor = {
		no_hardware_cursors = 1,
	},
	misc = {
		enable_swallow = true,
		swallow_regex = "^ghostty$",
		vrr = 3,
		disable_hyprland_logo = true,
	},
	ecosystem = {
		no_update_news = true,
		no_donation_nag = true,
	},
})

--- Monitors

local primary = "DP-1"
local secondary = "DP-4"
local tv = "HDMI-A-1"

hl.monitor({
	output = primary,
	mode = "3440x1440@120",
	position = "0x0",
	scale = "1",
})

hl.monitor({
	output = secondary,
	mode = "2560x1440@60",
	position = "-1440x-620",
	scale = "1",
	transform = 3,
})

hl.monitor({
	disabled = true,
	output = tv,
	mode = "3840x2160@120",
	position = "3840x0",
	scale = "2",
})

--- Binds

local mainMod = "SUPER"
local uwsm = "uwsm app -- "
local noctalia = "noctalia msg "

hl.bind(mainMod .. " + escape", hl.dsp.exec_cmd("hyprctl kill"))
hl.bind(mainMod .. " + q", hl.dsp.window.close())
hl.bind(mainMod .. " + s", hl.dsp.exec_cmd(noctalia .. "panel-open session"))

hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + h", hl.dsp.layout("swapcol l"))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.layout("swapcol r"))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.layout("swapcol r"))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.layout("swapcol l"))
hl.bind(mainMod .. " + equal", hl.dsp.layout("colresize +conf"))
hl.bind(mainMod .. " + minus", hl.dsp.layout("colresize -conf"))
hl.bind(mainMod .. " + SHIFT + 1", hl.dsp.window.move({ monitor = primary }))
hl.bind(mainMod .. " + SHIFT + 2", hl.dsp.window.move({ monitor = secondary }))
hl.bind(mainMod .. " + ALT + 1", hl.dsp.focus({ workspace = "1" }))
hl.bind(mainMod .. " + ALT + 2", hl.dsp.focus({ workspace = "2" }))
hl.bind(mainMod .. " + ALT + 0", hl.dsp.focus({ workspace = "name:gaming" }))
hl.bind("ALT + tab", hl.dsp.window.cycle_next())

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag()) -- left click
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize()) -- right click

hl.bind(mainMod .. " + t", hl.dsp.exec_cmd(uwsm .. "ghostty"))
hl.bind(mainMod .. " + b", hl.dsp.exec_cmd(uwsm .. "chromium"))
hl.bind(mainMod .. " + e", hl.dsp.exec_cmd(uwsm .. "dolphin"))
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd(noctalia .. "panel-toggle launcher"))
hl.bind(mainMod .. " + comma", hl.dsp.exec_cmd(noctalia .. "settings-toggle"))
hl.bind(mainMod .. " + tab", hl.dsp.exec_cmd(noctalia .. "window-switcher"))
hl.bind(mainMod .. " + SHIFT + s", hl.dsp.exec_cmd(noctalia .. "screenshot-region"))
hl.bind(mainMod .. " + SHIFT + space", hl.dsp.exec_cmd(uwsm .. "1password --quick-access"))
hl.bind("CONTROL + SHIFT + escape", hl.dsp.exec_cmd(uwsm .. "ghostty -e btop"))

--- Autostart

hl.on("hyprland.start", function()
	hl.exec_cmd("dbus-update-activation-environment --systemd --all")
	hl.exec_cmd("noctalia")
	hl.exec_cmd("xhost +SI:localuser:root")
end)

--- Workspaces

hl.workspace_rule({
	workspace = "1",
	monitor = primary,
	default = true,
	persistent = true,
})

hl.workspace_rule({
	workspace = "2",
	monitor = secondary,
	default = true,
	persistent = true,
	layout_opts = { direction = "down" },
})

hl.workspace_rule({
	workspace = "3",
	monitor = "HDMI-A-1",
	default = true,
	persistent = true,
})

hl.workspace_rule({
	workspace = "name:gaming",
	monitor = primary,
	persistent = true,
})

-- Auto-return to workspace 1 when the gaming workspace empties
hl.on("window.close", function(win)
	if win.workspace and win.workspace.name == "gaming" then
		hl.timer(function()
			local ws = hl.get_workspace("name:gaming")
			if ws and ws.is_empty then
				hl.dispatch(hl.dsp.focus({ workspace = "1" }))
			end
		end, { timeout = 100, type = "oneshot" })
	end
end)

--- Window rules

hl.window_rule({
	match = { content = "game" },
	workspace = "name:gaming",
})

hl.window_rule({
	match = { class = "^steam_app.*$" },
	workspace = "name:gaming",
})

hl.window_rule({
	match = {
		class = "steam",
		title = "Friends List",
	},
	float = true,
})

hl.window_rule({
	match = {
		class = "^steam_app.*$",
	},
	content = "game",
	decorate = false,
	fullscreen_state = 2,
	immediate = true,
})

-- GW2 launcher
hl.window_rule({
	match = {
		class = "^steam_app_1284210$",
		initial_title = "^Guild Wars 2$",
	},
	float = true,
	center = true,
	fullscreen = false,
	fullscreen_state = 0,
	decorate = false,
	no_blur = true,
})

hl.window_rule({
	match = { class = "discord" },
	monitor = secondary,
})

hl.window_rule({
	match = { class = "dev.noctalia.Noctalia" },
	float = true,
	size = { 1080, 920 },
})

hl.window_rule({
	match = { title = "satty" },
	float = true,
	size = { "monitor_w*0.70", "monitor_h*0.70" },
})

hl.window_rule({
	match = { class = "org.kde.dolphin" },
	float = true,
})

hl.window_rule({
	match = { class = "hyprland-share-picker" },
	float = true,
})
