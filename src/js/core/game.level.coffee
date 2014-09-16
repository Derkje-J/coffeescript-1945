'use strict'
# This is the base class for a level
#
class Game.Level extends Game.Container
	
	# Creates a level
	#
	# @param [Game.Canvas1945] the game reference
	#
	constructor: ( @game ) ->
		super

		Game.EventManager.on 'plane.create', @, @onPlaneCreated
		Game.EventManager.on 'plane.destroy', @, @onPlaneDestroyed
		Game.EventManager.on 'bullet.create', @, @onBulletCreated
		Game.EventManager.on 'bullet.destroy', @, @onBulletDestroyed
		Game.EventManager.on 'shard.create', @, @onShardCreated
		Game.EventManager.on 'shard.destroy', @, @onShardDestroyed
		Game.EventManager.on 'points.get', @, @onPointsGained
		
		
	# On plane created
	#
	# @param source [Game.Plane] the plane
	#
	onPlaneCreated: ( source ) ->		
		@addTo 'level', _.uniqueId( 'plane' ), source
		@level.planeCreated( source )
		
	# On plane destroyed
	#
	# @param source [Game.Plane] the plane
	#
	onPlaneDestroyed: ( source ) ->
	
		if source instanceof Game.EnemyPlane
			@level.planeDestroyed source
			@removeFrom 'level', @get( 'level' ).findKey source
		else if source instanceof Game.Player
			@game.die()
			
	# On points gained
	#
	# @param source [any] the source of the points
	# @param score [Integer] the number of points
	#
	onPointsGained: ( source, score ) ->
		@game.data.score += score
			
	# On bullet created
	#
	# @param source [any] the source of the bullet
	# @param buller [Game.Bullet] the bullet
	#
	onBulletCreated: ( source, bullet ) ->
		@addTo 'below', _.uniqueId( 'bullet' ), bullet
		
	# On bullet destroyed
	#
	# @param source [Game.Bullet] the bullet
	#
	onBulletDestroyed: ( source ) ->
		@removeFrom 'below', @get( 'below' ).findKey source
	
	# On shard created
	#
	# @param source [Game.Shard] the shard
	#
	onShardCreated: ( source ) ->
		@addTo 'below', _.uniqueId( 'shard' ), source
	
	# On shard destroyed
	#
	# @param source [Game.Shard] the shard
	#
	onShardDestroyed: ( source ) ->
		@removeFrom 'below',  @get( 'below' ).findKey source
		
	# Creates the level
	#
	# @param level [] the level id
	#
	create: ( level ) ->
		
		@createBackground()
		@createLayers()
		@createHeadsUpDisplay()
		
		@_load level
		
		#@pause()
		# @TODO show mission
		
		return this
		
	#
	#
	#
	_load: ( level ) ->

		switch level
			when 0
				@_injectLevelData new Levels.Level0()
			else
				@_injectLevelData new Levels.Endless()
				
	#
	#
	#
	_injectLevelData: ( level ) ->
		@level = level
		@level.injectInto @
		
	# Creates the background
	#
	# @return [self] the chainable self
	#
	createBackground: () ->
		@game.addTo 'background', 'islandA', Builder.BackgroundIsland.create 'A'
		@game.addTo 'background', 'islandB', Builder.BackgroundIsland.create 'B'
		@game.addTo 'background', 'islandC', Builder.BackgroundIsland.create 'C'
		return this
		
	#
	#
	createLayers: () ->
		@add 'below', new Game.Container()
		@add 'level', new Game.Container()
		@add 'above', new Game.Container()
		
		@addTo 'level', 'player', @player = Builder.PlayerPlane.create()
					
	#
	#
	#
	pause: () ->
		@level.pause()
		Game.EventManager.trigger 'level.paused', @, [ on ]
	
	#
	#
	#
	resume: () ->
		@level.resume()
		Game.EventManager.trigger 'level.paused', @, [ off ]
		
	# Creates the headsup display
	#
	# @return [self] the chainable self
	#
	createHeadsUpDisplay: () ->
		@game.addTo 'hud', 'bottom', @hud = new Display.HeadsUpDisplay @game, @
		
	# Clears the level
	#
	# @return [self] the chainable self
	#
	clear: ( ) ->
		@game.get( 'collisions' ).clear()
		
		@clearBackground()
		@clearLayers()
		@clearHeadsUpDisplay()
		return this
	
	#
	#
	kill: () ->
		@clear()
		
		Game.EventManager.off 'plane.destroy', @, @onPlaneDestroyed
		Game.EventManager.off 'bullet.create', @, @onBulletCreated
		Game.EventManager.off 'bullet.destroy', @, @onBulletDestroyed
		
	# Clears the background
	#
	# @return [self] the chainable self
	#
	clearBackground: () ->
		@game.removeFrom 'background', 'islandA'
		@game.removeFrom 'background', 'islandB'
		@game.removeFrom 'background', 'islandC'
		return this
		
	#
	#
	#
	clearLayers: () ->
		@removeFrom 'level', 'player'
		
		for key, object of @get( 'level' ).objects
			@removeFrom 'level', key
			
		#@level.clear()
			
		@remove 'above'
		@remove 'level'
		@remove 'below'
		
	# Clears the heads up display
	#
	# @return [self] the chainable self
	#
	clearHeadsUpDisplay: () ->
		@game.removeFrom 'hud', 'bottom'
		return this
	
	# Restart the level
	#
	# @return [self] the chainable self
	#
	restart: () ->
		@clear()
		@create()
		return this
		
	#
	#
	#
	update: ( event ) ->
		return this if event.paused or @level is undefined or @level.isPaused is on
		super
		@level.update event
		return this
		
	#
	#
	#
	#input : -> esc -> pause etc
	
