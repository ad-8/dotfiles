import XMonad

-- imports tutorial, part up until Xmobar setup
-- tutorial: https://xmonad.org/TUTORIAL.html
import XMonad.Util.EZConfig
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Magnifier
import XMonad.Hooks.EwmhDesktops
--------------------------------

-- imports to set up Xmobar
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
--------------------------------
import XMonad.Util.Loggers
--------------------------------
import System.Exit

-- a basic configuration — which is the same as the default config
-- default config: https://github.com/xmonad/xmonad/blob/master/src/XMonad/Config.hs
-- Do note that it is not advised to copy that file and use it as the basis of your configuration, as you won’t notice when a default changes!


myLayout = tiled ||| Mirror tiled ||| Full ||| threeCol
  where
    threeCol = magnifiercz' 1.3 $ ThreeColMid nmaster delta ratio
    tiled    = Tall nmaster delta ratio
    nmaster  = 1      -- Default number of windows in the master pane
    ratio    = 1/2    -- Default proportion of screen occupied by master pane
    delta    = 3/100  -- Percent of screen to increment by when resizing panes


myXmobarPP :: PP
myXmobarPP = def
    { ppSep             = magenta " • "
    , ppTitleSanitize   = xmobarStrip
    , ppCurrent         = wrap " " "" . xmobarBorder "Top" "#8be9fd" 2
    , ppHidden          = white . wrap " " ""
    , ppHiddenNoWindows = lowWhite . wrap " " ""
    , ppUrgent          = red . wrap (yellow "!") (yellow "!")
    , ppOrder           = \[ws, l, _, wins] -> [ws, l, wins]
    , ppExtras          = [logTitles formatFocused formatUnfocused]
    }
  where
    formatFocused   = wrap (white    "[") (white    "]") . magenta . ppWindow
    formatUnfocused = wrap (lowWhite "[") (lowWhite "]") . blue    . ppWindow

    -- | Windows should have *some* title, which should not not exceed a
    -- sane length.
    ppWindow :: String -> String
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30

    blue, lowWhite, magenta, red, white, yellow :: String -> String
    magenta  = xmobarColor "#ff79c6" ""
    blue     = xmobarColor "#bd93f9" ""
    white    = xmobarColor "#f8f8f2" ""
    yellow   = xmobarColor "#f1fa8c" ""
    red      = xmobarColor "#ff5555" ""
    lowWhite = xmobarColor "#bbbbbb" ""


main :: IO ()
main = xmonad
     . ewmhFullscreen
     . ewmh
     . withEasySB (statusBarProp "xmobar ~/.config/xmobar/xmobarrc" (pure myXmobarPP)) defToggleStrutsKey
     $ myConfig


myConfig = def
    { modMask    = mod4Mask  -- Rebind Mod to the Super key
    , layoutHook = myLayout  -- Use custom layouts
    , terminal   = "alacritty"
    }
  `additionalKeysP`
    [ ("M-S-z"    	, spawn "xscreensaver-command -lock")
    , ("M-C-s"  	, unGrab *> spawn "scrot -s"        )
    , ("M-f"      	, spawn "firefox"                   )
    , ("M-o"      	, spawn "rofi -show drun"           )
    , ("M-<Tab>"  	, spawn "rofi -show window"           )
    , ("M-S-q"    	, kill           )
    , ("M-S-e"         	, io (exitWith ExitSuccess)           )
    -- TODO get sth generic to work like spawn $ Xmonad.terminal 
    , ("M-<Return>"     , spawn "alacritty"       )
    ]


