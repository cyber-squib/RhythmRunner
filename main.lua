function love.load()
  --love.window.setFullscreen(true)
  love.window.setMode(1280,720)
  local w=love.graphics.getWidth()
  local h=love.graphics.getHeight()
  local d=h/6
  _button1=setmetatable({x=w*5/7+0,y=h/2+d,b='a'},Button)
  _button2=setmetatable({x=w*5/7+d,y=h/2+0,b='b'},Button)
  _button3=setmetatable({x=w*5/7-d,y=h/2+0,b='x'},Button)
  _button4=setmetatable({x=w*5/7+0,y=h/2-d,b='y'},Button)
  _button5=setmetatable({x=w*2/7+0,y=h/2+d,b='dpdown'},Button)
  _button6=setmetatable({x=w*2/7+d,y=h/2+0,b='dpright'},Button)
  _button7=setmetatable({x=w*2/7-d,y=h/2+0,b='dpleft'},Button)
  _button8=setmetatable({x=w*2/7+0,y=h/2-d,b='dpup'},Button)
end

function love.draw()
  --love.graphics.setColor(0xf3/0xff,0xea/0xff,0xd6/0xff,0xff/0xff)
  love.graphics.clear(0xf3/0xff,0xea/0xff,0xd6/0xff,0xff/0xff)
  _button1:draw()
  _button2:draw()
  _button3:draw()
  _button4:draw()
  _button5:draw()
  _button6:draw()
  _button7:draw()
  _button8:draw()
end

Button={}
Button.__index=Button

function Button:draw()
  local s=self
  local x=0
  local y=0
  local b=0
  if s.x then x=s.x end
  if s.y then y=s.y end
  if s.b then b=s.b end
  local r=love.graphics.getHeight()/16
  local h=love.graphics.getHeight()/48
  local yo=0
  if love.joystick.getJoysticks()[1]:isGamepadDown(b) then yo=h*3/4 end
  love.graphics.setColor(0x4d/0xff,0x7a/0xff,0xd9/0xff,0xff/0xff)
  love.graphics.circle('fill',x,y+h,r)
  love.graphics.rectangle('fill',x-r,y+yo,r*2,h-yo)
  love.graphics.circle('fill',x,y+yo,r)
  love.graphics.setColor(0xf3/0xff,0xea/0xff,0xd6/0xff,0xff/0xff)
  love.graphics.circle('fill',x,y+yo,r*15/16)
  love.graphics.setColor(0x66/0xff,0xe3/0xff,0xbc/0xff,0xff/0xff)
  love.graphics.circle('fill',x,y+yo,r*14/16)
end
