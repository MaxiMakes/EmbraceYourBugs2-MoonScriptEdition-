export width, height, id, i, world, beginContact, endContact, exit, enter, gamestate, p
blocks = require 'block'
player = require 'player'

bList = {}
floor = {}
p = {}

won = false
lost = false

id = 0
i = 0

beginContact= (a, b, coll)->
  --print "Coll!"
  if(a == p[1].fix)
    enter(a,b,coll)
  if(b == p[1].fix)
    enter(b,a,coll)
  return
endContact= (a,b,coll)->
  if(a == p[1].fix)
    exit(a,b,coll)
  if(b == p[1].fix)
    exit(b,a,coll)
  return
exit= (a,b,coll)->
  p[1].colliders -= 1
  --print(p[1].colliders)
  return
enter= (a,b,coll)->
  p[1].colliders += 1
  x, y = b\getBody()\getLinearVelocity()
  if y >= 1
    lost = true
  return

class game
  isRunning: false
  reset: ->
    lost = false
    for i,v in ipairs(bList)
      v.body\destroy!
      v.shape\destroy!
      v.fix\destroy!
    bList = {}
    id = 0
    for i,v in ipairs(p)
      v.body\destroy!
      v.shape\destroy!
      v.fix\destroy!
    p = {}
    table.insert p, player()
    gamestate = "Game"
    print "reset"
  load: ->
    love.physics.setMeter 64
    world = love.physics.newWorld 0, 9.81*64, false
    world.setCallbacks world, beginContact, endContact, preSolve, postSolve
    floor.body  = love.physics.newBody world, love.graphics.getWidth!, love.graphics.getHeight!-20, "static"
    floor.shape = love.physics.newRectangleShape  love.graphics.getWidth!, 20 --floor.body\getX!, floor.body\getY!,
    floor.fix   = love.physics.newFixture floor.body, floor.shape, blocks.density
    table.insert p, player()
  update: (dt)->
    --print p[1].body\getX!
    world\update(dt)
    for i, v in ipairs(p) do
  	 	v\update(dt)
  draw: ->
    love.graphics.push()
    love.graphics.translate(-p[1].body\getX(), -p[1].body\getY()+love.graphics.getHeight!/4*2.2)
    love.graphics.setColor( 255, 255, 255)
    love.graphics.polygon("fill", floor.body\getWorldPoints(floor.shape\getPoints!))
    for i,v in pairs(bList) do
      v\draw!
    love.graphics.setColor( 255, 255, 255)
    for i,v in ipairs(p) do
      v\draw!
    love.graphics.pop!
    if lost == true
      love.graphics.setColor( 255, 255, 255)
      love.graphics.print("You Lost", p[1].body\getX(), height / 2)
  keypressed: (key)->
    switch key
      when "escape" --return MainMenu
        gamestate = "MainMenu"
      when "1"
        a = blocks(p[1].body\getX!- 20*5,-20)
        table.insert(bList, a)
      when "2"
        a = blocks(p[1].body\getX!-blocks.size*4+2,-20)
        table.insert(bList, a)
      when "3"
        a = blocks(p[1].body\getX!-blocks.size*3+2,-20)
        table.insert(bList, a)
      when "4"
        a = blocks(p[1].body\getX!-blocks.size*2+2,-20)
        table.insert(bList, a)
      when "5"
        a = blocks(p[1].body\getX!,-20)
        table.insert(bList, a)
      when "6"
        a = blocks(p[1].body\getX!+blocks.size*2+2,-20)
        table.insert(bList, a)
      when "7"
        a = blocks(p[1].body\getX!+blocks.size*3+2,-20)
        table.insert(bList, a)
      when "8"
        a = blocks(p[1].body\getX!+blocks.size*4+2,-20)
        table.insert(bList, a)
      when "9"
        a = blocks(p[1].body\getX!+blocks.size*5+2,-20)
        table.insert(bList, a)
      when "0"
        a = blocks(p[1].body\getX!+blocks.size*6+2,-20)
        table.insert(bList, a)
    return
