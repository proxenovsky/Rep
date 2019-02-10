local FPS = 0.0
local fakeWalking = 0

local gui_set = gui.SetValue;
local gui_get = gui.GetValue;
local LeftKey = 0;
local BackKey = 0;
local RightKey = 0;

local rage_ref = gui.Reference("RAGE", "MAIN", "Anti-Aim Main");
local AntiAimleft = gui.Keybox(rage_ref, "Anti-Aim_left", "Manual AA left", 0);
local AntiAimRight = gui.Keybox(rage_ref, "Anti-Aim_Right", "Manual AA Right", 0);
local AntiAimBack = gui.Keybox(rage_ref, "Anti-Aim_Back", "Manual AA Back", 0);

--local rifk7_font = draw.CreateFont("Arial", 15, 700)
local rifk7_font = draw.CreateFont("Arial", 20, 200)
local arrow_font = draw.CreateFont("Arial", 25, 700)
local normal = draw.CreateFont("Arial")

local vis_main = gui.Reference('SETTINGS', "Miscellaneous")
local check_indicator = gui.Checkbox(vis_main, "Enable", "Enable", false)
local ActiveManualAA = gui.Checkbox(vis_main, 'Manual_AA', "Manaul AA", false)
local ActiveIndicators = gui.Checkbox(vis_main, 'Manaul_AA_Indicators', "Manaul AA Indicators", false)
local ActiveDisplayLBY = gui.Checkbox(vis_main, 'Display_LBY_(Estimate)', "Display LBY (Estimate)", false)
local ActiveDisplayPING = gui.Checkbox(vis_main, 'Display_PING', "Display PING", false)
local ping_slider = gui.Slider(vis_main, "Ping_slider", "PING Warning", 40, 10, 200)
local ActiveDisplayFPS = gui.Checkbox(vis_main, 'Display_FPS', "Display FPS", false)
local fps_slider = gui.Slider(vis_main, "Fps_slider", "FPS Waring", 80, 10, 144)
local ActivateFakeWalkIndicator = gui.Checkbox(vis_main, 'Fakewalk_Indicator', "Fakewalk Indicator", false)
local ActivateStandingIndicator = gui.Checkbox(vis_main, 'Standing_Indicator', "Standing Indicator", false)
local ActivateOverrideIndicator = gui.Checkbox(vis_main, 'Override_Indicator', "Override Indicator", false)
local active_x = gui.Checkbox(vis_main, "active_x", "Custom-X", false)
local wight_slider = gui.Slider(vis_main, "wight_slider", "X Pos", 30, 10, 1980)
local active_y = gui.Checkbox(vis_main, "active_y", "Custom-Y", false)
local high_slider = gui.Slider(vis_main, "high_slider", "Y-Pos", 45, 30, 1080)
local active_gap = gui.Checkbox(vis_main, "active_gap", "Custom-Gap", false)
local dis_slider = gui.Slider(vis_main, "dis_slider", "Gap", 25, 0, 100)
local shadowcheck = gui.Checkbox(vis_main, "Ocheck_shadow", "Text-Shadow", false)



local function main()


    if AntiAimleft:GetValue() ~= 0 then
        if input.IsButtonPressed(AntiAimleft:GetValue()) then
            LeftKey = LeftKey + 1;
            BackKey = 0;
            RightKey = 0;
        end
    end
    if AntiAimBack:GetValue() ~= 0 then
        if input.IsButtonPressed(AntiAimBack:GetValue()) then
            BackKey = BackKey + 1;
            LeftKey = 0;
            RightKey = 0;
        end
    end
    if AntiAimRight:GetValue() ~= 0 then
        if input.IsButtonPressed(AntiAimRight:GetValue()) then
            RightKey = RightKey + 1;
            LeftKey = 0;
            BackKey = 0;
        end
    end
end


function CountCheck()
    if (LeftKey == 1) then
        BackKey = 0;
        RightKey = 0;
    elseif (BackKey == 1) then
        LeftKey = 0;
        RightKey = 0;
    elseif (RightKey == 1) then
        LeftKey = 0;
        BackKey = 0;
    elseif (LeftKey == 2) then
        LeftKey = 0;
        BackKey = 0;
        RightKey = 0;
    elseif (BackKey == 2) then
        LeftKey = 0;
        BackKey = 0;
        RightKey = 0;
    elseif (RightKey == 2) then
        LeftKey = 0;
        BackKey = 0;
        RightKey = 0;
    end
end



function SetLeft()
    gui_set("rbot_antiaim_stand_real_add", -90);
    gui_set("rbot_antiaim_move_real_add", -90);

    gui_set("rbot_antiaim_autodir", false);
end

function SetBackWard()
    gui_set("rbot_antiaim_stand_real_add", 0);
    gui_set("rbot_antiaim_move_real_add", 0);

    gui_set("rbot_antiaim_autodir", false);
end

function SetRight()
    gui_set("rbot_antiaim_stand_real_add", 90);
    gui_set("rbot_antiaim_move_real_add", 90);

    gui_set("rbot_antiaim_autodir", false);
end

function SetAuto()
    gui_set("rbot_antiaim_stand_real_add", 0);
    gui_set("rbot_antiaim_move_real_add", 0);

    gui_set("rbot_antiaim_autodir", 1);
end



function draw_indicator()

    local active = check_indicator:GetValue()
    local active_ind = ActiveIndicators:GetValue()
    local active_aa = ActiveManualAA:GetValue()


    if active and active_ind and active_aa then


        local w, h = draw.GetScreenSize();
        if (LeftKey == 1) then
            SetLeft();
            a1, a2, a3 = 200, 0, 200
            arrow = "MANUAL [ < ]"
            draw.SetFont(arrow_font)
			draw.Color ( 255, 0, 255, 255 )
            draw.Text(w / 2 - 100, h / 2 - 14, "«");
            draw.TextShadow(w / 2 - 100, h / 2 - 14, "«");
        elseif (BackKey == 1) then
            SetBackWard();
            a1, a2, a3 = 200, 0, 200
            arrow = "MANUAL [ ^ ]"
            draw.SetFont(arrow_font)
			draw.Color ( 255, 0, 255, 255 )
            draw.Text(w / 2 - 8, h / 2 - 80, "^");
            draw.TextShadow(w / 2 - 8, h / 2 - 80, "^");
        elseif (RightKey == 1) then
            SetRight();
            a1, a2, a3 = 200, 0, 200
            arrow = "MANUAL [ > ]"
            draw.SetFont(arrow_font)
			draw.Color ( 255, 0, 255, 255 )
            draw.Text(w / 2 + 85, h / 2 - 14, "»");
            draw.TextShadow(w / 2 + 85, h / 2 - 14, "»");
        elseif ((LeftKey == 0) and (BackKey == 0) and (RightKey == 0)) then
            SetAuto();
            a1, a2, a3 = 17, 200, 20, 255
            arrow = "AUTOMATIC"
        end

        TextAdd(arrow, a1, a2, a3, 255)
        draw.SetFont(normal)
    end
end




local function GameFPS()
    FPS = 0.9 * FPS + (1.0 - 0.9) * globals.AbsoluteFrameTime();
    return math.floor((1.0 / FPS) + 0.5);
end


local function fakewalk_key_finder()

    local Entity = entities.GetLocalPlayer();
    local Alive = false
    local checkrage = gui.GetValue("rbot_active")
    local rageaa = gui.GetValue("rbot_antiaim_enable")
    if Entity ~= nil then
        Alive = Entity:IsAlive();
    end
    local fakewalk_key = gui.GetValue("rbot_antiaim_fakewalk") --getting the value of the key, use https://www.cambiaresearch.com/articles/15/javascript-char-codes-key-codes to find the key you need
    if fakewalk_key ~= 0 and checkrage and rageaa then
        if (Alive == true) then
            -- you have to check if it's 0 cause if it's 0 and you use it for something the script will crash

            if input.IsButtonDown(fakewalk_key) then
                w1, w2, w3 = 17, 200, 20
            else
                w1, w2, w3 = 150, 71, 71
            end
        else
		w1, w2, w3 = 150, 71, 71
		end
    else
        w1, w2, w3 = 150, 71, 71
    end

    return w1, w2, w3
end


function DrawPingColor()

    local ping_value = ping_slider:GetValue()
    local fakelag_enable = gui.GetValue("msc_fakelag_enable")
    local ping = 0

    if entities.GetPlayerResources() ~= nil then
        ping = entities.GetPlayerResources():GetPropInt("m_iPing", client.GetLocalPlayerIndex())
    end

    if (fakelatency_enable) then
        fakelatency = math.ceil(fakelatency_value * 1000)
        fakea = 255
        if ping > (fakelatency * 0.75) then
            p, i, n = 126, 183, 50

        elseif ping < (fakelatency * 0.75) and ping > (fakelatency * 0.5) then
            fakea = 255
            p, i, n = 255, 165, 0
        elseif ping < (fakelatency * 0.5) and ping > (fakelatency * 0.25) then
            p, i, n = 255, 69, 0
        elseif ping < (fakelatency * 0.25) then
            p, i, n = 255, 0, 0
        end
    end

    if fakelatency_enable ~= true then
        if ping > ping_value then
            p, i, n = 255, 0, 0
        elseif ping < ping_value * 0.85 and ping > ping_value * 0.75 then
            p, i, n = 255, 165, 0
        elseif ping < ping_value * 0.75 then
            p, i, n = 126, 183, 50
        end
    end
    return p, i, n
end

function DrawFPSColor()

    local fps_value = fps_slider:GetValue()

    if GameFPS() > fps_value then
        p1, p2, p3 = 126, 183, 50
    end

    if GameFPS() < fps_value * 0.9 and GameFPS() > (fps_value * 0.8) then
        p1, p2, p3 = 255, 165, 0
    end

    if GameFPS() < (fps_value * 0.8) then
        p1, p2, p3 = 255, 0, 0
    end

    return p1, p2, p3
end

local function DrawPING()

    local w, h = draw.GetScreenSize();
    local local_player = entities.GetLocalPlayer();
    local lowerbody = 0
    local velocity = 0
    local FinalVelocity = 0
    local Alive = false
    if local_player ~= nil then
        lowerbody = local_player:GetProp('m_flLowerBodyYawTarget');
    end
    local active = check_indicator:GetValue()
    local Entity = entities.GetLocalPlayer();
    local active_lby = ActiveDisplayLBY:GetValue()
    local active_ping = ActiveDisplayPING:GetValue()
    local active_fps = ActiveDisplayFPS:GetValue()
    local active_fakewalk = ActivateFakeWalkIndicator:GetValue()
    local active_standing = ActivateStandingIndicator:GetValue()
    local active_override = ActivateOverrideIndicator:GetValue()
  
	local PING = 0

    if Entity ~= nil then
        Alive = Entity:IsAlive();

        local velocityX = Entity:GetPropFloat("localdata", "m_vecVelocity[0]");
        local velocityY = Entity:GetPropFloat("localdata", "m_vecVelocity[1]");

        velocity = math.sqrt(velocityX ^ 2 + velocityY ^ 2);
        FinalVelocity = math.min(9999, velocity) + 0.2;
    end


    if active then

        draw.SetFont(rifk7_font)

        if gui.GetValue("msc_fakelatency_enable") then
            r1, g1, b1 = 17, 200, 20
        else
            r1, g1, b1 = 150, 71, 71
        end




        p1, p2, p3 = DrawPingColor();

  if entities.GetPlayerResources() ~= nil then
        PING = entities.GetPlayerResources():GetPropInt("m_iPing", client.GetLocalPlayerIndex())
    end

        if active_ping then
            TextAdd("PING " .. PING, p1, p2, p3, 255)
        end

        --   if gui.GetValue("msc_fakelatency_enable") then
        --    draw.Color(17, 200, 20, 255);
        -- else
        --    draw.Color(150, 71, 71, 255);
        -- end


        
            r, g, b = 150, 71, 71
      

        if active_lby then
            TextAdd("LBY B ", r, g, b, 255)
        end


        if active_fps then
            p, i, n = DrawFPSColor()
            TextAdd("FPS " .. GameFPS(), p, i, n, 255)
        end

        if active_fakewalk then
            w1, w2, w3 = fakewalk_key_finder()
            TextAdd("FAKEWALK ", w1, w2, w3, 255)
        end

        if entities.GetLocalPlayer() ~= nil then

            draw.Color(255, 255, 255, 255);

            if (Alive) then
                if (math.floor(FinalVelocity) > 0) then
                    v1, v2, v3, v4 = 150, 71, 71, 255
                else
                    v1, v2, v3, v4 = 17, 200, 20, 255
                end
            else
                v1, v2, v3, v4 = 150, 71, 71, 255
            end
        end

        if active_standing and Alive then
            TextAdd("LBY", v1, v2, v3, v4)
        end
        local override_key = gui.GetValue("rbot_resolver_override")

        if override_key ~= 0 then

            if input.IsButtonDown(override_key) then
                do1, o2, o3 = 17, 200, 20
            else
                o1, o2, o3 = 150, 71, 71
            end
        else
            o1, o2, o3 = 150, 71, 71
        end
        if active_override then
            TextAdd("OVERRIDE ", o1, o2, o3, 255)
        end
        TextDrawing()
    end
end

local text_tabl = { {} };


function TextAdd(text, r, g, b, a)
    text_tabl[#text_tabl + 1] = { text, r, g, b, a };
end

function TextDrawing()

    local a_gap = active_gap:GetValue()
    local a_x = active_x:GetValue()
    local a_y = active_y:GetValue()
    local posh = 45
    local posw = 30
    local gap = 15
    local shadow = shadowcheck:GetValue()
    if a_y then
        posh = (high_slider:GetValue())
    end
    if a_x then
        posw = (wight_slider:GetValue())
    end
    if a_gap then
        gap = dis_slider:GetValue()
    end

    sw, sh = draw.GetScreenSize();
	draw.SetFont(normal);
	--draw.Text(sw/sw+10,sh/sh+10,"rifk v0.8  by dummy and dat is klar")
    top_text = sh - (gap * #text_tabl) - posh;
    for i = 1, #text_tabl do
        draw.SetFont(rifk7_font);
        draw.Color(text_tabl[i][2], text_tabl[i][3], text_tabl[i][4], text_tabl[i][5])
        draw.Text(posw, top_text + gap * i, text_tabl[i][1]);
        if shadow then
            draw.TextShadow(posw, top_text + gap * i, text_tabl[i][1])
        end
        draw.SetFont(normal);
    end;
    text_tabl = {}
end


callbacks.Register("Draw", "main", main);
callbacks.Register("Draw", "CountCheck", CountCheck);
callbacks.Register("Draw", "SetLeft", SetLeft);
callbacks.Register("Draw", "SetBackWard", SetBackWard);
callbacks.Register("Draw", "SetRight", SetRight);
callbacks.Register("Draw", "SetAuto", SetAuto);
callbacks.Register("Draw", "draw_indicator", draw_indicator);
callbacks.Register("Draw", "DrawPING", DrawPING)