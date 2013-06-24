'use strict'
# The core sprite class
#
class Game.Sprite 

	# Creates a new sprite from a spritesheet
	#
	constructor: ( @spritesheet, x = 0, y = 0 ) ->
			
		@animation = new createjs.BitmapAnimation @spritesheet
		@globalize = _( @animation.localToGlobal ).bind( @animation )

		Object.defineProperties( @, 
			'createjs':
				get: -> return @animation
				
			'x':
				get: -> return @_x ? 0
				set: ( value ) -> 
					@_x = value
					@animation.x = ( value + .5 ) | 0
			
			'y':
				get: -> return @_y ? 0
				set: ( value ) -> 
					@_y = value
					@animation.y = ( value + .5 ) | 0
					
			'sx':
				get: -> return @_sx ? 1
				set: ( value ) -> 
					@_sx = value
					@animation.scaleX = value
			
			'sy':
				get: -> return @_sy ? 1
				set: ( value ) -> 
					@_sy = value
					@animation.scaleY = value
					
			'r':
				get: -> return @_r ? 0
				set: ( value ) -> 
					@_r = value
					@animation.rotation = ( value + .5 ) | 0
					
			'a':
				get: -> return @_a ? 1
				set: ( value ) -> 
					@_a = value
					@animation.alpha = value
				
					
			'width':
				get: -> @animation.getBounds().width
			
			'height':
				get: -> @animation.getBounds().height
							
			'bounds':
				get: ->  @animation.getBounds()
		)
		
		@x = x
		@y = y
		@a = 1
		@r = 0
		@sx = 1
		@sy = 1
		
		@_createCallbackQueue()
		
	# Creates a callback queue for animation end
	#
	_createCallbackQueue: () ->
		@_afterQueue = {}
		@createjs.addEventListener 'animationend', ( event ) =>
			if @_afterQueue[ event.name ]?
				actions = @_afterQueue[ event.name ]
				@_afterQueue[ event.name ] = []
				
				# All the callbacks!
				action.call( @ ) for action in actions
			return event
			
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
		
	# Sets a one time callback after animation ends
	#
	# @param animation [String] the animation
	# @param callback [Function] the callback
	# @return [self] the chainable self
	#
	after: ( animation, callback ) ->
		unless @_afterQueue[ animation ]?
			 @_afterQueue[ animation ] = []
		@_afterQueue[ animation ].push callback
		return this
		
	# On tick update
	#
	update: ( event ) ->
	
	#
	#
	destroy: ( ) ->
		@createjs.removeAllEventListeners 'animationend'
		