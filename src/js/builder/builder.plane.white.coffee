'use strict'
#
#
class Builder.WhiteEnemyPlane extends Builder.SpriteSheet

	@SpriteSheet = null

	# Creates a new Player Plane
	#
	# @return
	#
	@create: ( ) ->
	
		if WhiteEnemyPlane.SpriteSheet?
			return ( new Game.EnemyPlane WhiteEnemyPlane.SpriteSheet, undefined, undefined, undefined, 250 )
				.addBehaviour( Game.EnemyPlane.Behaviour.looper )
				.addBehaviour( Game.EnemyPlane.Behaviour.spawn.random.x )
				.addBehaviour( Game.EnemyPlane.Behaviour.spawn.random.y )
				.addBehaviour( Game.EnemyPlane.Behaviour.spawn.ondeath )
				.addBehaviour( Game.EnemyPlane.Behaviour.fire.point )
			
		builder = new Builder.WhiteEnemyPlane()
		builder.animationExtra( 'idle', 103, 466, 32, 32, 1, 1, 3, 3, true, 2 )
		builder.animationExtra( 'explode', 70, 169, 32, 32, 1, 1, 6, 6, 'hide', 4 )
		builder.animationExtra( 'hide', 268, 202, 32, 32, 1, 1, 1, 1, false, 1 )
		builder.animationExtra( 'loop', 565, 203, 32, 32, 1, 1, 1, 5, 'upside', 2 )
		builder.animation( 'upside', 70, 367, 32, 32, 1, 1, 2, 2 )
		builder.data.animations[ 'upside' ].frames.push _( builder.data.animations[ 'loop' ].frames ).last()
		
		WhiteEnemyPlane.SpriteSheet = builder.createjs
		return ( new Game.EnemyPlane WhiteEnemyPlane.SpriteSheet, undefined, undefined, undefined, 250 )
			.addBehaviour( Game.EnemyPlane.Behaviour.looper )
			.addBehaviour( Game.EnemyPlane.Behaviour.spawn.random.x )
			.addBehaviour( Game.EnemyPlane.Behaviour.spawn.random.y )
			.addBehaviour( Game.EnemyPlane.Behaviour.spawn.ondeath )
			.addBehaviour( Game.EnemyPlane.Behaviour.fire.point )