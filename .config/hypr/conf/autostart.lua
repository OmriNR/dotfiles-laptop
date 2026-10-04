hl.on("hyprland.start", function ()
    local HOME = os.getenv("HOME")

    -- Read wallpaper app setting
    local wallpaper_app = "quickshell"
    local f = io.open(HOME .. "/.config/ml4w/settings/wallpaper-app", "r")
    if f then
        wallpaper_app = f:read("*l"):match("^%s*(.-)%s*$")
        f:close()
    end

    -- Export variables to systemd, start graphical-session.target (needed by the portals,
    -- e.g. for apps like Firefox to follow dark mode), then restart the portals in order
    hl.exec_cmd("sh -c 'dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP DISPLAY HYPRLAND_INSTANCE_SIGNATURE; systemctl --user start hyprland-session.target; systemctl --user reset-failed xdg-desktop-portal-gtk; systemctl --user stop xdg-desktop-portal xdg-desktop-portal-hyprland xdg-desktop-portal-gtk; systemctl --user start xdg-desktop-portal-hyprland xdg-desktop-portal-gtk xdg-desktop-portal'")

    -- awww daemon
    hl.exec_cmd("awww-daemon")

    -- Load cursor
    hl.exec_cmd("hyprctl setcursor Bibata-Modern-Ice 24")

    -- Start listeners
    hl.exec_cmd("~/.config/ml4w/listeners.sh --startall")

    -- Start waybar
    hl.exec_cmd(HOME .. "/.config/waybar/launch.sh")

    -- Start polkit daemon
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")

    -- Restore wallpaper (skip for quickshell — handled inside ml4w-autostart)
    if wallpaper_app ~= "quickshell" then
        hl.exec_cmd("~/.config/ml4w/scripts/ml4w-wallpaper-app --restore")
    end

    -- Autostart scripts
    hl.exec_cmd("~/.config/ml4w/scripts/ml4w-autostart > ~/.mydotfiles/ml4w-autostart.log 2>&1")

    -- Load GTK settings
    hl.exec_cmd("~/.config/hypr/scripts/gtk.sh")

    -- Start swaync
    hl.exec_cmd("swaync")

    -- Start hypridle
    hl.exec_cmd("hypridle")

    -- Load cliphist history
    hl.exec_cmd("wl-paste --watch cliphist store")

    -- Start autostart cleanup
    hl.exec_cmd("~/.config/hypr/scripts/cleanup.sh")
end)
