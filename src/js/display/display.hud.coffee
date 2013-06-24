'use strict'
#
#
class Display.HeadsUpDisplay extends Game.Container

	#
	#
	@HealthBar =
		x: 12
		y: 45
		height: 10
		width: 126
		
	#
	#
	@LivesBar =
		x: 6
		y: 6
		image: Builder.PlaneMini.create
		animation: 'mini'

	# Creates a new Heads Up Display
	#
	# @param game [Game.Canvas1945] the game
	#
	constructor: ( @game, @level ) ->
		super
		@add 'background', Game.AssetManager.get 'bottom'
		@add 'healthbar', @createHealthBar()
		@add 'lives', @createLivesBar()
		@add 'score', @createScore()
		
		@y = Game.Canvas1945.Height - 76
		
		@_health = 0
		@_lives = @game.data.lives
		@_score = @game.data.score
		
		@drawHealthBar()
		@drawLivesBar()
		@drawScore()
		
	# Creates the health bar
	#
	createHealthBar: -> 
		@healthBar = new createjs.Shape()
		@healthBar.x = HeadsUpDisplay.HealthBar.x
		@healthBar.y = HeadsUpDisplay.HealthBar.y
		return @healthBar
		
	# Creates the lives bar
	#
	createLivesBar: ->
		@livesBar = new Game.Container()
		@livesBar.x = HeadsUpDisplay.LivesBar.x
		@livesBar.y = HeadsUpDisplay.LivesBar.y
		return @livesBar
		
	#
	#
	createScore: ->
		@scoreText = new createjs.Text( "0", "18px Arial", "white" )
		@scoreText.shadow = new createjs.Shadow( "rgba( 0, 0, 0, .9 )", 2, 2, 2 )
		@scoreText.x = 232
		@scoreText.y = 8
		return @scoreText
		
	# Gets the health bar colours
	#
	# @param health [Integer] health between 0 and max
	# @param max [Integer] max health
	# @returns [Array<String>] CSS colours that represent the health
	#
	getHealthColors: ( health = @_health, max = 100 ) ->
	
		# Green, DarkGreen ( health = 100 )
		orig = 
			[
				r: 0
				g: 128
				b: 0
			,
				r: 0
				g: 100
				b: 0
			]
				
		# Red, DarkRed ( health = 0 )
		dest = 
			[
				r: 255
				g: 0
				b: 0
			,
				r: 139
				g: 0
				b: 0
			]
		
		# Interpolation
		factor = health / max
		
		return _( orig ).reduce( ( results, colour, index ) -> 
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
		
	# Draws the health bar
	#
	# @param max [Integer] the maximum health on the livebar
	# @return [self] the chainable self
	#
	drawHealthBar: ( max = 100 ) ->
		@healthBar.graphics.clear()
		@healthBar.graphics.beginLinearGradientFill( 
			@getHealthColors(), 
			[ 0.8, 0.85 ], 
			(HeadsUpDisplay.HealthBar.width / 2 + 0.5 ) | 0 
			0,
			(HeadsUpDisplay.HealthBar.width / 2 + 0.5 ) | 0 
			HeadsUpDisplay.HealthBar.height
		).drawRect(
			0,
			0,
			HeadsUpDisplay.HealthBar.width / max * @_health, 
			HeadsUpDisplay.HealthBar.height
		)
		return this
		
	# Draws the lives bar
	#
	# @param max [Integer] the maximum number of lives on the livebar
	# @return [self] the chainable self
	#
	drawLivesBar: ( max = 5 ) ->
	
		while @livesBar.length > @_lives
			@livesBar.remove "life-#{ @livesBar.length }"
			
		while max > @livesBar.length < @_lives
			
			if @livesBar.length < max - 1
				@image = HeadsUpDisplay.LivesBar.image().stop( HeadsUpDisplay.LivesBar.animation )
				@image.y = 16
				@image.x = @livesBar.length * 28 + 16
				@image.createjs.shadow = new createjs.Shadow( "rgba( 0, 0, 0, .7 )", 2, 2, 0 )
			else
				@image = new createjs.Text( "+", "20px Arial", "white" )
				@image.shadow = new createjs.Shadow( "rgba( 0, 0, 0, .9 )", 2, 2, 2 )
				@image.x = @livesBar.length * 28 + 4
				@image.y = 4
				
			@livesBar.add "life-#{ @livesBar.length + 1 }", @image
		
		return this
		
	#
	#
	drawScore: ( ) ->
		@scoreText.text = ( @_score + .5 ) | 0
		return this
		
	# Updates the HUD
	#
	# @param event [TickEvent]
	# 
	update: ( event ) ->
		super event
		
		dt = event.delta / 1000
		
		if @level.player.health isnt @_health
			@_health = @_health + ( @level.player.health - @_health ) * Math.min( 1, dt * 4 ) 
			if Math.abs( @level.player.health - @_health ) < 0.001
				 @_health = @level.player.health
			@drawHealthBar()
		
		if @game.data.score isnt @_score
			
			@_score = @_score + ( @game.data.score - @_score ) * Math.min( 1, dt * 4 ) 
			if Math.abs( @game.data.score - @_score ) < 0.001
				 @_score = @game.data.score
			@drawScore()
		
		if @game.data.lives isnt @_lives
			@_lives = @game.data.lives
			@drawLivesBar()
		
		return self
		
		