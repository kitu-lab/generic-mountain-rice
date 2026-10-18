---------------------------------------------
------> KITU -- PLACEHOLDER FOR RICES <------
---------------------------------------------

---> IMPORTANT LOCALS
-- my programs
local terminal = "kitty" -- this is for my default terminal
local files = "dolphin" -- this is for my default file manager

-- my app launcher/menu
local launcher = "rofi -show drun -display-drun '' " -- command to execute launcher in desktop run mode

---> SCREEN SETTINGS
-- monitor
hl.monitor({
	output = "HDMI-A-1", -- monitor name
	mode = "1600x900@75", -- this is for setting up resolution and refresh rate
})
hl.monitor({
	output = "eDP-1", -- monitor name
	mode = "1280x720@60", -- also resolution and refresh rate
})
---> BINDING (long part)
-- some window rules
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind("SUPER + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind("SUPER + SHIFT + right", hl.dsp.window.move({ direction = "right" }))
hl.bind("SUPER + SHIFT + up", hl.dsp.window.move({ direction = "up" }))
hl.bind("SUPER + SHIFT + down", hl.dsp.window.move({ direction = "down" }))
hl.bind("SUPER + left", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + right", hl.dsp.focus({ direction = "right" }))
hl.bind("SUPER + up", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + down", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + V", hl.dsp.window.float(toggle, window))
hl.bind("SUPER + C", hl.dsp.window.close(window))
hl.bind("SUPER + F", hl.dsp.window.fullscreen(toggle, window))

-- keyboard layout haahhahahaahahahhahahahhahahaha
hl.config({
	input = {
		kb_layout = "br",
		kb_variant = "",
		repeat_delay = 300,
	},
})

-- hyprland canvas (plugin)
-- Canvas: pan (mouse binds)
hl.bind("SUPER + SHIFT + mouse:272", function()
	hl.exec_cmd("canvas-ctl pan-start")
end, { mouse = true })

hl.bind("SUPER + SHIFT + mouse:272", function()
	hl.exec_cmd("canvas-ctl pan-stop")
end, { mouse = true, release = true })

-- Canvas: edge-scroll (drag window to screen edge → camera follows)
hl.bind("SUPER + mouse:272", function()
	hl.dispatch(hl.dsp.window.drag())
	hl.exec_cmd("canvas-ctl edge-start")
end, { mouse = true })

hl.bind("SUPER + mouse:272", function()
	hl.exec_cmd("canvas-ctl edge-stop")
end, { mouse = true, release = true })

-- Canvas: center view on the floating window under the cursor
hl.bind("SUPER + mouse:274", hl.dsp.exec_cmd("canvas-ctl center-cursor"), { mouse = true })

-- Canvas: navigation (4-dir spatial)
hl.bind("SUPER + SHIFT + left", hl.dsp.exec_cmd("canvas-ctl nav-left"))
hl.bind("SUPER + SHIFT + right", hl.dsp.exec_cmd("canvas-ctl nav-right"))
hl.bind("SUPER + SHIFT + up", hl.dsp.exec_cmd("canvas-ctl nav-up"))
hl.bind("SUPER + SHIFT + down", hl.dsp.exec_cmd("canvas-ctl nav-down"))

-- Canvas: toggle & invert
hl.bind("SUPER + SHIFT + C", hl.dsp.exec_cmd("canvas-ctl canvas-toggle"))
hl.bind("SUPER + SHIFT + V", hl.dsp.exec_cmd("canvas-ctl canvas-toggle-single"))
hl.bind("SUPER + SHIFT + G", hl.dsp.exec_cmd("canvas-ctl toggle"))

-- workspaces (small script)
-- yes i stole it i know
-- im sorry
-- like im so sorry
-- okay
-- again im sorry
for i = 1, 10 do
	local key = i % 10
	hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- some programs
hl.bind("SUPER + H", hl.dsp.exec_cmd("hyprpicker --autocopy"))
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m region -z"))
hl.bind("SUPER + PRINT", hl.dsp.exec_cmd("hyprshot -m output -z"))
hl.bind("SUPER + E", hl.dsp.exec_cmd(files))
hl.bind("SUPER + Q", hl.dsp.exec_cmd(terminal))
hl.bind("SUPER + R", hl.dsp.exec_cmd(launcher))
hl.bind("SUPER + J", hl.dsp.layout("togglesplit"))

-- exit hyprland
hl.bind(
	"SUPER + SHIFT + E",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
) -- goodnight hyprland

---> COMPOSITOR SETTINGS
-- hyprland layout
hl.config({
	general = {
		layout = "dwindle",
	},
})
hl.config({
	dwindle = {
		preserve_split = true,
	},
})

-- wayland
-- 🚨🚨🚨 VERY ESSENTIAL LIKE HOLY ESSENTIAL OH MY GOD 🚨🚨🚨
hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})
-- 🚨🚨🚨 YES VERY ESSENTIAL NEVER FORGET NEVER FORGET 🚨🚨🚨
hl.layer_rule({
	name = "rofi",
	blur = false,
	match = {
		namespace = "rofi",
	},
	animation = "slide",
})

-- decorations (fun part)
hl.config({
	general = {
		border_size = 1,
		gaps_in = 3,
		gaps_out = 15,
		col = {
			active_border = {
				colors = { "rgb(ffff8d)" },
			},
			inactive_border = {
				colors = { "rgb(04070f)" },
			},
		},
	},
	decoration = {
		rounding = 0,
		blur = {
			enabled = false,
			passes = 3,
		},
		shadow = {
			enabled = false,
		},
	},
})

---> AUTOSTART
hl.on("hyprland.start", function()
	hl.exec_cmd("swaybg -i wallpapers/mountain.jpg & waybar")
end)

---> ANIMATIONS (not so fun part)
-- config
hl.config({
	animations = {
		enabled = true,
	},
})

-- bezier curves (not that hard tbh. edit: forget about im LARPING WAAAAAAA)
hl.curve("easeOut", { -- my favorite, use it on everything
	type = "bezier",
	points = {
		{ 0, 0.96 },
		{ 0.31, 0.97 },
	},
})
hl.curve("easeOutRebound", { -- so bouncy so yummy
	type = "bezier",
	points = {
		{ 0, 0.94 },
		{ 0.6, 1.16 },
	},
})
hl.curve("easeInOut", { -- it's tolerable
	type = "bezier",
	points = {
		{ 0.645, 0.045 },
		{ 0.355, 1 },
	},
})

-- setting up the tree i think I DONT KNOW WHAT AM I DOING IM SORRY
hl.animation({ leaf = "workspaces", enabled = true, speed = 7, bezier = "easeOut", style = "slidefade 20%" })
hl.animation({ leaf = "windows", enabled = true, speed = 3, bezier = "easeOut", style = "popinfade 20%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 5, bezier = "easeOutRebound", style = "slide" })
hl.animation({ leaf = "layers", enabled = true, speed = 5, bezier = "easeOut", style = "fade" })

-- ok thats it byee
