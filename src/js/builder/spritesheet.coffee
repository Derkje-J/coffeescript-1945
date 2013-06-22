class Builder.SpriteSheet
	
	#
	#
	constructor: ->
		@builder = new createjs.SpriteSheetBuilder()
		
		Object.defineProperty( @, 'createjs',
			get: -> return @builder
		)
	
	# Creates a sequence of frames
	#
	# @param x [Integer] the starting x
	# @param y [Integer] the starting y
	# @param w [Integer] the frame width
	# @param h [Integer] the frame height
	# @param gx [Integer] the horizontal gap between frames
	# @param gy [Integer] the vertical gap between frames
	# @param xlen [Integer] the horizontal length
	# @param len [Integer] the total number of frames
	# @retrun [Array<Integer>] array of ids
	#
	sequence: ( x, y, w, h, gx, gy, xlen, len ) ->
	
		len = xlen unless len?
		sequence = []
		
		for i in [0...len]
			i_x = x + ( ( w + gx ) * ( i % xlen ) )
			i_y = y + ( ( y + gy ) * Math.floor( i / xlen ) )
			sequence.push @builder.addFrame Game.Sprite.BaseSheet, new createjs.Rectangle( i_x, i_y, w, h )
			
		return sequence
		
	# Add animation
	#
	# @param animation [String] the animation name
	# @param s...
	# @return [self]
	#
	animation: ( animation, s... ) ->
	
		@builder.addAnimation( animation, 
			@sequence.apply( @, s )
		)
		
		return this
		
	# Add animation extra
	# @param animation [String] the animation name
	# @param s...
	# @param next [String]
	# @param frequency [Integer]
	# @return [self]
	#
	animationExtra: ( animation, s..., next, frequency ) ->
	
		@builder.addAnimation( animation, 
			@sequence.apply( @, s ),
			next,
			frequency
		)
		
		return this
		
		