'use strict'
# The core sprite class
#
class Game.Sprite 

	# The base bitmap for all the sprites
	#
	@BaseSheet = new createjs.Bitmap "img/1945.png"
	
	# Creates a new sprite from a spritesheet
	#
	constructor: ( @spritesheet, x = 0, y = 0 ) ->
			
		@animation = new createjs.BitmapAnimation @spritesheet
		
		Object.defineProperties( @, 
			'createjs':
				get: -> return @animation
				
			'x':
				get: -> return @_x ? 0
				set: ( value ) -> 
					@_x = value
					@animation.x = ( value + .5 )| 0
			
			'y':
				get: -> return @_y ? 0
				set: ( value ) -> 
					@_y = value
					@animation.y = ( value + .5 ) | 0
		)
		
		@x = x
		@y = y
	
	# Plays an animation
	#
	# @param animation [String] the animation string
	# @return [self] the chainable self
	#
	play: ( animation ) ->
		@createjs.gotoAndPlay animation
		return this
		
	# Sets an animation, but doesn't play
	#
	# @param animation [String] the animation string
	# @return [self] the chainable self
	#
	stop: ( animation ) ->
		@createjs.gotoAndStop animation
		return this
	
	# On tick update
	#
	update: ( event ) ->
		