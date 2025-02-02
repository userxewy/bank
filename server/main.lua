RegisterServerEvent("bank:depositMoney")
AddEventHandler("bank:depositMoney", function(amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getAccount("money").money >= amount then
        xPlayer.addAccountMoney("bank", amount)
        xPlayer.removeMoney(amount)
        TriggerClientEvent("esx:showNotification", source, "Vous avez déposé ~g~"..amount.."$")
        BankDiscordLog("Dépôt bancaire", "**Joueur:** " .. xPlayer.getName() ..  "\n**ID:** " .. source ..  "\n**Montant déposé:** " .. amount .. "$", 16034613)
    else
        TriggerClientEvent("esx:showNotification", source, "Vous n'avez pas assez d'argent")
    end
end)

RegisterServerEvent("bank:withdrawMoney")
AddEventHandler("bank:withdrawMoney", function(amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getAccount("bank").money >= amount then
        xPlayer.addAccountMoney("money", amount)
        xPlayer.removeAccountMoney("bank", amount)
        TriggerClientEvent("esx:showNotification", source, "Vous avez retiré ~b~"..amount.."$")
        BankDiscordLog("Retrait bancaire", "**Joueur:** " .. xPlayer.getName() ..  "\n**ID:** " .. source ..  "\n**Montant retiré:** " .. amount .. "$", 16034613)
    else
        TriggerClientEvent("esx:showNotification", source, "Vous n'avez pas assez d'argent")
    end
end)

RegisterServerEvent("bank:transferMoney")
AddEventHandler("bank:transferMoney", function(targetID, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(targetID)

    if xTarget == nil or xTarget == -1 then
        TriggerClientEvent("esx:showNotification", source, "ID introuvable")
    else
        if xPlayer.getAccount("bank").money >= amount then
            xPlayer.removeAccountMoney("bank", amount)
            xTarget.addAccountMoney("bank", amount)
            TriggerClientEvent("esx:showNotification", source, "Vous avez envoyé ~b~"..amount.."$")
            TriggerClientEvent("esx:showNotification", targetID, "Vous avez reçu ~b~" .. amount .. "$")
            BankDiscordLog("Transfert bancaire", "**Expéditeur:** " .. xPlayer.getName() .. "\n**ID Expéditeur:** " .. source ..  "\n**Destinataire:** " .. xTarget.getName() .. "\n**ID Destinataire:** " .. targetID .. "\n**Montant transféré:** " .. amount .. "$", 16034613)
        else
            TriggerClientEvent("esx:showNotification", source, "Vous n'avez pas assez d'argent")
        end
    end
end)