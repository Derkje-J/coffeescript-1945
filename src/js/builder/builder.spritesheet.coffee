'use strict'
#
#
class Builder.SpriteSheet
	
	# Creates a new spritesheet builder
	#
	constructor: ( image = Game.AssetManager.get( 'basesheet' ).image ) ->
		
		@data =
			images: [ image ]
			frames: []
			animations: {}
			
		Object.defineProperty( @, 'createjs',
			get: -> return new createjs.SpriteSheet @data
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
			i_y = y + ( ( h + gy ) * ( ( i / xlen ) | 0 ) )

			sequence.push @data.frames.length
			@data.frames.push [ i_x, i_y, w, h, 0, ( w / 2 + .5 ) | 0, ( h / 2 + .5 ) | 0 ]
			
		return sequence
		
	# Add animation
	#
	# @param animation [String] the animation name
	# @param s...
	# @return [self]
	#
	animation: ( animation, s... ) ->
	
		@data.animations[ animation ] = 
			frames: @sequence.apply( @, s )
			next: true
			frequency: 2
		
		return this
		
	# Add animation extra
	# @param animation [String] the animation name
	# @param s...
	# @param next [String]
	# @param frequency [Integer]
	# @return [self]
	#
	animationExtra: ( animation, s..., next, frequency ) ->
	
		@data.animations[ animation ] = 
			frames: @sequence.apply( @, s )
			next: next
			frequency: frequency
		
		return this
