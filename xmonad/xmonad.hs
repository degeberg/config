import XMonad
import System.Exit
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.UrgencyHook
import XMonad.Util.Run
import XMonad.Util.EZConfig(additionalKeys)
import XMonad.Util.Scratchpad
import XMonad.Layout.NoBorders
import XMonad.Layout.Accordion
import XMonad.Layout
import XMonad.Actions.CycleWS
import System.IO
import Graphics.X11.ExtraTypes.XF86
import Graphics.X11.ExtraTypes.XorgDefault

dmenuCmd= "dmenu_run -nb '#1a1a1a' -nf '#ffffff' -sb '#aecf96' -sf black -p '>'"
myBar = "xmobar"
myTerminal = "urxvtc"

main = do xmproc <- spawnPipe myBar
          xmonad $ withUrgencyHook NoUrgencyHook $ defaultConfig
                   { manageHook         = myManageHook <+> manageDocks <+> manageHook defaultConfig
                   , layoutHook         = myLayout
                   , terminal           = myTerminal
                   , keys               = myKeys
                   , workspaces         = ["web"] ++ map show [1 .. 9 :: Int] ++ ["a", "b", "im", "d"]
                   , logHook            = dynamicLogWithPP $ myPP xmproc
                   , modMask            = mod4Mask     -- Rebind Mod to the Windows key
                   , normalBorderColor  = "#555555"
                   , borderWidth         = 1
                   , startupHook        = (setWMName "LG3D" >> spawn "killall xbindkeys; xbindkeys")
                   }

myPP h = xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "<" ">"
                  , ppUrgent  = xmobarColor "red" "" . wrap "<" ">"
                  , ppHidden  = noScratchPad
                  , ppTitle   = shorten 100
                  , ppOutput  = hPutStrLn h }
  where
    noScratchPad ws = if ws == "NSP" then "" else ws

-- ManageHooks
myManageHook :: ManageHook
myManageHook = composeAll
    [ isFullscreen --> doFullFloat
    , className =? "Pidgin" --> doShift "d"
    , className =? "Skype" --> doShift "d"
    , className =? "Keepassx" --> doShift "b"
    , className =? "Firefox" --> doShift "web"
    , title     =? "VLC media player" --> doFloat
    , title     =? "VLC (XVideo output)" --> doFloat] <+> manageScratchPad

manageScratchPad :: ManageHook
manageScratchPad = scratchpadManageHook (W.RationalRect l t w h)
  where
    h = 0.4     -- terminal height, 10%
    w = 1       -- terminal width, 100%
    t = 1 - h   -- distance from top edge, 90%
    l = 1 - w   -- distance from left edge, 0%

-- Layouts
myLayout = avoidStruts (tiled ||| Mirror tiled ||| noBorders Full)
  where
    tiled = Tall 1 (3/100) (1/2)
    nmaster = 1
    ratio   = 1/2
    delta   = 3/100

-- Keys
myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@(XConfig {XMonad.modMask = modMask}) = M.fromList $
    -- killing programs
    [ ((modMask .|. shiftMask, xK_c ), kill)

    -- layouts
    , ((modMask, xK_space ), sendMessage NextLayout)
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- volume control
    , ((0, xF86XK_AudioLowerVolume), spawn "amixer -q set Master 5%-")
    , ((0, xF86XK_AudioRaiseVolume), spawn "amixer -q set Master 5%+")
    , ((0, xF86XK_AudioMute), spawn "amixer -q set Master toggle")
    , ((modMask .|. shiftMask, xK_m), spawn "amixer -q set Master 0")

    -- focus
    , ((modMask, xK_Tab ), windows W.focusDown)
    , ((modMask, xK_j ), windows W.focusDown)
    , ((modMask, xK_k ), windows W.focusUp)
    , ((modMask, xK_m ), windows W.focusMaster)
    , ((modMask, xK_Return), windows W.swapMaster)

    -- floating layer support
    , ((modMask, xK_t ), withFocused $ windows . W.sink)

    -- swapping
    , ((modMask .|. shiftMask, xK_j ), windows W.swapDown )
    , ((modMask .|. shiftMask, xK_k ), windows W.swapUp )

    -- increase or decrease number of windows in the master area
    , ((modMask , xK_comma ), sendMessage (IncMasterN 1))
    , ((modMask , xK_period), sendMessage (IncMasterN (-1)))

    -- switch between current and previous workspace
    , ((modMask .|. shiftMask , xK_w ), toggleWS )

    -- scratch pad
    , ((0, xK_Meta_R), scratchpadSpawnActionTerminal myTerminal)

    -- media keys
    , ((0, xF86XK_AudioPlay), spawn "mpc -q toggle")
    , ((0, xF86XK_AudioPrev), spawn "mpc -q prev")
    , ((0, xF86XK_AudioNext), spawn "mpc -q next")
    , ((0, xF86XK_AudioStop), spawn "mpc -q stop")

    -- resizing
    , ((modMask, xK_h ), sendMessage Shrink)
    , ((modMask, xK_l ), sendMessage Expand)
    --, ((modMask .|. shiftMask, xK_h ), sendMessage MirrorShrink)
    --, ((modMask .|. shiftMask, xK_l ), sendMessage MirrorExpand)

    -- quit, or restart
    , ((modMask .|. shiftMask, xK_q ), io (exitWith ExitSuccess))
    , ((modMask , xK_q ), restart "xmonad" True)
    ]
    ++
    -- mod-[1..9] %! Switch to workspace N
    -- mod-shift-[1..9] %! Move client to workspace N
    [((m .|. modMask, k), windows $ f i)
        -- | (i, k) <- zip (XMonad.workspaces conf) ([xK_onehalf] ++ [xK_1 .. xK_9] ++ [xK_0, xK_plus, 65105, xK_BackSpace]) -- 65105 is the key after the plus key on my keyboard
        | (i, k) <- zip (XMonad.workspaces conf) ([xK_grave] ++ [xK_1 .. xK_9] ++ [xK_0, xK_minus, xK_equal, xK_BackSpace]) -- 65105 is the key after the plus key on my keyboard
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
    -- mod-{w,e,r} %! Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r} %! Move client to screen 1, 2, or 3
    [((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]



