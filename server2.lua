reports = {
    {1, "System", "This is a test, you may ignore this!"},
}

AddEventHandler('playerJoining', function()
    TriggerClientEvent('updatePlayerList', -1)
end)
AddEventHandler('playerEnteredScope', function()
    TriggerClientEvent('updatePlayerList', -1)
end)
AddEventHandler('playerLeftScope', function()
    TriggerClientEvent('updatePlayerList', -1)
end)
AddEventHandler('onResourceStart', function()
    TriggerClientEvent('updatePlayerList', -1)
end)

RegisterServerEvent('updateReports')
AddEventHandler('updateReports', function(data)
    -- Code
    -- Code End
    TriggerClientEvent('updateReportsList', -1, reports)
end)

RegisterCommand('report', function(source, args, rawCommand)
    local reporter = tostring(GetPlayerName(source))
    local message = tostring(args)
    local id = #reports + 1
    local r = {}
    table.insert(r, id)
    table.insert(r, reporter)
    table.insert(r, message)
    --
    table.insert(reports, r)
    TriggerClientEvent('updateReportsList', -1, reports)
    print(tostring(reports))
end)