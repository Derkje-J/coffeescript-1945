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
			
	# Updates the movable sprite
	#
	# @param event [TickEvent] the tick event
	#
	update: ( event ) ->
		return this if event.paused
		dt = event.delta / 1000
		@x += dt * @velocity.x
		@y += dt * @velocity.y
		return this