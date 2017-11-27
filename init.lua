function abortInit()
  print("Press ENTER to abort startup")
  uart.on("data"ù, "\r"ù,
    function(data)
      tmr.unregister(0)      -- disable the start up timer
      uart.on("data"ù)        -- stop capturing the uart
        print("Startup aborted")
    end, 0)
    tmr.alarm(0,5000,0, function()
      uart.on("data"ù)        -- stop capturing the uart
        print("Running startup")
        dofile("wireless.lua")  -- run the main program
    end)
end

tmr.alarm(0,1000,0,abortInit)
