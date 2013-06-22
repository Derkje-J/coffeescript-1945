class Game.Sprite

	# The base bitmap for all the sprites
	#
	@BaseSheet = new createjs.Bitmap "img/1945.png"
	
	# Creates a new sprite from a spritesheet
	#
	constructor: ( @spritesheet ) ->
		
		@animation = new createjs.BitmapAnimation @spritesheet
		
		Object.defineProperties( @, 
			'createjs':
				get: -> return @animation
				
			'x':
				get: -> return @_x ? 0
				set: ( value ) -> 
					@_x = value
					@animation.x = Math.round value
			
			'y':
				get: -> return @_y ? 0
				set: ( value ) -> 
					@_y = value
					@animation.y = Math.round value
		)
	
	#
	#
	update: ( event ) ->
		