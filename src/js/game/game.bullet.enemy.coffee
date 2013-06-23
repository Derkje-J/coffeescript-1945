'use strict'
#
#
class Game.EnemyBullet extends Game.Bullet
	
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
		super spritesheet, x, y, vx, vy, type, damage, args