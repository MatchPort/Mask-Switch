local maskIndex = 0
local textureIndex = 0
local maskMax = 209
local textureMax = 10
local tryingMasks = false

RegisterCommand('findmask', function()
    if not tryingMasks then
        tryingMasks = true
        Citizen.CreateThread(function()
            local playerPed = PlayerPedId()
            while tryingMasks and maskIndex <= maskMax do
                for j = 0, textureMax do
                    textureIndex = j
                    SetPedComponentVariation(playerPed, 1, maskIndex, textureIndex, 2)
                    print("Trying mask ID: " .. maskIndex .. " with texture ID: " .. textureIndex)
                    Citizen.Wait(500) -- Reduced waiting time to 500ms
                    if not tryingMasks then
                        break
                    end
                end
                maskIndex = maskIndex + 1
            end
            tryingMasks = false
            maskIndex = 0
        end)
    else
        print("You are already trying on masks. Please wait until the process is finished.")
    end
end)

RegisterCommand('stopfindmask', function()
    if tryingMasks then
        tryingMasks = false
        print("Stopped trying on masks.")
    else
        print("You are not currently trying on masks.")
    end
end)
