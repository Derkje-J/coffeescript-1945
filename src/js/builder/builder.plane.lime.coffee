'use strict'
#
#
class Builder.LimeEnemyPlane extends Builder.EnemyPlane

	@SpriteSheet = null

	# Creates a new Player Plane
	#
	# @return
	#
	create: ( ) ->
	
		if LimeEnemyPlane.SpriteSheet?
			return super ( new Game.EnemyPlane LimeEnemyPlane.SpriteSheet )
				.addBehaviours( @getBehaviours() )
			
		builder = new Builder.LimeEnemyPlane()
		builder.animationExtra( 'idle', 202, 466, 32, 32, 1, 1, 3, 3, true, 2 )
		builder.animationExtra( 'explode', 70, 169, 32, 32, 1, 1, 6, 6, 'hide', 4 )
		builder.animationExtra( 'hide', 268, 202, 32, 32, 1, 1, 1, 1, false, 1 )
		builder.animationExtra( 'loop', 664, 203, 32, 32, 1, 1, 1, 5, 'upside', 2 )
		builder.animation( 'upside', 4, 367, 32, 32, 1, 1, 2, 2 )
		builder.data.animations[ 'upside' ].frames.push _.last builder.data.animations[ 'loop' ].frames 
		
		LimeEnemyPlane.SpriteSheet = builder.createjs
		return super ( new Game.EnemyPlane LimeEnemyPlane.SpriteSheet )
			.addBehaviours( @getBehaviours() )