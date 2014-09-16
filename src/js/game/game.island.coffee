'use strict'
#
#
class Game.Island extends Game.Movable
	
	# Level Bound padding. Should be at least frame size
	#
	@Padding = 50
	
	# Creates a new Game Island
	#
	# @param spritesheet [createjs.SpriteSheet] the spritesheet for this sprite
	# @param type [String] the type of the island
	#
	constructor: ( spritesheet, type = 'A' ) ->
	
		rel = ( Math.random() * ( Game.Canvas1945.Height / 3 - Island.Padding ) + .5 )  | 0
		x = Math.random() * Game.Canvas1945.Width
		y = switch type
			when 'A'
				rel
			when 'B'
				rel + Game.Canvas1945.Height / 3 * 1
			when 'C'
				rel + Game.Canvas1945.Height / 3 * 2
		
		super spritesheet, x, y, 0, 0
		
		@play 'type-' + type
		
	# Updates the island
	#
	# @param event [Object] the update event
	#
	update: ( event ) ->
		return this if event.paused or @isLevelPaused is on
		super event
		if @y > Game.Canvas1945.Height + Island.Padding
			@y = -Island.Padding
			@x = Math.random() * Game.Canvas1945.Width
