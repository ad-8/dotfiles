if status is-interactive
    # Commands to run in interactive sessions can go here
end
eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
abbr -a cgc cargo check
abbr -a cdb 'cd /Volumes/Blackbeard5'
abbr -a cgb 'cargo build'
abbr -a syncmov2 'rclone copy --progress /Volumes/Blackbeard5/media/movies/ sgefoo:movies/ -n'
abbr -a sync-local-only 'rsync -ahvP --delete --stats /Volumes/Blackbeard5/0-localsync/ /Volumes/AppleEnc/0-localsync/ -n'
abbr -a rl 'RUST_LOG=debug'
abbr -a s "strava-rs"
abbr -a st "strava-rs tui"
abbr -a fconf "hx ~/.config/fish/config.fish"
abbr -a es "exercism submit"
abbr -a cdj "cd ~/code/clojure"
abbr -a sync-backup "rclone copy --progress /Volumes/Blackbeard5/0-localsync/backup/ b2e:backup/ -n"
abbr -a nt 'ntfy-cli -@ "test" -t "NTFY" -m "'

abbr -a syncmoto "rsync -ahvP --stats '/media/ax/wd2b/0-localsync/mukke/' '/run/user/1000/gvfs/mtp:host=motorola_moto_g54_5G_ZY22HWD8XQ/Internal shared storage/Music/mukke/' --delete --omit-dir-times --no-perms --inplace --size-only --ignore-existing -n
"


abbr -a i3t i3timer
abbr -a ser 'xdg-open ~/Documents/serien2020.ods'
abbr -a cm chezmoi
abbr -a xo "xdg-open"
abbr -a rgi 'rg -iN "'
abbr -a sup "strava-rs update"
abbr -a str "cat ~/backup/streams.md"
abbr -a cds "cd ~/.strava-cli"
abbr -a pnk "protonvpn-cli ks --off && protonvpn-cli ks --on"
abbr -a pnc "protonvpn-cli ks --off && protonvpn-cli ks --permanent && protonvpn-cli c --protocol tcp --fastest"
abbr -a wt wttr
abbr -a plotw "cd $HOME/code/clojure/wttr && lein run && open wttr.html && prevd"
abbr -a plotb "java -jar $HOME/code/clojure/berge/target/berge-0.1.0-SNAPSHOT-standalone.jar"
abbr -a cs "sudo cryptsetup"
abbr -a l "licht"
abbr -a ebands "hx $HOME/.metal/bands.csv"
abbr -a gin 'clear && git status && echo && git log --oneline -10 && echo && git branch && echo && tokei src/'


abbr -a bi 'brew info'
abbr -a bin 'brew install'
abbr -a bs 'brew search'
abbr -a bt 'rclone tree b2e:'
abbr -a cda 'cd /Volumes/AppleEnc'
abbr -a cdc 'cd ~/code'
abbr -a cdo 'cd ~/obsidian-vault'
abbr -a cdg 'cd ~/code/golang/'
abbr -a cdi 'cd "/Users/ax/Library/Mobile Documents/com~apple~CloudDocs/"'
abbr -a cdM 'cd ~/MEGAsync/'
abbr -a cdm 'cd /media/ax'
abbr -a cdp 'cd ~/code/python/'
abbr -a cdr 'cd ~/code/rust'
abbr -a cdt 'cd /Volumes/TimeMachine/'
abbr -a ce 'crontab -e'
abbr -a c clear
abbr -a cg cargo
abbr -a cgi 'cargo install --path .'
abbr -a cgr 'cargo run'
abbr -a cgt 'cargo test'
abbr -a checkLib 'du -hs ~/Library/* | sort -hr | grep -E "(^[0-9]+,[0-9]+G|[0-9]{3}M)"'
abbr -a checkSpace '~/code/scripts_sh/check-caches.sh'
abbr -a cl 'crontab -l | bat'
abbr -a db 'cd ~/Dropbox'
abbr -a dl 'cd ~/Downloads'
abbr -a dot 'cd ~/.config'
abbr -a dt 'cd ~/Desktop/'
abbr -a el 'eza -l --group-directories-first --icons'
abbr -a eur 'python3 ~/code/scripts_py/list-remotes.py'
# official example:                     ffmpeg                 -i input.wav -codec:a libmp3lame -qscale:a 2 output.mp3
abbr -a flac2mp3 'fdfind -e flac --exec ffmpeg -loglevel error -i {} -codec:a libmp3lame -qscale:a 1 {.}.mp3'
abbr -a forget 'restic -r ~/MEGAsync/linux-repo/ forget --keep-weekly 52'
abbr -a ga 'git add'
abbr -a gb 'git branch'
abbr -a gc 'git commit -am'
abbr -a gca 'git commit --amend --no-edit'
abbr -a gcm 'git checkout main'
abbr -a gco 'git checkout'
abbr -a gd 'git diff'
abbr -a gi 'grep -i'
abbr -a gitinfo 'git config --get user.name && git config --get user.email'
abbr -a gl 'git log --oneline'
abbr -a gmi 'go mod init github.com/ad-8/'
abbr -a gms 'git merge --squash'
abbr -a gob 'go build'
abbr -a gocov 'go test -coverprofile=c.out'
abbr -a gocov2 'go tool cover -func=c.out'
abbr -a goi 'go install'
abbr -a gr 'git restore'
abbr -a gs 'git status'
abbr -a hg 'history | grep -i'
abbr -a is 'go install && mv ~/go/bin/strava-cli ~/go/bin/s'
abbr -a java-show '/usr/libexec/java_home -V'
abbr -a lg 'll | grep -i'
abbr -a lt 'll -t'
abbr -a n nnn
abbr -a nb newsboat
abbr -a o. 'open .'
abbr -a of 'open -a "Firefox"'
abbr -a ob 'open -a "Brave Browser"'
abbr -a oc 'open -a "Visual Studio Code"'
abbr -a og 'open -a "GitHub Desktop"'
abbr -a oi 'open -a "IntelliJ Idea"'
abbr -a os 'open -a Safari'
abbr -a ov 'open -a VLC'
abbr -a pir 'cat ~/backup/streams.md'
abbr -a pwdc 'pwd | xclip -selection clipboard'
abbr -a py python
abbr -a rc rclone
abbr -a rcp 'rclone copy --progress'
abbr -a rct 'rclone tree --level 2'
abbr -a rd 'rm -rf'
abbr -a rsdry 'rsync -ahvPn ~/Downloads/youtube_music_videos/ alex@192.168.2.160:/home/alex/Desktop/youtube_music_videos/ --delete'
abbr -a rsfoo 'rsync -ahv --delete --progress --stats foo/ bar/ -n'
abbr -a ruby /usr/local/opt/ruby/bin/ruby
abbr -a rsn 'restic -r ~/MEGAsync/linux-repo/ snapshots'
abbr -a ssa 'shasum --algorithm 256'
abbr -a ssc 'shasum --check'
abbr -a start 'yabai --start-service'
abbr -a stop 'yabai --stop-service'
abbr -a sync-music-before 'rsync -ahv --delete --progress --stats /Volumes/AppleEnc/music2k/0music-before-import/Music/ /Users/ax/Music/Music/ -n'
abbr -a syncmov 'rclone copy --progress /Volumes/Blackbeard5/media/movies-glacier-sync/ sge:mov -n'
abbr -a syncmusicb2e 'rclone copy --progress /Volumes/Blackbeard5/0-localsync/music2k/ b2e:music2k/ -n'
abbr -a synctv 'rclone copy --progress /Volumes/Blackbeard5/media/tvshows-glacier-sync/ sge3000:tv -n'
abbr -a synctv2 'rclone copy --progress /Volumes/Blackbeard5/tv2/ sgefoo:tv2/ -n'
abbr -a tl 'tree -L'
abbr -a todo 'rg -i todo --stats'
abbr -a fixme 'rg -i fixme --stats'
abbr -a up 'sudo apt update && sudo apt upgrade'
abbr -a upb 'brew update && brew upgrade'
abbr -a utun 'ifconfig | grep -A 2 utun'
abbr -a vd vimdiff

# echo "-- config.fish --"

set -g fish_user_paths "/usr/local/sbin" $fish_user_paths
# Color scheme for oh-my-fish theme "bobthefish"
set -g theme_color_scheme "nord"

# "adding ~/go/bin to PATH"
# set -gx PATH ~/go/bin $PATH
# set -gx PATH ~/.cargo/bin $PATH

#set -gx PATH ~/code/scripts/bb/src $PATH

#status --is-interactive; and rbenv init - fish | source
#set -gx EDITOR hx
#set -gx VISUAL hx

# helix rust needs this now
# set -x PATH (brew --prefix)/opt/llvm/bin $PATH


# alias ls "nnn -e"

#**************************************************
# NNN file manager
# plugins
#export NNN_PLUG='p:preview-tui;i:imgview'
# for doing previews
#set --export NNN_FIFO "/tmp/nnn.fifo"
#**************************************************

# --export -x is the same
set -Ux RESTIC_PASSWORD_FILE "/home/ax/.restic-std"

# alias foox "echo yo ho poh"

# starship init fish | source
# echo "-----------------"

source ~/.local/share/icons-in-terminal/icons.fish

#echo "sourced nnn"
export TERMINAL='kitty'

#export EDITOR='hx'
export ALTERNATE_EDITOR=""
export EDITOR="emacsclient -t"                  # $EDITOR opens in terminal
export VISUAL="emacsclient -c -a emacs"         # $VISUAL opens in GUI mode

# for nnn 'cd on quit' functionality
#set --export NNN_TMPFILE ~/.config/nnn/.lastd
alias nf rnf

# when changing between abbr and alias, remove entry from `fish_variables` accordingly 
#abbr -a em 'emacsclient -t'
alias e "emacsclient -t" 

# starship
source (/home/linuxbrew/.linuxbrew/bin/starship init fish --print-full-init | psub)

source ~/.config/fish/nnn.fish
## Stuff that should be at the end
zoxide init fish | source
