homePointer = homePointer or {}
 
 
 
function homePointer.init()
  homePointer.pane = hud3D.newPane("xz")
  homePointer.pane.xray()
  homePointer.img  = homePointer.img or image.new(32, 32)
  homePointer.pane.enableDraw()
  homePointer.pane.changeTexture( homePointer.img )
  homePointer.pane.setOpacity(.25)
 
  local uIn = prompt("Home Pos: (blank = here)", "text")
  if uIn == nil then
    homePointer.target = nil
  elseif uIn =="" then
    homePointer.target = {getPlayerPos()}
  else
    local m = uIn:gmatch("[-%d]+")
    homePointer.target = {tonumber(m()), tonumber(m()), tonumber(m())}
  end
  log(string.format("Target = {%7.2d, %7.2d, %7.2d}", table.unpack(homePointer.target)))
end
function homePointer.cleanup()
  homePointer.pane.disableDraw()
--  homePointer.img.graphics.destroy()
end
 
function homePointer.draw()
  local img = homePointer.img
  local g = img.graphics
  local cx, cy = img.getWidth()/2, img.getHeight()/2
  local px, py, pz = getPlayerPos()
  local dx, dz = px - homePointer.target[1], pz-homePointer.target[3]
  local yaw = math.atan2(dz,dx)
--  local yaw = math.rad(getPlayer().yaw-90)
  local NTY = math.rad(90)
  local w, q = cx*.9, cx*.45
 
  local a = {w*math.cos(yaw)+cx,   w * -math.sin(yaw)+cy}
  local d = {w*-math.cos(yaw)+cx,  w *  math.sin(yaw)+cy}
  local b = {q*math.cos(yaw+NTY)+cx,q * -math.sin(yaw+NTY)+cy}
  local c = {q*-math.cos(yaw+NTY)+cx,q*  math.sin(yaw+NTY)+cy}
  local t1 = {a, b, c}
  local t2 = {d, b, c}
 
  g.setColor(0x90FFFFFF)
  g.fillOval( 0, 0, 32, 32)
  g.setColor(0xFFFF0000)
  g.fillPolygon(t1)
 
  g.setColor(0xFF777777)
  g.fillPolygon(t2)
  img.update()
end
 
function homePointer.loop()
  log("Launched: "..tostring(homePointer.active))
  local hp = homePointer
  hp.draw()
  local fps = 10
  local mfps = 60
 
  local mdelay = 1000/mfps
  local delay = 1000/fps
  local nextDraw = os.millis() + delay
  local nextMove = os.millis()
  while homePointer.active do
    if os.millis() > nextDraw then
      hp.draw()
      nextDraw = nextDraw+delay
    end
    if os.millis() > nextMove then
      local x,y,z = getPlayerPos()
      hp.pane.setPos(x-.5, y, z-.5)
      nextMove = nextMove + mdelay
    end
  end
end
 
function homePointer.toggle()
  homePointer.active = not homePointer.active
  if not homePointer.active then return end
 
  homePointer.init()
  if homePointer.target ~=nil then
    log("Home Pointer: &aON")
  else
    log("Home Pointer: &eCANCELED")
  end
  a,b = pcall(homePointer.loop)
  if not a then log("&c"..b) end
  log("Home Pointer: &cOFF")
  homePointer.cleanup()
end
 
homePointer.toggle()
