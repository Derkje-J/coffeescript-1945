'use strict'
#
#
class Builder.OrangeEnemyPlane extends Builder.EnemyPlane

	@SpriteSheet = null

	# Creates a new Player Plane
	#
	# @return
	#
	create: ( ) ->
	
		if OrangeEnemyPlane.SpriteSheet?
			return super ( new Game.EnemyPlane OrangeEnemyPlane.SpriteSheet )
				.addBehaviours( @getBehaviours() )
			
		builder = new Builder.OrangeEnemyPlane()
		builder.animationExtra( 'idle', 4, 499, 32, 32, 1, 1, 3, 3, true, 2 )
		builder.animationExtra( 'explode', 70, 169, 32, 32, 1, 1, 6, 6, 'hide', 4 )
		builder.animationExtra( 'hide', 268, 202, 32, 32, 1, 1, 1, 1, false, 1 )
		
		OrangeEnemyPlane.SpriteSheet = builder.createjs
		return super ( new Game.EnemyPlane OrangeEnemyPlane.SpriteSheet )
			.addBehaviours( @getBehaviours() )