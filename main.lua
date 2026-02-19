function love.load()
  --love.window.setFullscreen(true)
  love.window.setMode(1920,1080,{centered=true,borderless=true})
  --love.window.setMode(1280,720,{centered=true,borderless=true})
  local w=love.graphics.getWidth()
  local h=love.graphics.getHeight()
  _tune=love.audio.newSource("rsrc/tune.wav","static")
  _confirm=love.audio.newSource("rsrc/confirm.wav","static")
  _decline=love.audio.newSource("rsrc/decline.wav","static")
  --_controlLeft=love.sound.newSoundData("rsrc/control_left.wav")
  --_controlRight=love.sound.newSoundData("rsrc/control_right.wav")
  _controlRight=love.sound.newSoundData("rsrc/control_left.wav")
  _controlLeft=love.sound.newSoundData("rsrc/control_right.wav")
  _tune:play()
  local d=h/(6+1)
          _button1=setmetatable({x=w*19/23+0,y=h/2+d,k=1,b='a'},Button)
          _button2=setmetatable({x=w*19/23+d,y=h/2+0,k=1,b='b'},Button)
          _button3=setmetatable({x=w*19/23-d,y=h/2+0,k=1,b='x'},Button)
          _button4=setmetatable({x=w*19/23+0,y=h/2-d,k=1,b='y'},Button)
          _button5=setmetatable({x=w*04/23+0,y=h/2+d,k=1,b='dpdown'},Button)
          _button6=setmetatable({x=w*04/23+d,y=h/2+0,k=1,b='dpright'},Button)
          _button7=setmetatable({x=w*04/23-d,y=h/2+0,k=1,b='dpleft'},Button)
          _button8=setmetatable({x=w*04/23+0,y=h/2-d,k=1,b='dpup'},Button)
   _leftBeatronome=setmetatable({x=w*19/23,y=h/2,c=_controlLeft},Beatronome)
  _rightBeatronome=setmetatable({x=w*04/23,y=h/2,c=_controlRight},Beatronome)
  _score=0
end

function love.draw()
  --love.graphics.scale(15/16,15/16)
  local w=love.graphics.getWidth()
  local h=love.graphics.getHeight()
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
  _leftBeatronome:draw()
  _rightBeatronome:draw()
  
  local r=love.graphics.getHeight()/(14+03)
  love.graphics.setLineWidth(r/4)
  love.graphics.rectangle("line",w/2-h/4,h/4,h/2,h/2,16,16)
  
  love.graphics.setFont(love.graphics.newFont(w/48))
  love.graphics.print("SCORE: ".._score,w*7/16,h*11/16)
  --if(ro)then love.graphics.print("RADIUS OFFSET: "..ro,w*7/16,h*13/16) end
  --if a then love.graphics.print("ANGLE CONTROL: "..a,w*7/16,h*14/16) end
  --if n then love.graphics.print("ANGLE INPUT: "..n,w*7/16,h*15/16) end
end

function love.gamepadpressed(j,b)

  local c=_controlLeft
  local n
  n=0
  if false then
  elseif b=='a' then
    c=_controlLeft
    n=.5
  elseif b=='b' then
    c=_controlLeft
    n=0
  elseif b=='x' then
    c=_controlLeft
    n=1
  elseif b=='y' then
    c=_controlLeft
    n=1.5
  elseif b=='dpdown' then
    c=_controlRight
    n=.5
  elseif b=='dpright' then
    c=_controlRight
    n=0
  elseif b=='dpleft' then
    c=_controlRight
    n=1
  elseif b=='dpup' then
    c=_controlRight
    n=1.5
  end
  
  local h=love.graphics.getHeight()
  local d=h/6
  
  local a,si
  si=_tune:tell("samples")
  a=0
  a=c:getSample(si,2)+1
  
  local xo=d*math.cos(a)
  local yo=d*math.sin(a)
  
  local r=love.graphics.getHeight()/16
  local ro
  ro=c:getSample(si,1)+1

  if true --_tune:isPlaying()
  and ro>.99 and ro<1.01 then
  elseif true
  and ro<1.75
  and math.abs(a-n)<.3
  then
    _score=_score+1
    _confirm:clone():play()
  else
    _score=_score-1
    _decline:clone():play()
  end

end

function love.mousepressed(x,y,b,t)

  local c=_controlLeft

  if false then
  elseif b==1 then
    c=_controlRight
  elseif b==2 then
    c=_controlLeft
  end
  
  local h=love.graphics.getHeight()
  local d=h/6
  
  local a,si
  si=_tune:tell("samples")
  a=0
  a=(c:getSample(si,2)/2+.5)*2*math.pi
  
  local xo=d*math.cos(a)
  local yo=d*math.sin(a)
  
  local r=love.graphics.getHeight()/16
  local rro
  rro=_controlRight:getSample(si,1)+1
  local lro
  lro=_controlLeft:getSample(si,1)+1
  
  local r=love.graphics.getHeight()/16
  
  if rro>.99 and rro<1.01 and lro>.99 and lro<1.01 then
  elseif (lro<1.75
  and _leftBeatronome
  and _leftBeatronome.rx
  and _leftBeatronome.ry
  and math.abs(_leftBeatronome.rx-x)<r*1.5
  and math.abs(_leftBeatronome.ry-y)<r*1.5)
  or (rro<1.75
  and _rightBeatronome
  and _rightBeatronome.rx
  and _rightBeatronome.ry
  and math.abs(_rightBeatronome.rx-x)<r*1.5
  and math.abs(_rightBeatronome.ry-y)<r*1.5)
  then
    _confirm:clone():play()
    _score=_score+1
  else
    _decline:clone():play()
    _score=_score-1
  end

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
  local r=love.graphics.getHeight()/(16+2)
  local h=love.graphics.getHeight()/48
  local yo=0
  local j=love.joystick.getJoysticks()
  if j[1] and j[1]:isGamepadDown(b) then yo=h*3/4 end
  if s.k and love.mouse.isDown(s.k) 
  and math.abs(love.mouse.getX()-s.x)<r*1.5
  and math.abs(love.mouse.getY()-s.y)<r*1.5
  then yo=h*3/4 end
  
  love.graphics.setColor(0xf1/0xff,0xd8/0xff,0x69/0xff,0xff/0xff)
  love.graphics.circle('fill',x,y+r*.125,r*1.5)
  
  love.graphics.setColor(0x4d/0xff,0x7a/0xff,0xd9/0xff,0xff/0xff)
  love.graphics.circle('fill',x,y+h,r)
  love.graphics.rectangle('fill',x-r,y+yo,r*2,h-yo)
  love.graphics.circle('fill',x,y+yo,r)
  love.graphics.setColor(0xf3/0xff,0xea/0xff,0xd6/0xff,0xff/0xff)
  love.graphics.circle('fill',x,y+yo,r*15/16)
  love.graphics.setColor(0x66/0xff,0xe3/0xff,0xbc/0xff,0xff/0xff)
  love.graphics.circle('fill',x,y+yo,r*14/16)
  
end

Beatronome={}
Beatronome.__index=Beatronome

function Beatronome:draw()



  local s=self
  local x=0
  local y=0
  
  if s.x then x=s.x end
  if s.y then y=s.y end
  
  local c=_controlLeft
  if s.c then c=s.c end
  
  
  local h=love.graphics.getHeight()
  local d=h/(6+1)
  
  local a,si
  si=_tune:tell("samples")
  a=0
  a=(c:getSample(si,2)/2+.5)*2*math.pi
  
  local xo=d*math.cos(a)
  local yo=d*math.sin(a)
  
  
  local r=love.graphics.getHeight()/(14+03)
  --local ro=math.abs(math.sin((c:getSample(si,1)/2+.5)*2*math.pi))*r*2
  --local ro=math.abs((math.sin((c:getSample(si,1)/2+.5)+.25)*math.pi))*r*2
  local ro=(c:getSample(si,1)+1)*love.graphics.getHeight()/(24+08)
  
  love.graphics.setColor(0xe8/0xff,0x7a/0xff,0x48/0xff,0xff/0xff)
  love.graphics.setLineWidth(r/4)
  s.rx=x+xo
  s.ry=y+yo
  love.graphics.circle('line',s.rx,s.ry+r*.125,r*10/8+ro)
  --love.graphics.setColor(0xf3/0xff,0xea/0xff,0xd6/0xff,0xff/0xff)
  --love.graphics.circle('fill',x+xo,y+yo+r*.125,r*13/8)
  
end
