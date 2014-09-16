class Game.Timeline
	
	constructor: ( @gameLevel ) ->
		@currentFrame = 0
		@speed = 1.0
		
		@timeFrames = {}
		@timeStamps = []
		
		Object.defineProperty( @, 'isDone',
			get: -> return @nextTimeStamp >= @timeStamps.length
		)
		
	# Adds an object to the timeline
	#
	# @param time [int] timestamp to insert at
	# @param object [Game.Movable] movable to insert
	#
	add: ( time, object ) ->
	
		if @timeFrames[ time ] is undefined
			@timeFrames[ time ] = []
			@timeStamps.push time
			
		@timeFrames[ time ].push object
		return this
			
	#
	#
	#
	prepare: () ->
		@timeStamps.sort (a, b) -> a - b
		@nextTimeStamp = 0
		@nextFrame = if @isDone then Number.MAX_VALUE else @timeStamps[ @nextTimeStamp ]
			
		return this
		
	#
	#
	#
	update: ( event ) ->
		dt = event.delta #/ 1000
		@currentFrame += dt * @speed
		while( @_process() )
			undefined
			
		return this
	
	#
	#
	#
	_process: () ->
		return false if ( @currentFrame < @nextFrame )
		
		for object in @timeFrames[ @nextFrame ]
			object.spawn()
			
		@currentFrame++
		@nextTimeStamp++
		@nextFrame = if @isDone then Number.MAX_VALUE else @timeStamps[ @nextTimeStamp ]
		
		return true