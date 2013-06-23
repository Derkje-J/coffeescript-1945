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
		
	# Creates a new Game Plane
	#
	# @param spritesheet [createjs.SpriteSheet] the spritesheet for this sprite
	#
	constructor: ( spritesheet, x = ( Game.Canvas1945.LevelWidth / 2 + .5) | 0, y = - 64, health = 3 ) ->
		super spritesheet, x, y
		@play 'idle'
		
		# Movement
		@_facing = Plane.Direction.down
		@direction = []
		@speed =
			x: 1
			y: 1
			facing: 1.3
			
		# Action
		@primaryEnabled = off
		@secondaryEnabled = off
		
		# Health
		@health = 3
		@damage = 30
		
	#
	#
	getDirectionModifier: ( direction ) ->
		result = switch direction
			when Plane.Direction.up
				{ y: -Game.Canvas1945.ScrollSpeed }
			when Plane.Direction.down
				{ y: Game.Canvas1945.ScrollSpeed }
			when Plane.Direction.left
				{ x: -Game.Canvas1945.ScrollSpeed }
			when Plane.Direction.right
				{ x: Game.Canvas1945.ScrollSpeed }
				
		if @_facing is direction and direction is Plane.Direction.down
			for p, v of result
				result[ p ] = v * @speed.facing
				
		return result
	
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
		modifiers = _( @direction ).reduce( ( result, key ) => 
			result[ modifier ] += value for modifier, value of @getDirectionModifier key
			return result
		, { x: 0, y: 0 } )
		
		# Set the movement data
		for key, value of modifiers
			@velocity[ key ] = value * @speed[ key ]
		return this
	
	#
	#
	move: ( direction ) ->
		return this if direction in @direction
		@direction.push direction
		@setVelocity()
		return this