'use strict'
#
#
class Game.Data
		
		#
		#
		#
		constructor: ->
			
			@load()
			
			Object.defineProperty( @, 'canResume',
				get: -> @_saved
			)
			
		# Saves the game data
		#
		save: ->
			@_saved = true
			return @_save()
			
		#
		#
		#
		_save: ->
			locache.set(	"game.data", JSON.stringify( @ ) )
			return this
		
		# Loads the game data
		#
		load: ->
			for key, value of JSON.parse( locache.get( "game.data" ) || JSON.stringify( @truncate() ) )
				@[ key ] = value
			return this
			
		#
		#
		#
		truncate: ->
			@lives = 3
			@score = 0
			@level = 0
			@_saved = false
			return @_save()
			