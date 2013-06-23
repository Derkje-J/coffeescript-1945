'use strict'
#
#
class Builder.PlayerPlane extends Builder.SpriteSheet

	@SpriteSheet = null

	# Creates a new Player Plane
	#
	# @return
	#
	@create: ( ) ->
	
		if PlayerPlane.SpriteSheet?
			return new Game.Player PlayerPlane.SpriteSheet
			
		builder = new Builder.PlayerPlane()
		builder.animation( 'idle', 4, 400, 65, 65, 1, 1, 3, 3 )
		builder.animationExtra( 'explode', 4, 301, 65, 65, 1, 1, 7, 7, false, 3 )
		
		PlayerPlane.SpriteSheet = builder.createjs
		return new Game.Player PlayerPlane.SpriteSheet