export p
class player
  density = 50
  size = 20
  source = love.audio.newSource( "Jump2.ogg", "static" )

  new: (x = love.graphics.getWidth!/2, y = 100)=>
    @body = love.physics.newBody(world, x, y, "dynamic")
    @body\setFixedRotation(true)
    @shape = love.physics.newRectangleShape(x, y, size, size)
    @fix = love.physics.newFixture(@body, @shape, @density)
    @colliders = 0
  draw: =>
    love.graphics.setColor 5, 224, 129
    love.graphics.polygon "fill", @body\getWorldPoints(@shape\getPoints())
  update: (dt)=>
    --print p[1].colliders
    if love.keyboard.isDown 'right'
      @body\applyForce 8000*dt, 0
    if love.keyboard.isDown 'left'
      @body\applyForce -8000*dt, 0
    if love.keyboard.isDown('up') and p[1].colliders > 0 --  <- worst solution ever
      love.audio.play(source)
      @body\applyForce 0, -15000*dt

    return
