'use strict'
#
#
class Builder.BlueEnemyPlane extends Builder.SpriteSheet

	@SpriteSheet = null

	# Creates a new Player Plane
	#
	# @return
	#
	@create: ( ) ->
	
		if BlueEnemyPlane.SpriteSheet?
			return ( new Game.EnemyPlane BlueEnemyPlane.SpriteSheet )
				.addBehaviour( Game.EnemyPlane.Behaviour.looper )
				.addBehaviour( Game.EnemyPlane.Behaviour.spawn.random.x )
				.addBehaviour( Game.EnemyPlane.Behaviour.spawn.random.y )
				.addBehaviour( Game.EnemyPlane.Behaviour.spawn.ondeath )
			
		builder = new Builder.BlueEnemyPlane()
		builder.animationExtra( 'idle', 301, 466, 32, 32, 1, 1, 3, 3, true, 2 )
		builder.animationExtra( 'explode', 70, 169, 32, 32, 1, 1, 6, 6, 'hide', 4 )
		builder.animationExtra( 'hide', 268, 202, 32, 32, 1, 1, 1, 1, false, 1 )
		builder.animationExtra( 'loop', 631, 203, 32, 32, 1, 1, 1, 5, 'upside', 2 )
		builder.animation( 'upside', 202, 367, 32, 32, 1, 1, 2, 2 )
		builder.data.animations[ 'upside' ].frames.push _( builder.data.animations[ 'loop' ].frames ).last()
		
		BlueEnemyPlane.SpriteSheet = builder.createjs
		return ( new Game.EnemyPlane BlueEnemyPlane.SpriteSheet )
			.addBehaviour( Game.EnemyPlane.Behaviour.looper )
			.addBehaviour( Game.EnemyPlane.Behaviour.spawn.random.x )
			.addBehaviour( Game.EnemyPlane.Behaviour.spawn.random.y )
			.addBehaviour( Game.EnemyPlane.Behaviour.spawn.ondeath )