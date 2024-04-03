from libqtile import bar, extension, hook, layout, qtile, widget
from colors import nord
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

# DUPLICATION of widgets lists, but some (all?) widgets need their own instance
# on each bar to function properly
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
