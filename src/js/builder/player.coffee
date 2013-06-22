class Builder.Player extends Builder.SpriteSheet

	#
	#
	@create: ( callback ) ->
		
		builder = new Builder.Player()
		builder.animation( 'idle', 4, 400, 65, 65, 1, 1, 3, 3 )
		builder.animation( 'explode', 4, 301, 65, 65, 1, 1, 7, 7 )
		
		builder.createjs.addEventListener( 'complete', callback )
		builder.createjs.buildAsync()