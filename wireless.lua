wifi.setmode(wifi.STATION)
wifi.sta.config("","")
tmr.alarm(0, 900000, 1, function()
    wifi.sleeptype(wifi.NONE_SLEEP)
    wifi.sta.connect()
    counter = 0
    tmr.alarm(1, 3000, 1, function() 
        counter = counter + 1
        if wifi.sta.getip()== nil then 
            print("IP unavaiable, Waiting...") 
            if counter > 30 then
                tmr.stop(1)
            end
        else 
            tmr.stop(1)
            print("Pabudimas, IP is "..wifi.sta.getip())
            tmr.alarm(3, 1000, 0, function()
                dofile("all.lua")
                end)
        end 
    end)
end)
