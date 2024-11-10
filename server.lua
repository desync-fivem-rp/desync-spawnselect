
-- Script by BreN --

ESX = nil

ESX = exports["es_extended"]:getSharedObject()

if Config.testnui then
    lib.addCommand('testnui', {
        help = 'Tests NUI functionality',
        -- params = {
        --     {
        --         name = 'enable',
        --         type = 'enable',
        --         help = "Target player's server id"
        --     }
        -- },
        restricted = 'group.admin'
    }, function(source, args, raw)
        -- print(args)
        -- for k, v in pairs(args) do
        --     print(k)
        --     print(v)
        -- end

        TriggerClientEvent('bren-boilerplate-nui:ToggleNUI', source)
    end)
end