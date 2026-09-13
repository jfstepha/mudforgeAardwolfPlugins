
plugin = {
  name = "Stats",
  author = "Jon Stephan",
  version = "1.0",
  description = "Custom stat for Aardwolf"
}

function init()
  utilprint("$G[" .. plugin.name .. " v" .. plugin.version .. "]$W by " .. plugin.author .. " - Installed!")
end

local hud = createWidget({ type = "html", title = "Stats" })

setWidgetProperty(hud, "content", [[
  <style>
    .bar{height:10px;background:#222;border-radius:5px}
    .fill{height:100%;border-radius:5px;transition:width .2s ease}
    body { font-family: Courier New; font-size: 4pt}"
    </style>
<table style="color: white;">
  <tr>
    <td>str:</td><td data-mud-bind="str">?</td><td>/</td><td data-mud-bind="maxstr">?</td>
  </tr>
  <tr>
    <td>int:</td><td data-mud-bind="int">?</td><td>/</td><td data-mud-bind="maxint">?</td>
  </tr>
  <tr>
    <td>wis:</td><td data-mud-bind="wis">?</td><td>/</td><td data-mud-bind="maxwis">?</td>
  </tr>
  <tr>
    <td>dex:</td><td data-mud-bind="dex">?</td><td>/</td><td data-mud-bind="maxdex">?</td>
  </tr>
  <tr>
    <td>con:</td><td data-mud-bind="con">?</td><td>/</td><td data-mud-bind="maxcon">?</td>
  </tr>
  <tr>
    <td>luck:</td><td data-mud-bind="luck">?</td><td>/</td><td data-mud-bind="maxluck">?</td>
  </tr>
</table>

]])

local allData = getAllGMCPData()
tprint(allData)


-- Computed values (percentage + tooltip) you push yourself:

onGMCPUpdate("Char.vitals", function(v)

    local s = getGMCPData("char.stats")
    local m = getGMCPData("char.maxstats")
    setBoundValues(hud, {str=s.str, maxstr=m.maxstr, int=s.int, maxint=m.maxint, 
      con=s.con, maxcon=m.maxcon, wis=s.wis, maxwis=m.maxwis, dex=s.dex, maxdex=m.maxdex,
      luck=s.luck, maxluck=m.maxluck})
  end)

