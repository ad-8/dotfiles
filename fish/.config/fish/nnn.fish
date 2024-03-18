# Source this file in config.fish !

# Bookmarks: example from wiki -> spaces in path are ok
export NNN_BMS=".:$HOME/.config;c:$HOME/code;D:$HOME/Documents;d:$HOME/Downloads/;h:$HOME;t:$HOME/Desktop;M:$HOME/MEGA/MEGAsync;m:/media/ax"

# Plugins
export NNN_PLUG='p:preview-tui;i:preview-tabbed;f:fzcd'

# Other
alias nnn "nnn -e"

set --export NNN_FIFO "/tmp/nnn.fifo"

