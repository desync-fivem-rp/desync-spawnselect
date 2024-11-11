local selectedCharId = nil

-- Show the spawn selection UI
RegisterNetEvent("desync-spawnselect:ShowUI")
AddEventHandler("desync-spawnselect:ShowUI", function(characterId)
    selectedCharId = characterId
    SetNuiFocus(true, true)
    TriggerServerEvent("desync-spawnselect:getSpawnPoints")
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
    
    -- Hide UI first
    SendNUIMessage({
        type = 'ui',
        status = false
    })

    -- Ensure we have valid coordinates
    local spawnCoords = {
        x = tonumber(data.coords.x),
        y = tonumber(data.coords.y),
        z = tonumber(data.coords.z),
        heading = tonumber(data.coords.heading) or 0.0
    }

    print("^2[desync-spawnselect] Spawn at location: " .. json.encode(spawnCoords) .. "^7")
    
    -- Tell server about character selection with specific coordinates
    TriggerServerEvent("desync-multichar:CharacterSelected", selectedCharId, spawnCoords)
    
    selectedCharId = nil
    cb({success = true})
end)

-- Hide UI callback
RegisterNUICallback('hideUI', function(_, cb)
    SetNuiFocus(false, false)
    cb({})
end)
