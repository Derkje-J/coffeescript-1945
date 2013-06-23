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
		
	# Creates the level
	#
	create: () ->
		@createBackground()
		@createPlayer()
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
		@game.addTo 'level', 'player', @player = Builder.PlanePlayer.create()
		
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
		@clearBackground()
		@clearPlayer()
		@clearHeadsUpDisplay()
		return this
		
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
		
	# Clears the heads up display
	#
	# @return [self] the chainable self
	#
	clearHeadsUpDisplay: () ->
		@game.removeFrom 'hud', 'hud'
		return this
	
	# Restart the level
	#
	# @return [self] the chainable self
	#
	restart: () ->
		@clear()
		@create()
		return this
