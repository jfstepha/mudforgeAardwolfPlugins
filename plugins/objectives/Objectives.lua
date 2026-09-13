-- Widget Plugin Template

plugin = {
  name = "Objectives",
  author = "Jon Stephan",
  version = "1.0.0",
  description = "Keeps tracks of current objectivs"
}

local widgetId = nil

function init()
  utilprint("$G[" .. plugin.name .. " v" .. plugin.version .. "]$W by " .. plugin.author .. " - Installed!")

  -- Create a custom widget
  wid = createWidget({
    name = "my-widget",
    title = "Objectives",
    type= "html",
    width = 300,
    height = 200,
    resizable = true,
    movable = true
  })

  -- Draw some content
  setWidgetProperty(wid, "content", [[
<table style="color: white;">
  <tr>
    <td>str:</td><td data-mud-bind="str">?</td><td>/</td><td data-mud-bind="maxstr">?</td>
  </tr>

]])

  showWidget(widgetId)
  disableTrigger(ktring)
  ostring = ""

  ktrig = addTrigger("^You still have to kill \* (.*)\((.*)\)$", function(matches)
    -- echo ("found kill target")
    ostring = ostring + "<tr><td style='color: lightgreen'>" + matches[0] + "</td><td style='color: lightblue'>" + matches[1] + "</td></tr>"
  end, {type = "regex"})

  etrig = addTrigger("You have \d+ days", function(matches)
    -- echo ("found end of cp")
    ostring = ostring + "</table>"
    setWidgetProperty(wid, "content", ostring)
    disableTrigger(ktring)
    disableTrigger(etring)
    -- echo ("ostring=" + ostring)
  end,  {type = "regex"})

  disableTrigger(ktrig)
  disableTrigger(etrig)

  addAlias("cpcheck", "", function(matches)
    getcpinfo()
  end)
end


getcpinfo = function()
    echo("getting cp info")
    ostring = "<style> body { font-family: Courier New; font-size: 4pt} </style>"
    ostring = ostring + "<table style=\"color: white;\">"
    enableTrigger(ktrig)
    enableTrigger(etrig)


    send("cp check")

    -- in case there is no match
    addTimer(10000, function()
      disableTrigger(ktring)
      disableTrigger(etring)
      ostring = ""
    end)

  end


