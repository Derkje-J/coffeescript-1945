'use strict'
#
#
class Game.Player extends Game.Plane
	
	# The key codes to go left
	#
	@KeyLeft = [ 37, 65, 100 ]
	
	# The key codes to go up
	#
	@KeyUp = [ 38, 87, 104 ]
	
	# The key codes to go right
	#
	@KeyRight = [ 39, 68, 101 ]
	
	# The key codes to go down
	#
	@KeyDown = [ 40, 83, 98 ]
	
	# The key codes for the primary action
	#
	@KeyPrimary = [ 32, 101 ]
	
	# The key codes for the secondary action
	#
	@KeySecondary = [ 16, 96 ]
		
	# The level padding
	#
	@Padding = 45
	
	# Creates a new Game Player
	#
	# @param spritesheet [createjs.SpriteSheet] the spritesheet for this sprite
	#
	constructor: ( spritesheet ) ->
		super spritesheet, undefined, Game.Canvas1945.LevelHeight - Player.Padding, 100
		@face Game.Movable.Direction.up
		@move()		
		
		@speed.forward = 2

		Game.EventManager.trigger 'collidable.create', @, [ Game.CollisionManager.Groups.Player, @ ]

	# Updates the player
	#
	# @param event [TickEvent] the event
	# @return [self] the chainable self
	#
	update: ( event ) ->
		return this if event.paused or @isLevelPaused is on
		super event
		
		# Bound movement
		@x = Player.Padding if @x < Player.Padding
		@x = Game.Canvas1945.LevelWidth - Player.Padding if @x > Game.Canvas1945.LevelWidth - Player.Padding
		@y = Player.Padding if @y < Player.Padding
		@y = Game.Canvas1945.LevelHeight - Player.Padding if @y > Game.Canvas1945.LevelHeight - Player.Padding
		
		return this
		
	#
	#
	collide: ( group, object ) ->
		if @inflict object.damage
			Game.EventManager.trigger 'collidable.destroy', @, [ Game.CollisionManager.Groups.Player, @ ]
			
		
	# Update input for the player
	#
	# @param event [KeyboardEvent] the event
	# @param state [Boolean] the state
	# @return [self] the chainable self
	#
	input: ( event, state ) ->
		
		if @isLevelPaused is on
			return false
			
		# Not movable if dead
		unless @isAlive
			return false
		
		dir = null
		
		# Direction keycodes
		if event.keyCode in Player.KeyDown
			dir = Game.Movable.Direction.down
		else if event.keyCode in Player.KeyUp
			dir = Game.Movable.Direction.up
		else if event.keyCode in Player.KeyRight
			dir = Game.Movable.Direction.right
		else if event.keyCode in Player.KeyLeft
			dir = Game.Movable.Direction.left
			
		# Action keycodes
		else if event.keyCode in Player.KeyPrimary
			@primaryEnabled = state
		else if event.keyCode in Player.KeySecondary
			@secondaryEnabled = state
			
		return false unless dir?
		
		# Update the direction array
		unless state
			@direction = _.without @direction, dir 
		else unless _.contains @direction, dir
			@direction.push dir
		
		@setVelocity()
			
		return true
	
	#
	#
	primaryAction: () ->
		#weapon = GameWeapon...
		Game.EventManager.trigger 'bullet.create', @, [ Builder.Bullet.create( Game.PlayerBullet, @x, @y ) ]
		