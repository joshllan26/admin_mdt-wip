--- VARS ---
local players = {}
local reports = {}
local notepad = nil

--- CODE ---

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if IsControlPressed(0, 171) then -- CAPSLOCK
            if IsControlJustReleased(0, 244) then -- M
                OpenMenu()
            end
        end
    end
end)

RegisterNetEvent('updatePlayerList')
AddEventHandler('updatePlayerList', function()
    players= {}

    players = GetActivePlayers()
end)

RegisterNetEvent('updateReportsList')
AddEventHandler('updateReportsList', function(data)
    reports = {}

    reports = data
end)

--- FUNCTIONS ---
function OpenMenu()
    TriggerServerEvent('fetchServerReports')
    Citizen.Wait(300)
    SendPlayers()
    SendReports()
    SendNotes()
    SetNuiFocus(true,true)
    SendNUIMessage({type = "open"})
end

function SendPlayers()
    if players == nil then
        players = GetActivePlayers()
    end

    for i = 1, #players do
        local pname = GetPlayerName(players[i])
        local pid = players[i]

        SendNUIMessage({type = "update", item = "player", player_id = pid, player_name = pname, player_rank = 0})
    end
end

function SendReports()
    if not reports == nil then
        for i = 1, #reports do
            local report = reports[i]
            local id = report[1]
            local name = report[2]
            local content = report[3]

            SendNUIMessage({type = "update", item = "report", report_id = id, reporting_user = name, report_content = content})
        end
    end
end

function SendNotes()
    if notepad ~= nil then
        SendNUIMessage({type = "update", item = "notepad", content = notepad})
    end
end