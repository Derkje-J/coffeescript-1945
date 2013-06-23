'use strict'
#
#
class Builder.PlaneMini extends Builder.SpriteSheet

	@SpriteSheet = null

	# Creates a new Player Plane
	#
	# @return
	#
	@create: ( ) ->
	
		if PlaneMini.SpriteSheet?
			return new Game.Sprite PlaneMini.SpriteSheet
			
		builder = new Builder.PlaneMini()
		builder.animation( '+5dir', 4, 268, 32, 32, 1, 1, 1, 1 )
		builder.animation( '+3dir', 37, 268, 32, 32, 1, 1, 1, 1 )
		builder.animation( '+2dir', 70, 268, 32, 32, 1, 1, 1, 1 )
		builder.animation( 'stones', 103, 268, 32, 32, 1, 1, 1, 1 )
		builder.animation( 'shield', 136, 268, 32, 32, 1, 1, 1, 1 )
		builder.animation( 'blue', 169, 268, 32, 32, 1, 1, 1, 1 )
		builder.animation( 'mini', 202, 268, 32, 32, 1, 1, 1, 1 )
		builder.animation( 'pow', 235, 235, 32, 32, 1, 1, 1, 2 )
		builder.animation( 'up', 202, 235, 32, 32, 1, 1, 1, 1 )
		
		PlaneMini.SpriteSheet = builder.createjs
		return new Game.Sprite PlaneMini.SpriteSheet