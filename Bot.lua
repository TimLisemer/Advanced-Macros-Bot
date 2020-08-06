local threads = {}
local inv
local map

Bot = not Bot
if not Bot then return end


local function startThreads()
    for j=1, #threads do
      threads[j].start()
    end
   
    while true do
      local isOneRunning = false
      for j=1, #threads do
        isOneRunning = isOneRunning or (threads[j].getStatus()~="done")
      end
      if not isOneRunning then break end
    end
end

function draw(x, y, z)
    hud = (hud and hud.destroy and hud) or hud3D.newPane("xz")

    hudTex = image.new((7), (7))
    hud.changeTexture( hudTex )
    hud.setSize(7, 7)
    hud.setOpacity(.3)

    local g = hudTex.graphics
    g.setColor(0xFFFF0000) --red
    g.fillRect(3+1, 3+1,1,1)
    hudTex.update()

    hud.setPos( x-3, y, z-3 )
    hud.enableDraw()
    hud.xray()
end

function findItem(itemName, mode) -- mode=1 -> chest; mode=2 -> mainInventory; mode=3 -> hotbar
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
        elseif(mode == 3) then
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

function clearInventory()
    navigate(5)
    inv = openInventory()
    map = inv.mapping["double chest"]
    use(50)
    sleep(1000)
    for i = 0, 27, 1 do 
        inv.quick(map.main[i])
        sleep(100)
    end
    inv.quick(map.hotbar[6])
    sleep(250)
    inv.quick(map.hotbar[7])
    sleep(250)
    inv.quick(map.hotbar[8])
    sleep(250)
    inv.quick(map.hotbar[9])
    sleep(250)
    inv.close()
end

function clearUpperInventory()
    navigate(5)
    inv = openInventory()
    map = inv.mapping["double chest"]
    use(50)
    sleep(1000)
    for i = 0, 27, 1 do 
        inv.quick(map.main[i])
        sleep(100)
    end
    inv.close()
end

function getFood()
    navigate(10)
    con = true
    while(con == true) do
        sleep(1000)
        use(50)
        sleep(1000)
        inv = openInventory()
        map = inv.mapping["double chest"]
        local t = findItem("minecraft:baked_potato", 1)
        if #t==0 then 
            inv.close()
            look(180, 5, 500)
            sleep(1000)
        else
            for a,b in pairs(t) do
                inv.click(b)
                sleep(100)
                inv.click(map.hotbar[5])
                sleep(100)
                inv.click(b)
                sleep(100)
                con = false
                break
            end
        end
    end
    inv.close()
    sleep(5000)
end

function walk(a, b, c, yaw, pitch)
    look(yaw, pitch, 500)
    sleep(1000)
    local x, y, z = getPlayerPos()
    while(math.floor(a) ~= math.floor(x+1) or math.floor(c) ~= math.floor(z+1)) do

        if((yaw > 170 and yaw <= 180) or (yaw < -170 and yaw >= -180)) then
            if(math.floor(a) ~= math.floor(x+1)) then
                if(x > a) then
                    while(x >= (a)) do
                        left(1)
                        x, y, z = getPlayerPos()
                        sleep(2)
                    end
                else
                    while(x <= (a)) do
                        right(1)
                        x, y, z = getPlayerPos()
                        sleep(2)
                    end
                end
            end
            if(math.floor(c) ~= math.floor(z+1)) then
                if(z > c) then
                    sprint(true)
                    while(z >= (c)) do
                        forward(1)
                        x, y, z = getPlayerPos()
                        sleep(2)
                    end
                    sprint(false)
                else
                    while(z <= (c)) do
                        back(1)
                        x, y, z = getPlayerPos()
                        sleep(2)
                    end
                end
            end
        elseif (yaw > 80 and yaw < 100) then
            if(math.floor(a) ~= math.floor(x+1)) then
                if(x > a) then
                    sprint(true)
                    while(x >= (a)) do
                        forward(1)
                        x, y, z = getPlayerPos()
                        sleep(2)
                    end
                    sprint(false)
                else
                    while(x <= (a)) do
                        back(1)
                        x, y, z = getPlayerPos()
                        sleep(2)
                    end
                end
            end
            if(math.floor(c) ~= math.floor(z+1)) then
                if(z > c) then
                    while(z >= (c)) do
                        right(1)
                        x, y, z = getPlayerPos()
                        sleep(2)
                    end
                else
                    while(z <= (c)) do
                        left(1)
                        x, y, z = getPlayerPos()
                        sleep(2)
                    end
                end
            end
        elseif (yaw > -10 and yaw < 10) then
            if(math.floor(a) ~= math.floor(x+1)) then
                if(x > a) then
                    while(x >= (a)) do
                        right(1)
                        x, y, z = getPlayerPos()
                        sleep(2)
                    end
                else
                    while(x <= (a)) do
                        left(1)
                        x, y, z = getPlayerPos()
                        sleep(2)
                    end
                end
            end
            if(math.floor(c) ~= math.floor(z+1)) then
                if(z > c) then
                    while(z >= (c)) do
                        back(1)
                        x, y, z = getPlayerPos()
                        sleep(2)
                    end
                else
                    sprint(true)
                    while(z <= (c)) do
                        forward(1)
                        x, y, z = getPlayerPos()
                        sleep(2)
                    end
                    sprint(false)
                end
            end
        elseif (yaw < -80 and yaw > -100) then
            if(math.floor(a) ~= math.floor(x+1)) then
                if(x > a) then
                    while(x >= (a)) do
                        back(1)
                        x, y, z = getPlayerPos()
                        sleep(2)
                    end
                else
                    sprint(true)
                    while(x <= (a)) do
                        forward(1)
                        x, y, z = getPlayerPos()
                        sleep(2)
                    end
                    sprint(false)
                end
            end
            if(math.floor(c) ~= math.floor(z+1)) then
                if(z > c) then
                    while(z >= (c)) do
                        left(1)
                        x, y, z = getPlayerPos()
                        sleep(2)
                    end
                else
                    while(z <= (c)) do
                        right(1)
                        x, y, z = getPlayerPos()
                        sleep(2)
                    end
                end
            end
        else
            log(yaw)
        end

    end
end

function destroy()
    sleep(200)
    i = 6
    d = 0
    while(threads[2].getStatus()=="running") do
        attack(100)
        sleep(100)
        if(d == 50) then
            d = 0
            if(i == 9) then
                i = 6
            else
                i = i+1
            end
        else
            d = d+1
        end
        setHotbar(i)
    end
end

function plant()
    sleep(200)
    i = 6
    d = 0
    while(threads[2].getStatus()=="running") do
        use(100)
        sleep(100)
        if(d == 50) then
            d = 0
            if(i == 9) then
                i = 6
            else
                i = i+1
            end
        else
            d = d+1
        end
        setHotbar(i)
    end
end

function eat()
    setHotbar(5)
    use(2000)
    sleep(2000)
    setHotbar(6)
end

function navigate(destination)
    sleep(1000)
    if(destination == 0) then               --Claim Menu
        look(180, 0, 500)
        sleep(1000)
        say("/claim")
        sleep(5000)
        look(180, 0, 500)
        sleep(1000)
        --use(50)
        sleep(1000)
        inv = openInventory()
        map = inv.mapping["double chest"]   --> /Claim Menu
        inv.click(map.contents[30])
        waitTick()
        eat()
        setHotbar(6)
        sleep(10000)
        inv.close()
        inv = openInventory()
        inv.close()
    elseif(destination == 1) then           --Sugar Cane
        navigate(0)
        walk(-5220, 32.5, -7167, 180, 0)
        eat()
    elseif(destination == 2) then           --Sugar Cane
        navigate(0)
        walk(-5223, 32.5, -7204, 180, 0)
        walk(-5292, 32.5, -7204, 90, 0)
        walk(-5292, 32, -7208, 90, 0)
        eat()
    elseif(destination == 3) then           --Sugar Cane
        navigate(0)
        walk(-5223, 32.5, -7204, 180, 0)
        walk(-5228, 32.5, -7204, 90, 0)
        walk(-5228, 32.5, -7191, 0, 0)
        walk(-5290, 32.5, -7191, 90, 0)
        walk(-5290, 32.5, -7198, 90, 0)
        walk(-5294, 32.5, -7198, 90, 0)
        walk(-5294, 32.5, -7195, 90, 0)
        eat()
    elseif(destination == 4) then           --Sugar Cane
        navigate(0)
        walk(-5223, 33, -7204, 180, 0)
        walk(-5228, 33, -7204, 90, 0)
        walk(-5228, 33, -7191, 0, 0)
        walk(-5290, 33, -7191, 90, 0)
        walk(-5290, 33, -7136, 0, 0)
        walk(-5294, 33, -7136, 90, 0)
        eat()
    elseif(destination == 5) then           --Chest
        navigate(0)
        walk(-5223, 33, -7204, 180, 0)
        walk(-5228, 33, -7204, 90, 0)
        walk(-5228, 33, -7191, 0, 0)
        walk(-5223, 33, -7191, 0, 0)
        walk(-5223, 33, -7180, 0, 0)
        eat()
        walk(-5226, 33, -7180, 90, 30)
    elseif(destination == 6) then           --Potato
        navigate(0)
        walk(-5223, 33, -7204, 180, 0)
        walk(-5234, 33, -7204, 90, 0)
        walk(-5234, 33, -7166, 0, 0)
        walk(-5239, 33, -7166, 90, 0)
        walk(-5239, 33, -7168, 180, 0)
    elseif(destination == 7) then           --Potato
        navigate(0)
        walk(-5223, 33, -7204, 180, 0)
        walk(-5234, 33, -7204, 90, 0)
        walk(-5234, 33, -7166, 0, 0)
        walk(-266, 33, -7166, 90, 0)
        walk(-5239, 33, -7168, 180, 0)
    elseif(destination == 8) then           --Potato
        navigate(0)
        walk(-5223, 32.5, -7204, 180, 0)
        walk(-5228, 32.5, -7204, 90, 0)
        walk(-5228, 32.5, -7191, 0, 0)
        walk(-5261, 32.5, -7191, 90, 0)
        walk(-5261, 32.5, -7136, 0, 0)
        walk(-5264, 33, -7136, 180, 0)
    elseif(destination == 9) then           --Carrot
        navigate(0)
        walk(-5223, 32.5, -7204, 180, 0)
        walk(-5228, 32.5, -7204, 90, 0)
        walk(-5228, 32.5, -7217, 180, 0)
        walk(-5266, 32.5, -7217, 90, 0)
        walk(-5266, 32.5, -7169, 0, 0)
        walk(-5269, 32.5, -7169, 180, 0)
    elseif(destination == 10) then           --Food Storage
        navigate(0)
        walk(-5223, 32.5, -7204, 180, 0)
        walk(-5228, 32.5, -7204, 90, 0)
        walk(-5228, 32.5, -7178, 0, 0)
        walk(-5223, 32.5, -7178, -90, 0)
        walk(-5223, 32.5, -7164, 0, 0)
        eat()
        walk(-5212, 32.5, -7164, -90, 0)
        look(180, -15, 500)
    end
end

function farm(x, y, z, row, col, yaw, navigationPoint, modus) --modus=0 --> SugarCane; modus=1 --> Carrot Potato
    clearInventory()
    getFood()
    navigate(navigationPoint)
    a, b, c = x, y, z
    for d = 1, col, 1 do 
        a, b, c = x, y, z
        walk(x, y, z, yaw, 0)
        sleep(2000)
        
        if((yaw > 170 and yaw <= 180) or (yaw < -170 and yaw >= -180)) then c = z-row end
        if(yaw > -10 and yaw < 10) then a = x+row end
        if(yaw < -80 and yaw > -100) then c = z+row end
        if(yaw > 80 and yaw < 100) then a = x-row end
        
        threads = {}
        moveDone = 0
        threads[#threads+1] = thread.new( destroy )
        if(modus == 0) then 
            threads[#threads+1] = thread.new( walk, a, b, c, yaw, 0)
        else
            threads[#threads+1] = thread.new( walk, a, b, c, yaw, 50)
        end
        startThreads()
        sleep(250)

        threads = {}
        moveDone = 0
        threads[#threads+1] = thread.new( plant )
        threads[#threads+1] = thread.new( walk, x, y, z, yaw, 50)
        startThreads()
        threads = {}
        look(yaw, 0, 500)
        if((yaw > 170 and yaw <= 180) or (yaw < -170 and yaw >= -180)) then x = x+1 end
        --if(yaw > -10 and yaw < 10) then a = x+row end
        --if(yaw < -80 and yaw > -100) then c = z+row end
        if(yaw > 80 and yaw < 100) then z = z-1 end
        eat()
        if(d % 25 == 0) then
            clearUpperInventory()
            navigate(navigationPoint)
        end
        walk(x, y, z, yaw, 0)
    end
end

while(Bot) do

    setHotbar(6)

    farm(-5220, 32.5, -7167, 110, 63, 180, 1, 0)
    sleep(10000)

    farm(-5290, 32, -7209, 51, 63, 90, 2, 0)
    sleep(10000)

    farm(-5294, 24, -7196, 48, 76, 90, 3, 0)
    sleep(10000)

    farm(-5294, 24, -7136, 45, 51, 90, 4, 0)
    sleep(10000)

    farm(-5239, 33, -7168, 180, 104, 17, 6, 1)
    sleep(10000)

    farm(-5266, 33, -7168, 180, 104, 15, 7, 1)
    sleep(10000)

    farm(-5264, 33, -7136, 180, 136, 23, 8, 1)
    sleep(10000)

    farm(-5269, 33, -7169, 180, 44, 62, 9, 1)
    sleep(10000)

end

Bot = false
