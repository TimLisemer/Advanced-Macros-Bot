local inv
local map

function findItem(itemName, chest)
    local t = {}
    if(chest == true) then
        for a, b in pairs(map.contents) do
            local item = inv.getSlot(b)
            if item and item.id==itemName then
            t[#t+1] = b
            end
        end
    else
        for a, b in pairs(map.main) do
            local item = inv.getSlot(b)
            if item and item.id==itemName then
            t[#t+1] = b
            end
        end
        for a, b in pairs(map.hotbar) do
            local item = inv.getSlot(b)
            if item and item.id==itemName then
            t[#t+1] = b
            end
        end
        if(chest == true) then
            for a, b in pairs(map.hotbar) do
                local item = inv.getSlot(b)
                if item and item.id==itemName then
                t[#t+1] = b
                end
            end
        end
    end
    return t
end
 
function craftAll()
  sleep(3000)
  while true do
    local t = findItem("minecraft:sugar_cane", map, false)
    if #t==0 then return end
    for a,b in pairs(t) do
        inv.click(b)
        waitTick()
        inv.click(map.craftingIn[1])
        waitTick()
        inv.quick(map.craftingOut)
        waitTick()
    end
  end
end


function move()
    sleep(3000)
    while true do
        local t = findItem("minecraft:sugar", map, false)
        if #t==0 then return end
        for a,b in pairs(t) do
            inv.quick(b)
            waitTick()
        end
    end
end
  

inv = openInventory()
map = inv.mapping.inventory
say("/clear")
for i = 1, 36 do
  say("/give @p minecraft:sugar_cane 64")
end
craftAll(map, inv)


use(50)
sleep(1000)
inv = openInventory()
map = inv.mapping["double chest"]

move()
 
inv.close()
