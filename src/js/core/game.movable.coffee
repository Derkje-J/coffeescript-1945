'use strict'
#
#
class Game.Movable extends Game.Sprite
	
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