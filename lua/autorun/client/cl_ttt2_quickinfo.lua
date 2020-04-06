-- Notes

-- https://github.com/TTT-2/TTT2/blob/vgui-rework/lua/ttt2/extensions/draw.lua draw.OutlinedBox
-- https://github.com/TTT-2/TTT2/blob/vgui-rework/gamemodes/terrortown/gamemode/shared/sh_util.lua color darken and so on
-- https://github.com/TTT-2/TTT2/blob/master/gamemodes/terrortown/gamemode/client/cl_fonts.lua Shadowed stuff
hook.Add("OnGamemodeLoaded","quickinfo_gamemode_loaded",function()
    surface.CreateAdvancedFont("quickinfo_peignot64", {font = "Peignot", size = 64, weight = 900})
    surface.CreateAdvancedFont("quickinfo_peignot24", {font = "Peignot", size = 24, weight = 900})
end)



local draw = draw
-- local center = Vector(ScrW()*0.5,ScrH()*0.5,0) -- May be useful later.

local function scrGrid(place, axis, gridsize)
    local out
    if axis == "x" then
        out = ScrW() / gridsize * place
    elseif axis == "y" then
        out = ScrH() / gridsize * place
    end
    return out
end

local function drawQuickinfo()
    hook.Add("PostRenderVGUI", "TTT2DrawQuickinfo", function()

        local primarycolor = vskin.GetBackgroundColor()

        local transparentprimary = ColorAlpha(primarycolor, 210)
        local outlinecolor = util.GetDefaultColor(primarycolor)

        -- get classcolor
        local roleColor = LocalPlayer():GetRoleColor()
        local roleColorText = util.GetDefaultColor(roleColor)
        local str_role = LANG.TryTranslation(roles.GetByIndex(LocalPlayer():GetSubRole()).name)

        --Main Background
        --	   	draw.Box(screenGrid(0, 1, 12, 11), transparentprimary)
        draw.Box(
            scrGrid(0, "x", 12),
            scrGrid(1, "y", 12),
            scrGrid(12, "x", 12),
            scrGrid(10, "y", 12),
            transparentprimary
        ) --Uses relative coordinates for the width and height!

        draw.OutlinedBox(scrGrid(-1, "x", 12), scrGrid(1, "y", 12), scrGrid(14, "x", 12), scrGrid(10, "y", 12), 5, outlinecolor)
        draw.ShadowedText("TTT2 by Alf21, Saibotk, Minetopia, Lebroomer - Quickinfo by James", "quickinfo_peignot24", 0, 0, roleColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1)

        --Role Title Strip
        draw.Box(scrGrid(0, "x", 12), scrGrid(2, "y", 12), scrGrid(12, "x", 12), scrGrid(1, "y", 12), roleColor) --Uses relative coordinates for the width and height!
        draw.OutlinedBox(scrGrid(-1, "x", 12), scrGrid(2, "y", 12), scrGrid(14, "x", 12), scrGrid(1, "y", 12), 1, outlinecolor)

        draw.ShadowedText(
            str_role,
            "quickinfo_peignot64",
            scrGrid(6, "x", 12),
            scrGrid(2.5, "y", 12),
            roleColorText,
            TEXT_ALIGN_CENTER,
            TEXT_ALIGN_CENTER,
            1
        )

        -- Role Description BG
        draw.Box(scrGrid(1, "x", 12), scrGrid(4, "y", 12), scrGrid(10, "x", 12), scrGrid(1, "y", 12), primarycolor)
        draw.OutlinedBox(scrGrid(1, "x", 12), scrGrid(4, "y", 12), scrGrid(10, "x", 12), scrGrid(1, "y", 12), 1, outlinecolor)
        -- Role Description
        local desc_wrapped = draw.GetWrappedText(
        "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", scrGrid(9.5, "x", 12), "quickinfo_peignot24") --Stupid text quickly written on mobile device using autocucumber

        local lineheight = 2.4
        for i = 1, #desc_wrapped do
            line_pos = scrGrid(lineheight, "x", 12)
            draw.ShadowedText(
                desc_wrapped[i],
                "quickinfo_peignot24",
                scrGrid(6, "x", 12),
                line_pos,
                roleColor,
                TEXT_ALIGN_CENTER,
                TEXT_ALIGN_CENTER
            )
            lineheight = lineheight + 0.125
        end
        --Miniinfo
        --	draw.Box(screenGrid(1, 4, 11, 6), 3, primarycolor)
        --	draw.OutlinedBox(screenGrid(1, 4, 11, 6), 3, outlinecolor)
        --

        --Infopane 1
        draw.Box(
            scrGrid(1, "x", 12),
            scrGrid(6, "y", 12),
            scrGrid(5, "x", 12),
            scrGrid(4, "y", 12),
            primarycolor
        )

        draw.OutlinedBox(
            scrGrid(1, "x", 12),
            scrGrid(6, "y", 12),
            scrGrid(5, "x", 12),
            scrGrid(4, "y", 12),
            1,
            outlinecolor
        )

        draw.Line(
            scrGrid(1, "x", 12),
            scrGrid(7, "y", 12),
            scrGrid(6, "x", 12),
            scrGrid(7, "y", 12),
            outlinecolor
        )

        -- Text Infopane 1 Title
        draw.ShadowedText(
            "Sick gameplay strats",
            "quickinfo_peignot24",
            scrGrid(3.5,"x", 12),
            scrGrid(6.5, "y", 12),
            outlinecolor,
            TEXT_ALIGN_CENTER,
            TEXT_ALIGN_CENTER
        )

        -- Text Infopane 1 Textw
        local hint_wrapped = draw.GetWrappedText("Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", scrGrid(3, "x", 12), "quickinfo_peignot24") --Stupid text quickly written on mobile device using autocucumber

        local hintlineheight = 4.25
        for i = 1, #hint_wrapped do
            hintline_pos = scrGrid(hintlineheight, "x", 12)
            draw.SimpleText(
                hint_wrapped[i],
                "quickinfo_peignot24",
                scrGrid(3.5, "x", 12),
                hintline_pos,
                outlinecolor,
                TEXT_ALIGN_CENTER,
                TEXT_ALIGN_CENTER
            )
            hintlineheight = hintlineheight + 0.125
        end

        -- Infopane 2
        draw.Box(scrGrid(6, "x", 12), scrGrid(6, "y", 12), scrGrid(5, "x", 12), scrGrid(4, "y", 12), primarycolor)
        draw.OutlinedBox(scrGrid(6, "x", 12), scrGrid(6, "y", 12), scrGrid(5, "x", 12), scrGrid(4, "y", 12), 1, outlinecolor)
        draw.Line(scrGrid(6, "x", 12), scrGrid(7, "y", 12), scrGrid(11, "x", 12), scrGrid(7, "y", 12), outlinecolor)
        -- Text Infopane 1 Title
        draw.ShadowedText("Current Settings", "quickinfo_peignot24", scrGrid(8.5, "x", 12), scrGrid(6.5, "y", 12), outlinecolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.Line(scrGrid(6, "x", 12), scrGrid(8.5, "y", 12), scrGrid(11, "x", 12), scrGrid(8.5, "y", 12), outlinecolor)

        draw.Line(scrGrid(7, "x", 12), scrGrid(7, "y", 12), scrGrid(7, "x", 12), scrGrid(10, "y", 12), outlinecolor)
        draw.Line(scrGrid(8, "x", 12), scrGrid(7, "y", 12), scrGrid(8, "x", 12), scrGrid(10, "y", 12), outlinecolor)
        draw.Line(scrGrid(9, "x", 12), scrGrid(7, "y", 12), scrGrid(9, "x", 12), scrGrid(10, "y", 12), outlinecolor)
        draw.Line(scrGrid(10, "x", 12), scrGrid(7, "y", 12), scrGrid(10, "x", 12), scrGrid(10, "y", 12), outlinecolor)

    end)
end

function clearQuickinfo()
    hook.Remove("PostRenderVGUI", "TTT2DrawQuickinfo")
end

print("Register Keybind!")
bind.Register("Quickinfo", drawQuickinfo, clearQuickinfo, nil, "Show Quick Roleinfo", KEY_E)
print("Loaded TTT2 Quickinfo!")
