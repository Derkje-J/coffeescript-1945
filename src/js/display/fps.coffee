'use strict'
#
#
class Display.FPS

	#
	#
	constructor: ->
	
		@text = new createjs.Text( "?? FPS", "8px Arial", "white" )
		@text.textAlign = 'right'
		@text.x = Game.Canvas1945.Width - 5
		@text.y = 5
		
		Object.defineProperty( @, 'createjs',
			get: -> return @text
		)

		@_frameCount = 0
		@_frameRate = 0
		@_time = 0
	
	#
	#
	update: ( event ) =>
	
		if ( ( @_time += event.delta ) >= 1000 )
			@_frameRate = @_frameCount
			@_frameCount = 0;
			@_time -= 1000;
			@text.text = "#{ @_frameRate } FPS"
		
		@_frameCount++