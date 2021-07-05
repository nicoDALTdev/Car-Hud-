Citizen.CreateThread(function()
    while true do
      local ped = PlayerPedId()
      local vehicle = GetVehiclePedIsIn(ped, false)
      local isInVehicle = IsPedInAnyVehicle(ped, false)
      local inMenu = IsPauseMenuActive()
      local ms = true

      Citizen.Wait(50)

      if isInVehicle and not inMenu then
        ms = false
        Citizen.Wait(0)
        if not trigger then
        TriggerEvent("getIn")
        trigger = true
        end
        local fuel = GetVehicleFuelLevel(vehicle) + 25
        local gear = GetVehicleCurrentGear(vehicle)
        local speed = GetEntitySpeed(vehicle)*3.6 
        local vueltas = GetVehicleCurrentRpm(vehicle)
        local rpm = 0
        if IsVehicleEngineOn(vehicle) then
            rpm = math.ceil(vueltas * 10000 - 2001, 2) / 80
        else
            rpm = 0
        end

        if speed < 1 then
          gear = 0
        end 
        local speed2 = speed / 3 + 15

        local health = GetVehicleEngineHealth(vehicle)

        local engineOn = GetIsVehicleEngineRunning(vehicle)

        SendNUIMessage({
            isInVehicle = isInVehicle;
            speed = speed;
            speed2 = speed2;
            fuel = fuel;
            rpm = rpm;
            getIn = getIn;
            engineOn = engineOn;
            text = text;
        });
      else
        SendNUIMessage({
          isInVehicle = false;
        });
        trigger = false
      end
    if ms then Citizen.Wait(1500) end
  end
end)

RegisterNetEvent("getIn", function() 
  getIn = true
  text = "KMH"
  Wait(500)
  getIn = false
end)