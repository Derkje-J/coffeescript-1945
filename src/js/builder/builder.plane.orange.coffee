'use strict'
#
#
class Builder.OrangeEnemyPlane extends Builder.SpriteSheet

	@SpriteSheet = null

	# Creates a new Player Plane
	#
	# @return
	#
	@create: ( ) ->
	
		if OrangeEnemyPlane.SpriteSheet?
			return ( new Game.EnemyPlane OrangeEnemyPlane.SpriteSheet )
				.addBehaviour( Game.EnemyPlane.Behaviour.looper )
				.addBehaviour( Game.EnemyPlane.Behaviour.spawn.random.x )
				.addBehaviour( Game.EnemyPlane.Behaviour.spawn.random.y )
				.addBehaviour( Game.EnemyPlane.Behaviour.spawn.ondeath )
			
		builder = new Builder.OrangeEnemyPlane()
		builder.animationExtra( 'idle', 103, 499, 32, 32, 1, 1, 3, 3, true, 1 )
		builder.animationExtra( 'explode', 70, 169, 32, 32, 1, 1, 6, 6, 'hide', 2 )
		builder.animationExtra( 'hide', 268, 202, 32, 32, 1, 1, 1, 1, false, 1 )
		
		OrangeEnemyPlane.SpriteSheet = builder.createjs
		return ( new Game.EnemyPlane OrangeEnemyPlane.SpriteSheet )
			.addBehaviour( Game.EnemyPlane.Behaviour.looper )
			.addBehaviour( Game.EnemyPlane.Behaviour.spawn.random.x )
			.addBehaviour( Game.EnemyPlane.Behaviour.spawn.random.y )
			.addBehaviour( Game.EnemyPlane.Behaviour.spawn.ondeath )