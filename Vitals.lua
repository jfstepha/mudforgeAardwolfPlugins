
plugin = {
  name = "Vitals",
  author = "Jon Stephan",
  version = "1.0",
  description = "Creates a custom widget with drawing capabilities"
}

function init()
  utilprint("$G[" .. plugin.name .. " v" .. plugin.version .. "]$W by " .. plugin.author .. " - Installed!")
end

local hud = createWidget({ type = "html", title = "Vitals" })

setWidgetProperty(hud, "content", [[
  <style>
    .bar{height:20px;background:#222;border-radius:5px}
    .fill{height:100%;border-radius:5px;transition:width .2s ease}
  </style>
  <div class="bar"><div class="fill" style="background:#666600;color:white;white-space:nowrap"
       data-mud-bind-style="width:mvPct"
       data-mud-bind-attr="title:mvTip">
         Move: 
         <span data-mud-bind="mv">?</span>
         /
         <span data-mud-bind="maxmv">?</span>
         (<span data-mud-bind="mvPct">?</span>)

    </div></div>

  <div class="bar"><div class="fill" style="background:#005500; color:white; white-space:nowrap"
       data-mud-bind-style="width:hpPct"
       data-mud-bind-attr="title:hpTip">
       HP:  
       <span data-mud-bind="hp">?</span>
       /
       <span data-mud-bind="maxhp">?</span>
       (<span data-mud-bind="hpPct">%</span>)
  </div></div>

  <div class="bar"><div class="fill" style="background:#0000ff; color:white; white-space:nowrap"
       data-mud-bind-style="width:manaPct"
       data-mud-bind-attr="title:manaTip">  
        Mana:
        <span data-mud-bind="mana">?</span>
        /
        <span data-mud-bind="maxmana">?</span>
        (<span data-mud-bind="manaPct">%</span>)
  </div></div>

  <div class="bar"><div class="fill" style="background:#777777;color:white;white-space:nowrap"
       data-mud-bind-style="width:tnlPct"
       data-mud-bind-attr="title:tnlTip">
         TNL: 
         <span data-mud-bind="tnl">?</span>
         /
         <span data-mud-bind="maxtnl">?</span>
         (<span data-mud-bind="tnlPct">?</span>)
    </div></div>


  <div class="bar"><div class="fill" style="background:#990000;color:white;white-space:nowrap"
       data-mud-bind-style="width:enemyPct"
       data-mud-bind-attr="title:enemyTip">  
         Enemy:
         <span data-mud-bind="enemy">?</span>
         /
         <span data-mud-bind="maxenemy">?</span>
        (<span data-mud-bind="enemyPct">?</span>)
  </div></div>

]])
--   <div class="bar">tnl<progress id="tnl" data-mud-bind-attr="max:maxtnl" data-mud-bind-attr="value:tnl">70</progress>




-- Computed values (percentage + tooltip) you push yourself:


function updatebars(x)
    -- echo("hp="+v.hp)
    -- echo("maxhp="+m.maxhp)
    -- echo("mana="+v.mana)
    -- echo("maxmana="+m.maxmana)
    local v = getGMCPData("Char.Vitals")
    local m = getGMCPData("Char.Maxstats")
    local s = getGMCPData("Char.Status")
    local b = getGMCPData("Char.Base")

    local hppct = math.floor(v.hp / m.maxhp * 100)
    if hppct > 100 then hppct = 100 end
    setBoundValues(hud, { hpPct = hppct .. "%", hpTip = v.hp .. "/" .. m.maxhp, maxhp=m.maxhp, hp=v.hp })

    local manapct = math.floor(v.mana / m.maxmana * 100)
    setBoundValues(hud, { manaPct = manapct .. "%", manaTip = v.mana .. "/" .. m.maxmana, maxmana = m.maxmana, mana=v.mana })

    local enemypct = s.enemypct
    setBoundValues(hud, { enemyPct = enemypct .. "%" , maxenemy=100, enemy=enemypct, enemyTip=100})

    local tnlpct = math.floor(s.tnl / b.perlevel * 100)
    setBoundValues(hud, { tnlPct = tnlpct .. "%" , maxtnl=b.perlevel, tnl=s.tnl, tnlTip = s.tnl .. "/" .. b.perlevel})

    local mvpct = math.floor((v.moves / m.maxmoves) * 100)
    setBoundValues(hud, { mvPct = mvpct .. "%" , maxmv=m.maxmoves, mv=v.moves, tnlTip = v.moves .. "/" .. m.maxmoves})
end

onGMCPUpdate("Char.Vitals", function(x) updatebars(x) end)
onGMCPUpdate("Char.MaxStats", function(x) updatebars(x) end)
onGMCPUpdate("Char.Status", function(x) updatebars(x) end)
onGMCPUpdate("Char.Base", function(x) updatebars(x) end)
