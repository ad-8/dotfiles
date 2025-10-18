if status is-interactive
    # Commands to run in interactive sessions can go here
end

abbr -a cdc 'cd ~/my/code'
abbr -a cdd 'cd ~/my/dotfiles'
abbr -a cdj "cd ~/my/code/clojure"
abbr -a cdm 'cd /run/media/ax'
abbr -a cdM 'cd ~/MEGA/MEGAsync/'
abbr -a cdr 'cd ~/my/code/rust'
abbr -a dl 'cd ~/Downloads'
abbr -a dot 'cd ~/.config'

abbr -a ga 'git add'
abbr -a gb 'git branch'
abbr -a gca 'git commit --amend --no-edit'
abbr -a gc 'git commit -m'
abbr -a gcm 'git checkout main'
abbr -a gco 'git checkout'
abbr -a gd 'git diff'
abbr -a gin 'clear && git status && echo && git log --oneline -10 && echo && git branch && echo && tokei'
abbr -a gitinfo 'git config --get user.name && git config --get user.email'
abbr -a gl 'git log --oneline'
abbr -a gms 'git merge --squash'
abbr -a gr 'git restore'
abbr -a gs 'git status'
abbr -a gsw 'git show'

abbr -a sc systemctl
abbr -a t tlbx
abbr -a r tlbx commandrunner

if type -q code
   abbr -a c. 'code .'
else
   abbr -a c. 'codium .'
end

abbr -a rg 'rg -i'
abbr -a rb ruby

abbr -a ebands "e $HOME/.metal/bands.csv"
abbr -a el 'eza -l --group-directories-first --icons'
#abbr -a fd fdfind
abbr -a gi 'grep -i'
abbr -a hg 'history | grep -i'
abbr -a i3t i3timer
abbr -a l "licht"

abbr -a et 'emacsclient -t'
abbr -a hx helix
abbr -a t. thunar .
abbr -a cm chezmoi
abbr -a db distrobox

abbr -a xc 'xclip -selection clipboard'

abbr -a lt 'll -t'
#abbr -a nf '~/my/scripts/nf.sh'
# by default, when in nnn, `e` opens a file with $VISUAL
abbr -a n "VISUAL='emacsclient -t' nnn"
abbr -a o. 'open .'
abbr -a pn protonvpn-cli
abbr -a pnc "protonvpn-cli ks --off && protonvpn-cli ks --permanent && protonvpn-cli c --protocol tcp --fastest"
abbr -a rc rclone
abbr -a rd 'rm -rf'
abbr -a rl 'RUST_LOG=debug'
abbr -a ssa 'sha256sum'
abbr -a ssc 'sha256sum --check'
abbr -a s "strava-rs"
abbr -a str "cat ~/my/archive/streams.md"
abbr -a st "strava-rs tui"
abbr -a tl 'tree -L'
abbr -a todo 'rg -i todo --stats'
abbr -a wt wttr
abbr -a zy zypper
abbr -a vd vimdiff

if test "$XDG_SESSION_TYPE" = "wayland"
    abbr -a pwdc 'pwd | wl-copy'
else
    abbr -a pwdc 'pwd | xclip -selection clipboard'
end

abbr -a fp flatpak
abbr -a fpl flatpak list --app
abbr -a fpu flatpak update

abbr -a pm 'pacman -S'
abbr -a pmq 'pacman -Q'

# Extract the distro ID from /etc/os-release, removing any quotes
set distro (grep -oP '^ID=\K.*' /etc/os-release | tr -d '"')

switch $distro
    case debian ubuntu linuxmint
        abbr -a up 'sudo apt update && sudo apt upgrade'
        alias bat='batcat'
        alias fd='fdfind'
        abbr -a nf "clear && fastfetch"
    case arch
        abbr -a up 'sudo pacman -Syu'
        abbr -a nf "clear && fastfetch"
    case opensuse-tumbleweed
        abbr -a up 'sudo zypper ref && sudo zypper dup'
        abbr -a nf "clear && fastfetch --logo opensuse"
    case nixos
         abbr -a up "sudo nixos-rebuild switch --flake ~/dotfiles-nixos#$hostname"
         abbr -a nf "clear && fastfetch"
    case void
        abbr -a up 'sudo xbps-install -Su'
        abbr -a nf "clear && fastfetch"
    case fedora
        abbr -a up 'sudo dnf upgrade --refresh'
        abbr -a nf "clear && fastfetch"
    case '*'
        abbr -a up 'Unknown distribution. KEKW'
        abbr -a nf "clear && fastfetch"
end

switch $distro
    case arch
         #abbr -a cu "checkupdates | sed 's/->//g' | column -t"
         abbr -a cu $HOME/scripts/bb/checkupdates.clj
    case fedora
         abbr -a cu "dnf check-update --refresh | wc -l"
    case nixos
         abbr -a cu "cd ~/dotfiles-nixos/ && nix flake update && git status && printf '\n----------\n\n' && nixos-rebuild dry-run --flake ~/dotfiles-nixos#$hostname"
         abbr -a lg 'nixos-rebuild list-generations | head'
    case '*'
         abbr -a cu "(checkupdate) Don't know how to on $distro"
end

# official example:                     ffmpeg                 -i input.wav -codec:a libmp3lame -qscale:a 2 output.mp3
abbr -a flac2mp3 'fdfind -e flac --exec ffmpeg -loglevel error -i {} -codec:a libmp3lame -qscale:a 1 {.}.mp3'

abbr -a ytdlp-split-audio "yt-dlp --format ba[ext=m4a] --split-chapters URL"

abbr -a v vim
abbr -a br bin/rails
abbr -a bk bin/kamal
abbr -a ff rfv
abbr -a ffa rfvuuu

abbr -a cgb 'cargo build'
abbr -a cg cargo
abbr -a cgc cargo check
abbr -a cgi 'cargo install --path .'
abbr -a cgr 'cargo run'
abbr -a cgt 'cargo test'

abbr -a syncmoto-music "rsync -ahvP --stats '$HOME/mukke/' '/run/user/1000/gvfs/mtp:host=motorola_moto_g54_5G_ZY22HWD8XQ/Internal shared storage/Music/mukke/' --delete --omit-dir-times --no-perms --inplace --size-only --ignore-existing -n"
abbr -a syncmoto-pics "rsync -ahvP --stats '/run/user/1000/gvfs/mtp:host=motorola_moto_g54_5G_ZY22HWD8XQ/Internal shared storage/DCIM' '$HOME/sync/Moto/' -n"
abbr -a syncmoto-backup "rsync -ahvP --stats '/run/user/1000/gvfs/mtp:host=motorola_moto_g54_5G_ZY22HWD8XQ/Internal shared storage/backups' '$HOME/sync/Moto/' -n"

abbr -a sync-pixel-music "rsync -ahvP --stats '/nas/media/mukke/' '/run/user/1000/gvfs/mtp:host=Google_Pixel_6a_25281JEGR07582/Internal shared storage/Music/mukke/' --omit-dir-times --no-perms --inplace --size-only --ignore-existing -n"

abbr -a sync-pixel-backup "rsync -ahvP --stats --no-g '/run/user/1000/gvfs/mtp:host=Google_Pixel_6a_25281JEGR07582/Internal shared storage/backup' '/nas/data/backup/pixel6a' -n"

abbr -a sync-pixel-pics "rsync -ahvP --stats --no-g '/run/user/1000/gvfs/mtp:host=Google_Pixel_6a_25281JEGR07582/Internal shared storage/DCIM' '/nas/data/backup/pixel6a' -n"

abbr -a sup "strava-rs update"

abbr -a rcp 'rclone copy --progress'
abbr -a rct 'rclone tree --level 2'

abbr -a dcc '$HOME/scripts/bb/dict.cc.clj'

fish_add_path ~/.cargo/bin/
fish_add_path ~/.config/emacs/bin/
fish_add_path ~/.gem/ruby/3.4.0/bin
fish_add_path ~/.local/bin
fish_add_path ~/.local/share/gem/ruby/3.3.0/bin/
fish_add_path ~/go/bin

# --export -x is the same
set -Ux RESTIC_PASSWORD_FILE "/home/ax/.restic-std"
set -g theme_color_scheme "nord"
# for "rails new" command:
# https://stackoverflow.com/questions/75391111/how-to-solve-bundlerpermissionerror-there-was-an-error-while-trying-to-write-t

# before
#set -Ux GEM_HOME $HOME/.gem
#
# 2025-08
#
# use gems only from the current rbenv Ruby version to avoid permission issues with system gems
set ruby_prefix (rbenv prefix)
set -x GEM_HOME $ruby_prefix/lib/ruby/gems/3.4.0
set -x GEM_PATH $GEM_HOME

# when changing between abbr and alias, remove entry from `fish_variables` accordingly 
#abbr -a em 'emacsclient -t'
alias e "emacsclient -t"

export ALTERNATE_EDITOR=""
export EDITOR="vim"                               # $EDITOR opens in terminal
# export VISUAL="emacsclient -c -a emacs"         # $VISUAL opens in GUI mode
export VISUAL="vim"

export TERMINAL='alacritty'
export MAN_POSIXLY_CORRECT 1

export QT_QPA_PLATFORMTHEME="qt5ct"

set -Ux fish_greeting "" # disable default welcome message
set -Ux PAGER less

function insert_timestamp --description 'Insert literal date command'
    commandline -i '$(date +%Y%m%d-%H%M%S)'
end

bind ctrl-t insert_timestamp

source ~/.config/fish/nnn.fish

starship init fish | source
zoxide init fish | source

status --is-interactive; and rbenv init - --no-rehash fish | source
