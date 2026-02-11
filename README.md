# dots
all in one dotfiles repo, now also includes my nixos config in `nixos`,  
thanks to this `git subtree add --prefix=nixos https://github.com/ad-8/dotfiles-nixos master.`

## NixOS
Second time's the charm?


### GUI Installation with LUKS -> convert to this flake-based config
Install via Graphical ISO Image, which has a fast and easy Calamares installer 
with optional LUKS setup.

Tested with GNOME as DE in LiveDVD+Installation,  
(choose `GNOME` instead of `No desktop` in installer for easier WLAN setup before rebuild later)  
then converted to the OG flake-config like so:
1. Add line to `/etc/nixos/configuration.nix`:
```nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
```

Also add `git` and `vim` to `environment.systemPackages` for the next steps.

2. `sudo nixos-rebuild switch`

3. git clone *dotfiles*, *dotfiles-nixos* and *scripts*, then `cp /etc/nixos/hardware-configuration.nix ~/dotfiles-nixos/hosts/<host>/` 

4. if NOT using LUKS, skip this step  
    add this LUKS line from `/etc/nixos/configuration.nix` to `~/dotfiles-nixos/hosts/<host>/configuration.nix`  
    (or replace existing equivalent)

    `boot.initrd.luks.devices... = "/dev/disk/by-uuid/..."`

5. `sudo nixos-rebuild boot --flake ~/dotfiles-nixos#<host>` 

