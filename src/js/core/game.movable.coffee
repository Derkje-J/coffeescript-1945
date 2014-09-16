'use strict'
#
#
class Game.Movable extends Game.Sprite
	
	# The direction strings
	#
	@Direction =
	
		# Directions
		up: 'up'
		down: 'down'
		left: 'left'
		right: 'right'
		
		# Inverses
		notup: 'down'
		notdown: 'up'
		notleft: 'right'
		notright: 'left'
		
		# Sides
		sideup: [ 'left', 'right' ]
		sidedown: [ 'right', 'left' ]
		sideleft: [ 'down', 'up' ]
		sideright: [ 'up', 'down' ]
	
	# Creates a new Game Movable
	#
	# @param spritesheet [createjs.SpriteSheet] the spritesheet for this sprite
	#
	constructor: ( spritesheet, x, y, vx = 0, vy = 0 ) ->
		super spritesheet, x, y
		@velocity = 
			x: vx
			y: vy
			
		@_levelPaused = off
		Game.EventManager.on 'level.paused', @, @onPaused
		
	#
	#
	#
	onPaused: ( source, state ) ->
		@_levelPaused = state
		return true
			
	# Updates the movable sprite
	#
	# @param event [TickEvent] the tick event
	#
	update: ( event ) ->
		return this if event.paused or @_levelPaused is on
		dt = event.delta / 1000
		for prop, value of @velocity
			@[ prop ] += dt * value
		@y += Game.Canvas1945.ScrollSpeed * dt
		return this