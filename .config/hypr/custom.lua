-- Startup apps, each pinned to its own workspace.
-- The rules only apply during startup, so windows opened later go wherever you are.
local startup_apps = {
    { workspace = 1, class = "^(zen)$",                       cmd = "zen-browser" },
    { workspace = 2, class = "^(com.microsoft.VSCode|[Cc]ode)$", cmd = "code" },
    { workspace = 3, class = "^(md.obsidian.Obsidian|obsidian)$", cmd = "flatpak run md.obsidian.Obsidian" },
    { workspace = 4, class = "^(com.rtosta.zapzap|zapzap)$",      cmd = "flatpak run com.rtosta.zapzap" },
    { workspace = 5, class = "^([Ss]potify)$",                    cmd = "flatpak run com.spotify.Client" },
}

hl.on("hyprland.start", function ()
    local rules = {}
    for _, app in ipairs(startup_apps) do
        table.insert(rules, hl.window_rule({
            name = "startup-ws" .. app.workspace,
            match = {class = app.class},
            workspace = app.workspace .. " silent",
        }))
        hl.exec_cmd(app.cmd)
    end

    -- Drop the rules once everything has had time to open
    hl.timer(function ()
        for _, rule in ipairs(rules) do
            rule:set_enabled(false)
        end
    end, {timeout = 60000, type = "oneshot"})
end)

-- ---------- Glass ----------
hl.config({
    decoration = {
        active_opacity   = 0.92,  -- focused windows get a slight glass look
        inactive_opacity = 0.82,
        blur = {
            size     = 6,      -- softer frost (was 4)
            passes   = 3,      -- 3 passes is enough at size 6, and lighter on the GPU
            vibrancy = 0.2,
            popups   = true,   -- right-click menus and dropdowns get frosted too
        },
    },
})

-- Keep video and games fully solid (a see-through video looks wrong)
hl.window_rule({ match = { class = "^(mpv|vlc|steam_app_.*)$" }, opacity = "1.0 override 1.0 override" })