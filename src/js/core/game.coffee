#
#
class Game.Game extends Game.Container
	
	# The width of the game
	#
	@Width = ( -> return 640 )()
	
	# The height of the game
	#
	@Height = ( -> return 480 )()
	
		
	# Creates a new Game
	#
	constructor: ->
	
		super
	
		# Create the game container
		canvas = document.createElement 'canvas'
		canvas.id = 'game'
		canvas.setAttribute 'width', Game.Width
		canvas.setAttribute 'height', Game.Height
		
		container = document.getElementById "container"
		container.appendChild canvas
		
		# Create the stage
		@stage = @container = new createjs.Stage canvas
		@_setTicker()
		
	# Sets the ticker
	#
	_setTicker: ->
		createjs.Ticker.addEventListener "tick", @update
		createjs.Ticker.useRAF = on
		createjs.Ticker.setFPS 60
		return this
		
	# Gets the stage
	#
	# @return [Stage] the createjs stage
	#
	getStage: ->
		return @stage
	
	# Runs every tick and passes down the tick event
	#
	update: ( event ) ->
		super event
		@stage.update()
