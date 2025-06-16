if status is-interactive
    # Commands to run in interactive sessions can go here
end

# eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)

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
abbr -a gc 'git commit -am'
abbr -a gcm 'git checkout main'
abbr -a gco 'git checkout'
abbr -a gd 'git diff'
abbr -a gin 'clear && git status && echo && git log --oneline -10 && echo && git branch && echo && tokei src/'
abbr -a gitinfo 'git config --get user.name && git config --get user.email'
abbr -a gl 'git log --oneline'
abbr -a gms 'git merge --squash'
abbr -a gr 'git restore'
abbr -a gs 'git show'

abbr -a sc systemctl
abbr -a t tlbx
abbr -a tb tlbx
abbr -a tx tlbx
abbr -a c. 'code .'

abbr -a cgb 'cargo build'
abbr -a cg cargo
abbr -a cgc cargo check
abbr -a cgi 'cargo install --path .'
abbr -a cgr 'cargo run'
abbr -a cgt 'cargo test'
abbr -a ebands "e $HOME/.metal/bands.csv"
abbr -a el 'eza -l --group-directories-first --icons'
#abbr -a fd fdfind
abbr -a gi 'grep -i'
abbr -a hg 'history | grep -i'
abbr -a i3t i3timer
abbr -a lg 'll | grep -i'
abbr -a l "licht"

abbr -a et 'emacsclient -t'
abbr -a hx helix
abbr -a t. thunar .

abbr -a xc 'xclip -selection clipboard'

abbr -a lt 'll -t'
#abbr -a nf '~/my/scripts/nf.sh'
abbr -a nf "clear && fastfetch"
# by default, when in nnn, `e` opens a file with $VISUAL
abbr -a n "VISUAL='emacsclient -t' nnn"
abbr -a o. 'open .'
abbr -a pn protonvpn-cli
abbr -a pnc "protonvpn-cli ks --off && protonvpn-cli ks --permanent && protonvpn-cli c --protocol tcp --fastest"
abbr -a pwdc 'pwd | xclip -selection clipboard'
abbr -a rc rclone
abbr -a rd 'rm -rf'
abbr -a rl 'RUST_LOG=debug'
abbr -a ssa 'shasum --algorithm 256'
abbr -a ssc 'shasum --check'
abbr -a s "strava-rs"
abbr -a str "cat ~/my/archive/streams.md"
abbr -a st "strava-rs tui"
abbr -a tl 'tree -L'
abbr -a todo 'rg -i todo --stats'
abbr -a wt wttr
abbr -a zy zypper

abbr -a ytdlp-split-audio "yt-dlp --format ba[ext=m4a] --split-chapters URL"

abbr -a fp flatpak
abbr -a fpl flatpak list --app
abbr -a fpu flatpak update

abbr -a pm 'pacman -S'

if grep -q 'Debian GNU/Linux' /etc/os-release
    abbr -a up 'sudo apt update && sudo apt upgrade'
    # TODO move to another block
    alias bat batcat
    alias fd fdfind
else if grep -q 'Arch Linux' /etc/os-release
    abbr -a up 'sudo pacman -Syu'
#else if test -f /etc/SuSE-release
else if grep -q 'openSUSE Tumbleweed' /etc/os-release
    abbr -a up 'sudo zypper ref && sudo zypper dup'
else if grep -q 'Fedora' /etc/os-release
    abbr -a up 'sudo dnf upgrade --refresh'
else if grep -q 'Void' /etc/os-release
    abbr -a up 'sudo xbps-install -Su'
else
    abbr -a up 'Unknown distribution. Cannot install htop.'
end


if test -f /etc/arch-release
   abbr -a cu "checkupdates | sed 's/->//g' | column -t"
else
    abbr -a cu "(checkupdate) This system is probably not Arch"
end

# official example:                     ffmpeg                 -i input.wav -codec:a libmp3lame -qscale:a 2 output.mp3
abbr -a flac2mp3 'fdfind -e flac --exec ffmpeg -loglevel error -i {} -codec:a libmp3lame -qscale:a 1 {.}.mp3'

abbr -a vd vimdiff
abbr -a br bin/rails
abbr -a bk bin/kamal

abbr -a syncmoto-music "rsync -ahvP --stats '$HOME/mukke/' '/run/user/1000/gvfs/mtp:host=motorola_moto_g54_5G_ZY22HWD8XQ/Internal shared storage/Music/mukke/' --delete --omit-dir-times --no-perms --inplace --size-only --ignore-existing -n"
abbr -a syncmoto-pics "rsync -ahvP --stats '/run/user/1000/gvfs/mtp:host=motorola_moto_g54_5G_ZY22HWD8XQ/Internal shared storage/DCIM' '$HOME/sync/Moto/' -n"
abbr -a syncmoto-backup "rsync -ahvP --stats '/run/user/1000/gvfs/mtp:host=motorola_moto_g54_5G_ZY22HWD8XQ/Internal shared storage/backups' '$HOME/sync/Moto/' -n"

abbr -a sync-pixel-music "rsync -ahvP --stats '/nas/media/mukke/' '/run/user/1000/gvfs/mtp:host=Google_Pixel_6a_25281JEGR07582/Internal shared storage/Music/mukke/' --delete --omit-dir-times --no-perms --inplace --size-only --ignore-existing -n"

abbr -a sync-pixel-backup "rsync -ahvP --stats --no-g '/run/user/1000/gvfs/mtp:host=Google_Pixel_6a_25281JEGR07582/Internal shared storage/backup' '/nas/data/backup/pixel6a' -n"

abbr -a sync-pixel-pics "rsync -ahvP --stats --no-g '/run/user/1000/gvfs/mtp:host=Google_Pixel_6a_25281JEGR07582/Internal shared storage/DCIM' '/nas/data/backup/pixel6a' -n"


abbr -a restic-forget 'restic -r ~/MEGA/MEGAsync/linux-repo/ forget --keep-weekly 52'
abbr -a restic-snapshots 'restic -r ~/MEGA/MEGAsync/linux-repo/ snapshots'

abbr -a rgi 'rg -iN "'
abbr -a sup "strava-rs update"

abbr -a rcp 'rclone copy --progress'
abbr -a rct 'rclone tree --level 2'

abbr -a dcc '$HOME/scripts/bb/dict.cc.clj'

fish_add_path ~/.cargo/bin/
fish_add_path ~/.config/emacs/bin/
fish_add_path ~/go/bin
fish_add_path ~/.local/share/gem/ruby/3.3.0/bin/
fish_add_path ~/.gem/ruby/3.3.0/bin

# --export -x is the same
set -Ux RESTIC_PASSWORD_FILE "/home/ax/.restic-std"
set -g theme_color_scheme "nord"
# for "rails new" command:
# https://stackoverflow.com/questions/75391111/how-to-solve-bundlerpermissionerror-there-was-an-error-while-trying-to-write-t
set -Ux GEM_HOME $HOME/.gem

# when changing between abbr and alias, remove entry from `fish_variables` accordingly 
#abbr -a em 'emacsclient -t'
alias e "emacsclient -t"

export ALTERNATE_EDITOR=""
export EDITOR="emacsclient -t"                  # $EDITOR opens in terminal
# export VISUAL="emacsclient -c -a emacs"         # $VISUAL opens in GUI mode
export VISUAL="emacsclient -t"

export TERMINAL='alacritty'
export MAN_POSIXLY_CORRECT 1

export QT_QPA_PLATFORMTHEME="qt5ct"

set -Ux fish_greeting "" # disable default welcome message
set -Ux PAGER less

source ~/.config/fish/nnn.fish

starship init fish | source
zoxide init fish | source
