
plugin = {
  name = "Inventory",
  author = "Jon Stephan",
  version = "1.0",
  description = "Display inventor"
}


hud = createWidget({ 
    type = "html",
    name = "Inventory",
    size = { width = 400, height = 200 }
})


function init()
  utilprint("$G[" .. plugin.name .. " v" .. plugin.version .. "]$W by " .. plugin.author .. " - Installed!")

local timerId = addTimer (5000, function()
end)

invtrig = addTrigger("^{invmon}.*$", function()
   echo("inv updated tick")
   send("inventory")

   local istr = ""

   st = addTrigger("^{inventory}", function()
     -- echo("regex start matched")
     istr = "<style> body { font-family: Courier New; font-size: 4pt} </style>"
     istr = istr + "<table style='color:white;'>"

     local lt = addTrigger("(.*)", function(m)
       -- echo("line matched:" .. m[0])
       if (m[0] == "{/inventory}") then
         istr = istr + ""
       else
         istr = istr + "<tr><td>* " + m[0] + "</td></tr>"
       end
     end, {type="regex", omitFromOutput=true})


     et = addTrigger( "^{/inventory}", function()
       -- echo("regex end matched")
       istr = istr + "</table>"
       --echo("istr:"+istr)
       removeTrigger(lt)
       setWidgetProperty(hud, "content", istr)
       removeTrigger(st)
       removeTrigger(et)
      end, {oneshot = true, type = "regex", omitFromOutput=true} )
    end, {oneshot = true, type = "regex", omitFromOutput=true})

end, {oneshot = false, type="regex", omitFromOutput=true})
  
end