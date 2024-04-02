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


# NOT ALL KEYS work with ALL LAYOUTS..., e.g. grow-left/right etc dont work with Monad, e.g. grow-left/right etc dont work with Monad
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

    Key([mod], "Up", lazy.layout.grow()),
    Key([mod], "Down", lazy.layout.shrink()),
    Key([mod], "n", lazy.layout.normalize()),
    Key([mod], "o", lazy.layout.maximize()),
    Key([mod, "shift"], "space", lazy.layout.flip()),


    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    # Split
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack"),

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

    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    
    # new ones
    Key([mod], 'period', lazy.next_screen(), desc='Next monitor'),
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



layout_theme = {"border_width": 3,
                "margin": 8, # = gap
                "border_focus": nord["orange"],
                "border_normal": nord["polar4"],
                }



# order in list = order after reload
layouts = [
    #layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
    layout.MonadTall(ratio=0.6, new_client_position='before_current', **layout_theme),
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

my_widgets2 = [
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
    widget.Systray(background="#2e3440"),
    widget.Spacer(length = 8),
]


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
