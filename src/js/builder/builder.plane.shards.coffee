'use strict'
#
#
class Builder.EnemyPlaneShards extends Builder.SpriteSheet

	#
	#
	@SpriteSheet = null
	
	#
	#
	@ShardsOfType:
		back: 11
		
	#
	#
	constructor: () ->
		super Game.AssetManager.get( 'shards' ).image

	# Creates a new Player Plane
	#
	# @param x [Integer] the x position
	# @param y [Integer] the y position
	# @return [Array<Game.Shard>] the shards
	#
	@create: ( x, y, vx, vy ) ->
		
		if EnemyPlaneShards.SpriteSheet?
			return @_instance x, y, vx, vy
			
		builder = new Builder.EnemyPlaneShards()
		builder.animation( 'back', 4, 4, 32, 32, 1, 1, 4, EnemyPlaneShards.ShardsOfType.back )
		
		EnemyPlaneShards.SpriteSheet = builder.createjs
		return @_instance x, y, vx, vy
	
	#
	#
	@_instance: ( x, y, vx, vy ) ->
		
		results = []
		pick = [ 0...EnemyPlaneShards.ShardsOfType.back ]
		for i in [ 0...5 ]
			picked = pick[ ( Math.random() * pick.length + 0.5 ) | 0 ]
			pick = _( pick ).without picked
			results.push new Game.Shard EnemyPlaneShards.SpriteSheet, x, y, vx, vy, picked, 'back'
		return results
	