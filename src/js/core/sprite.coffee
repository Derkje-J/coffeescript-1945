class Game.Sprite

	@BaseSheet = new createjs.Bitmap "img/1945.png"
	
	#
	#
	constructor: ( data ) ->
		
		@spritesheet = new createjs.SpriteSheet data
		@animation = new createjs.BitmapAnimation @spritesheet
		
		Object.defineProperty( @, 'createjs',
			get: -> return @animation
		)