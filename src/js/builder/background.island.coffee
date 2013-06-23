'use strict'
#
#
class Builder.BackgroundIsland extends Builder.SpriteSheet

	#
	#
	@SpriteSheet = null

	# Creates a new Background Island
	#
	# @param type [String] type of the island
	# @return [Game.Island] the game island
	#
	@create: ( type ) ->
	
		if BackgroundIsland.SpriteSheet?
			return new Game.Island BackgroundIsland.SpriteSheet, type
			
		builder = new Builder.BackgroundIsland()
		builder.animation( 'type-A', 103, 499, 64, 65, 1, 1, 1, 1 )
		builder.animation( 'type-B', 168, 499, 64, 65, 1, 1, 1, 1 )
		builder.animation( 'type-C', 233, 499, 64, 65, 1, 1, 1, 1 )
		
		BackgroundIsland.SpriteSheet = builder.createjs
		return new Game.Island BackgroundIsland.SpriteSheet, type