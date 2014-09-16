'use strict'
#
#
class Builder.WhiteEnemyPlane extends Builder.EnemyPlane

	@SpriteSheet = null

	# Creates a new Player Plane
	#
	# @return
	#
	create: ( ) ->
	
		if WhiteEnemyPlane.SpriteSheet?
			return super ( new Game.EnemyPlane WhiteEnemyPlane.SpriteSheet, undefined, undefined, undefined, 250 )
				.addBehaviours( @getBehaviours() )
				.addBehaviour( Game.EnemyPlane.Behaviour.fire.point )
			
		builder = new Builder.WhiteEnemyPlane()
		builder.animationExtra( 'idle', 103, 466, 32, 32, 1, 1, 3, 3, true, 2 )
		builder.animationExtra( 'explode', 70, 169, 32, 32, 1, 1, 6, 6, 'hide', 4 )
		builder.animationExtra( 'hide', 268, 202, 32, 32, 1, 1, 1, 1, false, 1 )
		builder.animationExtra( 'loop', 565, 203, 32, 32, 1, 1, 1, 5, 'upside', 2 )
		builder.animation( 'upside', 70, 367, 32, 32, 1, 1, 2, 2 )
		builder.data.animations[ 'upside' ].frames.push _.last  builder.data.animations[ 'loop' ].frames
		
		WhiteEnemyPlane.SpriteSheet = builder.createjs
		return super ( new Game.EnemyPlane WhiteEnemyPlane.SpriteSheet, undefined, undefined, undefined, 250 )
			.addBehaviours( @getBehaviours() )
			.addBehaviour( Game.EnemyPlane.Behaviour.fire.point )