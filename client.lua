selectedCharId = nil

-- Show the spawn selection UI
RegisterNetEvent("desync-spawnselect:ShowUI")
AddEventHandler("desync-spawnselect:ShowUI", function(characterId)
    selectedCharId = characterId
    SetNuiFocus(true, true)
<<<<<<< HEAD
    -- TriggerServerEvent("desync-spawnselect:getSpawnPoints")

    SendNUIMessage({
        type = 'setSpawnPoints',
        points = Config.SpawnPoints
    })

=======
    TriggerEvent("desync-spawnselect:setSpawnPoints", Config.SpawnPoints)
>>>>>>> a96a10e9b06c5f32ee77a0667deaae34049d6b16
    SendNUIMessage({
        type = 'ui',
        status = true
    })
end)

-- Receive spawn points from server
RegisterNetEvent("desync-spawnselect:setSpawnPoints")
AddEventHandler("desync-spawnselect:setSpawnPoints", function(spawnPoints)
    SendNUIMessage({
        type = 'setSpawnPoints',
        points = spawnPoints
    })
end)

-- Handle spawn selection from UI
RegisterNUICallback('spawnAtLocation', function(data, cb)
    SetNuiFocus(false, false)

    -- Cleanup multichar
    TriggerEvent("desync-multichar:cleanup")
    
    -- Hide UI first
    SendNUIMessage({
        type = 'ui',
        status = false
    })

    -- Trigger spawn manager to handle the actual spawning

    local characterData = {
        characterId = selectedCharId,
        coords = vector4(tonumber(data.coords.x), tonumber(data.coords.y), tonumber(data.coords.z), tonumber(data.coords.heading) or 0.0)
    }

    local success = lib.callback.await("desync-core:SetSelfToDefaultRoutingBucket", false)
    -- print(success)

    TriggerServerEvent("desync-spawnmanager:RequestSpawn", characterData)

    -- TriggerEvent("desync-spawnmanager:requestSpawn", {
    --     characterId = selectedCharId,
    --     coords = {
    --         x = tonumber(data.coords.x),
    --         y = tonumber(data.coords.y),
    --         z = tonumber(data.coords.z),
    --         heading = tonumber(data.coords.heading) or 0.0
    --     }
    -- })
    
    selectedCharId = nil
    cb({success = true})
end)

-- Hide UI callback
RegisterNUICallback('hideUI', function(_, cb)
    SetNuiFocus(false, false)
    cb({})
end)
