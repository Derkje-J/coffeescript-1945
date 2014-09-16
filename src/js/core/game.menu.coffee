'use strict'
# This is the base class for a level
#
class Game.Menu extends Game.Container
	
	# Creates a level
	#
	# @param [Game.Canvas1945] the game reference
	#
	constructor: ( @game ) ->
		super
		
		@add 'bar', @bar = new Display.Progress()
		@bar.x = ( Game.Canvas1945.Width - @bar.width ) / 2
		@bar.y = ( Game.Canvas1945.Height - @bar.height ) / 2
		
	#
	#
	#
	onProgress: ( event ) =>
		@bar.total = event.total
		@bar.current = event.progress
		
