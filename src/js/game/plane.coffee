'use strict'
#
#
class Game.Plane extends Game.Movable
		
	# The direction strings
	#
	@Direction =
		up: 'up'
		down: 'down'
		left: 'left'
		right: 'right'	
		
	# The direction modifiers
	#
	@DirectionModifiers =
		up:
			y: -Game.Canvas1945.ScrollSpeed
		down:
			y: Game.Canvas1945.ScrollSpeed
		left:
			x: -Game.Canvas1945.ScrollSpeed
		right:
			x: Game.Canvas1945.ScrollSpeed
	
	# Creates a new Game Plane
	#
	# @param spritesheet [createjs.SpriteSheet] the spritesheet for this sprite
	#
	constructor: ( spritesheet, x = ( Game.Canvas1945.LevelWidth / 2 + .5) | 0, y = 45 ) ->
		super spritesheet, x, y
		@play 'idle'
		
		# Movement
		@direction = []
		@directionMultiplier =
			x: 1
			y: 1
			
		# Action
		@primaryEnabled = off
		@secondaryEnabled = off
		
		# State
		@health = 3
	
	# Updates the player
	#
	# @param event [TickEvent] the event
	# @return [self] the chainable self
	#
	update: ( event ) ->
		return if event.paused
		super event
		
		return this
		
	# Sets the velocity according to the direction
	#
	# @return [self] the chainable self
	#
	setVelocity: () ->
		
		# Get the movement data
		modifiers = _( @direction ).reduce( ( result, key ) -> 
			result[ modifier ] += value for modifier, value of Plane.DirectionModifiers[ key ]
			return result
		, { x: 0, y: 0 } )
		
		# Set the movement data
		for key, value of modifiers
			@velocity[ key ] = value * @directionMultiplier[ key ]
		return this
	