--DO NOT TOUCH ANJENG!
posmag = 1
totalmag = #magplant.posx
totalblock = {0}
mulai = false
jalan = true
change = false
makanclover = false
cloverDrop = 0
isiblock = 0
time = os.time()
time2 = ""
start_time = 0
totalbgems = 0
BGemsDroped = 0
totalblockbreak = 0
lastwebhookUpdate = os.time()

function webhook(text)
    local t = os.time() - time
    local date_obj = os.date("*t", t)
    date_obj.hour = date_obj.hour - 8
    local timestamp = string.format("%02d:%02d:%02d", date_obj.hour, date_obj.min, date_obj.sec)
    local timestampEmbed = os.date("!%Y-%m-%dT%H:%M:%SZ")
    local payload = [[{
        "content": "",
        "embeds": [{
            "title": "Auto PNB Change Mag",
            "description": "**<:Megaphone:1098981347667751003> ]].. text ..[[**",
            "color": 16741096,
            "fields": [
            {
                "name": "<:OnlineStatus:1098981372984565841> Ping",
                "value": "➥ `]].. math.floor(GetPing()) ..[[`",
                "inline": true
            },
            {
                "name": "<:Growtopian:1098981370988068885> Name",
                "value": "➥ `]].. removeColorAndSymbols(GetLocal().name) ..[[`",
                "inline": true
            },
            {
                "name": "<:Earth:1098981367523590214> World",
                "value": "➥ `]].. GetLocal().world ..[[`",
                "inline": true
            },
            {
                "name": "<:LuckyClover:1098985409154908280> Clover Stock",
                "value": "➥ `]].. math.floor(countCloverInv()) ..[[`",
                "inline": true
            },
            {
                "name": "<:Gems:1098981361139863686> Total Gems",
                "value": "➥ `]].. format_int(math.floor(GetLocal().gems)) ..[[`",
                "inline": true
            },
            {
                "name": "<:BGems:1098981610222792834> Total BGems",
                "value": "➥ `]].. format_int(math.floor(totalbgems)) ..[[`",
                "inline": true
            },
            {
                "name": "<:Magplant:1089704391205998682> Current Magplant",
                "value": "➥ `[]].. magplant.posx[posmag] ..[[,]].. magplant.posy[posmag] ..[[]`",
                "inline": true
            },
            {
                "name": "<:POG:1098981355771133985> Block in Magplant",
                "value": "➥ `]].. format_int(isiblock) ..[[`",
                "inline": true
            },
            {
                "name": "<:Clock:1089704385937948692> Script Running",
                "value": "➥ `]].. timestamp..[[`",
                "inline": true
            }
            ],
            "author": {
                "name": "VinnProject",
                "icon_url": "https://cdn.discordapp.com/attachments/1087044029696442489/1098984099164729475/VinnPedia.png"
            },
            "footer": {
                "text": "Version 2.0 | Updating every ]].. math.floor(delaywebhook) ..[[ seconds"
            },
            "timestamp": "]].. timestampEmbed ..[["
        }]
    }]]
    local webhook = url
    SendWebhook(webhook, payload)
end

gemscount = 0
localgems = 0
function countGems()
    gemscount = GetLocal().gems - localgems
end

function countCloverInv()
    local count = 0
    for _,inv in pairs(GetInventory()) do
        if inv.id == 528 then
            count = count + inv.count
        end
    end
    return count
end

function punch(x, y)
    pkt = {}
    pkt.type = 3
    pkt.int_data = 18
    pkt.int_x = math.floor(GetLocal().pos_x // 32 + x)
    pkt.int_y = math.floor(GetLocal().pos_y // 32 + y)
    pkt.pos_x = GetLocal().pos_x
    pkt.pos_y = GetLocal().pos_y 
    SendPacketRaw(pkt)
end

function removeColorAndSymbols(str)
    local cleanedStr = string.gsub(str, "`(%S)", '')
    cleanedStr = string.gsub(cleanedStr, "`{2}|(~{2})", '')
    return cleanedStr
end

function Start()
    if collectgems then
        SendPacket(2, "action|dialog_return\ndialog_name|cheats\ncheck_autofarm|1\n|check_bfg|1\ncheck_autospam|0\ncheck_autopull|0\ncheck_autoplace|0\ncheck_antibounce|0\ncheck_modfly|0\ncheck_speed|0\ncheck_gravity|0\ncheck_lonely|0\ncheck_fastdrop|0\ncheck_gems|1")
    else
        SendPacket(2, "action|dialog_return\ndialog_name|cheats\ncheck_autofarm|1\n|check_bfg|1\ncheck_autospam|0\ncheck_autopull|0\ncheck_autoplace|0\ncheck_antibounce|0\ncheck_modfly|0\ncheck_speed|0\ncheck_gravity|0\ncheck_lonely|0\ncheck_fastdrop|0\ncheck_gems|0")
    end
end

function Stop()
    if collectgems then
        SendPacket(2, "action|dialog_return\ndialog_name|cheats\ncheck_autofarm|0\n|check_bfg|0\ncheck_autospam|0\ncheck_autopull|0\ncheck_autoplace|0\ncheck_antibounce|0\ncheck_modfly|0\ncheck_speed|0\ncheck_gravity|0\ncheck_lonely|0\ncheck_fastdrop|0\ncheck_gems|1")
    else
        SendPacket(2, "action|dialog_return\ndialog_name|cheats\ncheck_autofarm|0\n|check_bfg|0\ncheck_autospam|0\ncheck_autopull|0\ncheck_autoplace|0\ncheck_antibounce|0\ncheck_modfly|0\ncheck_speed|0\ncheck_gravity|0\ncheck_lonely|0\ncheck_fastdrop|0\ncheck_gems|0")
    end
end

function getPosX()
    return math.floor(GetLocal().pos_x / 32)
end

function getPosY()
    return math.floor(GetLocal().pos_y / 32)
end

function consumeClover()
    place(528)
    Sleep(500)
end

function place(ID)
    local id = ID
    local pkt = {}
    pkt.type = 3
    pkt.int_data = id
    pkt.pos_x = GetLocal().pos_x
    pkt.pos_y = GetLocal().pos_y
    pkt.int_x = getPosX()
    pkt.int_y = getPosY()
    pkt.flags = 2560
    SendPacketRaw(pkt)
end

function GetRemote()
    SendPacket(2, "action|dialog_return\ndialog_name|magplant_edit\nx|".. magplant.posx[posmag] .."|\ny|".. magplant.posy[posmag] .."|\nbuttonClicked|getRemote")
end

function SuckBGEMS()
    if collectgems then
        Sleep(500)
    else
        SendPacket(2, "action|dialog_return\ndialog_name|social\nbuttonClicked|bgem_suckall")
        Sleep(500)
    end
    
end

function OnConsoleMessage(text)
    var = {}
    var[0] = "OnConsoleMessage"
    var[1] = "`0[`# VinnProject `0] `9" ..text
    var.netid = -1
    SendVarlist(var)
end

function wrenchTile(x,y)
    pkt = {}
    pkt.type = 3
    pkt.int_data = 32
    pkt.int_x = x
    pkt.int_y = y
    pkt.pos_x = GetLocal().pos_x
    pkt.pos_y = GetLocal().pos_y
    SendPacketRaw(pkt)
end

function clearBlock()
    for y = 0, 199 do
        for x = 0, 199 do
            if GetTile(x,y).fg == IDBlock then
                FindPath(x-1,y)
                Sleep(500)
                punch(1,0)
                Sleep(500)
            end
        end
    end

end

function Disconnect()
    if GetLocal().world ~= world then
        localgems = 0
        while GetLocal().world ~= world do
            webhook("Disconnected, trying to reconnect...")
            if GetLocal().world ~= world then
                SendPacket(3, "action|join_request\nname|".. world .."\n")
                Sleep(delaydc)
            end
        end
        webhook("Connected, continuing break...")
        clearBlock()
        Sleep(500)
        FindPath(magplant.posx[posmag],magplant.posy[posmag]-1)
        Sleep(1000)
        wrenchTile(magplant.posx[posmag],magplant.posy[posmag])
        Sleep(500)
        GetRemote()
        Sleep(1000)
        Start()
    else
        webhook("Disconnected, trying to reconnect...")
        FindPath(magplant.posx[posmag],magplant.posy[posmag]-1)
        Sleep(1000)
        wrenchTile(magplant.posx[posmag],magplant.posy[posmag])
        Sleep(500)
        GetRemote()
        Sleep(1000)
        webhook("Continuing break...")
        Start()
    end
end

function CheckMAG()
    if change then
        Sleep(3000)
        Stop()
        ::SELESAI::
        Sleep(1000)
        if posmag ~= totalmag then
            clearBlock()
            isiblock = 0
            localgems = GetLocal().gems
            SuckBGEMS()
            Sleep(500)
            webhook("Changing mag...")
            posmag = posmag + 1
            ::ATAS::
            FindPath(magplant.posx[posmag],magplant.posy[posmag]-1)
            Sleep(1000)
            wrenchTile(magplant.posx[posmag],magplant.posy[posmag])
            Sleep(500)
            totalblock[posmag] = isiblock
            if isiblock == 0 then
                if posmag ~= totalmag then
                    posmag = posmag + 1
                    goto ATAS
                else
                    goto SELESAI  
                end
            end
            GetRemote()
            Sleep(1000)
            Start()
            webhook("Breaking...")
            lastwebhookUpdate = os.time()
            change = false
        else
            localgems = GetLocal().gems
            Sleep(500)
            webhook("All magplant empty...")
            jalan = false
            RemoveCallbacks()
            Sleep(2000)
        end
    end
end

function CheckRemote()
    remote = false
    for _,cur in pairs(GetInventory()) do
        if cur.id == 5640 then remote = true end
    end
    if not remote then Disconnect() end
end

function CheckDC()
    if GetTile(GetLocal().tile_x, GetLocal().tile_y).fg == 6 or GetTile(GetLocal().tile_x, GetLocal().tile_y).fg == 6548 or GetLocal().world == "EXIT" then
        Disconnect()
    end
end

function checkmag(varlist, packet)
    if varlist[0]:find("OnDialogRequest") and varlist[1]:find("end_dialog|magplant_edit") then
        if varlist[1]:find("add_label|small|Building mode: `6DISABLED``") then
            isiblock = 0
            return true
        end
        local matches = varlist[1]:match("`w(%d+)`` items")
        local magcount = tonumber(matches)
        OnConsoleMessage("Total Block in Magplant : "..magcount)
        isiblock = magcount
        return true
    end
end

function checkbgem(varlist, packet)
    if varlist[0]:find("OnDialogRequest") and varlist[1]:find("The Black Gem Bank") then
        local matches = varlist[1]:match("You have `$(%d+)``")
        local bgemcount = tonumber(matches)
        OnConsoleMessage("Total BGems in the Bank : "..bgemcount)
        totalbgems = bgemcount
        return true
    end
end

function emptymag(varlist, packet)
    if varlist[0]:find("OnTalkBubble") and varlist[1] == GetLocal().netid and varlist[2]:find("is empty") then
        change = true
    end
end

function antilag(packet)
    if packet.type == 8 or packet.type == 17 then
        return true
    end
end

function format_int(number)
    local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')
    int = int:reverse():gsub("(%d%d%d)", "%1,")
    return minus .. int:reverse():gsub("^,", "") .. fraction
end

function checkEmptyMag()
    ::ATAS::
    FindPath(magplant.posx[posmag],magplant.posy[posmag]-1)
    Sleep(500)
    wrenchTile(magplant.posx[posmag],magplant.posy[posmag])
    Sleep(500)
    if isiblock == 0 then
        if posmag ~= totalmag then
            posmag = posmag + 1
            goto ATAS
        else
            change = true
            CheckMAG()
        end
    end
end

function StartTrue()
    if not mulai then
        Stop()
        RemoveCallbacks()
        AddCallback("CheckMAG","OnVarlist",checkmag)
        AddCallback("CheckBGem","OnVarlist",checkbgem)
        AddCallback("CheckEmpty","OnVarlist",emptymag)
        AddCallback("AntiLag","OnIncomingRawPacket",antilag)
        os.setlocale('en_US.UTF-8', 'time', 'Asia/Makassar')
        clearBlock()
        Sleep(1000)
        SendPacket(2, "action|dialog_return\ndialog_name|social\nbuttonClicked|bgems")
        Sleep(1000)
        webhook("Script Executed...")
        Sleep(500)
        checkEmptyMag()
        if jalan then
            FindPath(magplant.posx[posmag],magplant.posy[posmag]-1)
            Sleep(500)
            wrenchTile(magplant.posx[posmag],magplant.posy[posmag])
            Sleep(500)
            totalblock[posmag] = isiblock
            GetRemote()
            Sleep(1000)
            consumeClover()
            Sleep(500)
            Start()
            webhook("Breaking...")
            mulai = true
            time2 = os.time()
            localgems = GetLocal().gems
            start_time = os.time()
            lastwebhookUpdate = os.time()
        end
    else
        if os.time() - start_time >= 1800 then
            Stop()
            webhook("Consuming Clover...")
            Sleep(500)
            consumeClover()
            Sleep(500)
            Start()
            start_time = os.time()
        end
        SuckBGEMS()
        CheckDC()
        CheckRemote()
        CheckMAG()
        Sleep(1000)
        if os.time() - lastwebhookUpdate >= delaywebhook then
            SendPacket(2, "action|dialog_return\ndialog_name|social\nbuttonClicked|bgems")
            localgems = GetLocal().gems
            Sleep(1000)
            wrenchTile(magplant.posx[posmag],magplant.posy[posmag])
            Sleep(1000)
            webhook("Breaking...")
            lastwebhookUpdate = os.time()
        end
    end
end

while jalan do
    StartTrue()
end
