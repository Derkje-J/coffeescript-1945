'use strict'
# This is the base class for a level
#
class Game.Level
	
	# Creates a level
	#
	# @param [Game.Canvas1945] the game reference
	#
	constructor: ( @game ) ->
	
		@create()
		
		#Game.EventManager.on 'plane.create', @, @onPlaneCreated
		Game.EventManager.on 'plane.destroy', @, @onPlaneDestroyed
		Game.EventManager.on 'bullet.create', @, @onBulletCreated
		Game.EventManager.on 'bullet.destroy', @, @onBulletDestroyed
		
	#
	#
	#onPlaneCreated: ( source ) ->		
		#@game.addTo 'level', _( 'plane' ).uniqueId(), source	
		
	#
	#
	onPlaneDestroyed: ( source ) ->
		if source instanceof Game.EnemyPlane
			@game.removeFrom 'level', @game.get( 'level' ).findKey source
		else if source instanceof Game.Player
			@game.die()
			
	#
	#
	onBulletCreated: ( source, bullet ) ->
		@game.addTo 'below-level', _( 'bullet' ).uniqueId(), bullet
		
	#
	#
	onBulletDestroyed: ( source ) ->
		@game.removeFrom 'below-level', @game.get( 'below-level' ).findKey source
		
	# Creates the level
	#
	create: () ->
	
		@createBackground()
		@createPlayer()
		@createEnemies()
		@createHeadsUpDisplay()
		
		return this
		
	# Creates the background
	#
	# @return [self] the chainable self
	#
	createBackground: () ->
		@game.addTo 'background', 'islandA', Builder.BackgroundIsland.create 'A'
		@game.addTo 'background', 'islandB', Builder.BackgroundIsland.create 'B'
		@game.addTo 'background', 'islandC', Builder.BackgroundIsland.create 'C'
		return this
		
	# Creates the player
	#
	# @return [self] the chainable self
	#
	createPlayer: () ->
		@game.addTo 'level', 'player', @player = Builder.PlayerPlane.create()
		
	#
	#
	createEnemies: () ->
		for i in [0...15]
			@game.addTo 'level', 'enemy-' + i, enemy = Builder.GreenEnemyPlane.create()

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
		@clearPlayer()
		@clearEnemies()
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
		
	# Clears the player
	#
	# @return [self] the chainable self
	#
	clearPlayer: () ->
		@game.removeFrom 'level', 'player'
		return this
		
	#
	#
	clearEnemies: () ->
		for i in [0...15]
			@game.removeFrom 'level', 'enemy-' + i
		
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
