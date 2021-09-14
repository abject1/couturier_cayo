-----------------------------------------
-- Created and modify by L'ile Légale RP
-- SenSi and Kaminosekai
-----------------------------------------

ESX = nil
local PlayersTransforming  = {}
local PlayersSelling       = {}
local PlayersHarvesting = {}
local clothe = 1
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
	TriggerEvent('esx_service:activateService', 'couturier_cayo', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'couturier_cayo', _U('couturier_cayo_client'), true, true)
TriggerEvent('esx_society:registerSociety', 'couturier_cayo', 'couturier_cayo', 'society_couturier_cayo', 'society_couturier_cayo', 'society_couturier_cayo', {type = 'private'})

local function Harvest(source, zone)
	if PlayersHarvesting[source] == true then

		local xPlayer  = ESX.GetPlayerFromId(source)
		if zone == "WoolFarm" then
			local itemQuantity = xPlayer.getInventoryItem('wool').count
			if itemQuantity >= 100 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_place'))
				return
			else
				SetTimeout(2058, function()
					xPlayer.addInventoryItem('wool', 1)
					Harvest(source, zone)
				end)
			end
		end
	end
end

RegisterServerEvent('a_couturier_cayo:startHarvest')
AddEventHandler('a_couturier_cayo:startHarvest', function(zone)
	local _source = source
  	
	if PlayersHarvesting[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
		PlayersHarvesting[_source]=false
	else
		PlayersHarvesting[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('wool_taken'))  
		Harvest(_source,zone)
	end
end)


RegisterServerEvent('a_couturier_cayo:stopHarvest')
AddEventHandler('a_couturier_cayo:stopHarvest', function()
	local _source = source
	
	if PlayersHarvesting[_source] == true then
		PlayersHarvesting[_source]=false
		TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
	else
		TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~ramasser')
		PlayersHarvesting[_source]=true
	end
end)


local function Transform1(source, zone)

	if PlayersTransforming[source] == true then

		local xPlayer  = ESX.GetPlayerFromId(source)
		if zone == "TraitementTissu" then
			local laineQuantity = xPlayer.getInventoryItem('wool').count
			local tissuQuantity = xPlayer.getInventoryItem('tissu').count
			
			if laineQuantity <= 0 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_wool'))
				return
			elseif tissuQuantity >= 100 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_place'))
				return
			else
				SetTimeout(2322, function()
					xPlayer.removeInventoryItem('wool', 1)
					xPlayer.addInventoryItem('tissu', 2)
				
					Transform1(source, zone)
				end)
			end
		end
	end	
end

RegisterServerEvent('a_couturier_cayo:startTransform1')
AddEventHandler('a_couturier_cayo:startTransform1', function(zone)
	local _source = source
  	
	if PlayersTransforming[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
		PlayersTransforming[_source]=false
	else
		PlayersTransforming[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('transforming_in_progress')) 
		Transform1(_source,zone)
	end
end)

RegisterServerEvent('a_couturier_cayo:stopTransform1')
AddEventHandler('a_couturier_cayo:stopTransform1', function()

	local _source = source
	
	if PlayersTransforming[_source] == true then
		PlayersTransforming[_source]=false
		TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
		
	else
		TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~transformer votre laine')
		PlayersTransforming[_source]=true
		
	end
end)

local function Transform2(source, zone)

	if PlayersTransforming[source] == true then

		local xPlayer  = ESX.GetPlayerFromId(source)
		if zone == "TraitementClothe" then
			local tissuQuantity = xPlayer.getInventoryItem('tissu').count
			local clotheQuantity = xPlayer.getInventoryItem('clothe').count
			
			if tissuQuantity <= 0 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_tissu'))
				return
			elseif clotheQuantity >= 100 then
				TriggerClientEvent('esx:showNotification', source, _U('not_enough_place'))
				return
			else
				SetTimeout(2580, function()
					xPlayer.removeInventoryItem('tissu', 2)
					xPlayer.addInventoryItem('clothe', 1)
				
					Transform2(source, zone)
				end)
			end
		end
	end	
end

RegisterServerEvent('a_couturier_cayo:startTransform2')
AddEventHandler('a_couturier_cayo:startTransform2', function(zone)
	local _source = source
  	
	if PlayersTransforming[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
		PlayersTransforming[_source]=false
	else
		PlayersTransforming[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('transforming_in_progress')) 
		Transform2(_source,zone)
	end
end)

RegisterServerEvent('a_couturier_cayo:stopTransform2')
AddEventHandler('a_couturier_cayo:stopTransform2', function()

	local _source = source
	
	if PlayersTransforming[_source] == true then
		PlayersTransforming[_source]=false
		TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
		
	else
		TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~transformer votre tissu')
		PlayersTransforming[_source]=true
		
	end
end)


local function Sell1(source, zone)

	if PlayersSelling[source] == true then
		local xPlayer  = ESX.GetPlayerFromId(source)
		
		if zone == 'SellFarmCayo' then
			if xPlayer.getInventoryItem('clothe').count <= 0 then
				clothe = 0
			else
				clothe = 1
			end
		
			if clothe == 0  then
				TriggerClientEvent('esx:showNotification', source, _U('no_clothe_sale'))
				return
			else
				if (clothe == 1) then

					local bonus = math.random(0, 25)

					SetTimeout(950, function()
						local money = math.random(20,40)
						local playerMoney = 50
						local bonus = math.random(0, 8)
						xPlayer.removeInventoryItem('clothe', 1)
						xPlayer.addAccountMoney('bank', playerMoney)
						xPlayer.addAccountMoney('bank', bonus)
						local societyAccount = nil

						TriggerEvent('esx_addonaccount:getSharedAccount', 'society_couturier_cayo', function(account)
							societyAccount = account
						end)
						if societyAccount ~= nil then
							societyAccount.addMoney(money)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. money .. _U('comp_earned_ped') .. playerMoney .. _U('bonus') .. bonus)
						end
						Sell1(source,zone)
					end)
				end
				
			end
		end
	end
end

RegisterServerEvent('a_couturier_cayo:startSell1')
AddEventHandler('a_couturier_cayo:startSell1', function(zone)

	local _source = source
	
	if PlayersSelling[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
		PlayersSelling[_source]=false
	else
		PlayersSelling[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))
		Sell1(_source, zone)
	end

end)

RegisterServerEvent('a_couturier_cayo:stopSell1')
AddEventHandler('a_couturier_cayo:stopSell1', function()

	local _source = source
	
	if PlayersSelling[_source] == true then
		PlayersSelling[_source]=false
		TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
		
	else
		TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~vendre')
		PlayersSelling[_source]=true
	end

end)

local function Sell2(source, zone)

	if PlayersSelling[source] == true then
		local xPlayer  = ESX.GetPlayerFromId(source)
		
		if zone == 'SellFarmLosSantos' then
			if xPlayer.getInventoryItem('clothe').count <= 0 then
				clothe = 0
			else
				clothe = 1
			end
		
			if clothe == 0  then
				TriggerClientEvent('esx:showNotification', source, _U('no_clothe_sale'))
				return
			else
				if (clothe == 1) then

					local bonus = math.random(0, 75)

					SetTimeout(950, function()
						local societyMoney = math.random(40,70)
						local playerMoney = 100
						local bonus = math.random(0, 20)
						xPlayer.removeInventoryItem('clothe', 1)
						xPlayer.addAccountMoney('bank', playerMoney)
						xPlayer.addAccountMoney('bank', bonus)
						local societyAccount = nil

						TriggerEvent('esx_addonaccount:getSharedAccount', 'society_couturier_cayo', function(account)
							societyAccount = account
						end)
						if societyAccount ~= nil then
							societyAccount.addMoney(money)
							TriggerClientEvent('esx:showNotification', xPlayer.source, _U('comp_earned') .. money .. _U('comp_earned_ped') .. playerMoney .. _U('bonus') .. bonus)
						end
						Sell2(source,zone)
					end)
				end
				
			end
		end
	end
end

RegisterServerEvent('a_couturier_cayo:startSell2')
AddEventHandler('a_couturier_cayo:startSell2', function(zone)

	local _source = source
	
	if PlayersSelling[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~C\'est pas bien de glitch ~w~')
		PlayersSelling[_source]=false
	else
		PlayersSelling[_source]=true
		TriggerClientEvent('esx:showNotification', _source, _U('sale_in_prog'))
		Sell2(_source, zone)
	end

end)

RegisterServerEvent('a_couturier_cayo:stopSell2')
AddEventHandler('a_couturier_cayo:stopSell2', function()

	local _source = source
	
	if PlayersSelling[_source] == true then
		PlayersSelling[_source]=false
		TriggerClientEvent('esx:showNotification', _source, 'Vous sortez de la ~r~zone')
		
	else
		TriggerClientEvent('esx:showNotification', _source, 'Vous pouvez ~g~vendre')
		PlayersSelling[_source]=true
	end

end)

RegisterServerEvent('a_couturier_cayo:getStockItem')
AddEventHandler('a_couturier_cayo:getStockItem', function(itemName, count)

	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_couturier_cayo', function(inventory)

		local item = inventory.getItem(itemName)

		if item.count >= count then
			inventory.removeItem(itemName, count)
			xPlayer.addInventoryItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_withdrawn') .. count .. ' ' .. item.label)

	end)

end)

ESX.RegisterServerCallback('a_couturier_cayo:getStockItems', function(source, cb)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_couturier_cayo', function(inventory)
		cb(inventory.items)
	end)

end)

RegisterServerEvent('a_couturier_cayo:putStockItems')
AddEventHandler('a_couturier_cayo:putStockItems', function(itemName, count)

	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_couturier_cayo', function(inventory)

		local item = inventory.getItem(itemName)

		if item.count >= 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
		end

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('added') .. count .. ' ' .. item.label)

	end)
end)

ESX.RegisterServerCallback('a_couturier_cayo:getPlayerInventory', function(source, cb)

	local xPlayer    = ESX.GetPlayerFromId(source)
	local items      = xPlayer.inventory

	cb({
		items      = items
	})

end)