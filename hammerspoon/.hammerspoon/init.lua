-- Hyper key
hyper = hs.hotkey.modal.new({}, 'f17')

f18 = hs.hotkey.bind({}, 'f18', function()
    hyper.triggered = false
    hyper:enter()
  end, function()
    hyper:exit()
    if not hyper.triggered then
      hs.eventtap.keyStroke({}, 'escape')
    end
end)

-- Launch or focus app
local app_keys = {
    ['q'] = 'Google Chrome',
    ['w'] = 'iTerm 2',
    ['e'] = 'Visual Studio Code',
    ['s'] = 'Slack',
    ['d'] = 'Dash',
}

for key, app in pairs(app_keys) do
    hyper:bind({}, key, function()
    	hs.application.launchOrFocus(app)
    end)
end

-- Open new window
hyper:bind({}, 'return', function()
    hs.eventtap.keyStroke({'cmd'}, 'n')
end)

-- Toggle fullscreen mode
hyper:bind({}, 'space', function()
    hs.execute('/usr/local/bin/chunkc tiling::window -t fullscreen')
end)

hyper:bind({'shift'}, 'space', function()
    hs.execute('/usr/local/bin/chunkc tiling::window -t native-fullscreen')
end)

-- Send to desktop
for i=1,9 do
    i = tostring(i)
    hyper:bind({}, i, function()
        hs.execute('/usr/local/bin/chunkc tiling::window -d ' .. i)
        hs.eventtap.keyStroke({'ctrl'}, i)
    end)
end

-- Send to monitor
for i=1,2 do
    i = tostring(i)
    hyper:bind({'cmd'}, i, function()
        hs.execute('/usr/local/bin/chunkc tiling::window -m ' .. i)
    end)
end

-- Rotate and mirror desktop
local chunkwm_desktop_keys = {
    ['['] = '-r 90',
    [']'] = '-r 270',
    ['\''] = '-r 180',
    ['\\'] = '-m vertical',
}

for key, args in pairs(chunkwm_desktop_keys) do
    hyper:bind({}, key, function()
        hs.execute('/usr/local/bin/chunkc tiling::desktop ' .. args)
    end)
end

-- Move window focus
local chunkwm_focus_keys = {
    ['left'] = 'west',
    ['right'] = 'east',
    ['up'] = 'north',
    ['down'] = 'south',
}

for key, side in pairs(chunkwm_focus_keys) do
    hyper:bind({}, key, function()
        hs.execute('/usr/local/bin/chunkc tiling::window -f ' .. side)
    end)
end

-- Adjust tiling ratio
local chunkwm_tiling_keys = {
    [','] = {'west', 'east'},
    ['.'] = {'east', 'west'},
}

for key, edges in pairs(chunkwm_tiling_keys) do
    hyper:bind({}, key, function()
        cmd = ''
        ratio = 0.05
        for _, edge in ipairs(edges) do
            cmd = cmd .. string.format('/usr/local/bin/chunkc tiling::window -r %.2f -e %s;', ratio, edge)
            ratio = -ratio
        end
        hs.execute(cmd)
    end)
end
