'use strict'
# This is the main class for the canvas game
#
class Game.Canvas1945 extends Game.Container
	
	# The width of the game
	#
	@Width = 640
	
	#
	#
	@LevelWidth = 640
	
	# The height of the game
	#
	@Height = 480
	
	#
	#
	@LevelHeight = 410
	
	# The current scroll speed of the game
	#
	@ScrollSpeed = 100
		
	# Creates a new Game
	#
	constructor: ->
	
		super

		# Create the stage
		@canvas = @_createCanvas()
		@stage = @container = new createjs.Stage @canvas
		@_setTicker()
		@_setInput @canvas
		@_createPersistantData()
		@_createLayers()
		@_createLevel()
		@_createDebug()
	
		# Define some properties
		Object.defineProperty( @, 'paused',
			get: -> return createjs.Ticker.getPaused()
			set: ( value ) ->  createjs.Ticker.setPaused value
		)
		
	# Sets the ticker
	#
	# @return [self] the chainable self
	#
	_setTicker: ->
		createjs.Ticker.addEventListener "tick", @update
		createjs.Ticker.useRAF = on
		createjs.Ticker.setFPS 60
		return this
		
	# Sets the input event
	#
	# @param event [Event] the event 
	# @return [self] the chainable self
	#
	_setInput: ( canvas = @canvas ) ->
		canvas.onkeydown = ( event ) =>
			@input event, on
			return false
		canvas.onkeyup = ( event ) =>
			@input event, off
			return false
		return this
		
	# Creates the canvas element
	#
	# @return [HTMLElement] the canvas element
	#
	_createCanvas: ->
		canvas = document.createElement 'canvas'
		canvas.id = 'game'
		canvas.setAttribute 'width', Canvas1945.Width
		canvas.setAttribute 'height', Canvas1945.Height
		canvas.setAttribute 'tabindex', 0
		container = document.getElementById "container"
		container.appendChild canvas 
		
		canvas.onmousedown = ( event ) -> 
			canvas.focus() 
			return false
		
		return canvas
		
	# Create the layers
	#
	# @return [self] the chainable self
	#
	_createLayers: ->
		@add 'background', new Game.Container()
		@add 'level', new Game.Container()
		@add 'foreground', new Game.Container()
		@add 'hud', new Game.Container()
		return this
		
	# Creates the level
	#
	# @return [self] the chainable self
	#
	_createLevel: ->		
		@level = new Game.Level @
		return this
		
	#
	#
	_createPersistantData: ->
		@lives = 3
		@score = 0
		return this
		
	# Creates the DEBUG hud
	#
	# @return [self] the chainable self
	#
	_createDebug: ->
		@addTo 'hud', 'fps', new Display.FPS()
		return this
		
	# Removes the layers
	#
	# @return [self] the chainable self
	#
	_removeLayers: ->
		@remove 'hud'
		@remove 'foreground'
		@remove 'level'
		@remove 'background'
		return this
	
	# Add to layer
	#
	# @param layer [String] the layer name
	# @param key [String] the key
	# @param object [any] the object
	# @return [self] the chainable self
	#
	addTo: ( layer, key, object ) ->
		( @get layer ).add key, object
		return this
		
	# Gets from layer
	#
	# @param layer [String] the layer name
	# @param key [String] the key
	#
	getFrom: ( layer, key ) ->
		return ( @get layer ).get key
		
	# Remove from layer
	#
	# @param layer [String] the layer name
	# @param key [String] the key
	# @return [self] the chainable self
	#
	removeFrom: ( layer, key ) ->
		( @get layer ).remove key
		return this
	
	# Runs every tick and passes down the tick event
	# 
	# @param event [Event] the update event
	# @return [self] the chainable self
	#
	update: ( event ) ->
		super event
		@stage.update()
		return this
