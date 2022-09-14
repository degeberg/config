import XMonad
import System.Exit
import qualified XMonad.StackSet as W
import qualified Data.Map as M
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.UrgencyHook
import XMonad.Util.Run
--import XMonad.Util.Scratchpad
import XMonad.Util.NamedScratchpad
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Fullscreen
import XMonad.Actions.CycleWS
--import XMonad.Actions.GridSelect
import XMonad.Actions.TopicSpace
import XMonad.Actions.DynamicWorkspaces
  (addWorkspacePrompt, removeWorkspace)
import XMonad.Actions.WithAll (killAll)
import XMonad.Prompt
import XMonad.Prompt.Workspace
import Graphics.X11.ExtraTypes.XF86
import qualified XMonad.Layout.Tabbed as Tabbed
import XMonad.Hooks.EwmhDesktops

runCmd, myBar, myTerminal :: String
--runCmd= "dmenu_run -nb '#1a1a1a' -nf '#ffffff' -sb '#aecf96' -sf black -p '>'"
runCmd= "rofi -show run"
myBar = "xmobar"
myTerminal = "urxvtc"

main :: IO ()
main = do xmproc <- spawnPipe myBar
          xmonad $ withUrgencyHook NoUrgencyHook $ ewmh desktopConfig
                   { manageHook         = myManageHook <+> manageDocks <+> manageHook def
                   , layoutHook         = smartBorders myLayout
                   , terminal           = myTerminal
                   , keys               = myKeys
                   --, workspaces         = ["web"] ++ map show [1 .. 9 :: Int] ++ ["a", "b", "im", "d"] ++ myTopics
                   , workspaces         = ["web"] ++ map show [1 .. 9 :: Int] ++ ["a", "mail", "im", "music", "plex"]
                   , logHook            = setWMName "LG3D" >> dynamicLogWithPP (myPP xmproc)
                   , modMask            = mod4Mask     -- Rebind Mod to the Windows key
                   , normalBorderColor  = "#555555"
                   , borderWidth        = 1
                   , startupHook        = setWMName "LG3D" >> spawn "killall xbindkeys; xbindkeys"
                   }

myPP h = xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "<" ">"
                  , ppUrgent  = xmobarColor "red" "" . wrap "<" ">"
                  , ppHidden  = noScratchPad
                  , ppTitle   = shorten 100
                  , ppOutput  = hPutStrLn h }
  where
    noScratchPad ws = if ws == "NSP" then "" else ws



scratchpads :: [NamedScratchpad]
scratchpads = [
    NS "term" "urxvtc -name scratchpad" (resource =? "scratchpad")
        (customFloating $ W.RationalRect l t w h)
  ]
  where
    h = 0.4     -- terminal height, 10%
    w = 1       -- terminal width, 100%
    t = 1 - h   -- distance from top edge, 90%
    l = 1 - w   -- distance from left edge, 0%

-- ManageHooks
myManageHook :: ManageHook
myManageHook = composeAll
    [ isFullscreen --> doFullFloat
    , title     =? "plexhometheater" --> doShift "plex"
    --, className =? "Firefox" --> doShift "web"
    , title     =? "VLC media player" --> doFloat
    , title     =? "VLC (XVideo output)" --> doFloat
    , title     =? "Microsoft Teams Notification" --> doFloat
    --] <+> manageScratchPad
    ] <+> namedScratchpadManageHook scratchpads

shell ::  X ()
shell = spawn myTerminal

browser, edit, ssh ::  String -> X ()
browser s = spawn ("firefox-developer-edition " ++ s)
edit s = spawn ("gvim " ++ s)
ssh s = spawn (myTerminal ++ " -e ssh " ++ s)

topicItems :: [TopicItem]
topicItems =
  [ inHome "web"  (browser "")
  , inHome "mail" (spawn "thunderbird")
  ]

myTopicConfig :: TopicConfig
myTopicConfig = def
  { topicDirs          = tiDirs    topicItems
  , topicActions       = tiActions topicItems
  , defaultTopicAction = const (shell)
  , defaultTopic       = "web"
  }

--myTopicConfig :: TopicConfig
--myTopicConfig = defaultTopicConfig
--    { topicDirs = M.fromList []
--    , defaultTopicAction = const shell
--    , defaultTopic = "dashboard"
--    , topicActions = M.fromList
--        [ ("web",       browser "")
--        , ("im",        ssh "im@degeberg")
--        , ("plex",      spawn "/usr/bin/openpht.sh")
--        , ("mail",      spawn "thunderbird")
--        , ("music",     spawn "gpmdp")
--        ]
--    }


--manageScratchPad :: ManageHook
--manageScratchPad = scratchpadManageHook (W.RationalRect l t w h)
--  where
--    h = 0.4     -- terminal height, 10%
--    w = 1       -- terminal width, 100%
--    t = 1 - h   -- distance from top edge, 90%
--    l = 1 - w   -- distance from left edge, 0%

-- Layouts
myLayout = onWorkspaces ["plex"] (noBorders (fullscreenFull Full)) $
           avoidStruts (tiled ||| Mirror tiled ||| Full)
  where
    tiled = Tall 1 (3/100) (1/2)

--myXPConfig = defaultXPConfig
--  { fgColor = "#a8a3f7"
--  -- , bgColor = "#ff3c6d"}
--  , bgColor = "#3f3c6d"}

goto :: Topic -> X ()
goto = switchTopic myTopicConfig

--promptedGoto :: X ()
--promptedGoto = workspacePrompt myXPConfig goto

-- Keys
myKeys :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeys conf@XConfig {XMonad.modMask = modMask} = M.fromList $
    -- killing programs
    [ ((modMask .|. shiftMask, xK_c ), kill)

    -- layouts
    , ((modMask, xK_space ), sendMessage NextLayout)
    , ((modMask .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    , ((modMask, xK_a), currentTopicAction myTopicConfig)
--    , ((modMask, xK_d), promptedGoto)
--    , ((modMask .|. shiftMask, xK_n), addWorkspacePrompt myXPConfig >> shell)
--    , ((modMask .|. shiftMask, xK_BackSpace), killAll >> removeWorkspace)

    -- volume control
    , ((0, xF86XK_AudioLowerVolume), spawn "pulsevol down")
    , ((0, xF86XK_AudioRaiseVolume), spawn "pulsevol up")
    , ((0, xF86XK_AudioMute), spawn "pulsevol mute-toggle")
    , ((modMask .|. shiftMask, xK_m), spawn "pulsevol set-volume 0")
    , ((modMask, xK_Down), spawn "pulsevol down")
    , ((modMask, xK_Up), spawn "pulsevol up")

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
    , ((modMask, xK_w ), toggleWS )

    -- scratch pad
    --, ((0, xK_Meta_R), scratchpadSpawnActionTerminal myTerminal)
    , ((0, xK_Meta_R), namedScratchpadAction scratchpads "term")

    -- media keys
    --, ((0, xF86XK_AudioPlay), spawn "mpc -q toggle")
    --, ((0, xF86XK_AudioPrev), spawn "mpc -q prev")
    --, ((0, xF86XK_AudioNext), spawn "mpc -q next")
    --, ((0, xF86XK_AudioStop), spawn "mpc -q stop")

    -- key maps
    , ((modMask, xK_Prior), spawn "keymap prev")
    , ((modMask, xK_Next), spawn "keymap next")
    , ((modMask, xK_Home), spawn "keymap mru")

    -- resizing
    , ((modMask, xK_h ), sendMessage Shrink)
    , ((modMask, xK_l ), sendMessage Expand)
    --, ((modMask .|. shiftMask, xK_h ), sendMessage MirrorShrink)
    --, ((modMask .|. shiftMask, xK_l ), sendMessage MirrorExpand)

    -- quit, or restart
    , ((modMask .|. shiftMask, xK_q ), io exitSuccess)
    , ((modMask , xK_q ), restart "xmonad" True)

--    , ((modMask, xK_g), goToSelected defaultGSConfig)

     ,((modMask, xK_b     ), sendMessage ToggleStruts)

     ,((0, xF86XK_Calculator ), spawn "/home/dhe/bin/whoscalling.pl")
     ,((0, xK_Pause ),          spawn "/home/dhe/bin/whoscalling.pl")

     ,((modMask, xK_p),                    spawn runCmd)
     ,((modMask .|. shiftMask, xK_Return), shell)
     ,((modMask .|. shiftMask, xK_s),      spawn "rofi -show ssh")
     ,((modMask .|. shiftMask, xK_d),      spawn "rofi -show window")
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



