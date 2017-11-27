t = 0


function sendt(t,co,key)
 print("Temp:"..t.." C\n")
conn=net.createConnection(net.TCP, 0) 
conn:on("receive", function(conn, payload) print(payload) end)
conn:connect(80,'184.106.153.149') 
conn:send("GET /update?key="..key.."&field1="..t.."&field2="..co.." HTTP/1.1\r\n") 
conn:send("Host: api.thingspeak.com\r\n") 
conn:send("Accept: */*\r\n") 
conn:send("User-Agent: Mozilla/4.0 (compatible; esp8266 Lua; Windows NT 5.1)\r\n")
conn:send("\r\n")

conn:on("sent",function(conn)
                    print("Closing connection")
                      conn:close()
                  end)
conn:on("disconnection", function(conn)
                              print("Got disconnection...")
  end)
end


uart.setup(0,9600,8,0,1,0)
uart.on("data", 0, 
    function(data)
	--print("receive from uart:", data)
		if string.len(data) == 9 then
			result = string.byte(data,3)*256 + string.byte(data,4)
			t = result = string.byte(data,5)-20
--			print (result)
			sendt(t,result,"YOUR_KEY")
		end
    end, 0)


function sendData()
t = read()
uart.write(0,0xFF,0x01,0x86,0x00,0x00,0x00,0x00,0x00,0x79)
end

tmr.alarm(0, 60000, 1, function() sendData() end )