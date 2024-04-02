# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

# imports
import os
import subprocess
# qtile
from libqtile import bar, extension, hook, layout, qtile, widget
from libqtile.config import Click, Drag, Group, Key, KeyChord, Match, Screen

from libqtile.lazy import lazy
from libqtile.utils import guess_terminal



mod = "mod4"
alt_left = "mod1"
terminal = guess_terminal()

# Allows you to input a name when adding treetab section.
@lazy.layout.function
def add_treetab_section(layout):
    prompt = qtile.widgets_map["prompt"]
    prompt.start_input("Section name: ", layout.cmd_add_section)

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),


    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    
    # Treetab prompt
    Key([mod, "shift"], "a", add_treetab_section, desc='Prompt to add new section in treetab'),

    Key([mod], "f", lazy.window.toggle_fullscreen(), desc='toggle fullscreen'),

    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h",
        lazy.layout.shuffle_left(),
        lazy.layout.move_left().when(layout=["treetab"]),
        desc="Move window to the left/move tab left in treetab"),

    Key([mod, "shift"], "l",
        lazy.layout.shuffle_right(),
        lazy.layout.move_right().when(layout=["treetab"]),
        desc="Move window to the right/move tab right in treetab"),

    Key([mod, "shift"], "j",
        lazy.layout.shuffle_down(),
        lazy.layout.section_down().when(layout=["treetab"]),
        desc="Move window down/move down a section in treetab"
    ),
    Key([mod, "shift"], "k",
        lazy.layout.shuffle_up(),
        lazy.layout.section_up().when(layout=["treetab"]),
        desc="Move window downup/move up a section in treetab"
    ),
    # Grow (resize) windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),


    Key([mod, "control"], "Down", lazy.layout.shrink(), desc="Grow window to the left"),
    Key([mod, "control"], "Up", lazy.layout.grow(), desc="Grow window to the right"),


    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "n", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "p", lazy.prev_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "q", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),

    Key([mod, alt_left], "l", lazy.spawn('licht'), desc="Let there be light"),
    Key([mod, alt_left], "x", lazy.spawn('i3lock --color 000000 --show-failed-attempts'), desc="Lock Screen"),
    Key([mod, "shift"], "x", lazy.spawn('/usr/local/bin/lock-n-sleep.sh', shell=True), desc="Lock Screen & Suspend"),
    

    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    
    # new ones
    Key([mod], "d", lazy.spawn("i3-dmenu-desktop"), desc="dmenu desktop apps"),
    Key([mod, "shift"], "d", lazy.spawn("dmenu_run -l 25"), desc="dmenu cmd apps"),
    Key([mod], 'period', lazy.next_screen(), desc='Next monitor'),

    # Emacs programs launched using the key chord CTRL+e followed by 'key'
    KeyChord([mod],"o", [
        Key([], "a", lazy.spawn("xfce4-appfinder"), desc='launch alacritty'),
        Key([], "b", lazy.spawn("blueman-manager"), desc='launch blueman'),
        Key(["shift"], "b", lazy.spawn("firefox"), desc='launch browser'),
        Key([], "e", lazy.spawn('emacsclient --create-frame --alternate-editor="vim"'), desc='launch emacs'),  # TODO launch emacsclient
        Key([], "f", lazy.spawn("thunar"), desc='launch file manager'),
        Key([], "s", lazy.spawn("gnome-system-monitor"), desc='launch system monitor'),
    ]),
]

# Add key bindings to switch VTs in Wayland.
# We can't check qtile.core.name in default config as it is loaded before qtile is started
# We therefore defer the check until the key binding is run by using .when(func=...)
for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )


groups = []
group_names = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]
group_labels = [
    "1 󰆍 ",
    "2  ",
    "3  ",
    "4 󰘧 ",
    " 5 ",
    " 6 ",
    " 7 ",
    "8  ",
    "9   ",
    "0   ",
]

#group_layouts = ["monadtall", "monadtall", "tile", "tile", "monadtall", "monadtall", "monadtall", "monadtall", "monadtall"]

for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
#            layout=group_layouts[i].lower(),
            label=group_labels[i],
        ))

for i in groups:
    keys.extend(
        [
            # mod1 + group number = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(toggle=True),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + group number = switch to & move focused window to group
            #Key(
            #    [mod, "shift"],
            #    i.name,
            #    lazy.window.togroup(i.name, switch_group=True),
            #    desc="Switch to & move focused window to group {}".format(i.name),
            #),
            # Or, use below if you prefer not to switch to that group.
            # mod1 + shift + group number = move focused window to group
             Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
                 desc="move focused window to group {}".format(i.name)),
        ]
    )


nord = {
    "polar1": "#2e3440",
    "polar2": "#3b4252",
    "polar3": "#434c5e",
    "polar4": "#4c566a",
    "snow1": "#d8dee9",
    "snow2": "#e5e9f0",
    "snow3": "#eceff4",
    "frost1": "#8fbcbb",
    "frost2": "#88c0d0",
    "frost3": "#81a1c1",
    "frost4": "#5e81ac",
    "red": "#bf616a",
    "orange": "#d08770",
    "yellow": "#ebcb8b",
    "green": "#a3be8c",
    "lila": "#b48ead"
}



layout_theme = {"border_width": 2,
                "margin": 8,
                "border_focus": "#d08770",
                "border_normal": "#4c566a",
                }

layout_theme_2 = {"border_width": 10,
                "margin": 20,
                "border_focus": "#d08770",
                "border_normal": "#4c566a",
                }


# order in list = order after reload
layouts = [
    #layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
    layout.MonadTall(ratio=0.6, new_client_position='before_current', **layout_theme),
#    layout.MonadTall(ratio=0.5, **layout_theme_2),
    layout.Max(
        border_focus='',
        border_normal='',
        border_width=3),
    layout.TreeTab(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    #layout.Tile(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="sans",
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()



#set $yellow #ebcb8b
#set $red    #bf616a
#
# this_current_screen_border for the group that's active on the current screen,
# other_screen_border for the group that's active on another (unfocused) screen.
#
# To theme the widget on all other unfocused screens:
# this_screen_border for the group that is active on the screen where the widget is located,
# other_current_screen_border for all other groups that are active anywhere.
groupbox_settings = dict(
    highlight_method='line',
    #highlight_color = ['#000000', '#d08770'],
    highlight_color = nord['orange'],
    active = nord['snow1'],
    inactive = nord['polar4'],

    this_screen_border = nord['red'],
    this_current_screen_border = nord['red'],

    other_screen_border = nord['yellow'],
    other_current_screen_border = nord['yellow'],
)

my_widgets = [
    widget.CurrentLayout(),
    widget.GroupBox(
        **groupbox_settings
    ),
    widget.Prompt(),
    widget.WindowName(),
    widget.Volume(fmt='Vol: {}', emoji=True),
    widget.GenPollCommand(
        #background="282A36",
        cmd="i3weather short",
        fmt="{}",
        shell=True,
        update_interval=300,
    ),
    widget.GenPollCommand(
        #background="282A36",
        cmd="i3vpn",
        fmt="{}",
        shell=True,
        update_interval=10,
    ),
    widget.GenPollCommand(
        background="282A36",
        cmd="cat /tmp/licht-ed16d5b5",
        fmt="LICHT: {}",
        shell=True,
        update_interval=5,
    ),
    #TextBox(text="foo.sh", mouse_callbacks={"Button1": lambda: qtile.cmd_spawn("sh /tmp/foo.sh")}),
    #widget.TextBox("Press &lt;M-r&gt; to spawn", foreground="#d75f5f"),
    # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
    #widget.StatusNotifier(),
    widget.Clock(format="%a %d.%m.%Y %H:%M:%S"),
    widget.QuickExit(),
    widget.Spacer(length = 8),
    #widget.Systray(background="#2e3440"),
    widget.Spacer(length = 8),
]

more_widgets = [widget.Systray(background="#2e3440")]
my_widgets2  = my_widgets + more_widgets
my_widgets2[0] = widget.CurrentLayout() # needs its own instance

screens = [
    Screen(
        top=bar.Bar(
            my_widgets,
            24,
            background="#2e3440",
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate = 60,
    ),
    Screen(
        top=bar.Bar(
            my_widgets2,
            28,
            background="#2e3440",
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate = 60,
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = True # aaah finally :) move cursor when switching focus
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(wm_class="xfce4-appfinder"),

    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None



@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser('~')
    subprocess.call([home + '/.config/qtile/autostart.sh'])




# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
