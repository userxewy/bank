CreateThread(function()
    for _,v in pairs(BankSettings.Positions) do    
        local BankBlips = AddBlipForCoord(v.pos)
		SetBlipSprite(BankBlips, 108)
		SetBlipScale(BankBlips, 0.8)
		SetBlipDisplay(BankBlips, 4)
		SetBlipColour(BankBlips, 2)
        SetBlipAsShortRange(BankBlips, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Banque")
        EndTextCommandSetBlipName(BankBlips)
    end
    while true do
        local pCoords = GetEntityCoords(PlayerPedId())
        local onMarker = false
        for _,v in pairs(BankSettings.Positions) do
            if #(pCoords - v.pos) < 15.0 then
                onMarker = true
                DrawMarker(1, v.pos, 0, 0, 0, 0, 0, 0, 0.75, 0.75, 0.25, 244, 171, 53, 1.0, 0, 0, 0, 0)                
            end
            if #(pCoords - v.pos) < 1.2 then
                ESX.ShowHelpNotification("Appuyer sur ~INPUT_PICKUP~ pour accéder à la banque")
                if IsControlJustReleased(0, 38) then
                    OpenBankMenu()
                end              
            end
        end
        if onMarker then
            Wait(1)
        else
            Wait(500)
        end
    end
end)