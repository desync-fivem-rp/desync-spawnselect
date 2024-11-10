-- Script by BreN --

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		Citizen.Wait(10)
		ESX = exports["es_extended"]:getSharedObject()
	end
end)

RegisterNetEvent('bren-boilerplate-nui:ToggleNUI')
AddEventHandler('bren-boilerplate-nui:ToggleNUI', function()
	ToggleNUI()
end)

nuiVisible = false
function ToggleNUI()
	nuiVisible = not nuiVisible

	if nuiVisible then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'open',
			type = "enableui",
			nuiVisible = nuiVisible,
			debug = true,
		})
	else
		SetNuiFocus(false, false)
		SendNUIMessage({
			action = 'close',
			type = "disableui",
			nuiVisible = nuiVisible,
			debug = true,
		})
	end
end

-- NUI Callback example
RegisterNUICallback('loaded', function(data, cb)
	for k, v in pairs(data) do
		print(tostring(k) .. ': ' .. tostring(v))
	end

	cb({
		response = "This is a test callback.",
		anotherResponse = "This is another test callback."
	})

	-- You can also just send back a single value but it is not recommended
	-- instead use the above format to send a table of data:
	-- cb("This is a test callback")
end)

-- Use this in conjunction with the 'keyup' eventListener in JS in order to allow a user to hit the Escape key to close the UI
RegisterNUICallback('close', function(data, cb)
	SetNuiFocus(false, false)
end)