'use strict'
#
#
class Builder.EnemyPlane extends Builder.SpriteSheet

	constructor: () ->
		@_behaviours = []
		super()
	
	#
	#
	keepLooping: ->
		@_behaviours.push Game.EnemyPlane.Behaviour.looper
		return this
		
	#
	#
	randomPosition: ->
		@randomPositionX()
		@randomPositionY()
		return this
		
	#
	#
	randomPositionX: ->
		@_behaviours.push Game.EnemyPlane.Behaviour.spawn.random.x
		return this
		
	#
	#
	randomPositionY: ->
		@_behaviours.push Game.EnemyPlane.Behaviour.spawn.random.y
		return this
		
	#
	#
	#
	keepRespawning: ->
		@_behaviours.push Game.EnemyPlane.Behaviour.spawn.ondeath
		return this
		
	#
	#
	#
	position: ( x, y ) ->
		@positionX x
		@positionY y
		return this
	
	#
	#
	#
	positionX: ( x ) ->
		@_spawnPositionX = x
		return this
		
	#
	#
	#
	positionY: ( y ) ->
		@_spawnPositionY = y
		return this

	#
	#
	#
	getBehaviours: () ->
		@_behaviours