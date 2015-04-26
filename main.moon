export width, height, id, i, world, beginContact, endContact, exit, enter, gamestate
game = require 'game'
gamestate = "MainMenu"
--width, height = love.window.getWidth!, love.window.getHeight!
width, height = 400, 600

love.load = ->
  love.window.setTitle("Embrace Your Bugs 2.0")
  game.load!

love.update = (dt)->
  switch gamestate
    when "Game"
      game.update(dt)


love.keypressed = (key)->
  switch gamestate
    when "Game"
      game.keypressed(key)
    when "MainMenu"
      switch key
        when "s" --Start the game
          gamestate = "Game"
          game.isRunning = true
        when "r"
          game.reset!
        when "escape" --Close the window
          love.event.quit!

love.draw = ->
  switch gamestate
    when "Game"
      game.draw!
    when "MainMenu"
--      print "MainMenu"
      love.graphics.setColor( 255, 255, 255)
      msg = ""
      if game.isRunning == true
        msg = "Press 'S' resume the game. \nPress 'escape' to close the window. \nPress 'R' to reset the game"
      else
        msg = "Press 'S' to start a new game. \nPress 'escape' to close the window."
      love.graphics.print(msg, width/2, height/2)
    when "Player1"
      print "Player 1 won"
    when "Player2"
      print "Player 2 won"
