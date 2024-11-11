-- Send spawn points to client
RegisterNetEvent("desync-spawnselect:getSpawnPoints")
AddEventHandler("desync-spawnselect:getSpawnPoints", function()
    local source = source
    TriggerClientEvent("desync-spawnselect:setSpawnPoints", source, Config.SpawnPoints)
end)
