#
#
class Game.Container
	
	# Creates a new container
	#
	constructor: ->
	
		@objects = {}
		@container = new createjs.Container()
		
		Object.defineProperty( @, 'createjs',
			get: -> return @container
		)
		
	# Runs every tick and passes down the tick event
	# 
	# @param event
	#
	update: ( event ) =>
		for object in @objects
			object.update event 
		return this
	
	# Adds an object
	#
	# @param key [String] the id of the object
	# @param object [any] the object
	# @return [self] the chainable self
	#
	add: ( key, object ) ->
		if @get( key )?
			throw new Error
			
		@objects[ key ] = object
		@container.addChild object.createjs
		return this
	
	# Removes an object
	#
	# @param key [String] the id of the object
	# @return [self] the chainable self
	#
	remove: ( key ) ->
		unless ( object = @get( key ) )?
			throw new Error
			
		@container.removeChild object.createjs
		delete @objects[ key ]
		return this
	
	# Gets an object
	#
	# @param key [String] the id of the object
	# @return [any] the object
	#
	get: ( key ) ->
		return @objects[ key ]
