'use strict'
#
#
class Display.Progress extends Game.Container
		
	constructor: -> 
		super
		@bar = new createjs.Shape()
				
		Object.defineProperty( @, 'total',
			get: -> return @_total
			set: ( value ) -> @_total = value
		)
		
		Object.defineProperty( @, 'current',
			get: -> return @_current
			set: ( value ) -> @_current = value
		)
		
		Object.defineProperty( @, 'width',
			get: -> return @_width
			set: ( value ) -> @_width = value
		)
		
		Object.defineProperty( @, 'height',
			get: -> return @_height
			set: ( value ) -> @_height = value
		)
		
		@add 'bar', @bar
		
		@_current = 0
		@_total = 1
		@_displayedCurrent = @current
		
		@width = 200
		@height = 5
		
	# Gets the bar colours
	#
	# @param current [Integer] current between 0 and max
	# @param max [Integer] max
	# @returns [Array<String>] CSS colours that represent the current value
	#
	getColors: ( current = @_displayedCurrent, max = @total ) ->
	
		# Green, DarkGreen ( current = 100 )
		orig = 
			[
				r: 255
				g: 255
				b: 255
			,
				r: 200
				g: 200
				b: 200
			]
				
		# Red, DarkRed ( current = 0 )
		dest = 
			[
				r: 50
				g: 50
				b: 50
			,
				r: 0
				g: 0
				b: 0
			]
		
		# Interpolation
		factor = current / max
		
		return _.reduce( orig, ( results, colour, index ) -> 
			result = {}
			
			# Interpolate each component of each colour
			for component, value of colour
				result[ component ] = value * factor + dest[ index ][ component ] * ( 1 - factor )
			
			# Return the new colour
			results.push result
			return results
			
		, [] ).map( ( colour ) -> 
		
			# Build CSS RGB colour
			return "rgb( #{ ( colour.r + 0.5 ) | 0 }, #{ ( colour.g + 0.5 ) | 0 }, #{ ( colour.b + 0.5 ) | 0 } )" 
		)

	#
	#
	#
	draw: () ->
		@bar.graphics.clear()
		@bar.graphics.beginLinearGradientFill( 
			@getColors(), 
			[ 0.8, 0.85 ], 
			(@width/ 2 + 0.5 ) | 0 
			0,
			(@width / 2 + 0.5 ) | 0 
			@height
		).drawRect(
			0,
			0,
			@width / @total * @_displayedCurrent, 
			@height
		)
		
	# Updates the HUD
	#
	# @param event [TickEvent]
	# 
	update: ( event ) ->
		super event
		
		dt = event.delta / 1000
		
		if @current isnt @_displayedCurrent
			@_displayedCurrent = @_displayedCurrent + ( @current - @_displayedCurrent ) * Math.min( 1, dt * 2) 
			if Math.abs( @current - @_displayedCurrent ) < 0.001
				 @_displayedCurrent = @current
			@draw()
				
		return this
		
		