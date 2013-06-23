'use strict'
#
#
class Game.PlayerBullet extends Game.Bullet
	
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
	constructor: ( spritesheet, x, y, vx = 0, vy = -150, type = 'up', damage = 3, args = {} ) ->
		super spritesheet, x, y, vx, vy, type, damage, args
		Game.EventManager.trigger 'collidable.create', @, [ Game.CollisionManager.Groups.PlayerBullet, @ ]	
			
	# Destroys the bullet
	#
	# @return [self] the chainable self
	#
	destroy: ->
		super
		Game.EventManager.trigger 'collidable.destroy', @, [ Game.CollisionManager.Groups.PlayerBullet, @ ]
		return this