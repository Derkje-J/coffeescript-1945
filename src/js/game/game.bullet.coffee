'use strict'
#
#
class Game.Bullet extends Game.Movable
	
	# Creates a new Game Bullet
	#
	# @param spritesheet [createjs.SpriteSheet] the spritesheet for this sprite
	# @param x [Integer] the x spawn position
	# @param y [Integer] the y spawn position
	# @param vx
	# @param vy
	# @param type [String] the bullet type
	# @param damage [Integer] the damage
	# @param args [Object] additional arguments
	#
	constructor: ( spritesheet, x, y, vx, vy, type = 'point', damage = 1, args = {} ) ->
		super spritesheet, x, y, vx, vy
		@damage = damage
		@play type
		
	# Updates the bullet
	#
	# @param event [TickEvent] the event
	# @return [self] the chainable self
	#
	update: ( event ) ->
		return if event.paused
		super event
		
		if @y < -64 or @y > Game.Canvas1945.Height or @x < -64 or @x > Game.Canvas1945.Width + 64
			@destroy()
		
		return this
		
	#
	#
	collide: ( group, object ) ->
		@destroy()
		
	# Destroys this bullet
	#
	destroy: () ->
		super
		Game.EventManager.trigger 'bullet.destroy', @, []
		return this