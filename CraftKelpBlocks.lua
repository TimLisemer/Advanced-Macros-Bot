local inv
local map
wasFull = 1
isFull = 0
chestFull = 2

function findItem(itemName, mode) -- mode=1 -> chest; mode=2 -> mainInventory, hotbar
    local t = {}
    if(mode == 1) then
        for a, b in pairs(map.contents) do
            local item = inv.getSlot(b)
            if item and item.id==itemName then
            t[#t+1] = b
            end
        end
    else
        if(mode == 2) then
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
        end
    end
    return t
end

function invFull()
    full = 0
    for a, b in pairs(map.main) do
        local item = inv.getSlot(b)
        if item then full = full+1 end
    end
    for a, b in pairs(map.hotbar) do
        local item = inv.getSlot(b)
        if item then full = full+1 end
    end
    if(full == 36) then return 1 else return 0 end
end

function craftkelpBlock()
    waitTick()
    i = 1
    d = 1
    while true do
        local t = findItem("minecraft:dried_kelp", 2)
        if #t<9 then return end
        for a,b in pairs(t) do
            if(i <= 9) then
                inv.click(b)
                waitTick()
                inv.click(map.craftingIn[i])
            end
            if(i == 9) then
                sleep(100)
                inv.quick(map.craftOut)
                sleep(500)
            end
            if(i >= 10 and i <= 19) then
                inv.quick(map.craftingIn[d])
                d = d+1
            end
            if(i >= 20) then
                i = 1
                d = 1
                sleep(100)
                break
            end
            i = i+1
        end
    end
end


function movekelp()
    waitTick()
    while true do
        local t = findItem("minecraft:dried_kelp", 1)
        chestFull = #t
        if #t==0 then return end
        for a,b in pairs(t) do
            inv.quick(b)
            waitTick()
            if (invFull() == 1) then return end
        end
    end
    wasFull = 0
end


inv = openInventory()
map = inv.mapping.inventory
isFull = invFull()
while(wasFull == 1 and isFull == 0 and chestFull >= 2) do
    use(50)
    sleep(100)
    inv = openInventory()
    map = inv.mapping["double chest"]

    movekelp()
    inv.close()

    waitTick()
    say("/w")
    waitTick()

    inv = openInventory()
    map = inv.mapping["crafting table"]
    craftkelpBlock()
    inv.close()
    inv = openInventory()
    map = inv.mapping.inventory
    isFull = invFull()
    inv.close()
end


