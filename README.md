# dotfiles
One big beautiful repository, now also including my NixOS config in `nixos`, thanks to this command:  
`git subtree add --prefix=nixos https://github.com/ad-8/dotfiles-nixos master.`

## symlink with GNU Stow
`stow -vR --target=$HOME *` or  
`stow -vR --target=$HOME niri/`

# NixOS
Second time's the charm?


## Installation with LUKS -> convert to flake-based config
Choose `GNOME` when booting the /Graphical ISO image/ (uses the Calamares installer) *and* choose `GNOME` instead of `No desktop` in the installer for an easy initial WiFi setup.

Then follow these simple steps:  
1. Add line to `/etc/nixos/configuration.nix`:
```nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
```

Also add `git` and `vim` to `environment.systemPackages` for the next steps.

2. `sudo nixos-rebuild switch`

3. git clone *ad-8/dotfiles*  and *ad-8/scripts*, then `cp /etc/nixos/hardware-configuration.nix ~/dotfiles/nixos/hosts/<host>/` 

4. if NOT using LUKS, skip this step  
    add this line from `/etc/nixos/configuration.nix` to `~/dotfiles/nixos/hosts/<host>/configuration.nix`  
    (or replace existing equivalent)

    `boot.initrd.luks.devices... = "/dev/disk/by-uuid/..."`

5. `sudo nixos-rebuild boot --flake ~/dotfiles/nixos#<host>` 

