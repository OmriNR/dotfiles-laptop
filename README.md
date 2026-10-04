# dotfiles-laptop

Hyprland setup for Fedora 44: [ML4W dotfiles](https://github.com/mylinuxforwork/dotfiles) with the
[Caelestia](https://github.com/caelestia-dots/shell) shell, customized.

## Customizations

- **Fedora blue theme**: matugen uses a fixed color (`#51a2da`) instead of wallpaper colors
  (`.config/ml4w/scripts/ml4w-wallpaper`); Caelestia uses the `tokyonight` scheme.
- **Caelestia** draws only the left bar; its wallpaper layer is off so the ML4W wallpaper shows
  (`.config/caelestia/shell.json`).
- **ML4W dock and Waybar disabled** (`.config/ml4w/settings/dock.json`, `.config/ml4w/settings/waybar-disabled`).
- **Display scale 1.25** (`.config/hypr/monitors.lua`).
- **Super+Shift+W** opens the wallpaper picker, **Super+Ctrl+W** sets a random wallpaper.
- **Fedora logo** in fastfetch when a terminal opens.
- **Caelestia autostarts** after `ml4w-autostart` finishes (that script runs `killall qs`) — `.config/hypr/conf/autostart.lua`.
- **Super+L** locks the screen (in addition to Super+Ctrl+L).
- **English + Hebrew** keyboard layouts, switched with **Alt+Shift** (`.config/hypr/input.lua`).
- **Wallpaper menu** reads `~/Wallpapers` (`.config/ml4w/settings/wallpaper-folder`; the images aren't in this repo).
- **Dark mode for apps (Firefox etc.)**: `hyprland-session.target` starts `graphical-session.target`
  so the xdg-desktop-portals run under Hyprland (`.config/systemd/user/`, `.config/hypr/conf/autostart.lua`).

## Installing Caelestia on Fedora

```bash
sudo dnf copr enable errornointernet/quickshell
sudo dnf copr enable celestelove/libcava
sudo dnf copr enable celestelove/app2unit
sudo dnf copr enable celestelove/caelestia
sudo dnf install quickshell-git caelestia-shell caelestia-cli
caelestia scheme set -n tokyonight
```

Start it from Hyprland with `caelestia shell -d`.

## Restoring

This folder lives at `~/.mydotfiles/com.ml4w.dotfiles`; the folders in `~/.config` are symlinks into it
(`~/.config/hypr -> ../.mydotfiles/com.ml4w.dotfiles/.config/hypr`, etc.).
`~/.config/systemd/user/hyprland-session.target` is also a symlink into `.config/systemd/user/`.
