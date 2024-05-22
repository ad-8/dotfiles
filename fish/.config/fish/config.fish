if status is-interactive
    # Commands to run in interactive sessions can go here
end

# eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)

abbr -a cdc 'cd ~/code'
abbr -a cdd 'cd ~/dotfiles'
abbr -a cdj "cd ~/code/clojure"
abbr -a cdm 'cd /run/media/ax'
abbr -a cdM 'cd ~/MEGA/MEGAsync/'
abbr -a cdo 'cd ~/obsidian-vault'
abbr -a cdp 'cd ~/code/python/'
abbr -a cdr 'cd ~/code/rust'
abbr -a dl 'cd ~/Downloads'
abbr -a dot 'cd ~/.config'
abbr -a dt 'cd ~/Desktop/'

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
abbr -a gs 'git status'

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

abbr -a xc 'xclip -selection clipboard'

abbr -a lt 'll -t'
abbr -a nf '~/scripts/nf.sh'
# by default, when in nnn, `e` opens a file with $VISUAL
abbr -a n "VISUAL='vim' nnn -H"
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
abbr -a str "cat ~/archive/streams.md"
abbr -a st "strava-rs tui"
abbr -a tl 'tree -L'
abbr -a todo 'rg -i todo --stats'
abbr -a wt wttr
abbr -a zy zypper

abbr -a bi 'brew info'
abbr -a bin 'brew install'
abbr -a bs 'brew search'
abbr -a ai 'apt info'
abbr -a ain 'sudo apt install'
abbr -a upb 'brew update && brew upgrade'
abbr -a up 'sudo apt update && sudo apt upgrade'
abbr -a pm 'pacman -S'

abbr -a cu checkupdates

# official example:                     ffmpeg                 -i input.wav -codec:a libmp3lame -qscale:a 2 output.mp3
abbr -a flac2mp3 'fdfind -e flac --exec ffmpeg -loglevel error -i {} -codec:a libmp3lame -qscale:a 1 {.}.mp3'

abbr -a vd vimdiff

abbr -a syncmoto-music "rsync -ahvP --stats '$HOME/mukke/' '/run/user/1000/gvfs/mtp:host=motorola_moto_g54_5G_ZY22HWD8XQ/Internal shared storage/Music/mukke/' --delete --omit-dir-times --no-perms --inplace --size-only --ignore-existing -n"
abbr -a syncmoto-pics "rsync -ahvP --stats '/run/user/1000/gvfs/mtp:host=motorola_moto_g54_5G_ZY22HWD8XQ/Internal shared storage/DCIM' '$HOME/Sync/Moto/' -n"
abbr -a syncmoto-backup "rsync -ahvP --stats '/run/user/1000/gvfs/mtp:host=motorola_moto_g54_5G_ZY22HWD8XQ/Internal shared storage/backups' '$HOME/Sync/Moto/' -n"

abbr -a syncmov2 'rclone copy --progress /Volumes/Blackbeard5/media/movies/ sgefoo:movies/ -n'
abbr -a sync-local-only 'rsync -ahvP --delete --stats /Volumes/Blackbeard5/0-localsync/ /Volumes/AppleEnc/0-localsync/ -n'

abbr -a restic-forget 'restic -r ~/MEGA/MEGAsync/linux-repo/ forget --keep-weekly 52'
abbr -a restic-snapshots 'restic -r ~/MEGA/MEGAsync/linux-repo/ snapshots'

abbr -a backup-home "tar -cvzf $(date +'%Y-%m-%d_%H-%M-%S')_home.tar.gz ~/.config/ ~/.metal/ ~/.ssh/ ~/.strava-cli/ ~/Documents/ ~/Pictures/ ~/archive/ ~/code/ ~/dotfiles/ ~/notes/ ~/scripts/"

abbr -a fconf "hx ~/.config/fish/config.fish"
abbr -a es "exercism submit"
abbr -a sync-backup "rclone copy --progress /Volumes/Blackbeard5/0-localsync/backup/ b2e:backup/ -n"
abbr -a nt 'ntfy-cli -@ "test" -t "NTFY" -m "'

abbr -a xo "xdg-open"
abbr -a rgi 'rg -iN "'
abbr -a sup "strava-rs update"

abbr -a bt 'rclone tree b2e:'
abbr -a ce 'crontab -e'

abbr -a rcp 'rclone copy --progress'
abbr -a rct 'rclone tree --level 2'

abbr -a sync-music-before 'rsync -ahv --delete --progress --stats /Volumes/AppleEnc/music2k/0music-before-import/Music/ /Users/ax/Music/Music/ -n'
abbr -a syncmov 'rclone copy --progress /Volumes/Blackbeard5/media/movies-glacier-sync/ sge:mov -n'
abbr -a syncmusicb2e 'rclone copy --progress /Volumes/Blackbeard5/0-localsync/music2k/ b2e:music2k/ -n'
abbr -a synctv 'rclone copy --progress /Volumes/Blackbeard5/media/tvshows-glacier-sync/ sge3000:tv -n'
abbr -a synctv2 'rclone copy --progress /Volumes/Blackbeard5/tv2/ sgefoo:tv2/ -n'

fish_add_path ~/.cargo/bin/
fish_add_path ~/.config/emacs/bin/

# --export -x is the same
set -Ux RESTIC_PASSWORD_FILE "/home/ax/.restic-std"
set -g theme_color_scheme "nord"

# when changing between abbr and alias, remove entry from `fish_variables` accordingly 
#abbr -a em 'emacsclient -t'
alias e "emacsclient -t"

export ALTERNATE_EDITOR=""
export EDITOR="emacsclient -t"                  # $EDITOR opens in terminal
# export VISUAL="emacsclient -c -a emacs"         # $VISUAL opens in GUI mode
export VISUAL="emacsclient -t"

export TERMINAL='alacritty'

set -U fish_greeting ""
set -Ux PAGER less

source ~/.config/fish/nnn.fish
## Stuff that should be at the end
zoxide init fish | source

starship init fish | source
