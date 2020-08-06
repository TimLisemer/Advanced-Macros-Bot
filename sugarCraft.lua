local inv = openInventory()
 
local function ref()
  log("&eInventory types: ")
  for a,b in pairs(inv.mapping) do
    log(" > &7"..a)
    if(a=="inventory")then
      for a,b in pairs(b) do
        log("    > "..a)
      end
    end
  end
  log("&bFunctions:")
  for a,b in pairs(inv) do
    if(type(b)=="function" or (type(b)=="table") and getmetatable(b) and getmetatable(b).luaFunction)then
      log(" > &7"..a)
    end
  end
end
local map = inv.mapping.inventory
 
 
function findCane()
  local t = {}
  for a, b in pairs(map.main) do
    local item = inv.getSlot(b)
    if item and item.id=="minecraft:sugar" then
      t[#t+1] = b
    end
  end
  for a, b in pairs(map.hotbar) do
    local item = inv.getSlot(b)
    if item and item.id=="minecraft:sugar" then
      t[#t+1] = b
    end
  end
  return t
end
 
function craftAll()
  sleep(3000)
  while true do
    local t = findCane()
    if #t==0 then return end
    for a,b in pairs(t) do
      inv.click(b)
      --sleep(40)
      --waitTick()
      inv.click(map.craftingIn[1])
      --sleep(40)
      --waitTick()
      inv.quick(map.craftingOut)--, b)
      --waitTick()
      --sleep(40)
    end
  end
end
 
ref()
 
--findCane()
craftAll()
 
inv.close()
