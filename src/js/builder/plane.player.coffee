'use strict'
#
#
class Builder.PlanePlayer extends Builder.SpriteSheet

	@SpriteSheet = null

	# Creates a new Player Plane
	#
	# @return
	#
	@create: ( ) ->
	
		if PlanePlayer.SpriteSheet?
			return new Game.Player PlanePlayer.SpriteSheet
			
		builder = new Builder.PlanePlayer()
		builder.animation( 'idle', 4, 400, 65, 65, 1, 1, 3, 3 )
		builder.animation( 'explode', 4, 301, 65, 65, 1, 1, 7, 7 )
		
		PlanePlayer.SpriteSheet = builder.createjs
		return new Game.Player PlanePlayer.SpriteSheet