'use strict'
#
#
class Builder.Bullet extends Builder.SpriteSheet

	@SpriteSheet = null

	# Creates a new Player Plane
	#
	# @return
	#
	@create: ( bulletctor, x, y, vx, vy, type, damage, args ) ->
	
		if Bullet.SpriteSheet?
			return ( new bulletctor Bullet.SpriteSheet, x, y, vx, vy, type, damage, args )
			
		builder = new Builder.Bullet()
		builder.animationExtra( 'point', 37, 202, 32, 32, 1, 1, 1, 1, false, 1 )
		builder.animationExtra( 'mini', 70, 202, 32, 32, 1, 1, 1, 1, false, 1 )
		builder.animationExtra( 'up', 37, 169, 32, 32, 1, 1, 1, 1, false, 1 )
		builder.animationExtra( '2up', 4, 169, 32, 32, 1, 1, 1, 1, false, 1 )
		builder.animationExtra( '2down', 4, 202, 32, 32, 1, 1, 1, 1, false, 1 )
		builder.animationExtra( 'leftup', 4, 235, 32, 32, 1, 1, 1, 1, false, 1 )
		builder.animationExtra( 'rightup', 37, 235, 32, 32, 1, 1, 1, 1, false, 1 )
		builder.animationExtra( 'leftdown', 70, 235, 32, 32, 1, 1, 1, 1, false, 1 )
		builder.animationExtra( 'rightdown', 103, 235, 32, 32, 1, 1, 1, 1, false, 1 )
		builder.animationExtra( 'left', 136, 235, 32, 32, 1, 1, 1, 1, false, 1 )
		builder.animationExtra( 'right', 169, 235, 32, 32, 1, 1, 1, 1, false, 1 )
		
		Bullet.SpriteSheet = builder.createjs
		return ( new bulletctor Bullet.SpriteSheet, x, y, vx, vy, type, damage, args )