local BankMenu = RageUI.CreateMenu("Banque", "Interactions disponibles")

BankMenu.Closed = function()
    RageUI.CloseAll()
    MenuIsOpen = false 
    FreezeEntityPosition(PlayerPedId(), false)
end

function OpenBankMenu()
    if MenuIsOpen then 
        RageUI.CloseAll()
        MenuIsOpen = false 
    else
        MenuIsOpen = true 
        RageUI.Visible(BankMenu, true)
        CreateThread(function()
            while MenuIsOpen do
                FreezeEntityPosition(PlayerPedId(), true)
                RageUI.IsVisible(BankMenu, function()
                    for _, value in pairs(ESX.PlayerData.accounts) do 
                        if value.name == "money" then 
                            RageUI.Separator(("Argent en liquide : ~g~%s$"):format(value.money))
                        end
                        if value.name == "bank" then 
                            RageUI.Separator(("Argent en banque : ~b~%s$"):format(value.money))
                        end
                    end
                    RageUI.Button("Déposer de l'argent", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            local amount = KeyboardInput("DepositMoney", "Montant à déposer", "", 10)
                            if amount ~= nil then 
                                amount = tonumber(amount)
                                if type(amount) == "number" then
                                    TriggerServerEvent("bank:depositMoney", amount)
                                end
                            end
                        end
                    })
                    RageUI.Button("Retirer de l'argent", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            local amount = KeyboardInput("WithdrawMoney", "Montant à retirer", "", 10)
                            if amount ~= nil then 
                                amount = tonumber(amount)
                                if type(amount) == "number" then
                                    TriggerServerEvent("bank:withdrawMoney", amount)
                                end
                            end 
                        end
                    })
                    RageUI.Button("Transférer de l'argent", nil, {RightLabel = "→"}, true, {
                        onSelected = function()
                            local targetID = KeyboardInput("TransferMoney", "ID du joueur", "", 5)
                            local amount = KeyboardInput("TransferMoney", "Montant à envoyer", "", 10)
                            if amount ~= nil then 
                                amount = tonumber(amount)
                                if type(amount) == "number" then
                                    TriggerServerEvent("bank:transferMoney", targetID, amount)
                                end
                            end 
                        end
                    })
                end)
                Wait(0)
            end
        end)
    end
end