local threads = {}

Cytooxien = not Cytooxien
if not Cytooxien then return end


local function startThreads()
    for i=1, #threads do
      threads[i].start()
    end
   
    while true do
      local isOneRunning = false
      for i=1, #threads do
        isOneRunning = isOneRunning or (threads[i].getStatus()~="done")
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
    use(1000)
    sleep(1000)
    setHotbar(6)
end

function sugarCane(x, y, z, row, col, yaw)
    threads = {}
    a, b, c = x, y, z
    for d = 1, col, 1 do 
        a, b, c = x, y, z
        walk(x, y, z, yaw, 0)
        sleep(2000)
        
        if((yaw > 170 and yaw <= 180) or (yaw < -170 and yaw >= -180)) then c = z-row end
        if(yaw > -10 and yaw < 10) then a = x+row end
        if(yaw < -80 and yaw > -100) then c = z+row end
        if(yaw > 80 and yaw < 100) then a = x-row end

        moveDone = 0
        threads[#threads+1] = thread.new( destroy )
        threads[#threads+1] = thread.new( walk, a, b, c, yaw, 0)
        startThreads()
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
        walk(x, y, z, yaw, 0)
    end
end


local inv = openInventory()

--[[
while(Cytooxien) do
    setHotbar(6)
    sleep(1000)
    --sugarCane(-5220, 32.5, -7167, 110, 63, 180)
    --sleep(10000)

    walk(-5157, 32.5, -7166, 180, 0)
    walk(-5223, 32.5, -7166, 90, 0)
    walk(-5223, 32.5, -7203, 180, 0)
    walk(-5292, 32.5, -7203, 90, 0)
    walk(-5292, 32, -7208, 90, 0)
    --sugarCane(-5290, 32, -7208, 45, 1, 90)
    --sugarCane(-5290, 32, -7209, 51, 63, 90)
    sleep(10000)

    walk(-5290, 32, -7270, 0, 0)
    walk(-5286, 32.5, -7270, 0, 0)
    walk(-5286, 33, -7204, 0, 0)
    walk(-5338, 33, -7204, 90, 0)
    walk(-5338, 25, -7192, 0, 0)
    walk(-5297, 24.5, -7192, -90, 0)
    walk(-5297, 24, -7195, 180, 0)
    --sugarCane(-5294, 24, -7195, 42, 1, 90)
    --sugarCane(-5294, 24, -7196, 48, 76, 90)
    sleep(10000)

    walk(-5294, 24, -7265, 180, 0)
    walk(-5290, 24.5, -7265, -90, 0)
    walk(-5290, 24.5, -7136, 0, 0)
    --sugarCane(-5294, 24, -7136, 42, 51, 90)
    sleep(10000)

    walk(-5294, 24.5, -7191, -180, 0)
    walk(-5229, 25, -7191, -90, 0)
    walk(-5229, 33, -7203, -180, 0)
    walk(-5223, 32.5, -7203, -90, 0)
    walk(-5223, 32.5, -7167, 0, 0)
end
]]--

Cytooxien = false

