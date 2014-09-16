'use strict'
#
#
class Builder.GreenEnemyPlane extends Builder.SpriteSheet

	@SpriteSheet = null

	# Creates a new Player Plane
	#
	# @return
	#
	@create: ( ) ->
	
		if GreenEnemyPlane.SpriteSheet?
			return ( new Game.EnemyPlane GreenEnemyPlane.SpriteSheet )
				.addBehaviour( Game.EnemyPlane.Behaviour.looper )
				.addBehaviour( Game.EnemyPlane.Behaviour.spawn.random.x )
				.addBehaviour( Game.EnemyPlane.Behaviour.spawn.random.y )
				.addBehaviour( Game.EnemyPlane.Behaviour.spawn.ondeath )
			
		builder = new Builder.GreenEnemyPlane()
		builder.animationExtra( 'idle', 4, 466, 32, 32, 1, 1, 3, 3, true, 2 )
		builder.animationExtra( 'explode', 70, 169, 32, 32, 1, 1, 6, 6, 'hide', 4 )
		builder.animationExtra( 'hide', 268, 202, 32, 32, 1, 1, 1, 1, false, 1 )
		builder.animationExtra( 'loop', 598, 203, 32, 32, 1, 1, 1, 5, 'upside', 2 )
		builder.animation( 'upside', 136, 367, 32, 32, 1, 1, 2, 2 )
		builder.data.animations[ 'upside' ].frames.push _.last builder.data.animations[ 'loop' ].frames
		
		GreenEnemyPlane.SpriteSheet = builder.createjs
		return ( new Game.EnemyPlane GreenEnemyPlane.SpriteSheet )
			.addBehaviour( Game.EnemyPlane.Behaviour.looper )
			.addBehaviour( Game.EnemyPlane.Behaviour.spawn.random.x )
			.addBehaviour( Game.EnemyPlane.Behaviour.spawn.random.y )
			.addBehaviour( Game.EnemyPlane.Behaviour.spawn.ondeath )