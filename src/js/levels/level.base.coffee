class Levels.Base
	
	constructor: () ->
		@enemyCount = 0
		
		@_isPaused = off
		Object.defineProperty( @, 'isPaused',
			get: -> return @_isPaused
		)
		
		
	#
	#
	#
	pause: () ->
		@_isPaused = on
	
	#
	#
	#
	resume: () ->
		@_isPaused = off
	
	#
	#
	#
	injectInto: ( @gameLevel ) ->
	
	#
	#
	#	
	planeCreated: ( source ) ->
		if source instanceof Game.EnemyPlane
			@enemyCount++
	
	#
	#
	#
	planeDestroyed: ( source ) ->
		if source instanceof Game.EnemyPlane
			@enemyCount--
		
	#
	#
	#
	update: ( event ) ->
		