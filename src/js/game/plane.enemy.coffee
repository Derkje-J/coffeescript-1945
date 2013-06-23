'use strict'
#
#
class Game.PlaneEnemy extends Game.Plane
		
	# The direction strings
	#
	@Behaviour =
		looper: 'looper'
		shoot:
			straight: 'shoot-straight'
			aim: 'shoot-aim'
		spawn:
			random:
				x: 'spawn-random-x'
				y: 'spawn-random-y'
		
	# Creates a new Game Plane
	#
	# @param spritesheet [createjs.SpriteSheet] the spritesheet for this sprite
	#
	constructor: ( spritesheet, x = ( Game.Canvas1945.LevelWidth / 2 + .5) | 0, y = - 64, health = 3 ) ->
		super spritesheet, x, y, health
		@behaviour = []
		
		Game.EventManager.trigger( 'collidable.create', @, [ Game.CollisionManager.Groups.Enemy, @ ]  )
		
	#
	#
	addBehaviour: ( behaviour, next = off ) ->
		@behaviour.push behaviour
		
		unless next
			if @behaves PlaneEnemy.Behaviour.spawn.random.x
				@x = Math.random() * Game.Canvas1945.LevelWidth
			if @behaves PlaneEnemy.Behaviour.spawn.random.y
				@y -= Math.random() * Game.Canvas1945.LevelHeight * 2
		
		return this
		
	#
	#
	behaves: ( behaviour ) ->
		return behaviour in @behaviour
	
	# Updates the enemy
	#
	# @param event [TickEvent] the event
	# @return [self] the chainable self
	#
	update: ( event ) ->
		return if event.paused
		super event
		
		if @_facing is Game.Plane.Direction.down and @y > Game.Canvas1945.Height
			
			if @behaves PlaneEnemy.Behaviour.looper
				@y = -64
			if @behaves PlaneEnemy.Behaviour.spawn.random.x
				@x = Math.random() * Game.Canvas1945.LevelWidth
				
			# else
			# todo kill	
			
		else if @_facing is Game.Plane.Direction.up and @y < - 64
			
			if @behaves PlaneEnemy.Behaviour.looper
				@y = Game.Canvas1945.Height
			if @behaves PlaneEnemy.Behaviour.spawn.random.x
				@x = Math.random() * Game.Canvas1945.LevelWidth
			
			# else
			# todo kill	
			
		return this
		
	#
	#
	collide: ( group, object ) ->
		if @inflict object.damage
			Game.EventManager.trigger 'collidable.destroy', @, [ Game.CollisionManager.Groups.Enemy, @ ]
		
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