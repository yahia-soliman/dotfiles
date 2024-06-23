from libqtile import bar, hook, layout, qtile
from libqtile.config import Click, Drag, DropDown, Group, Key, Match, ScratchPad, Screen
from libqtile.layout.columns import Columns
from libqtile.layout.floating import Floating
from libqtile.layout.max import Max
from libqtile.lazy import lazy
from qtile_extras import widget
from qtile_extras.widget.decorations import PowerLineDecoration

from src import colors

mod = "mod4"
terminal = "alacritty"

arrow_right = {
    "decorations": [
        PowerLineDecoration(
            path="arrow_right",
            size=11,
        )
    ]
}
arrow_left = {
    "decorations": [
        PowerLineDecoration(
            path="arrow_left",
            size=11,
        )
    ]
}
rounded_right = {
    "decorations": [
        PowerLineDecoration(
            path="rounded_right",
            size=11,
        )
    ]
}
rounded_left = {
    "decorations": [
        PowerLineDecoration(
            path="rouded_left",
            size=11,
        )
    ]
}
forward_slash = {
    "decorations": [
        PowerLineDecoration(
            path="forward_slash",
            size=11,
        )
    ]
}
backward_slash = {
    "decorations": [
        PowerLineDecoration(
            path="back_slash",
            size=11,
        )
    ]
}

keys = [
    # mod + {j,k}           move focus between windows
    Key([mod], "j", lazy.layout.next()),
    Key([mod], "k", lazy.layout.previous()),
    # mod + ctrl + {h,j,k,l}    move windows in the current layout
    Key([mod, "control"], "h", lazy.layout.shuffle_left()),
    Key([mod, "control"], "l", lazy.layout.shuffle_right()),
    Key([mod, "control"], "j", lazy.layout.shuffle_down()),
    Key([mod, "control"], "k", lazy.layout.shuffle_up()),
    # mod + shift + {h,j,k,l}   resize the focused window
    Key([mod, "shift"], "h", lazy.layout.grow_left()),
    Key([mod, "shift"], "l", lazy.layout.grow_right()),
    Key([mod, "shift"], "j", lazy.layout.grow_down()),
    Key([mod, "shift"], "k", lazy.layout.grow_up()),
    Key([mod], "n", lazy.layout.normalize()),
    Key([mod], "f", lazy.window.toggle_fullscreen()),
    Key([mod, "shift"], "Return", lazy.layout.toggle_split()),
    Key([mod], "q", lazy.window.kill()),
    Key([mod], "Tab", lazy.next_layout()),
    Key(["mod1"], "Tab", lazy.group["1"].toscreen()),
    Key([mod, "control"], "r", lazy.reload_config()),
    Key([mod, "control"], "q", lazy.shutdown()),
    # keys related to launching programs are in the sxhkd config
]

groups = [
    Group("1", label="󰣇"),
    Group("2", label=""),
    Group("3", label=""),
    Group("4", label=""),
    Group("5", label="󱁇"),
    Group("6", label="󰚀"),
]

for i in groups:
    keys.extend(
        [
            Key([mod], i.name, lazy.group[i.name].toscreen()),
            Key([mod, "shift"], i.name, lazy.window.togroup(i.name)),
        ]
    )

groups.append(ScratchPad("scratchpad", [DropDown("scratchy", terminal, on_focus_lost_hide=False, width=0.4, height=0.6, y=0.2, x=0.3)]))
keys.append(Key([mod], "s", lazy.group['scratchpad'].dropdown_toggle('scratchy')))

layouts = [
    Columns(
        name="󰙀",
        num_columns=2,
        border_width=0,
        margin=12,
        wrap_focus_columns=False,
        wrap_focus_rows=False,
        border_focus=colors.magenta,
        border_normal=colors.black,
    ),
    Max(border_width=0, margin=12, name=""),
    Floating(
        name="",
        border_width=0,
    ),
]

widget_defaults = dict(
    font="sans",
    fontsize=12,
    padding=3,
)
# extension_defaults = [widget_defaults.copy()]


def search():
    qtile.cmd_spawn("rofi -show drun")


def power():
    qtile.cmd_spawn("sh -c ~/.config/rofi/scripts/power")


screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Spacer(
                    length=1,
                    background=colors.none,
                    **rounded_right,
                ),
                widget.Spacer(length=5, background=colors.fg),
                widget.TextBox(
                    " ",
                    background=colors.fg,
                    foreground=colors.bg,
                    fontsize=28,
                    mouse_callbacks={"Button1": lazy.spawn("rofi -show drun")},
                ),
                widget.Spacer(
                    length=1,
                    background=colors.fg,
                    **arrow_left,
                ),
                widget.Spacer(length=5, background=colors.bg),
                widget.GroupBox(
                    fontsize=20,
                    borderwidth=3,
                    highlight_method="block",
                    active=colors.blue,
                    block_highlight_text_color=colors.red,
                    highlight_color="#4B427E",
                    inactive=colors.fg,
                    foreground="#4B427E",
                    background=colors.bg,
                    this_current_screen_border=colors.bg,
                    this_screen_border=colors.bg,
                    other_current_screen_border=colors.bg,
                    other_screen_border=colors.bg,
                    urgent_border=colors.bg,
                    disable_drag=True,
                ),
                widget.Spacer(
                    length=1,
                    background=colors.bg,
                    **arrow_left,
                ),
                widget.Spacer(length=12, background=colors.bg_alt),
                widget.CurrentLayout(
                    background=colors.bg_alt,
                    foreground=colors.cyan,
                    fmt="{} ",
                    font="JetBrains Mono Bold",
                    fontsize=20,
                ),
                widget.Spacer(
                    length=1,
                    background=colors.bg_alt,
                    **arrow_left,
                ),
                widget.WindowName(background=colors.none, foreground=colors.none),
                widget.Spacer(
                    length=1,
                    background=colors.none,
                    **arrow_left,
                ),
                widget.Spacer(length=8, background=colors.bg_alt),
                widget.Systray(background=colors.bg_alt, fontsize=8),
                widget.Spacer(length=7, background=colors.bg_alt),
                widget.Spacer(
                    length=1,
                    background=colors.bg_alt,
                    **forward_slash,
                ),
                # add net here
                widget.TextBox(
                    text="󰍛",
                    background=colors.bg,
                    foreground=colors.magenta,
                    fontsize=18,
                ),
                widget.Memory(
                    background=colors.bg,
                    format="{MemUsed: .0f}{mm} ",
                    foreground=colors.magenta,
                    font="JetBrains Mono Bold",
                    fontsize=13,
                    update_interval=5,
                ),
                widget.Spacer(length=8, background=colors.bg),
                widget.TextBox(
                    text=" ",
                    background=colors.bg,
                    foreground=colors.yellow,
                    fontsize=15,
                ),
                widget.CPU(
                    fontsize=13,
                    format="{load_percent}%   ",
                    font="JetBrains Mono Bold",
                    foreground=colors.yellow,
                    background=colors.bg,
                    update_interval=4,
                ),
                widget.TextBox(
                    text="󰔐",
                    background=colors.bg,
                    foreground=colors.red,
                    fontsize=16,
                ),
                widget.ThermalSensor(
                    update_interval=15,
                    format="{temp:.0f}{unit}",
                    font="JetBrains Mono Bold",
                    fontsize=13,
                    tag_sensor="Tctl",
                    foreground=colors.red,
                    background=colors.bg,
                ),
                widget.Spacer(length=8, background=colors.bg),
                widget.Volume(
                    font="JetBrains Mono Bold",
                    theme_path="~/.config/qtile/Assets/Volume/",
                    get_volume_command="~/.local/bin/getvol",
                    check_mute_string="MUTED",
                    emoji=True,
                    background=colors.bg,
                ),
                widget.Spacer(length=-10, background=colors.bg),
                widget.Volume(
                    font="JetBrains Mono Bold",
                    get_volume_command="~/.local/bin/getvol",
                    check_mute_string="MUTED",
                    fontsize=13,
                    volume_app="pavucontrol",
                    background=colors.bg,
                    foreground="#E5B9C6",
                ),
                widget.Spacer(length=8, background=colors.bg),
                widget.Spacer(
                    length=1,
                    background=colors.bg,
                    **arrow_left,
                ),
                widget.Image(
                    filename="~/.config/qtile/Assets/Misc/clock.png",
                    background="#282738",
                    margin_y=6,
                    margin_x=5,
                ),
                widget.Clock(
                    format="%I:%M %p",
                    background=colors.bg_alt,
                    foreground="#E5B9C6",
                    font="JetBrains Mono Bold",
                    fontsize=13,
                ),
                widget.Spacer(
                    length=18,
                    background=colors.bg_alt,
                ),
            ],
            30,
            border_color=colors.none,
            background=colors.none,
            border_width=[0, 0, 0, 0],
            margin=[8, 12, 0, 12],
        ),
    ),
]  # End screens


# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
floating_layout = Floating(
    border_focus=colors.yellow,
    border_normal=colors.none,
    border_width=0,
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ],
)

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"


# E O F
