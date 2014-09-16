'use strict'
# This is the base class for a level
#
class Game.Menu extends Game.Container
	
	# Creates a level
	#
	# @param [Game.Canvas1945] game reference
	#
	constructor: ( @game ) ->
		super
		
		@add 'bar', @bar = new Display.Progress()
		@bar.x = ( Game.Canvas1945.Width - @bar.width ) / 2
		@bar.y = ( Game.Canvas1945.Height - @bar.height ) / 2
		
		@_optionsCount = 2
		@_selectedOption = if @game.data.canResume then 1 else 0	
		
		Object.defineProperty( @, 'selectedOption',
			get: -> @_selectedOption
		)
		
	# On Loading progress
	#
	# @param [LoadingEvent] event the event
	#
	onProgress: ( event ) =>
		@bar.total = event.total
		@bar.current = event.progress
		
	# Ready loading all the assets, so continue with menu display
	#
	#
	ready: () =>
		@remove 'bar'
		@add 'menu', @menu = new Display.Menu @ 
	
	
	#
	#
	#
	_pickOptions: () ->
		switch @_selectedOption
			when 0
				@optionNew()
			when 1
				@optionResume()
	
	#
	#
	#
	optionNew: () ->
		@game.data.truncate()
		@_createLevel()
		
	#
	#
	#
	optionResume: () ->
		@_createLevel()
		
	#
	#
	#
	_createLevel: () ->
		@game.createLevel @game.data.level 
		
	#
	#
	#
	input: ( event, state ) ->
		return unless state
	
		if ( event.keyCode is 38 )
			@_selectedOption = if @_selectedOption > 0 then @_selectedOption - 1 else @_optionsCount - 1
			return true
		else if ( event.keyCode is 40 )
			@_selectedOption = ( @_selectedOption + 1 ) % @_optionsCount
			return true
		else if ( event.keyCode is 13 )
			@_pickOptions()
			return true
			
		return false
