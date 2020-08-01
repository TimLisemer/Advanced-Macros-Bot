positionOn = not positionOn
if not positionOn then return end

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


function navigate(x, y, z)

    a, b, c = getPlayerPos()

    if a > x then
    end

end



log (string.format("started Running"))

draw(0, 4, 0)

local x, y, z
while positionOn do
    x, y, z = getPlayerPos()
    entity = getEntity(1)

    log(string.format("Yaw: ", entity.isOnLadder, " Pitch: ", entity.name))
    
    sleep(10)
end
log("position &cOff")
