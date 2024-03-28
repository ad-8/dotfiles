import XMonad

import XMonad.Util.EZConfig

-- a basic configuration — which is the same as the default config
-- default config: https://github.com/xmonad/xmonad/blob/master/src/XMonad/Config.hs
-- Do note that it is not advised to copy that file and use it as the basis of your configuration, as you won’t notice when a default changes!

main :: IO ()
main = xmonad $ def
    { modMask = mod4Mask  -- Rebind Mod to the Super key
    }
  `additionalKeysP`
    [ ("M-S-z", spawn "xscreensaver-command -lock")
    , ("M-C-s", unGrab *> spawn "scrot -s"        )
    , ("M-f"  , spawn "firefox"                   )
    ]

