-- Wezterm configuration
-- powered by aquawius
-- this is version 6, modified based on aquawius's file
-- version 1: initial config
-- version 2: wsl support
-- version 3: update theme to purple style
-- version 4: fix bug "git log" with "terminal is not fully functional"
--            tracert: term set to "" is not a compatible term for git
-- version 5: update theme to dracula official.
-- version 6: add feature: open hyperlinks on pressing ctrl key and mouse_left key.
-- version 7: because `Cascadia Code` official Nerd Font released, `CaskaydiaCove Nerd Font` no longer to use.
--            change default font to `Cascadia Code`.

local wezterm = require("wezterm");
local dracula = require('dracula');

local config = {
    check_for_updates = true,
    -- Here are wezterm default color scheme, which is good.
    -- color_scheme = "Fahrenheit",
    -- color_scheme = "Gruvbox Dark",
    -- color_scheme = "Blue Matrix",
    -- color_scheme = "Pandora",
    -- color_scheme = "Grape",
    -- color_scheme = "Firewatch",
    -- color_scheme = "Duotone Dark",
    -- color_scheme = "Sakura",
    -- color_scheme = "lovelace",

    enable_scroll_bar = true,
    exit_behavior = "Close",

    inactive_pane_hsb = {
        hue = 1.0,
        saturation = 1.0,
        brightness = 1.0,
    },

    -- font = wezterm.font(''),
    font = wezterm.font_with_fallback({
        "Roboto Mono",
        "Cascadia Code", 
        "Fira Code"
    }),
    font_size = 12.0,

    default_prog = {'pwsh'},
    -- default_cwd = "/some/path",
    launch_menu = {},

    -- if you want to use leader key, you should set operations on trig.
    -- leader = { key = "b", mods = "CTRL" },
    set_environment_variables = {},

    -- set default theme to dracula official conf
    colors = dracula,
    -- 如果只有一个标签，则隐藏标签栏
    hide_tab_bar_if_only_one_tab = false, 
    -- 显示新建标签按钮在标签栏上
    show_new_tab_button_in_tab_bar = true,  
    -- 开启后标签栏在底部
    tab_bar_at_bottom = false,
    -- 开启后标签栏具有圆角
    use_fancy_tab_bar = false,
    -- 启用标签栏
    enable_tab_bar = true,  -- 注意这里的逗号
    -- 启用滚动条
    enable_scroll_bar = true,  -- 注意这里的逗号
    -- 关闭行为，默认为 "Close"
    exit_behavior = "Close",  -- 注意这里的逗号
    -- 设置窗口背景透明度
    window_background_opacity = 0.94,  -- 注意这里的逗号
    -- 更改字体大小时调整窗口大小
    adjust_window_size_when_changing_font_size = true,

    -- enable feature on open hyperlinks on press ctrl key
    mouse_bindings = { -- Change the default click behavior so that it only selects
    -- text and doesn't open hyperlinks
    {
        event = {
            Up = {
                streak = 1,
                button = "Left"
            }
        },
        mods = "NONE",
        action = wezterm.action.CompleteSelection("PrimarySelection")
    }, -- and make CTRL-Click open hyperlinks
    {
        event = {
            Up = {
                streak = 1,
                button = "Left"
            }
        },
        mods = "CTRL",
        action = wezterm.action.OpenLinkAtMouseCursor
    }, -- Disable the 'Down' event of CTRL-Click to avoid weird program behaviors
    {
        event = {
            Down = {
                streak = 1,
                button = 'Left'
            }
        },
        mods = 'CTRL',
        action = wezterm.action.Nop
    },
    {
        event = {
            Down = {
                streak = 1,
                button = 'Right'
            }
        },
        mods = 'NONE',
        action = wezterm.action.PasteFrom('Clipboard')
    }}
}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    -- config.term = "" -- Set to empty so FZF works on windows
    -- config.term = "xterm"  -- fix bug in command "git log" with "terminal is not fully functional" or delete this term = "xxxx" (using default term value)
    ---------------------------------------------------------------------------------------
    table.insert(config.launch_menu, {
        label = "Command Prompt",
        args = {"cmd.exe"}
    })
    ----------------------------------------------------------------------------------------
    table.insert(config.launch_menu, {
        label = "PowerShell 5",
        args = {"powershell.exe", "-NoLogo"}
    })
    ----------------------------------------------------------------------------------------
    table.insert(config.launch_menu, {
        label = "PowerShell 7",
        args = {"pwsh.exe", "-NoLogo"}
    })
    ----------------------------------------------------------------------------------------
    table.insert(config.launch_menu, {
        label = "Bash",
        args = {"C:\\Program Files\\Git\\bin\\Bash.exe","--login", "-i"}
    })
    ----------------------------------------------------------------------------------------	

    table.insert(config.launch_menu, {
        label = "Cmder",
        args = { "cmd.exe", "/k", "title Cmder & C:\\Users\\Kaishuai\\AppData\\Local\\Programs\\Cmder\\vendor\\init.bat" }
    })
    -----------------------------------------------------------------------------------------
    table.insert(config.launch_menu, {
        label = "Default WSL Command Prompt",
        args = {"wsl"}
    })
    -----------------------------------------------------------------------------------------
    -- 添加 Visual Studio 开发者命令提示符选项
    --table.insert(config.launch_menu, {
    --    label = "Visual Studio Dev Shell",
    --    args = {
    --        "powershell.exe",
    --        "-NoExit",  "-Command", 
    --        "& {Import-Module 'C:\\Program Files\\Microsoft Visual Studio\\2022\\Community\\Common7\\Tools\\Microsoft.VisualStudio.DevShell.dll'; Enter-VsDevShell 4d37fb70 -SkipAutomaticLocation -DevCmdArguments '-arch=x64 -host_arch=x64'}"
    --    }
    --})
    --table.insert(config.launch_menu, {
    --    label = "VS Command Prompt 2022 (PowerShell 7)",
    --    args = {"pwsh", "-NoLogo", "-NoExit", "-ExecutionPolicy", "Bypass", "-NoProfile", "-Command",
    --            " & 'C:\\Program Files\\Microsoft Visual Studio\\2022\\Professional\\Common7\\Tools\\Launch-VsDevShell.ps1'"}
    --})
    --table.insert(config.launch_menu, {
    --    label = "Anaconda PowerShell Prompt",
    --    args = {"pwsh", "-NoLogo", "-NoExit", "-ExecutionPolicy", "Bypass", "-Command",
    --            "& 'C:\\ProgramData\\anaconda3\\shell\\condabin\\conda-hook.ps1' ; conda activate 'C:\\ProgramData\\anaconda3' "}
    --})
    -- table.insert(config.launch_menu, {
    --     label = "VS PowerShell 2022",
    --     args = {"powershell", "-NoLogo", "-NoExit", "-Command", "devps 17.0"}
    -- })
    -- table.insert(config.launch_menu, {
    --     label = "VS PowerShell 2019",
    --     args = {"powershell", "-NoLogo", "-NoExit", "-Command", "devps 16.0"}
    -- })
    -- table.insert(config.launch_menu, {
    --     label = "VS Command Prompt 2022",
    --     args = {"powershell", "-NoLogo", "-NoExit", "-Command", "devcmd 17.0"}
    -- })
    -- table.insert(config.launch_menu, {
    --     label = "VS Command Prompt 2019",
    --     args = {"powershell", "-NoLogo", "-NoExit", "-Command", "devcmd 16.0"}
    -- })

    -- Enumerate any WSL distributions that are installed and add those to the menu
    local success, wsl_list, wsl_err = wezterm.run_child_process({"wsl", "-l"})
    -- `wsl.exe -l` has a bug where it always outputs utf16:
    -- https://github.com/microsoft/WSL/issues/4607
    -- So we get to convert it
    wsl_list = wezterm.utf16_to_utf8(wsl_list)

    for idx, line in ipairs(wezterm.split_by_newlines(wsl_list)) do
        -- Skip the first line of output; it's just a header
        if idx > 1 then
            -- Remove the "(Default)" marker from the default line to arrive at the distribution name on its own

            -- For English Users, the default line:
            -- local distro = line:gsub(" %(Default%)", "")
            
            -- For Chinese User,
            local distro = line:gsub(" %(默认%)", "")

            -- Add an entry that will spawn into the distro with the default shell
            table.insert(config.launch_menu, {
                label = distro .. " (WSL default shell)",
                args = {"wsl", "--distribution", distro}
            })

            -- Here's how to jump directly into some other program; in this example
            -- its a shell that probably isn't the default, but it could also be
            -- any other program that you want to run in that environment
            -- table.insert(config.launch_menu, {
            --     label = distro .. " (WSL zsh login shell)",
            --     args = { "wsl", "--distribution", distro, "--exec", "/bin/zsh", "-l" },
            -- })
        end
    end
else
    -- Not a windows environment
    ----------------------------------------------------------------------------
    table.insert(config.launch_menu, {
        label = "bash",
        args = {"bash", "-l"} -- "-l" for login shell 
    })
    ----------------------------------------------------------------------------
    table.insert(config.launch_menu, {
        label = "tcsh",
        args = {"tcsh", "-l"}
    })
    ----------------------------------------------------------------------------
    table.insert(config.launch_menu, {
        label = "ksh93",
        args = {"zsh93", "-l"}
    })
    ----------------------------------------------------------------------------
    table.insert(config.launch_menu, {
        label = "zsh",
        args = {"zsh", "-l"}
    })
    ----------------------------------------------------------------------------
    table.insert(config.launch_menu, {
        label = "fish",
        args = {"fish", "-l"}
    })
    ----------------------------------------------------------------------------
    table.insert(config.launch_menu, {
        label = "pwsh",
        args = {"pwsh", "-l"}
    })
end

-- get the current run programs for display on tab bar
-- Equivalent to POSIX basename(3)
-- Given "/foo/bar" returns "bar"
-- Given "c:\\foo\\bar" returns "bar"
function Basename(s)
    return string.gsub(s, "(.*[/\\])(.*)", "%2")
end


config.keys = { 
    { key = "n", mods = "ALT", action = wezterm.action { SpawnTab = "DefaultDomain" } },
    { key = "w", mods = "ALT", action = wezterm.action.CloseCurrentTab({ confirm = false }) },
    { key = "LeftArrow", mods = "ALT", action = wezterm.action { ActivateTabRelative = -1 } },
    { key = "RightArrow", mods = "ALT", action = wezterm.action { ActivateTabRelative = 1 } },
    { key = 'o', mods = 'ALT', action = wezterm.action.SpawnCommandInNewTab{ args = { 'ssh', 'openbsd-gw' } } },
    { key = "e", mods = "ALT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },  
    { key = "h", mods = "ALT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "q", mods = "ALT", action = wezterm.action.CloseCurrentPane({ confirm = false }) },
    { key = "LeftArrow", mods = "SHIFT", action = wezterm.action.ActivatePaneDirection("Left") },
    { key = "RightArrow", mods = "SHIFT", action = wezterm.action.ActivatePaneDirection("Right") },
    { key = "UpArrow", mods = "SHIFT", action = wezterm.action.ActivatePaneDirection("Up") },
    { key = "DownArrow", mods = "SHIFT", action = wezterm.action.ActivatePaneDirection("Down") },
    { key = 'U', mods = 'CTRL|SHIFT', action = wezterm.action.AttachDomain 'openbsd' },
}

for i = 1, 9 do
    table.insert(config.keys, {
        key = tostring(i),
        mods = 'ALT',
        action = wezterm.action.ActivateTab(i - 1),
    })
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
    local pane = tab.active_pane
    local title_to_display = ""

    local pane_title = pane.title -- 通常包含远程SSH会话的完整标题，如 user@host:~/path
    local process_name = Basename(pane.foreground_process_name) -- 本地前台进程名，如 cmd.exe, pwsh.exe

    -- 1. 处理 SSH 会话标题
    -- 尝试从 pane.title 中提取主机名
    if pane_title and string.len(pane_title) > 0 then
        local at_pos = string.find(pane_title, "@")
        if at_pos then
            -- 找到了 "@" 符号，很可能是SSH会话
            local colon_pos = string.find(pane_title, ":", at_pos) -- 查找 "@" 之后的 ":"
            local hostname = ""
            if colon_pos then
                -- 如果有 ":"，则取 "@" 和 ":" 之间的部分作为主机名
                hostname = string.sub(pane_title, at_pos + 1, colon_pos - 1)
            else
                -- 如果没有 ":"，则取 "@" 之后的所有部分作为主机名
                hostname = string.sub(pane_title, at_pos + 1)
            end
            
            -- 如果成功提取到主机名，则格式化为 "ssh: 主机名"
            if string.len(hostname) > 0 then
                title_to_display = "ssh: " .. hostname
            end
        end
    end

    -- 2. 如果不是 SSH 会话，或者SSH主机名未成功提取，则处理本地进程名
    if title_to_display == "" then
        -- 移除 .exe 后缀（仅限Windows环境的进程名）
        if string.sub(process_name, -4) == ".exe" then
            title_to_display = string.sub(process_name, 1, -5)
        else
            title_to_display = process_name
        end
    end

    -- 3. 根据 max_width 限制标题宽度 (保留了动态截断功能)
    local padding_space_count = 2 -- 标题前后各一个空格
    local available_width = max_width - padding_space_count

    if available_width < 0 then
        available_width = 0
    end

    if string.len(title_to_display) > available_width then
        if available_width == 0 then
            title_to_display = "…"
        elseif available_width == 1 then
            title_to_display = "."
        else
            -- 确保至少留下一个字符给省略号
            title_to_display = string.sub(title_to_display, 1, available_width - 1) .. "…"
        end
    end

    -- 返回标题，前后各加一个空格以美观
    return {{ Text = " " .. title_to_display .. " " }}
end)

return config
