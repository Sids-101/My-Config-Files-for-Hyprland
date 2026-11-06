
-- ==========================================
-- HYPRLAND LUA CONFIGURATION
-- Converted from original hyprland.conf
-- ==========================================

local mod = "SUPER"

-- ==========================================
-- NVIDIA ENVIRONMENT VARIABLES
-- ==========================================

-- Uncomment if needed:
-- hl.env("NVD_BACKEND", "direct")

hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")

-- ==========================================
-- CURSOR SETTINGS
-- ==========================================

hl.config({
    cursor = {
        no_hardware_cursors = 1,
    },
})

-- ==========================================
-- MONITOR SETTINGS
-- ==========================================

hl.monitor({
    output = "eDP-1",
    mode = "1920x1080@144",
    position = "0x0",
    scale = 1,
})

-- ==========================================
-- INPUT SETTINGS
-- ==========================================

hl.config({
    input = {
        kb_layout = "us",
        numlock_by_default = true,
        accel_profile = "flat",
        sensitivity = 0.5,

        touchpad = {
            natural_scroll = false,
            scroll_factor = 1.0,
            tap_to_click = true,
            drag_lock = true,
        },
    },
})

-- ==========================================
-- TOUCHPAD GESTURES
-- ==========================================

hl.gesture({
    fingers = 4,
    direction = "horizontal",
    action = "workspace",
})

-- ==========================================
-- GENERAL SETTINGS
-- ==========================================

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 5,
        border_size = 2,

        col = {
            active_border = {
                colors = {
                    "rgba(33ccffee)",
                    "rgba(00ff99ee)",
                },
                angle = 45,
            },

            inactive_border = "rgba(595959aa)",
        },
    },
})

-- ==========================================
-- MISC SETTINGS
-- ==========================================

hl.config({
    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        mouse_move_enables_dpms = true,
        key_press_enables_dpms = true,
    },
})

-- ==========================================
-- WORKSPACE RULES
-- ==========================================

-- Workspace 1 is the default workspace.
-- All nine workspaces are assigned to eDP-1.

for i = 1, 9 do
    hl.workspace_rule({
        workspace = tostring(i),
        monitor = "eDP-1",
        default = (i == 1),
    })
end

-- ==========================================
-- STARTUP APPLICATIONS
-- ==========================================

hl.on("hyprland.start", function()

    -- Numlock
    hl.exec_cmd("numlock on")

    -- System tray
    hl.exec_cmd("nm-applet")

    -- Waybar
    hl.exec_cmd("waybar")

    -- KDE Polkit authentication agent
    hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")

    -- Wallpaper daemon and wallpaper
    hl.exec_cmd(
        "awww-daemon && sleep 1 && awww img /home/sid/Pictures/Wallpapers/DontTreadOnMe.jpg"
    )

    -- Switch to workspace 1
    hl.dispatch(hl.dsp.focus({
        workspace = "1",
    }))

    -- Ensure monitor is awake
    hl.exec_cmd("hyprctl dispatch dpms on eDP-1")

    -- Launch applications silently on workspace 1
    hl.exec_cmd("kitty", {
        workspace = "1 silent",
    })

    hl.exec_cmd("firefox", {
        workspace = "1 silent",
    })

end)

-- ==========================================
-- WORKSPACE SWITCHING
-- ==========================================

for i = 1, 9 do
    hl.bind(
        mod .. " + " .. tostring(i),
        hl.dsp.focus({
            workspace = tostring(i),
        })
    )
end

-- ==========================================
-- KEYBINDINGS
-- ==========================================

-- Rofi application launcher
hl.bind(
    "SUPER + SPACE",
    hl.dsp.exec_cmd(
        "rofi -show drun -theme ~/.config/rofi/themes/squared-nord.rasi"
    )
)

-- Reload configuration
hl.bind(
    "SUPER + SHIFT + R",
    hl.dsp.reload_config()
)

-- Close active window
hl.bind(
    "SUPER + SHIFT + M",
    hl.dsp.window.close()
)

hl.bind(
    mod .. " + Q",
    hl.dsp.window.close()
)

-- Open terminal
hl.bind(
    mod .. " + RETURN",
    hl.dsp.exec_cmd("kitty")
)

-- Toggle floating
hl.bind(
    mod .. " + T",
    hl.dsp.window.float()
)

-- Toggle fullscreen
hl.bind(
    mod .. " + F",
    hl.dsp.window.fullscreen()
)

-- Random wallpaper
hl.bind(
    "SUPER + R",
    hl.dsp.exec_cmd("/home/sid/Scripts/random_wallpaper.sh")
)

-- ==========================================
-- RESIZE FLOATING WINDOWS
-- ==========================================

hl.bind(
    "SUPER + SHIFT + LEFT",
    hl.dsp.window.resize({
        x = -10,
        y = 0,
        relative = true,
    })
)

hl.bind(
    "SUPER + SHIFT + RIGHT",
    hl.dsp.window.resize({
        x = 10,
        y = 0,
        relative = true,
    })
)

hl.bind(
    "SUPER + SHIFT + UP",
    hl.dsp.window.resize({
        x = 0,
        y = -10,
        relative = true,
    })
)

hl.bind(
    "SUPER + SHIFT + DOWN",
    hl.dsp.window.resize({
        x = 0,
        y = 10,
        relative = true,
    })
)

-- ==========================================
-- MOVE WINDOWS TO WORKSPACES
-- ==========================================

for i = 1, 9 do
    hl.bind(
        "SUPER + SHIFT + " .. tostring(i),
        hl.dsp.window.move({
            workspace = tostring(i),
        })
    )
end

-- ==========================================
-- WINDOW FOCUS
-- ==========================================

hl.bind(
    "SUPER + LEFT",
    hl.dsp.focus({ direction = "left" })
)

hl.bind(
    "SUPER + RIGHT",
    hl.dsp.focus({ direction = "right" })
)

hl.bind(
    "SUPER + UP",
    hl.dsp.focus({ direction = "up" })
)

hl.bind(
    "SUPER + DOWN",
    hl.dsp.focus({ direction = "down" })
)

-- ==========================================
-- SWAP WINDOWS
-- ==========================================

hl.bind(
    "SUPER + ALT + LEFT",
    hl.dsp.window.swap({ direction = "left" })
)

hl.bind(
    "SUPER + ALT + RIGHT",
    hl.dsp.window.swap({ direction = "right" })
)

hl.bind(
    "SUPER + ALT + UP",
    hl.dsp.window.swap({ direction = "up" })
)

hl.bind(
    "SUPER + ALT + DOWN",
    hl.dsp.window.swap({ direction = "down" })
)

-- ==========================================
-- WLOGOUT
-- ==========================================

hl.bind(
    "SUPER + L",
    hl.dsp.exec_cmd("wlogout")
)

-- ==========================================
-- MOUSE BINDS
-- ==========================================

hl.bind(
    "SUPER + mouse:272",
    hl.dsp.window.drag(),
    { mouse = true }
)

hl.bind(
    "SUPER + mouse:273",
    hl.dsp.window.resize(),
    { mouse = true }
)

-- ==========================================
-- LID SWITCH HANDLING
-- ==========================================

hl.bind(
    "switch:on:Lid Switch",
    hl.dsp.exec_cmd("hyprctl dispatch dpms off"),
    { locked = true }
)

hl.bind(
    "switch:off:Lid Switch",
    hl.dsp.exec_cmd("hyprctl dispatch dpms on eDP-1"),
    { locked = true }
)



-- ==========================================
-- ANIMATION SETTINGS
-- ==========================================

hl.curve("myBezier", {
    type = "bezier",
    points = {
        { 0.05, 0.9 },
        { 0.1, 1.05 },
    },
})

hl.curve("closeEase", {
    type = "bezier",
    points = {
        { 0.4, 0.0 },
        { 0.2, 1.0 },
    },
})

-- General window animations
hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 5,
    bezier = "myBezier",
})

-- Opening windows
hl.animation({
    leaf = "windowsIn",
    enabled = true,
    speed = 5,
    bezier = "myBezier",
    style = "popin 90%",
})

-- Closing windows
hl.animation({
    leaf = "windowsOut",
    enabled = true,
    speed = 5,
    bezier = "closeEase",
})

-- Window movement
hl.animation({
    leaf = "windowsMove",
    enabled = true,
    speed = 5,
    bezier = "myBezier",
})

-- Border
hl.animation({
    leaf = "border",
    enabled = true,
    speed = 10,
    bezier = "default",
})

-- Workspaces
hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 6,
    bezier = "myBezier",
})



-- ==========================================
-- DECORATION SETTINGS
-- ==========================================

hl.config({
    decoration = {
        rounding = 10,

        blur = {
            enabled = true,
            size = 4,
            passes = 1,
        },
    },
})
