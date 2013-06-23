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

		#Game.EventManager.on 'plane.create', @, @onPlaneCreated
		Game.EventManager.on 'plane.destroy', @, @onPlaneDestroyed
		Game.EventManager.on 'bullet.create', @, @onBulletCreated
		Game.EventManager.on 'bullet.destroy', @, @onBulletDestroyed
		
	#
	#
	#onPlaneCreated: ( source ) ->		
		#@addTo 'level', _( 'plane' ).uniqueId(), source	
		
	#
	#
	onPlaneDestroyed: ( source ) ->
		if source instanceof Game.EnemyPlane
			@removeFrom 'level', @get( 'level' ).findKey source
		else if source instanceof Game.Player
			@game.die()
			
	#
	#
	onBulletCreated: ( source, bullet ) ->
		@addTo 'below', _( 'bullet' ).uniqueId(), bullet
		
	#
	#
	onBulletDestroyed: ( source ) ->
		@removeFrom 'below', @get( 'below' ).findKey source
		
	# Creates the level
	#
	create: () ->
	
		@createBackground()
		@createLayers()
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
		
	#
	#
	createLayers: () ->
		@add 'below', new Game.Container()
		@add 'level', new Game.Container()
		@add 'above', new Game.Container()
		
		@addTo 'level', 'player', @player = Builder.PlayerPlane.create()
		
		for i in [0...15]
			@addTo 'level', 'enemy-' + i, enemy = Builder.GreenEnemyPlane.create()
		
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
		
		for i in [0...15]
			@removeFrom 'level', 'enemy-' + i
			
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
