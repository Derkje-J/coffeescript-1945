'use strict'
#
#
class Game.Plane extends Game.Movable
		
	
	# The base speed
	#
	@BaseSpeed =
		side: 100
		forward: 100
		
	# Creates a new Game Plane
	#
	# @param spritesheet [createjs.SpriteSheet] the spritesheet for this sprite
	# @param x [Integer] the x spawn position
	# @param y [Integer] the y spawn position
	# @param health [Integer] the health
	#
	constructor: ( spritesheet, x = ( Game.Canvas1945.LevelWidth / 2 + .5) | 0, y = - 64, health = 3 ) ->
		super spritesheet, x, y
		# Movement
		@direction = []
		@speed =
			side: 1
			forward: 1
			
		# Action
		@primaryEnabled = off
		@secondaryEnabled = off
		@_nextActionTime = 0
		@_throttleActionTime = 350
		
		# Health
		@health = @maxhealth = health
		@damage = 30
		
		@play 'idle'
		@face Game.Movable.Direction.down
		@move Game.Movable.Direction.down
		
	# Inflicts damage to this plane
	#
	# @param damage [Integer] the damage
	# @return [Boolean] fatal damage
	#
	inflict: ( damage ) ->
		
		if ( @health -= damage ) <= 0
			@health = 0
			
			# Explode animation
			@after 'explode', @destroy
			@play 'explode'
			
			# Face down and move along the scrollspeed
			@_facing = Game.Movable.Direction.down
			@direction = [ Game.Movable.Direction.down ]
			@setVelocity()
			
			return true
		return false
		
	# Get direction modifier for a direction
	#
	# @param direction [Integer] the direction
	# @return [Object] the modifiers
	#
	getDirectionModifier: ( direction ) ->
		speed = 0
		
		# Base speed
		if @_facing is direction 
			speed = Plane.BaseSpeed.forward * @speed.forward
		else if direction in Game.Movable.Direction[ "side#{@_facing}" ]
			speed = Plane.BaseSpeed.side * @speed.side
		else if direction is Game.Movable.Direction[ "not#{@_facing}" ]
			speed = 0
			
		if direction is Game.Movable.Direction.down
			speed += Game.Canvas1945.ScrollSpeed
		
		return switch direction
			when Game.Movable.Direction.up
				{ y: -speed }
			when Game.Movable.Direction.left
				{ x: -speed }
			when Game.Movable.Direction.right
				{ x: speed }
			when Game.Movable.Direction.down
				{ y: speed }
	
	# Updates the plane
	#
	# @param event [TickEvent] the event
	# @return [self] the chainable self
	#
	update: ( event ) ->
		return if event.paused
		super event
		
		if @_nextActionTime <= 0 or ( @_nextActionTime -= event.delta ) <= 0
			if @primaryEnabled
				@_nextActionTime += @_throttleActionTime
				@primaryAction?()
			if @secondaryEnabled
				@_nextActionTime += @_throttleActionTime
				@secondaryAction?()
		
		return this
		
	# Destroys this plane
	#
	destroy: () ->
		super
		Game.EventManager.trigger 'plane.destroy', @, []
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
			@velocity[ key ] = value
		return this
	
	# Moves the plane in a direction
	#
	# @param directions [Integer] the directions
	# @return [self] the chainable self
	#
	move: ( directions... ) ->
		@direction = []
		@direction.push direction for direction in directions
		@setVelocity()
		return this
		
	#
	#
	face: ( direction ) ->
		return this if @_facing is direction
		@_facing = direction
		@setVelocity()
		return this