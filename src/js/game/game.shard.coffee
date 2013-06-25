'use strict'
#
#
class Game.Shard extends Game.Movable
	
	@Types =
		back: 'back'
	
	#
	#
	constructor: ( spritesheet, x, y, vx, vy, frame, type ) ->
	
		# slow down
		vx *= 0.8
		vy *= 0.8
		
		# scatter
		vx += ( Math.random() * 80 - 40 + 0.5 ) | 0
		vy += ( Math.random() * 80 - 40 + 0.5 ) | 0
		vr = ( Math.random() * 720 - 360 + 0.5 ) | 0
		
		r = ( Math.random() * 360 + 0.5 ) | 0
		
		super spritesheet, x, y, vx, vy
		
		@stop type
		@createjs.advance() while frame-- > 0
		
		# Rotation
		@r = r
		@velocity.r = vr 
		@velocity.sx = -.5
		@velocity.sy = -.5
		@velocity.a = -.75
		
		@acceleration =
			x: ( vx / -2 ) | 0
			y: ( vy / -2 ) | 0
			r: ( vr / -4 ) | 0
			
		@health = 1.5
		
		Game.EventManager.trigger 'shard.create', @, []
		
	#
	#
	destroy: () ->
		super
		Game.EventManager.trigger 'shard.destroy', @, []
		return this
		
	#
	#
	update: ( event ) ->
		return if event.paused
		
		dt = event.delta / 1000
		for prop, value of @acceleration
			@velocity[ prop ] += dt * value
		
		super event
		
		if ( @health -= dt ) <= 0
			# TODO turn into splash
			@destroy()
		
		return this