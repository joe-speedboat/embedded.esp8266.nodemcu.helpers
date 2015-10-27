-- simple telnet server
function startServer()
   sv=net.createServer(net.TCP, 180)
   sv:listen(23,   function(conn)
      function s_output(str)
         if (conn~=nil)    then
            conn:send(str)
         end
      end
      node.output(s_output,0)
      conn:on("receive", function(conn, pl) 
         node.input(pl) 
         if (conn==nil)    then 
            print("conn is nil.") 
         end
      end)
      conn:on("disconnection",function(conn) 
         node.output(nil) 
      end)
   end)   
   print("Telnet Server started at IP: "..wifi.sta.getip().." on port 23")
end

