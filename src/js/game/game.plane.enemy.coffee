'use strict'
#
#
class Game.EnemyPlane extends Game.Plane
		
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
			ondeath: 'ondeath'
		fire:
			point: 'point'
		
	# Creates a new Game Plane
	#
	# @param spritesheet [createjs.SpriteSheet] the spritesheet for this sprite
	#
	constructor: ( spritesheet, x = ( Game.Canvas1945.LevelWidth / 2 + .5) | 0, y = - 64, health = 3 ) ->
		super spritesheet, x, y, health
		@behaviour = []
		
		Game.EventManager.trigger 'collidable.create', @, [ Game.CollisionManager.Groups.Enemy, @ ] 
		
	#
	#
	addBehaviour: ( behaviour, next = off ) ->
		@behaviour.push behaviour
		
		unless next
			if @behaves EnemyPlane.Behaviour.spawn.random.x
				@x = Math.random() * Game.Canvas1945.LevelWidth
			if @behaves EnemyPlane.Behaviour.spawn.random.y
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
		
		# Out of bounds
		if ( @y > Game.Canvas1945.Height and @_facing is Game.Movable.Direction.down ) or 
		( @y < - 64 and @_facing is Game.Movable.Direction.up )
			
			# If not a looper, kill
			unless @behaves EnemyPlane.Behaviour.looper
				@destroy() if destroy	
			
			# Set new positions
			@y = if @_facing is Game.Movable.Direction.down then -64 else Game.Canvas1945.Height
			if @behaves EnemyPlane.Behaviour.spawn.random.x
				@x = Math.random() * Game.Canvas1945.LevelWidth
				
		return this
		
	#
	#
	collide: ( group, object ) ->
		if @inflict object.damage
			Game.EventManager.trigger 'collidable.destroy', @, [ Game.CollisionManager.Groups.Enemy, @ ]
			
	#
	#
	destroy: () ->
		unless @behaves EnemyPlane.Behaviour.spawn.ondeath
			Game.EventManager.trigger 'plane.destroy', @, []
			return this
			
		@health = @maxhealth
		@play 'idle'
		@y = if @_facing is Game.Movable.Direction.down then -64 else Game.Canvas1945.Height
		if @behaves EnemyPlane.Behaviour.spawn.random.x
			@x = Math.random() * Game.Canvas1945.LevelWidth
		Game.EventManager.trigger 'collidable.create', @, [ Game.CollisionManager.Groups.Enemy, @ ]