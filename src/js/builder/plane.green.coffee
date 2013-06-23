'use strict'
#
#
class Builder.PlaneGreen extends Builder.SpriteSheet

	@SpriteSheet = null

	# Creates a new Player Plane
	#
	# @return
	#
	@create: ( ) ->
	
		if PlaneGreen.SpriteSheet?
			return ( new Game.PlaneEnemy PlaneGreen.SpriteSheet )
				.move( 'down' )
				.addBehaviour( Game.PlaneEnemy.Behaviour.looper )
				.addBehaviour( Game.PlaneEnemy.Behaviour.spawn.random.x )
				.addBehaviour( Game.PlaneEnemy.Behaviour.spawn.random.y )
			
		builder = new Builder.PlaneGreen()
		builder.animationExtra( 'idle', 4, 466, 32, 32, 1, 1, 3, 3, true, 1 )
		builder.animationExtra( 'explode', 69, 169, 32, 32, 1, 1, 6, 6, 'hide', 2 )
		builder.animationExtra( 'hide', 268, 202, 32, 32, 1, 1, 1, 1, false, 1 )
		builder.animationExtra( 'loop', 598, 203, 32, 32, 1, 1, 1, 5, 'upside', 2 )
		builder.animation( 'upside', 136, 367, 32, 32, 1, 1, 2, 2 )
		builder.data.animations[ 'upside' ].frames.push _( builder.data.animations[ 'loop' ].frames ).last()
		
		PlaneGreen.SpriteSheet = builder.createjs
		return ( new Game.PlaneEnemy PlaneGreen.SpriteSheet )
			.move( 'down' )
			.addBehaviour( Game.PlaneEnemy.Behaviour.looper )
			.addBehaviour( Game.PlaneEnemy.Behaviour.spawn.random.x )
			.addBehaviour( Game.PlaneEnemy.Behaviour.spawn.random.y )