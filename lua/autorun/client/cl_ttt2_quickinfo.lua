-- Notes

-- https://github.com/TTT-2/TTT2/blob/vgui-rework/lua/ttt2/extensions/draw.lua draw.OutlinedBox
-- https://github.com/TTT-2/TTT2/blob/vgui-rework/gamemodes/terrortown/gamemode/shared/sh_util.lua color darken and so on
-- https://github.com/TTT-2/TTT2/blob/master/gamemodes/terrortown/gamemode/client/cl_fonts.lua Shadowed stuff


local draw = draw
-- local center = Vector(ScrW()*0.5,ScrH()*0.5,0) -- May be useful later.
local primarycolor = VSKIN.GetBackgroundColor()
local transparentprimary = ColorAlpha(primarycolor, 200)
local outlinecolor = util.GetDefaultColor(primarycolor)

local function screenGrid(x, y, xend, yend)
    y = y or x
    xend = xend or x
    yend = yend or y

    x = ScrW() / 12 * x
    xend = ScrW() / 12 * xend
    y = ScrH() / 12 * y
    yend = ScrH() / 12 * yend
    return x, y, xend, yend
end

local function drawQuickinfo()
    hook.Add("DrawOverlay", "TTT2DrawQuickinfo", function()
        -- get classcolor
        local roleColor = LocalPlayer():GetRoleColor()
        local roleColorText = util.GetDefaultColor(roleColor)

        --Main Background
        draw.Box(screenGrid(0, 1, 12, 11), 1, transparentprimary)
        draw.OutlinedBox(screenGrid(0, 1, 12, 11), 1, outlinecolor)
        draw.ShadowedText("TTT2 by Alf21, Saibotk, Minetopia, Lebroomer - Quickinfo by James", screenGrid(0, 0), roleColorText, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 0.5)


        --Role Title Strip
        draw.Box(screenGrid(0, 1, 12, 11), 1, roleColor)
        draw.OutlinedBox(screenGrid(0, 1, 12, 11), 1, outlinecolor)
        -- Roletext
        draw.ShadowedText("STR_ROLE", "Trebuchet24", screenGrid(7, 2.5), roleColorText, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2) -- WILL BE REPLACED BY THE ACTUAL ROLE STRING ONCE THAT IS IMPLEMENTED


        draw.Box(screenGrid(0, 2, 12, 3), 3, primarycolor)
        draw.OutlinedBox(screenGrid(0, 2, 12, 3), 3, outlinecolor)
        -- Role Description
        local desc_wrapped = draw.GetWrappedText("STR_ROLEDESCRIPTION WHICH IS FOR SOME REASON STUPIDLY LONG HOLY COW I SHOULD STOP NOW FOR THE SAKE OF ALL PEOPLE THAT ARE INVOLVED IN THIS FACILITY AND I AM AND I AM AND I AM", ({screenGrid(10)})[1], "Trebuchet24") --Stupid text quickly written on mobile device using autocucumber

        local lineheight = 2.5
        for i = 1, #desc_wrapped do
            line_pos = screenGrid(lineheight)
            draw.ShadowedText(
                desc_wrapped[i],
                "Trebuchet24",
                screenGrid(6),
                line_pos[1],
                colorDescription,
                TEXT_ALIGN_CENTER,
                TEXT_ALIGN_CENTER
            )
            lineheight = lineheight + 0.1
        end

        --Miniinfo
        --    draw.Box(screenGrid(1, 4, 11, 6), 3, primarycolor)
        --    draw.OutlinedBox(screenGrid(1, 4, 11, 6), 3, outlinecolor)
        --

        --Infopane 1
        draw.Box(screenGrid(1, 6, 6, 10), 3, primarycolor)
        draw.OutlinedBox(screenGrid(1, 6, 6, 10), 3, outlinecolor)

        -- Text Infopane 1 Title
        draw.ShadowedText("Hints", "Trebuchet24", screenGrid(7, 2.5), roleColorText, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1.5)

        -- Text Infopane 1 Text
        draw.ShadowedText("Hints", "Trebuchet24", screenGrid(7, 2.5), roleColorText, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1.5)
        local hint_wrapped = draw.GetWrappedText("STR_ROLEDESCRIPTION WHICH IS FOR SOME REASON STUPIDLY LONG HOLY COW I SHOULD STOP NOW FOR THE SAKE OF ALL PEOPLE THAT ARE INVOLVED IN THIS FACILITY AND I AM AND I AM AND I AM", ({screenGrid(10)})[1], "Trebuchet24") --Stupid text quickly written on mobile device using autocucumber

        local hintlineheight = 2.5
        for i = 1, #hint_wrapped do
            hintline_pos = screenGrid(hintlineheight)
            draw.ShadowedText(
                hint_wrapped[i],
                "Trebuchet24",
                screenGrid(6),
                hintline_pos[1],
                colorDescription,
                TEXT_ALIGN_CENTER,
                TEXT_ALIGN_CENTER
            )
            hintlineheight = hintlineheight + 0.1
        end

        --Infopane 2
        draw.Box(screenGrid(8, 6, 11, 10), 3, primarycolor)
        draw.OutlinedBox(screenGrid(8, 6, 11, 10), 3, outlinecolor)

    end)
end

function clearQuickinfo()


end


bind.Register("Quickinfo", drawQuickinfo(), clearQuickinfo(), "Miscellaneous", "Show Quick Roleinfo", MOUSE3)
