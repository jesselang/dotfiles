local mash = {"ctrl", "alt", "cmd"}

hs.hotkey.bind(mash, "R", function()
    hs.reload()
end)

function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()

local log = hs.logger.new('config','debug')

hs.hotkey.bind(mash, "Space", function()
    hs.grid.toggleShow()
end)

hs.hotkey.bind(mash, "Left", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

hs.hotkey.bind(mash, "Right", function()
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w / 2)
  f.y = max.y
  f.w = max.w / 2
  f.h = max.h
  win:setFrame(f)
end)

function move_window_to_adjacent_space(win, direction)
    local f = win:frame()
    local loc = {x = f.x + 80, y = f.y + 4}
    local delay = 0.1

    hs.eventtap.event.newMouseEvent(
        hs.eventtap.event.types.leftMouseDown,
        loc
    ):post()
    hs.timer.doAfter(delay * 2, function()
        hs.eventtap.event.newKeyEvent({"ctrl"}, direction, true):post()
        hs.eventtap.event.newKeyEvent({"ctrl"}, direction, false):post()
        hs.timer.doAfter(delay, function()
            hs.eventtap.event.newMouseEvent(
                hs.eventtap.event.types.leftMouseUp,
                loc
            ):post()
            --hs.eventtap.leftClick(loc)
            --win:sendToBack()
            --win:raise()
        end)
    end)
end

hs.hotkey.bind({"ctrl", "shift"}, "Right", function()
    move_window_to_adjacent_space(hs.window.focusedWindow(), 'right')
end)

hs.hotkey.bind({"ctrl", "shift"}, "Left", function()
    move_window_to_adjacent_space(hs.window.focusedWindow(), 'left')
end)

hs.hotkey.bind({"shift"}, "Delete", function ()
    app = hs.application.frontmostApplication()
    if app:title() == "Mail" then
        app:selectMenuItem({"Message", "Flag", "Clear Flag"})
    end
end)

hs.hotkey.bind(mash, "T", function()
    app = hs.application("ttrack")

    if app:unminimize():focus() then
        hs.eventtap.keyStroke({"ctrl"}, "c")
        hs.eventtap.keyStrokes("summary task time today\n")
        hs.eventtap.keyStrokes("status\n")
    end
end)

hs.hotkey.bind(mash, "W", function()
    details = hs.wifi.interfaceDetails()
    hs.wifi.setPower(not details.power)
end)

local displays = {
    builtin     = "Color LCD",
    dell        = "DELL U2718Q", -- office
    soyo        = "MB24W" -- home
}

local layouts = {
    {
        name = "office",
        displays = {
            {
                displays.builtin,
                displays.dell
            }
        },
        layout = {
            {"Slack", nil, displays.builtin, '[0,0,40,100]'},
            -- when outlook is too big, it lands in the wrong display
            {"Microsoft Outlook", nil, displays.builtin, '[40,0,100,100]'},
            {"iTerm2", "ttrack", nil, '[75,75,100,100]'},
            {"Google Chrome", "~Hangouts", displays.dell, hs.layout.maximized}
        }
    },
    {
        name = "default",
        layout = {
            {"Slack", nil, nil, '[50,0,100,100]'},
            {"Microsoft Outlook", nil, nil, '[0,0,50,100]'},
            -- chrome is assigned to a different screen
            {"Google Chrome", "~Hangouts", nil, hs.layout.maximized}

        }
    },
}

function findLayout()
    local screens = {}

    for _, v in ipairs(hs.screen.allScreens()) do
        table.insert(screens, v:name())
        log:d(v:name())
    end

    table.sort(screens)

    for _, layout in ipairs(layouts) do
        if not layout.displays then
            -- default layout, must match
            return layout
        else
            for _, display_list in ipairs(layout.displays) do
                if #display_list ~= #screens then
                    break
                end

                table.sort(display_list)

                for i, _ in ipairs(display_list) do
                    if display_list[i] ~= screens[i] then
                        notmatch = true

                        break
                    end
                end

                if notmatch then
                    break
                end

                return layout
            end
        end
    end

    error("default layout without screens not defined")
end

local _current_layout = nil

function applyLayout(layout)
    hs.layout.apply(layout.layout,
        -- window title matching
        function(windowTitle, layoutWindowTitle)
            if layoutWindowTitle:sub(1, 1) == '~' then
                return not string.match(
                    windowTitle,
                    layoutWindowTitle:sub(2)
                )
            else
                return string.match(windowTitle, layoutWindowTitle)
            end
        end
    )
    _current_layout = layout.name
    hs.alert.show('layout: ' .. layout.name)
end

function layout(event)
    local l = findLayout()
    log:d(l.name)
    if not event or _current_layout ~= l.name then
        applyLayout(l)
    end
end
-- window layouts
local screen = hs.screen.watcher.new(function()
    layout(true)
end)

hs.hotkey.bind(mash, "L", function()
    layout(false)
end)


screen:start()

local vpn_connection = "US2 (ROS)"

hs.hotkey.bind(mash, "V", function()
    app = hs.application.find('net.juniper.PulseTray')
    log:d(app:title())
    log:d(hs.inspect(app:getMenuItems()))
    connected = app:findMenuItem({vpn_connection, "Disconnect"})
    connected = connected and connected.enabled or false

    if connected then
        app:selectMenuItem({vpn_connection, "Disconnect"})
    else
        app:selectMenuItem({vpn_connection, "Connect"})
    end

--     if not connected then
--         app = hs.application.frontmostApplication()
--         log:d(app:title())
--         log:d(app:bundleID())
--         win = app:focusedWindow()
--         log:d(win:topLeft())
--         log:d(win:size())
--     end
end)

require('push2talk').new({'ctrl', 'alt'}, ';', 'q'):start()

-- hs.notify.new({title="Hammerspoon", informativeText="Config loaded"}):send()
hs.alert.show(' Hammerspoon Ready')
