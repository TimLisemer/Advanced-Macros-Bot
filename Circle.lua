circleGuideOn = not circleGuideOn
if not circleGuideOn then return end
 
local res = 1
 
circleGuide = (circleGuide and circleGuide.destroy and circleGuide) or hud3D.newPane("xz")
local rad = tonumber(prompt("Radius:"))
 
circleGuideTex = image.new(res*(rad*2+1), res*(rad*2+1))
circleGuide.changeTexture( circleGuideTex )
circleGuide.setSize(rad*2+1, rad*2+1)
circleGuide.setOpacity(.3)
local g = circleGuideTex.graphics
g.setColor(0xFFFF0000) --red
g.drawOval(1,1,rad*2*res,rad*2*res)
g.setColor(0xFF00FF00) --green
g.fillRect(rad*res+1, rad*res+1,1,1)
 
circleGuideTex.update()
 
local x,y,z = getPlayerBlockPos()
circleGuide.setPos( x-rad, y, z-rad )
circleGuide.enableDraw()
circleGuide.xray()
 
 
log("Guide &aON &f(&7",rad,"&f)")
while circleGuideOn do
  local _,py = getPlayerPos()
  circleGuide.setPos(x-rad, py, z-rad)
  waitTick()
end
log("Guide &cOff")
circleGuide.disableDraw()
