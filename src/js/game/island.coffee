#
#
class Game.Island extends Game.Sprite
	
	# Level Bound padding. Should be at least frame size
	#
	@Padding = 50
	
	# Creates a new Game Island
	#
	# @param spritesheet [createjs.SpriteSheet] the spritesheet for this sprite
	# @param type [String] the type of the island
	#
	constructor: ( spritesheet, type = 'A' ) ->
	
		super spritesheet
		@createjs.gotoAndStop 'type-' + type
		@x = Math.random() * Game.Canvas1945.Width
		rel = Math.floor( Math.random() * ( Game.Canvas1945.Height / 3 - Island.Padding ) )
		switch type
			when 'A'
				@y = rel
			when 'B'
				@y = rel + Game.Canvas1945.Height / 3 * 1
			when 'C'
				@y = rel + Game.Canvas1945.Height / 3 * 2
		
	# Updates the island
	#
	# @param event [Object] the update event
	#
	update: ( event ) ->
		return if event.paused
		
		dt = event.delta / 1000
		@y += dt * Game.Canvas1945.ScrollSpeed
		
		if @y > Game.Canvas1945.Height + Island.Padding
			@y = -Island.Padding
			@x = Math.random() * Game.Canvas1945.Width
