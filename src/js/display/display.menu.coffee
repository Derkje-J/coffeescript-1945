'use strict'
#
#
class Display.Menu extends Game.Container
		
	constructor: ( @gameMenu ) -> 
		super
		
		# Create options
		@_options = []
		@_options.push new createjs.Text( "New Game", "12px Arial", "white" )
		@_options.push new createjs.Text( "Resume Game", "12px Arial", "white" )
		
		@add 'option_new', @_options[0]
		@add 'option_resume', @_options[1]
		
		@_baseX = 280
		@_options[0].x = @_baseX
		@_options[1].x = @_baseX
		
		@_baseY = 225
		@_options[0].y = @_baseY 
		@_options[1].y = @_baseY + 20
		
		# Create selector
		@_selectorSize = 4
		selector = new createjs.Shape()
		selector.graphics.beginStroke "white"
		selector.graphics.moveTo( 0, 0 ).lineTo( @_selectorSize * 2, @_selectorSize ).lineTo( 0, @_selectorSize * 2 ).lineTo( 0, 0 )
		
		@add 'selector', selector
		selector.x = @_baseX - @_selectorSize * 2 - 10
		selector.y = @_options[ @gameMenu.selectedOption ].y + @_selectorSize / 2
		
		
	# Updates the HUD
	#
	# @param event [TickEvent]
	# 
	update: ( event ) ->
		super event
		
		requestedY = @_options[ @gameMenu.selectedOption ].y + @_selectorSize / 2
		if ( requestedY isnt @get( 'selector' ).y )
			@get( 'selector' ).y = requestedY
		
		return this

		
		