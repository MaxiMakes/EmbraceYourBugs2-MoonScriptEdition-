export id
class block
  size: 20
  density: 200000
  img: love.graphics.newImage("asset.png")
  new: (x, y) =>
    @body = love.physics.newBody(world, x, y, "dynamic")
    @shape = love.physics.newRectangleShape(x, y, @size, @size)
    @fix = love.physics.newFixture @body, @shape, @density
    @id = id
    id += 1
  draw: =>
    love.graphics.setColor 40*@id, 10*@id, 35*@id
    love.graphics.polygon "fill", @body.getWorldPoints(@body, @shape.getPoints(@shape))
    --love.graphics.draw(@img, @body\getX!, @body\getY!, 0, 0.3 , 0.3, 10, 10)
    print "Draw Block"
