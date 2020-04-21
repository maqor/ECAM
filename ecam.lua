require 'cairo'

function conky_main()
    local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
    cr = cairo_create(cs)
    
    -- Globale Variablen
    warnings = {}
    messages = {}
    
    -- Anzeigen laden
    cpu_gauge()
    ram_gauge()
    swap_gauge()
    disk_usage_gauge()
    --upload_gauge()
    --download_gauge()
    
    -- Warnungen und Nachrichten laden
    warning()
    message()
    
    -- Zeichnen
    cairo_stroke(cr)
    -- Aufräumen
    cairo_destroy(cr)
    cairo_surface_destroy(cs)
    cr=nil
    
end

function cpu_gauge()
    -- Beschreibungstext
    cpu_desc = "CPU"
    cairo_select_font_face(cr, "B612 Mono", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL);
    cairo_set_font_size(cr, 20)
    cairo_set_source_rgba(cr, 1.0, 1.0, 1.0, 0.8)
    cairo_move_to(cr, 45, 82)
    cairo_show_text(cr, cpu_desc)
    -- Prozessorauslastung auslesen
    cpuload = tonumber(conky_parse("${cpu}"))
    cputext = cpuload.."%"
    -- Informationen auf den Bildschirm schreiben
    cairo_select_font_face(cr, "B612 Mono", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL);
    cairo_set_font_size(cr, 18)
    cairo_set_source_rgba(cr, 0.0, 1.0, 0.0, 1.0)
    cairo_move_to(cr, 170, 108)
    cairo_show_text(cr ,cputext)
    -- Linie zeichnen
    cairo_set_line_width (cr, 2)
    cairo_set_line_cap (cr,CAIRO_LINE_CAP_ROUND)
    ctrx1,ctry1=160, 74
    p_len=60
    cairo_move_to (cr, ctrx1,ctry1)
    angle1=((cpuload * 2.39) -230)
    xval1=ctrx1 + (p_len * (math.cos ((angle1 * (math.pi / 180)))))
    yval1=ctry1 + (p_len * (math.sin ((angle1 * (math.pi / 180)))))
    cairo_line_to (cr, xval1, yval1)
    
end

function ram_gauge()
    -- Beschreibungstext
    ram_desc = "RAM"
    cairo_select_font_face(cr, "B612 Mono", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL);
    cairo_set_font_size(cr, 20)
    cairo_set_source_rgba(cr, 1.0, 1.0, 1.0, 0.8)
    cairo_move_to(cr, 71, 225)
    cairo_show_text(cr, ram_desc)
    -- Speicherauslastung auslesen
    ramload = tonumber(conky_parse("${memperc}"))
    ramtext = ramload.."%"
    -- Informationen auf den Bildschirm schreiben
    cairo_select_font_face(cr, "B612 Mono", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL);
    cairo_set_font_size(cr, 18)
    cairo_set_source_rgba(cr, 0.0, 1.0, 0.0, 1.0)
    cairo_move_to(cr, 72, 197)
    cairo_show_text(cr ,ramtext)
    -- Linie zeichnen
    cairo_set_line_width (cr, 2)
    cairo_set_line_cap (cr,CAIRO_LINE_CAP_ROUND)
    ctrx1,ctry1 = 89, 170
    p_len=53
    cairo_move_to (cr, ctrx1,ctry1)
    angle1=((ramload * 2.3) -205)
    xval1=ctrx1 + (p_len * (math.cos ((angle1 * (math.pi / 180)))))
    yval1=ctry1 + (p_len * (math.sin ((angle1 * (math.pi / 180)))))
    cairo_line_to (cr, xval1, yval1)
end

function swap_gauge()
    -- Beschreibungstext
    swap_desc = "SWAP"
    cairo_select_font_face(cr, "B612 Mono", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL);
    cairo_set_font_size(cr, 20)
    cairo_set_source_rgba(cr, 1.0, 1.0, 1.0, 0.8)
    cairo_move_to(cr, 195, 225)
    cairo_show_text(cr, swap_desc)
    -- Swapauslastung auslesen
    swapload = tonumber(conky_parse("${swapperc}"))
    swaptext = swapload.."%"
    -- Informationen auf den Bildschirm schreiben
    cairo_select_font_face(cr, "B612 Mono", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL);
    cairo_set_font_size(cr, 18)
    cairo_set_source_rgba(cr, 0.0, 1.0, 0.0, 1.0)
    cairo_move_to(cr, 210, 197)
    cairo_show_text(cr, swaptext)
    -- Linie zeichnen
    cairo_set_line_width (cr, 2)
    cairo_set_line_cap (cr,CAIRO_LINE_CAP_ROUND)
    ctrx1,ctry1 = 220, 170
    p_len=53
    cairo_move_to (cr, ctrx1,ctry1)
    angle1=((swapload * 2.3) -205)
    xval1=ctrx1 + (p_len * (math.cos ((angle1 * (math.pi / 180)))))
    yval1=ctry1 + (p_len * (math.sin ((angle1 * (math.pi / 180)))))
    cairo_line_to (cr, xval1, yval1)
end

function disk_usage_gauge()
    -- Beschreibungstext
    du_desc = "DISK USAGE"
    cairo_select_font_face(cr, "B612 Mono", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL);
    cairo_set_font_size(cr, 20)
    cairo_set_source_rgba(cr, 1.0, 1.0, 1.0, 0.8)
    cairo_move_to(cr, 92, 350)
    cairo_show_text(cr, du_desc)
    -- Festplattenauslastung auslesen
    diskusage = tonumber(conky_parse("${fs_used_perc}"))
    disktext = diskusage.."%"
    -- Informationen auf den Bildschirm schreiben
    cairo_select_font_face(cr, "B612 Mono", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL);
    cairo_set_font_size(cr, 18)
    cairo_set_source_rgba(cr, 0.0, 1.0, 0.0, 1.0)
    cairo_move_to(cr, 193, 322)
    cairo_show_text(cr, disktext)
    -- Linie zeichnen
    cairo_set_line_width (cr, 2)
    cairo_set_line_cap (cr,CAIRO_LINE_CAP_ROUND)
    ctrx1,ctry1 = 160, 304
    p_len=53
    cairo_move_to (cr, ctrx1,ctry1)
    angle1=((diskusage * 2.05) -205)
    xval1=ctrx1 + (p_len * (math.cos ((angle1 * (math.pi / 180)))))
    yval1=ctry1 + (p_len * (math.sin ((angle1 * (math.pi / 180)))))
    cairo_line_to (cr, xval1, yval1)
end

function upload_gauge()
    -- Uploadgeschwindigkeit auslesen
    upspeed = tonumber(conky_parse("${upspeedf}"))
    uptext = upspeed.."%"
    -- Informationen auf den Bildschirm schreiben
    cairo_select_font_face(cr, "B612 Mono", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL);
    cairo_set_font_size(cr, 18)
    cairo_set_source_rgba(cr, 0.0, 1.0, 0.0, 1.0)
    cairo_move_to(cr, 193, 295)
    cairo_show_text(cr, uptext)
    -- Linie zeichnen
    cairo_set_line_width (cr, 2)
    cairo_set_line_cap (cr,CAIRO_LINE_CAP_ROUND)
    ctrx1,ctry1 = 160, 276
    p_len=53
    cairo_move_to (cr, ctrx1,ctry1)
    angle1=((upspeed * 2.39) -230)
    xval1=ctrx1 + (p_len * (math.cos ((angle1 * (math.pi / 180)))))
    yval1=ctry1 + (p_len * (math.sin ((angle1 * (math.pi / 180)))))
    cairo_line_to (cr, xval1, yval1)
end

function download_gauge()
    -- Downloadgeschwindigkeit auslesen
    downspeed = tonumber(conky_parse("${downspeedf}"))
    downtext = downspeed.."%"
    -- Informationen auf den Bildschirm schreiben
    cairo_select_font_face(cr, "B612 Mono", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL);
    cairo_set_font_size(cr, 18)
    cairo_set_source_rgba(cr, 0.0, 1.0, 0.0, 1.0)
    cairo_move_to(cr, 193, 295)
    cairo_show_text(cr, downtext)
    -- Linie zeichnen
    cairo_set_line_width (cr, 2)
    cairo_set_line_cap (cr,CAIRO_LINE_CAP_ROUND)
    ctrx1,ctry1 = 160, 276
    p_len=53
    cairo_move_to (cr, ctrx1,ctry1)
    angle1=((downspeed * 2.39) -230)
    xval1=ctrx1 + (p_len * (math.cos ((angle1 * (math.pi / 180)))))
    yval1=ctry1 + (p_len * (math.sin ((angle1 * (math.pi / 180)))))
    cairo_line_to (cr, xval1, yval1)
end

function warning()
    check_battery()
end

function message()
    check_ac_power()
    check_con()
end

function check_battery()
    --print(conky_parse("${battery_percent 1}"))
    if tonumber(conky_parse("${battery_percent }")) <= 20 and conky_parse("${acpiacadapter}") ~= "on-line" then
        bat_warn = "LOW BATTERY"
        bat_adv = "Connect to ext. power"
        cairo_select_font_face(cr, "B612 Mono", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL);
        cairo_set_font_size(cr, 20)
        cairo_set_source_rgba(cr, 1.0, 0.05, 0.0, 1.0)
        cairo_move_to(cr, 20, 440)
        cairo_show_text(cr, bat_warn)
        cairo_set_font_size(cr, 12)
        cairo_set_source_rgba(cr, 0.7, 1.0, 0.9, 1.0)
        cairo_move_to(cr, 30, 455)
        cairo_show_text(cr, bat_adv)
   end
end

function check_ac_power()
    if conky_parse("${acpiacadapter}") == "on-line" then
        gpu_con = "GPU"
        cairo_select_font_face(cr, "B612 Mono", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL);
        cairo_set_font_size(cr, 20)
        cairo_set_source_rgba(cr, 0.0, 0.7, 0.0, 1.0)
        cairo_move_to(cr, 240, 440)
        cairo_show_text(cr, gpu_con)
    end
end

function check_con()
    if conky_parse("${wireless_essid wlan0}") ~= null then
        wireless_con = "CON:W"
        cairo_select_font_face(cr, "B612 Mono", CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_NORMAL);
        cairo_set_font_size(cr, 20)
        cairo_set_source_rgba(cr, 0.0, 0.7, 0.0, 1.0)
        cairo_move_to(cr, 235, 470)
        cairo_show_text(cr, wireless_con)
    end
end
