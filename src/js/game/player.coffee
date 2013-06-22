'use strict'
#
#
class Game.Player extends Game.Sprite
	
	# Creates a new Game Player
	#
	# @param spritesheet [createjs.SpriteSheet] the spritesheet for this sprite
	#
	constructor: ( spritesheet ) ->
		super spritesheet
				
		@x = 100
		@y = 100
		@play 'idle'
	
	#
	#
	update: ( event ) ->
		return if event.paused