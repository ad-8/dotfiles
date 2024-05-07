# Source this file in config.fish !

# Bookmarks: example from wiki -> spaces in path are ok
export NNN_BMS=".:$HOME/.config;c:$HOME/code;D:$HOME/Documents;d:$HOME/Downloads/;h:$HOME;M:$HOME/MEGA/MEGAsync;m:/run/media/ax"

# Plugins
export NNN_PLUG='P:preview-tui;p:preview-tabbed;F:fzcd;f:fzopen;'

# Other
alias nnn "nnn -e"

set --export NNN_FIFO "/tmp/nnn.fifo"

# Preview TUI Plugin uses this for text files
export NNN_TERMINAL="alacritty"
