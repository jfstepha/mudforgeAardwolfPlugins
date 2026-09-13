plugin = {
  name = "Inventory",
  author = "Jon Stephan",
  version = "1.0.1",
  description = "Display inventor"
}

hud = createWidget({ 
    type = "html",
    name = "Inventory",
    size = { width = 400, height = 200 }
})

istr = ""

lt = addTrigger("(.*)", function(m)
  -- echo("line matched:" .. m[0])
  if (m[0] == "{/inventory}") then
    istr = istr + ""
  else
    istr = istr + "<tr><td>* " + m[0] + "</td></tr>"
  end
end, {type="regex", omitFromOutput=true})

st = addTrigger("^{inventory}", function()
    -- echo("regex start matched")
    istr = "<style> body { font-family: Courier New; font-size: 4pt} </style>"
    istr = istr + "<table style='color:white;'>"
    -- echo("enabling lt & et")
    enableTrigger(lt)
    enableTrigger(et)
end, {type = "regex", omitFromOutput=true})

et = addTrigger( "^{/inventory}", function()
  -- echo("regex end matched")
  istr = istr + "</table>"
  -- echo("istr:"+istr)
  disableTrigger(lt)
  setWidgetProperty(hud, "content", istr)
  disableTrigger(st)
  disableTrigger(et)
end, {type = "regex", omitFromOutput=true} )

invtrig = addTrigger("^{invitem}.*$", function()
   -- echo("inviten matched enabling st")
   send("inventory")
   enableTrigger(st)
   istr = ""
end, {type="regex", omitFromOutput=true})

invtrig2 = addTrigger("^{invmon}.*$", function()
   --echo("invmon matched enabling st")
   send("inventory")
   enableTrigger(st)
   istr = ""
end, {type="regex", omitFromOutput=true})


function init()
  utilprint("$G[" .. plugin.name .. " v" .. plugin.version .. "]$W by " .. plugin.author .. " - Installed.")
end

function onPluginEnable()
  -- Triggers are enabled, grab inventory
  send("inventory")

  utilprint("$G[" .. plugin.name ..  " v" .. plugin.version .. "]$W - Enabled.")

end
